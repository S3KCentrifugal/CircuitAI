# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54017); wall 228 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:57:05
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\glitters\runs\20261003T180056Z-595e8608\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=995 E=0 bank=930 pull=66 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 4725 are not on it` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 4.9 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 4725 are not on it
- forbid 'invariant' hit at 13.9 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 9 T2 constructors, none added
- forbid 'invariant' hit at 17.0 min: [INVARIANT] INV-010 combat unit armfast 4390 produced at +97 metal under the gate 200
- forbid 'invariant' hit at 19.2 min: [INVARIANT] INV-010 combat unit armfast 19242 produced at +68 metal under the gate 200
- forbid 'invariant' hit at 19.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 7 T2 constructors, none added
- forbid 'invariant' hit at 20.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 4 T2 constructors, none added
- forbid 'invariant' hit at 21.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 5 T2 constructors, none added
- forbid 'invariant' hit at 22.1 min: [INVARIANT] INV-010 combat unit armfast 30343 produced at +152 metal under the gate 200
- forbid 'invariant' hit at 22.7 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 5 T2 constructors, none added
- forbid 'invariant' hit at 23.3 min: [INVARIANT] INV-010 combat unit armfast 27664 produced at +193 metal under the gate 200
- forbid 'invariant' hit at 24.3 min: [INVARIANT] INV-010 combat unit armfast 21426 produced at +196 metal under the gate 200
- forbid 'invariant' hit at 25.4 min: [INVARIANT] INV-010 combat unit armfast 27080 produced at +191 metal under the gate 200
- forbid 'invariant' hit at 25.6 min: [INVARIANT] INV-010 combat unit legstr 29535 produced at +161 metal under the gate 200
- forbid 'invariant' hit at 26.6 min: [INVARIANT] INV-010 combat unit armfast 20780 produced at +197 metal under the gate 200

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\glitters\runs\20261003T180056Z-595e8608\screen_2026-10-03_17-58-06-522.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\glitters\runs\20261003T180056Z-595e8608\screen_2026-10-03_17-58-47-017.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\glitters\runs\20261003T180056Z-595e8608\screen_2026-10-03_17-59-12-517.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811002\cohort\20261003T172752Z-278ef6b8\glitters\runs\20261003T180056Z-595e8608\screen_2026-10-03_18-00-55-312.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (2801, 775) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (2801, 775) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order corap
  0.10  [AIR][Capacity] own=2/30 usage=6/66 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=995 E=0 bank=930 pull=66 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2832, 746), 57 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|cortex|corap|2787|782|0|1|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(4210,608) factory=armlab landLocked=no spot=2 known=1/1
  0.17  [Team][Roster] team 1 first mex at 4256,480
  0.17  [Playtest] finished cormex team 0 at 0.17 min
  0.18  [Team][Roster] first mex 6710 at 2688,704
  0.18  [Team][Roster] Re-announced: roster|1|0|0|AIR|cortex|corap|2787|782|0|1|1|2688|704
  0.19  [AIR][Rule] opening.mex builder=26153
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=961 E=18 bank=595 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=23/232
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.31  [Playtest] finished cormex team 0 at 0.31 min
  0.43  [AIR][Capacity] own=3/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=949 E=30 bank=210 pull=86 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=10/109
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.46  [Playtest] finished cormex team 0 at 0.46 min
  0.47  [AIR][Rule] recovery.energy builder=26153
  0.60  [AIR][Capacity] own=5/30 usage=16/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=897 E=30 bank=291 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=31/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.63  [Playtest] finished corsolar team 0 at 0.63 min
  0.77  [AIR][Capacity] own=7/30 usage=16/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=830 E=30 bank=644 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=39/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.81  [Playtest] finished corsolar team 0 at 0.81 min
  0.82  [AIR][Wind] cluster=0 slots=6 at=2584,576 local=false builder=26153
  0.82  [AIR][Rule] opening.energy builder=26153
  0.93  [AIR][Capacity] own=7/50 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=851 E=50 bank=1070 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=36/146
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +7.5 bank 851/1150, energy +70.0 bank 1075/1100, units 7
  1.01  [Playtest] finished corwin team 0 at 1.01 min
  1.10  [AIR][Capacity] own=7/70 usage=7/40 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=860 E=70 bank=1082 pull=40 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=13/53
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.13  [Playtest] finished corwin team 0 at 1.13 min
  1.24  [Playtest] finished corwin team 0 at 1.24 min
  1.26  [AIR][Starter] nearby distance=128
  1.26  [AIR][Rule] opening.plant builder=26153
  1.27  [AIR][EcoLayout] reserved air.eco.0 reactor=1888,400 converters=8 support=12 zone=494
  1.27  [AIR][Capacity] own=7/85 usage=4/28 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=872 E=85 bank=1099 pull=28 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=630/1100
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.28  [AIR][EcoLayout] reserved air.eco.1 reactor=1632,912 converters=8 support=12 zone=517
  1.30  [AIR][EcoLayout] reserved air.eco.2 reactor=1248,400 converters=8 support=12 zone=542
  1.32  [AIR][EcoLayout] reserved air.eco.3 reactor=4064,1424 converters=8 support=12 zone=582
  1.43  [AIR][Capacity] own=7/110 usage=35/70 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=634 E=109 bank=1046 pull=70 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=283/494
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=18167 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.57  [Playtest] finished corap team 0 at 1.57 min
  1.58  [AIR][Produce] opening.scout corfink plant=18167 projected=1/1
  1.58  [AIR][Rule] opening.commander.guard builder=26153
  1.58  [AIR][Claim] cancel unowned native order cornanotc
  1.58  [AIR][State] T1_CONTEST
  1.60  [AIR][Capacity] own=7/103 usage=1/11 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T1_CONTEST M=7 bank=392 E=106 bank=1159 pull=11 plants=1/0 aircraftDemand=3/123
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.71  [AIR][Produce] constructor.recovery corca plant=18167 projected=1/3
  1.77  [AIR][Capacity] own=7/87 usage=0/8 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=55 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST M=7 bank=404 E=88 bank=144 pull=199 plants=1/0 aircraftDemand=3/123
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=55 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  1.93  [AIR][Capacity] own=4/86 usage=0/4 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=55 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=424 E=86 bank=3 pull=135 plants=1/0 aircraftDemand=3/123
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=55 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.5 bank 440/1250, energy +90.5 bank 2/1201, units 12
  2.10  [AIR][Capacity] own=7/89 usage=0/8 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=55 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=456 E=88 bank=2 pull=110 plants=1/0 aircraftDemand=3/123
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=55 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.12  [AIR][Produce] constructor.recovery corca plant=18167 projected=2/3
  2.12  [AIR][Rule] recovery.energy builder=3867
  2.27  [AIR][Capacity] own=3/94 usage=2/5 gifts=0 sent=0 excess=0 pressure=false mobile=55 arriving=55 idle=0 ecoStatic=0 working=55 shortage=54 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=463 E=92 bank=9 pull=167 plants=1/0 aircraftDemand=3/123
  2.27  [AIR][Projects] energyQueued=0 committed=133/0
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=164 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.43  [AIR][Capacity] own=4/108 usage=2/8 gifts=0 sent=0 excess=0 pressure=false mobile=55 arriving=55 idle=0 ecoStatic=0 working=54 shortage=82 reason=funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=447 E=107 bank=87 pull=135 plants=1/0 aircraftDemand=3/123
  2.43  [AIR][Projects] energyQueued=0 committed=104/0
  2.43  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=192 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.47  [AIR][Produce] constructor.recovery corca plant=18167 projected=3/3
  2.47  [AIR][Rule] recovery.energy builder=25585
  2.60  [AIR][Capacity] own=7/112 usage=5/8 gifts=0 sent=0 excess=0 pressure=false mobile=110 arriving=55 idle=0 ecoStatic=0 working=109 shortage=52 reason=funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=406 E=111 bank=584 pull=199 plants=1/0 aircraftDemand=3/123
  2.60  [AIR][Projects] energyQueued=0 committed=209/0
  2.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=217 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.70  [AIR][Produce] opening.screen corveng plant=18167 projected=1/6
  2.70  [AIR][Rule] recovery.assist builder=24807
  2.76  [AIR][Commander] cleared factory guard for commander.energy.local
  2.76  [AIR][Rule] commander.energy.local builder=26153
  2.77  [AIR][Capacity] own=7/117 usage=18/387 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST M=7 bank=333 E=117 bank=241 pull=387 plants=1/0 aircraftDemand=3/123
  2.77  [AIR][Projects] energyQueued=1 committed=187/175
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  2.86  [Playtest] finished corwin team 0 at 2.86 min
  2.87  [AIR][Rule] commander.factory.guard builder=26153
  2.88  [Playtest] finished corsolar team 0 at 2.88 min
  2.89  [AIR][Rule] recovery.assist builder=3867
  2.93  [AIR][Produce] opening.screen corveng plant=18167 projected=2/6
  2.93  [AIR][Screen] fighters=1 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  2.93  [AIR][Capacity] own=7/119 usage=14/387 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=109 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=243 E=120 bank=315 pull=387 plants=1/0 aircraftDemand=4/131
  2.93  [AIR][Projects] energyQueued=0 committed=71/0
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +7.5 bank 215/1250, energy +141.9 bank 4/1327, units 19
  3.07  [Playtest] finished corsolar team 0 at 3.07 min
  3.08  [AIR][Rule] recovery.energy builder=3867
  3.08  [AIR][Rule] mex.expand builder=24807
  3.09  [AIR][Rule] mex.expand builder=25585
  3.10  [AIR][Capacity] own=5/141 usage=5/167 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=191 E=141 bank=6 pull=177 plants=1/0 aircraftDemand=4/131
  3.10  [AIR][Projects] energyQueued=1 committed=150/0
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.10  [AIR][Screen] fighters=1 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.14  [AIR][Rule] recovery.assist builder=24807
  3.15  [AIR][Rule] recovery.assist builder=25585
  3.22  [AIR][Produce] opening.screen corveng plant=18167 projected=3/6
  3.27  [AIR][Layout] cluster=0 labs=3 at=3387,2966
  3.27  [AIR][Capacity] own=5/161 usage=11/126 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=176 E=161 bank=189 pull=126 plants=1/0 aircraftDemand=4/131
  3.27  [AIR][Projects] energyQueued=0 committed=87/0
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Screen] fighters=2 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  3.43  [Playtest] finished corsolar team 0 at 3.43 min
  3.43  [AIR][Capacity] own=6/161 usage=13/167 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=165 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=115 E=161 bank=7 pull=261 plants=1/0 aircraftDemand=3/129
  3.43  [AIR][Projects] energyQueued=0 committed=0/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Screen] fighters=2 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  3.45  [AIR][Rule] recovery.energy builder=24807
  3.45  [AIR][Layout] cluster=1 labs=1 at=3099,1526
  3.47  [AIR][Layout] cluster=2 labs=1 at=1659,566
  3.48  [AIR][Layout] cluster=3 labs=1 at=1659,1814
  3.51  [AIR][Produce] opening.screen corveng plant=18167 projected=4/6
  3.60  [AIR][Capacity] own=6/173 usage=15/252 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=74 E=180 bank=10 pull=261 plants=1/0 aircraftDemand=3/130
  3.60  [AIR][Projects] energyQueued=0 committed=231/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=73
  3.62  [AIR][Screen] fighters=3 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  3.67  [AIR][Layout] cluster=4 labs=3 at=3291,2966
  3.77  [AIR][Capacity] own=6/176 usage=13/177 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=15 E=176 bank=1 pull=261 plants=1/0 aircraftDemand=3/129
  3.77  [AIR][Projects] energyQueued=0 committed=142/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.78  [AIR][Screen] fighters=3 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  3.79  [AIR][Produce] opening.screen corveng plant=18167 projected=5/6
  3.92  [Playtest] finished corsolar team 0 at 3.91 min
  3.93  [AIR][Capacity] own=7/174 usage=12/168 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=55 ecoStatic=0 working=54 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=285 E=174 bank=14 pull=328 plants=1/0 aircraftDemand=3/129
  3.93  [AIR][Projects] energyQueued=1 committed=225/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.95  [AIR][Screen] fighters=4 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +7.5 bank 272/1250, energy +198.0 bank 7/1477, units 25
  4.04  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.04  [AIR][Rule] commander.idle.assist builder=26153
  4.05  [AIR][Produce] opening.screen corveng plant=18167 projected=6/6
  4.06  [AIR][Rule] commander.factory.guard builder=26153
  4.10  [AIR][Capacity] own=7/196 usage=12/143 gifts=0 sent=0 excess=0 pressure=true mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=248 E=191 bank=271 pull=143 plants=1/0 aircraftDemand=3/129
  4.10  [AIR][Projects] energyQueued=0 committed=149/0
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=137
  4.12  [AIR][Screen] fighters=5 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  4.16  [Playtest] finished corsolar team 0 at 4.16 min
  4.18  [AIR][Rule] recovery.assist builder=24807
  4.27  [AIR][Capacity] own=7/201 usage=12/236 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=199 E=199 bank=11 pull=261 plants=1/0 aircraftDemand=3/129
  4.27  [AIR][Projects] energyQueued=0 committed=88/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.32  [AIR][Screen] fighters=6 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  4.35  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.35  [AIR][Rule] commander.idle.wait builder=26153
  4.43  [AIR][Capacity] own=7/238 usage=8/9 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=164 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=183 E=236 bank=1450 pull=9 plants=1/0 aircraftDemand=3/130
  4.43  [AIR][Projects] energyQueued=0 committed=0/0
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [Playtest] finished corsolar team 0 at 4.43 min
  4.45  [AIR][Rule] commander.idle.energy builder=26153
  4.45  [AIR][Rule] mex.expand builder=3867
  4.45  [AIR][Claim] cancel unowned native order cormakr
  4.45  [AIR][Rule] intel.radar builder=24807
  4.46  [AIR][Rule] wait builder=25585
  4.48  [AIR][Screen] fighters=6 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  4.52  [AIR][Layout] repaired support air.bay.0 viable=1/5 slot=6424 at=2696,648
  4.52  [AIR][Rule] opening.support builder=25585
  4.53  [AIR][Produce] recon.replace corfink plant=18167 projected=1/1
  4.60  [AIR][Capacity] own=7/245 usage=23/144 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=409 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=7 bank=181 E=242 bank=1556 pull=144 plants=1/0 aircraftDemand=3/130
  4.60  [AIR][Projects] energyQueued=0 committed=411/4170
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+0/2 available=yes firstSlot=2
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=123
  4.65  [AIR][Screen] fighters=6 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  4.69  [Playtest] finished corsolar team 0 at 4.69 min
  4.70  [AIR][Claim] cancel unowned native order cormakr
  4.70  [AIR][Rule] commander.energy.local builder=26153
  4.77  [AIR][Capacity] own=7/267 usage=15/175 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=465 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=7 bank=51 E=268 bank=1619 pull=209 plants=1/0 aircraftDemand=3/130
  4.77  [AIR][Projects] energyQueued=0 committed=286/3525
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=165 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.82  [AIR][Screen] fighters=6 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  4.83  [Playtest] finished corwin team 0 at 4.83 min
  4.87  [AIR][Produce] air.control corveng plant=18167 projected=7/7
  4.90  [Playtest] finished corrad team 0 at 4.90 min
  4.92  [AIR][Rule] opening.support.assist builder=24807
  4.93  [AIR][Capacity] own=7/286 usage=5/80 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=269 shortage=39 reason=funded workload
  4.93  [AIR][Economy] T1_CONTEST M=7 bank=1 E=288 bank=1625 pull=192 plants=1/0 aircraftDemand=3/130
  4.93  [AIR][Projects] energyQueued=0 committed=223/2842
  4.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=204 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.98  [AIR][Screen] fighters=6 cells=8 centre=4176,1006 width=600 advance=400 responding=false
  5.00  [Playtest] eco team 0 at 5.0 min: metal +7.5 bank 0/1250, energy +280.7 bank 1627/1627, units 34
  5.00  [Playtest] target team 0 at (2801, 775) from its start position
  5.00  [Playtest] camera requested (2792,640) height=2200
  5.02  [Playtest] camera captured name=ta position=(2792,640) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (2792, 640)
  5.03  [Playtest] finished corwin team 0 at 5.03 min
  5.04  [AIR][Rule] commander.factory.guard builder=26153
  5.10  [AIR][Capacity] own=7/279 usage=3/122 gifts=0 sent=0 excess=0 pressure=false mobile=165 arriving=0 idle=0 ecoStatic=0 working=130 shortage=84 reason=funded workload
  5.10  [AIR][Economy] T1_CONTEST M=7 bank=1 E=281 bank=1628 pull=216 plants=1/0 aircraftDemand=3/130
  5.10  [AIR][Projects] energyQueued=0 committed=162/2238
  5.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=249 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=18167 BP=150 nanos=0+1/2 available=yes firstSlot=2
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 3795 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.08  RESERVE: zone 7 at (3819, 469) facing 0, 77x61 cells: 3980 of 4697 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3819, 965) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3819, 917) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3819, 869) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3819, 821) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (4056, 1048) facing 0 (id 63)
  0.08  RESERVE: zone 8 at (3499, 1445) facing 0, 41x45 cells: 1845 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3499, 1797) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3499, 1749) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3499, 1701) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (3499, 1653) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (4688, 1520) facing 0 (id 116)
  0.08  RESERVE: zone 9 at (4688, 1448) facing 0, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (4688, 1472) facing 0: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (4784, 1496) facing 0, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 11 at (4688, 1496) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (4688, 1744) facing 0, 10x20 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (1461, 9771) facing 2, 77x61 cells: 4076 of 4697 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9275) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9323) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9371) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9419) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (1704, 9192) facing 2 (id 63)
  0.09  RESERVE: zone 8 at (1461, 8795) facing 2, 41x45 cells: 1811 of 1845 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8443) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8491) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8539) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8587) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (1968, 8720) facing 2 (id 116)
  0.09  RESERVE: zone 9 at (1968, 8792) facing 2, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (1968, 8768) facing 2: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (2064, 8744) facing 2, 6x21 cells: 126 of 126 held
  0.09  RESERVE: corridor 11 at (1872, 8744) facing 2, 6x21 cells: 126 of 126 held
  0.09  RESERVE: zone 12 at (1968, 8744) facing 0, 6x9 cells: 0 of 54 held
  0.09  RESERVE: corridor 12 at (1968, 8496) facing 2, 10x20 cells: 164 of 200 held
  0.17  RESERVE: armlab at (4944, 1536) facing 0 (id 119)
  0.17  RESERVE: zone 12 at (4944, 1464) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (4944, 1488) facing 0: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (5040, 1512) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (4944, 1512) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (4944, 1760) facing 0, 10x20 cells: 190 of 200 held
  0.17  RESERVE: leglab at (2352, 8736) facing 2 (id 119)
  0.17  RESERVE: zone 13 at (2352, 8808) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (2352, 8784) facing 2: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 14 at (2448, 8760) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: corridor 15 at (2256, 8760) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (2352, 8760) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (2352, 8512) facing 2, 10x20 cells: 180 of 200 held
  0.18  EXP: approach: corcom(28807) at (3450, 9699) walks to (3425, 9681), 139 from the cormex site (3312, 9600)
  0.25  RESERVE: armalab at (5240, 1544) facing 0 (id 122)
  0.25  RESERVE: zone 15 at (5240, 1424) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (5240, 1472) facing 0: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (5240, 1496) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (5240, 1792) facing 0, 13x20 cells: 257 of 260 held
  0.25  RESERVE: zone 18 at (4592, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4592, 1904) facing 0 (id 127)
  0.25  RESERVE: zone 19 at (4560, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4560, 1904) facing 0 (id 128)
  0.25  RESERVE: zone 20 at (4528, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4528, 1904) facing 0 (id 129)
  0.25  RESERVE: zone 21 at (4496, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4496, 1904) facing 0 (id 130)
  0.25  RESERVE: zone 22 at (4400, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4400, 1904) facing 0 (id 131)
  0.25  RESERVE: zone 23 at (4368, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4368, 1904) facing 0 (id 132)
  0.25  RESERVE: zone 24 at (4048, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4048, 1904) facing 0 (id 133)
  0.25  RESERVE: zone 25 at (4016, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4016, 1904) facing 0 (id 134)
  0.25  RESERVE: zone 26 at (3984, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3984, 1904) facing 0 (id 135)
  0.25  RESERVE: zone 27 at (3952, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3952, 1904) facing 0 (id 136)
  0.25  RESERVE: zone 28 at (3920, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3920, 1904) facing 0 (id 137)
  0.25  RESERVE: zone 29 at (3888, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3888, 1904) facing 0 (id 138)
  0.25  RESERVE: zone 30 at (3856, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3856, 1904) facing 0 (id 139)
  0.25  RESERVE: zone 31 at (3824, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3824, 1904) facing 0 (id 140)
  0.25  RESERVE: zone 32 at (3792, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3792, 1904) facing 0 (id 141)
  0.25  RESERVE: zone 33 at (3760, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3760, 1904) facing 0 (id 142)
  0.25  RESERVE: zone 34 at (3728, 1904) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3728, 1904) facing 0 (id 143)
  0.25  RESERVE: zone 35 at (4464, 1792) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (4464, 1792) facing 0 (id 144)
  0.25  RESERVE: zone 36 at (3960, 1800) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: armrl at (3960, 1800) facing 0 (id 145)
  0.25  RESERVE: legalab at (3016, 8744) facing 2 (id 122)
  0.25  RESERVE: zone 17 at (3016, 8864) facing 2, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of legnanotc 2x2 gap 0 behind (3016, 8816) facing 2: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 18 at (3016, 8792) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 19 at (3016, 8496) facing 2, 13x20 cells: 252 of 260 held
  0.25  RESERVE: zone 20 at (1456, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1456, 8336) facing 0 (id 127)
  0.25  RESERVE: zone 21 at (1488, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1488, 8336) facing 0 (id 128)
  0.25  RESERVE: zone 22 at (1520, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1520, 8336) facing 0 (id 129)
  0.25  RESERVE: zone 23 at (1552, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1552, 8336) facing 0 (id 130)
  0.25  RESERVE: zone 24 at (1584, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1584, 8336) facing 0 (id 131)
  0.25  RESERVE: zone 25 at (1616, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1616, 8336) facing 0 (id 132)
  0.25  RESERVE: zone 26 at (1648, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1648, 8336) facing 0 (id 133)
  0.25  RESERVE: zone 27 at (1744, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1744, 8336) facing 0 (id 134)
  0.25  RESERVE: zone 28 at (1776, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1776, 8336) facing 0 (id 135)
  0.25  RESERVE: zone 29 at (2096, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2096, 8336) facing 0 (id 136)
  0.25  RESERVE: zone 30 at (2128, 8336) facing 0, 2x2 cells: 4 of 4 held
```
