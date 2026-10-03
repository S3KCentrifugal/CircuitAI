# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54004); wall 197 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:36:28
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\glitters\runs\20261003T173949Z-f0eaacfe\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=995 E=0 bank=931 pull=63 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1470 (5 by power), bank 0 + 15/s (0 by metal))` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 5.0 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1470 (5 by power), bank 0 + 15/s (0 by metal))
- forbid 'invariant' hit at 12.0 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 3 T2 constructors, none added
- forbid 'invariant' hit at 14.0 min: [INVARIANT] INV-004 metal floating at 2101 of 2200 for 60 s while legwin is under construction and static build power 0 is under 327
- forbid 'invariant' hit at 14.5 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 5 T2 constructors, none added
- forbid 'invariant' hit at 14.8 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (1888, 9760) not upgraded
- forbid 'invariant' hit at 18.8 min: [INVARIANT] INV-010 combat unit armfast 11440 produced at +114 metal under the gate 200
- forbid 'invariant' hit at 25.9 min: [INVARIANT] INV-010 combat unit armfast 1759 produced at +194 metal under the gate 200
- forbid 'invariant' hit at 27.5 min: [t=00:02:49.529572][f=0049530] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 27.5 min: [t=00:02:49.580140][f=0049545] [INVARIANT] INV-081 AIR observer: commander guards idle factory for over ten seconds
- forbid 'invariant' hit at 28.5 min: [INVARIANT] INV-010 combat unit armfast 28553 produced at +199 metal under the gate 200
- forbid 'invariant' hit at 29.2 min: [INVARIANT] INV-022 a new set of legadveconv starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.7 min: [INVARIANT] INV-010 combat unit armfast 16011 produced at +192 metal under the gate 200
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 727 elmos away, not flush (160)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\glitters\runs\20261003T173949Z-f0eaacfe\screen_2026-10-03_17-37-37-789.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\glitters\runs\20261003T173949Z-f0eaacfe\screen_2026-10-03_17-38-16-347.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\glitters\runs\20261003T173949Z-f0eaacfe\screen_2026-10-03_17-38-38-355.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\glitters\runs\20261003T173949Z-f0eaacfe\screen_2026-10-03_17-39-48-922.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2801, 775) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2801, 775) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=6/63 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=995 E=0 bank=931 pull=63 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2832, 746), 56 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|2789|783|0|1|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(4210,610) factory=armlab landLocked=no spot=2 known=1/1
  0.17  [Team][Roster] team 1 first mex at 4256,480
  0.17  [Playtest] finished armmex team 0 at 0.17 min
  0.18  [AIR][Rule] opening.mex builder=2274
  0.18  [Team][Roster] first mex 19579 at 2688,704
  0.18  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2789|783|0|1|1|2688|704
  0.27  [AIR][Capacity] own=2/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=953 E=18 bank=491 pull=86 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=13/138
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.43  [Playtest] finished armmex team 0 at 0.43 min
  0.43  [AIR][Capacity] own=3/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP RECOVERY M=3 bank=938 E=30 bank=85 pull=89 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.44  [AIR][Rule] recovery.energy builder=2274
  0.60  [Playtest] finished armsolar team 0 at 0.60 min
  0.60  [AIR][Capacity] own=6/30 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=865 E=30 bank=296 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.76  [Playtest] finished armsolar team 0 at 0.76 min
  0.77  [AIR][Capacity] own=7/40 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=785 E=48 bank=691 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.92  [Playtest] finished armsolar team 0 at 0.92 min
  0.93  [AIR][Claim] cancel unowned native order armmakr
  0.93  [AIR][Capacity] own=7/60 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=697 E=68 bank=1126 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.93  [AIR][Wind] cluster=0 slots=6 at=2584,576 local=false builder=2274
  0.93  [AIR][Rule] opening.energy builder=2274
  1.00  [Playtest] eco team 0 at 1.0 min: metal +7.5 bank 730/1150, energy +90.0 bank 1150/1150, units 7
  1.10  [AIR][Capacity] own=7/90 usage=7/41 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=749 E=90 bank=1144 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=14/63
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.13  [Playtest] finished armwin team 0 at 1.13 min
  1.14  [AIR][Starter] nearby distance=128
  1.14  [AIR][Rule] opening.plant builder=2274
  1.15  [AIR][EcoLayout] reserved air.eco.0 reactor=1888,400 converters=8 support=12 zone=1166
  1.17  [AIR][EcoLayout] reserved air.eco.1 reactor=1632,912 converters=8 support=12 zone=1189
  1.18  [AIR][EcoLayout] reserved air.eco.2 reactor=1248,400 converters=8 support=12 zone=1214
  1.20  [AIR][EcoLayout] reserved air.eco.3 reactor=4064,1424 converters=8 support=12 zone=1254
  1.27  [AIR][Capacity] own=7/90 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=591 E=90 bank=1119 pull=69 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=404/684
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.27  [AIR][Bay] 0 plant=14169 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.43  [AIR][Capacity] own=7/105 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=309 E=105 bank=1123 pull=69 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=46/78
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=14169 BP=0 nanos=0+0/0 available=yes firstSlot=-1
  1.45  [Playtest] finished armap team 0 at 1.45 min
  1.47  [AIR][Claim] cancel unowned native order armnanotc
  1.47  [AIR][Claim] cancel unowned native order armnanotc
  1.47  [AIR][State] T1_CONTEST
  1.47  [AIR][Produce] opening.scout armpeep plant=14169 projected=1/1
  1.47  [AIR][Rule] opening.commander.guard builder=2274
  1.60  [AIR][Produce] constructor.recovery armca plant=14169 projected=1/3
  1.60  [AIR][Capacity] own=7/105 usage=8/258 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T1_CONTEST M=7 bank=251 E=105 bank=337 pull=258 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=7/105 usage=1/34 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=260 E=105 bank=29 pull=134 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  1.91  [AIR][Produce] constructor.recovery armca plant=14169 projected=2/3
  1.91  [AIR][Rule] recovery.energy builder=25952
  1.93  [AIR][Capacity] own=7/105 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=290 E=105 bank=121 pull=19 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=1 committed=155/0
  1.93  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.5 bank 284/1250, energy +110.9 bank 2/1275, units 13
  2.10  [AIR][Capacity] own=7/110 usage=1/0 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=97 reason=funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=279 E=108 bank=179 pull=137 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=126/0
  2.10  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=197 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.18  [AIR][Produce] constructor.recovery armca plant=14169 projected=3/3
  2.18  [AIR][Rule] recovery.assist builder=18537
  2.27  [AIR][Capacity] own=7/110 usage=7/42 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=99 shortage=0 reason=available or arriving power
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=244 E=110 bank=819 pull=197 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=88/0
  2.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  2.40  [AIR][Produce] opening.screen armfig plant=14169 projected=1/6
  2.40  [AIR][Rule] mex.expand builder=19456
  2.43  [AIR][Capacity] own=7/115 usage=7/58 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=7 bank=176 E=115 bank=1312 pull=58 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=79/500
  2.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  2.44  [AIR][Commander] cleared factory guard for commander.energy.local
  2.44  [AIR][Rule] commander.energy.local builder=2274
  2.52  [Playtest] finished armsolar team 0 at 2.52 min
  2.53  [AIR][Rule] mex.assist builder=25952
  2.53  [AIR][Rule] energy.grow builder=18537
  2.56  [Playtest] finished armwin team 0 at 2.56 min
  2.60  [AIR][Capacity] own=7/120 usage=4/147 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=123 E=118 bank=843 pull=147 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=1 committed=113/721
  2.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.67  [Playtest] finished armwin team 0 at 2.67 min
  2.69  [AIR][Rule] commander.energy.assist builder=2274
  2.74  [AIR][Produce] opening.screen armfig plant=14169 projected=2/6
  2.74  [AIR][Screen] fighters=1 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  2.76  [Playtest] finished armwin team 0 at 2.76 min
  2.77  [AIR][Capacity] own=7/149 usage=13/145 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST M=7 bank=70 E=151 bank=579 pull=145 plants=1/0 aircraftDemand=3/127
  2.77  [AIR][Projects] energyQueued=0 committed=13/135
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  2.77  [AIR][Rule] commander.energy.local builder=2274
  2.85  [Playtest] finished armmex team 0 at 2.85 min
  2.86  [AIR][Rule] mex.expand builder=25952
  2.87  [Playtest] finished armwin team 0 at 2.87 min
  2.88  [AIR][Rule] commander.energy.assist builder=2274
  2.92  [AIR][Screen] fighters=1 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  2.93  [AIR][Capacity] own=7/162 usage=11/174 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=350 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST M=7 bank=41 E=165 bank=649 pull=174 plants=1/0 aircraftDemand=3/127
  2.93  [AIR][Projects] energyQueued=0 committed=13/57
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  2.96  [Playtest] finished armwin team 0 at 2.96 min
  2.97  [AIR][Rule] commander.factory.guard builder=2274
  2.97  [AIR][Rule] mex.expand builder=18537
  2.98  [AIR][Wind] cluster=1 slots=6 at=3080,784 local=false builder=19456
  2.98  [AIR][Rule] energy.grow builder=19456
  3.00  [Playtest] eco team 0 at 3.0 min: metal +9.3 bank 44/1300, energy +219.6 bank 827/1378, units 22
  3.00  [AIR][Rule] energy.grow builder=25952
  3.04  [AIR][Produce] opening.screen armfig plant=14169 projected=3/6
  3.08  [AIR][Screen] fighters=2 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  3.10  [AIR][Capacity] own=9/198 usage=7/249 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=49 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST M=9 bank=64 E=191 bank=1337 pull=249 plants=1/0 aircraftDemand=3/125
  3.10  [AIR][Projects] energyQueued=2 committed=126/819
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.10  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=72
  3.21  [AIR][Produce] opening.screen armfig plant=14169 projected=4/6
  3.25  [AIR][Screen] fighters=3 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  3.27  [AIR][Capacity] own=9/219 usage=13/409 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST M=9 bank=47 E=219 bank=1306 pull=409 plants=1/0 aircraftDemand=3/126
  3.27  [AIR][Projects] energyQueued=0 committed=91/587
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.32  [AIR][Layout] cluster=0 labs=3 at=3389,2967
  3.33  [AIR][Layout] cluster=1 labs=1 at=3101,1431
  3.35  [AIR][Layout] cluster=2 labs=1 at=1661,567
  3.36  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.36  [AIR][Rule] commander.idle.assist builder=2274
  3.37  [AIR][Layout] cluster=3 labs=1 at=1661,1815
  3.37  [AIR][Produce] opening.screen armfig plant=14169 projected=5/6
  3.38  [AIR][Layout] cluster=4 labs=1 at=2909,1527
  3.39  [AIR][Rule] commander.factory.guard builder=2274
  3.42  [AIR][Screen] fighters=4 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  3.43  [AIR][Capacity] own=9/220 usage=7/161 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=72 reason=funded workload
  3.43  [AIR][Economy] T1_CONTEST M=9 bank=35 E=220 bank=1378 pull=161 plants=1/0 aircraftDemand=3/126
  3.43  [AIR][Projects] energyQueued=0 committed=52/339
  3.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=222 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.56  [AIR][Produce] opening.screen armfig plant=14169 projected=6/6
  3.60  [AIR][Capacity] own=9/215 usage=10/293 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST M=9 bank=17 E=218 bank=1364 pull=293 plants=1/0 aircraftDemand=3/126
  3.60  [AIR][Projects] energyQueued=0 committed=15/100
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.60  [AIR][Screen] fighters=5 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  3.60  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=65
  3.68  [Playtest] finished armwin team 0 at 3.68 min
  3.69  [AIR][Rule] intel.radar builder=25952
  3.73  [Playtest] finished armwin team 0 at 3.73 min
  3.76  [Playtest] finished armmex team 0 at 3.76 min
  3.76  [AIR][Produce] intercept armfig plant=14169 projected=7/7
  3.77  [AIR][Capacity] own=9/202 usage=5/127 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=100 shortage=118 reason=funded workload
  3.77  [AIR][Economy] T1_CONTEST M=9 bank=24 E=207 bank=900 pull=127 plants=1/0 aircraftDemand=3/126
  3.77  [AIR][Projects] energyQueued=0 committed=94/758
  3.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=268 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.78  [AIR][Commander] cleared factory guard for commander.local.assist
  3.78  [AIR][Rule] commander.local.assist builder=2274
  3.80  [AIR][Screen] fighters=6 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  3.83  [Playtest] finished armrad team 0 at 3.83 min
  3.85  [AIR][Rule] commander.factory.guard builder=2274
  3.85  [AIR][Rule] mex.assist builder=25952
  3.93  [AIR][Capacity] own=11/212 usage=12/407 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST M=11 bank=24 E=212 bank=505 pull=407 plants=1/0 aircraftDemand=3/126
  3.93  [AIR][Projects] energyQueued=0 committed=72/560
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=-1
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.97  [AIR][Screen] fighters=6 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.2 bank 30/1350, energy +221.4 bank 116/1379, units 32
  4.04  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.04  [AIR][Rule] commander.idle.assist builder=2274
  4.10  [AIR][Capacity] own=10/216 usage=4/48 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=22 reason=funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=67 E=213 bank=1013 pull=48 plants=1/0 aircraftDemand=3/126
  4.10  [AIR][Projects] energyQueued=0 committed=38/281
  4.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=172 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=-1
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=58
  4.15  [AIR][Screen] fighters=7 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  4.22  [Playtest] finished armmex team 0 at 4.22 min
  4.24  [AIR][Layout] repaired support air.bay.0 viable=1/5 slot=16754 at=2728,568
  4.24  [AIR][Rule] opening.support builder=25952
  4.24  [AIR][Rule] energy.grow builder=18537
  4.25  [AIR][Produce] recon.replace armpeep plant=14169 projected=1/1
  4.26  [Playtest] finished armwin team 0 at 4.26 min
  4.27  [AIR][Capacity] own=11/230 usage=1/24 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST M=11 bank=147 E=226 bank=1310 pull=24 plants=1/0 aircraftDemand=3/126
  4.27  [AIR][Projects] energyQueued=1 committed=270/3375
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=2
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.28  [AIR][Rule] commander.factory.guard builder=2274
  4.32  [AIR][Screen] fighters=7 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  4.37  [AIR][Commander] cleared factory guard for commander.energy.assist
  4.37  [AIR][Rule] commander.energy.assist builder=2274
  4.43  [AIR][Capacity] own=13/260 usage=11/120 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=440 shortage=78 reason=funded workload
  4.43  [AIR][Economy] T1_CONTEST M=13 bank=206 E=258 bank=1310 pull=144 plants=1/0 aircraftDemand=3/126
  4.43  [AIR][Projects] energyQueued=0 committed=267/3347
  4.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=228 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.45  [Playtest] finished armwin team 0 at 4.45 min
  4.46  [AIR][Rule] commander.factory.guard builder=2274
  4.47  [AIR][Rule] opening.support.assist builder=18537
  4.48  [AIR][Screen] fighters=7 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  4.51  [AIR][Produce] air.control armfig plant=14169 projected=8/8
  4.60  [AIR][Capacity] own=13/268 usage=5/197 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=117 reason=funded workload
  4.60  [AIR][Economy] T1_CONTEST M=13 bank=236 E=267 bank=995 pull=257 plants=1/0 aircraftDemand=3/126
  4.60  [AIR][Projects] energyQueued=0 committed=216/2848
  4.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=267 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+1/2 available=yes firstSlot=2
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=53
  4.65  [AIR][Screen] fighters=7 cells=8 centre=4176,1008 width=600 advance=400 responding=false
  4.69  [AIR][Produce] air.control armfig plant=14169 projected=9/9
  4.77  [AIR][Capacity] own=7/227 usage=6/200 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=90 shortage=31 reason=funded workload
  4.77  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=244 E=233 bank=2 pull=385 plants=1/0 aircraftDemand=3/126
  4.77  [AIR][Projects] energyQueued=0 committed=169/2306
  4.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=181 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+1/0 available=yes firstSlot=2
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.83  [AIR][Screen] fighters=8 cells=8 centre=4143,1402 width=1200 advance=795 responding=false
  4.84  [Playtest] finished armwin team 0 at 4.84 min
  4.86  [AIR][Rule] overflow.support.assist builder=19456
  4.93  [AIR][Capacity] own=6/208 usage=4/185 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=41 shortage=39 reason=funded workload
  4.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=274 E=216 bank=4 pull=296 plants=1/0 aircraftDemand=3/124
  4.93  [AIR][Projects] energyQueued=0 committed=144/2009
  4.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=189 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+1/0 available=yes firstSlot=2
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.95  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.95  [AIR][Rule] commander.idle.wait builder=2274
  5.00  [AIR][Screen] fighters=9 cells=8 centre=4143,1402 width=1200 advance=795 responding=false
  5.00  [Playtest] eco team 0 at 5.0 min: metal +13.0 bank 304/1400, energy +197.6 bank 281/1380, units 37
  5.00  [Playtest] target team 0 at (2801, 775) from its start position
  5.00  [Playtest] camera requested (2792,640) height=2200
  5.01  [Playtest] camera captured name=ta position=(2792,640) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (2792, 640)
  5.10  [AIR][Capacity] own=11/195 usage=0/17 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=176 reason=funded workload
  5.10  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=338 E=196 bank=745 pull=108 plants=1/0 aircraftDemand=3/125
  5.10  [AIR][Projects] energyQueued=0 committed=85/1184
  5.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=326 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
... 3424 more
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
  0.09  RESERVE: zone 7 at (1461, 9771) facing 2, 77x61 cells: 4060 of 4697 held
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
  0.18  EXP: approach: corcom(24492) at (3450, 9702) walks to (3423, 9683), 139 from the cormex site (3312, 9600)
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
