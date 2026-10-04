# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 16.1 min (frame 29017); wall 128 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:35:08
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=SUPPORT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_workforce_budget.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T173508Z-a30dd71d\runs\20261003T173720Z-6f976a48\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `adoption` | seen at 0.5 min | `[WorkforceProbe] PASS named-state adoption support=12` |
| expect `sample` | seen at 0.1 min | `[AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload` |
| expect `donor-stop` | seen at 10.0 min | `[t=00:01:39.124233][f=0018000] [WorkforceFixture] donor stopped bursts=108` |
| expect `work` | seen at 1.0 min | `2 idle=0 guards=0 metal=438/19100 income=6.6 pull=55.1 received=0.0 energy=52080 incomeE=4558.5 usageM=55.1 usageE=152.8 sent=0.0 excess=0.0 workingBP=240.0 idleBP=0.0 nanoWorking=0 factoriesWorking=0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-076 unclaimed native nano order remains after AIR reconciliation` |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 14.5 min: [INVARIANT] INV-076 unclaimed native nano order remains after AIR reconciliation
- forbid 'invariant' hit at 15.5 min: [INVARIANT] INV-076 unclaimed native nano order remains after AIR reconciliation

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T173508Z-a30dd71d\runs\20261003T173720Z-6f976a48\screen_2026-10-03_17-36-17-132.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T173508Z-a30dd71d\runs\20261003T173720Z-6f976a48\screen_2026-10-03_17-36-32-850.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T173508Z-a30dd71d\runs\20261003T173720Z-6f976a48\screen_2026-10-03_17-36-52-674.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T173508Z-a30dd71d\runs\20261003T173720Z-6f976a48\screen_2026-10-03_17-37-12-149.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 4 shots, end at 16.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4700, 11000) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 29
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (4700, 11000) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 29
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
  0.10  [Team][Roster] Team 1 (AI 1): role=SUPPORT side=armada start=(4700,10997) factory=armlab landLocked=no spot=7 known=1/1
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=6 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=990 E=18 bank=911 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.30  [AIR][Rule] opening.mex builder=29509
  0.30  [Team][Roster] first mex 27610 at 2288,11968
  0.30  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2175|11785|0|2|1|2288|11968
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=2 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=5 bank=1032 E=30 bank=988 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=46/463
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.52  [AIR][Layout] cluster=0 labs=6 at=2055,11617
  0.52  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 support=12 zone=134
  0.52  [AIR][Layout] cluster=1 labs=6 at=2535,11425
  0.52  [Playtest] finished armmstor team 0 at 0.52 min
  0.52  [Playtest] finished armmstor team 0 at 0.52 min
  0.52  [Playtest] finished armmstor team 0 at 0.52 min
  0.52  [Playtest] finished armmstor team 0 at 0.52 min
  0.52  [Playtest] finished armmstor team 0 at 0.52 min
  0.52  [Playtest] finished armmstor team 0 at 0.52 min
  0.52  [AIR][Rule] opening.mex builder=29542
  0.53  [AIR][Rule] opening.plant builder=5224
  0.53  [Playtest] finished armmex team 0 at 0.53 min
  0.53  [AIR][EcoLayout] reserved air.eco.1 reactor=1408,11792 converters=8 support=12 zone=283
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.54  [AIR][Wind] cluster=0 slots=6 at=2328,11696 local=true builder=29509
  0.54  [AIR][Rule] opening.energy builder=29509
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.55  [AIR][EcoLayout] reserved air.eco.2 reactor=3200,11280 converters=8 support=12 zone=311
  0.57  [AIR][EcoLayout] reserved air.eco.3 reactor=4096,11664 converters=8 support=12 zone=344
  0.60  [AIR][Capacity] own=4/30 usage=7/38 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1037 E=30 bank=16129 pull=38 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=1291/8894
  0.60  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=240 floating=false savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=online
  0.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.65  [Playtest] finished armwin team 0 at 0.65 min
  0.66  [AIR][Rule] opening.commander.guard builder=29509
  0.68  [Playtest] finished armdrag team 0 at 0.68 min
  0.77  [AIR][Capacity] own=6/4550 usage=19/92 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=120 shortage=25 reason=funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=937 E=4403 bank=52091 pull=92 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=1114/8042
  0.77  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=265 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  0.77  [AIR][Bay] 0 plant=1971 BP=0 nanos=0+0/1 available=yes firstSlot=0
  0.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.83  [AIR][EcoLayout] relocate blocked unused air.eco.0
  0.83  [AIR][EcoLayout] reserved air.eco.0 reactor=2688,11920 converters=8 support=12 zone=366
  0.93  [AIR][Capacity] own=6/4559 usage=55/152 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=120 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=659 E=4559 bank=52100 pull=152 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=735/6865
  0.93  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=240 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  0.93  [AIR][Bay] 0 plant=1971 BP=0 nanos=0+0/1 available=yes firstSlot=0
  0.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 438/19100, energy +4558.5 bank 52080/52100, units 27
  1.01  [Playtest] finished armap team 0 at 1.01 min
  1.02  [AIR][State] T1_CONTEST
  1.02  [AIR][Produce] opening.scout armpeep plant=1971 projected=1/1
  1.02  [AIR][LabGate] M10=6 window=true bank=5408 cost=2900 reason=bank
  1.02  [AIR][Rule] production.banked builder=5224
  1.03  [AIR][State] T2_TRANSITION
  1.10  [AIR][Capacity] own=6/4558 usage=10/239 gifts=0 sent=0 excess=0 pressure=true mobile=240 arriving=0 idle=0 ecoStatic=0 working=120 shortage=1778 reason=funded workload
  1.10  [AIR][Economy] T2_TRANSITION M=6 bank=5404 E=4558 bank=52200 pull=239 plants=1/0 aircraftDemand=3/121
  1.10  [AIR][Projects] energyQueued=0 committed=3374/34887
  1.10  [AIR][Workforce] t1=0/3 t2=2/3 targetBP=2018 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.10  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.19  [AIR][Produce] constructor.recovery armca plant=1971 projected=1/3
  1.27  [AIR][Capacity] own=6/4559 usage=17/214 gifts=0 sent=0 excess=0 pressure=true mobile=240 arriving=50 idle=0 ecoStatic=0 working=120 shortage=1528 reason=funded workload
  1.27  [AIR][Economy] T2_TRANSITION M=6 bank=10264 E=4559 bank=52200 pull=365 plants=1/0 aircraftDemand=3/121
  1.27  [AIR][Projects] energyQueued=0 committed=3221/33237
  1.27  [AIR][Workforce] t1=1/3 t2=2/3 targetBP=1818 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.27  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=28358 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.41  [AIR][Produce] constructor.recovery armca plant=1971 projected=2/3
  1.41  [AIR][Rule] mex.assist builder=31863
  1.43  [AIR][Capacity] own=6/4559 usage=17/199 gifts=0 sent=0 excess=0 pressure=false mobile=290 arriving=50 idle=0 ecoStatic=0 working=120 shortage=1228 reason=funded workload
  1.43  [AIR][Economy] T2_TRANSITION M=6 bank=10084 E=4560 bank=52225 pull=199 plants=1/0 aircraftDemand=3/121
  1.43  [AIR][Projects] energyQueued=0 committed=3062/31529
  1.43  [AIR][Workforce] t1=2/3 t2=2/3 targetBP=1568 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.43  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=28358 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Capacity] own=6/4563 usage=17/202 gifts=0 sent=0 excess=0 pressure=true mobile=290 arriving=50 idle=0 ecoStatic=0 working=169 shortage=1020 reason=funded workload
  1.60  [AIR][Economy] T2_TRANSITION M=6 bank=14889 E=4561 bank=52225 pull=391 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=2889/29640
  1.60  [AIR][Workforce] t1=2/3 t2=2/3 targetBP=1360 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.60  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=28358 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [AIR][Share] metal 19008 of 19200 (99%): sent 1021 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  1.63  [AIR][Produce] constructor.recovery armca plant=1971 projected=3/3
  1.63  [AIR][Rule] mex.assist builder=23975
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30690) (D-106)
  1.77  [AIR][Capacity] own=6/4564 usage=17/182 gifts=23 sent=0 excess=0 pressure=true mobile=340 arriving=50 idle=0 ecoStatic=0 working=220 shortage=653 reason=funded workload
  1.77  [AIR][Economy] T2_TRANSITION M=8 bank=19008 E=4564 bank=52250 pull=371 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=2701/27570
  1.77  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=1043 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.77  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=28358 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.85  [AIR][Produce] opening.screen armfig plant=1971 projected=1/6
  1.85  [AIR][Rule] opening.support builder=20639
  1.93  [AIR][Commander] cleared factory guard for opening.support.assist
  1.93  [AIR][Rule] opening.support.assist builder=29509
  1.93  [AIR][Capacity] own=6/4574 usage=25/435 gifts=16 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=0 ecoStatic=0 working=270 shortage=516 reason=funded workload
  1.93  [AIR][Economy] T2_TRANSITION M=24 bank=19008 E=4574 bank=52275 pull=465 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=2726/28483
  1.93  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=906 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.93  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/4 available=yes firstSlot=2
  1.93  [AIR][Bay] 1 plant=28358 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 18976/19200, energy +4583.8 bank 52180/52275, units 34
  2.02  [AIR][Share] metal 19008 of 19200 (99%): sent 143 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.02  [Playtest] finished armaap team 0 at 2.02 min
  2.03  [AIR][Produce] constructor.expand armaca plant=8690 projected=3/3
  2.03  [AIR][State] T2_SUSTAIN
  2.05  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30970) (D-106)
  2.10  [AIR][Capacity] own=6/4582 usage=23/352 gifts=31 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=570 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=23 bank=19206 E=4581 bank=52475 pull=564 plants=1/1 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=2384/24284
  2.10  [AIR][Workforce] t1=3/3 t2=2/3 targetBP=510 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  2.10  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.10  [AIR][Bay] 1 plant=28358 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.18  [AIR][Produce] opening.screen armfig plant=1971 projected=2/6
  2.18  [AIR][Screen] fighters=1 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.19  [Playtest] finished armmoho team 0 at 2.19 min
  2.19  [Playtest] finished armnanotc team 0 at 2.19 min
  2.20  [AIR][Rule] mex.upgrade builder=29542
  2.21  [AIR][Reclaim] armwin id=6397 worker=23975
  2.21  [AIR][Rule] energy.reclaim builder=23975
  2.21  [AIR][NanoGate] armca 31863 can=yes busy=no count=1
  2.21  [AIR][Rule] overflow.support builder=31863
  2.21  [AIR][NanoGate] armca 20639 can=yes busy=yes count=1
  2.21  [AIR][Rule] overflow.support builder=20639
  2.22  [AIR][NanoGate] armcom 29509 can=no busy=yes count=1
  2.22  [AIR][Rule] commander.factory.guard builder=29509
  2.27  [AIR][Capacity] own=6/4578 usage=21/557 gifts=2 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=49 shortage=695 reason=funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=33 bank=19511 E=4578 bank=52185 pull=587 plants=1/1 aircraftDemand=9/294
  2.27  [AIR][Projects] energyQueued=0 committed=3219/35480
  2.27  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=1205 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  2.27  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+0/2 available=yes firstSlot=3
  2.27  [AIR][Bay] 1 plant=28358 BP=0 nanos=0+1/20 available=yes firstSlot=2
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.32  [AIR][Commander] cleared factory guard for commander.local.assist
  2.32  [AIR][Rule] commander.local.assist builder=29509
  2.33  [AIR][Produce] opening.screen armfig plant=1971 projected=3/6
  2.35  [AIR][Support] return to production bay=0
  2.37  [AIR][Screen] fighters=2 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.43  [AIR][Capacity] own=15/4578 usage=23/486 gifts=24 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=520 shortage=2057 reason=funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=33 bank=19800 E=4578 bank=52197 pull=728 plants=1/1 aircraftDemand=9/294
  2.43  [AIR][Projects] energyQueued=0 committed=2913/31711
  2.43  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=2567 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.43  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+1/2 available=yes firstSlot=3
  2.43  [AIR][Bay] 1 plant=28358 BP=0 nanos=0+1/20 available=yes firstSlot=2
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.53  [AIR][Screen] fighters=2 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.54  [AIR][Produce] opening.screen armfig plant=1971 projected=4/6
  2.54  [Playtest] finished armnanotc team 0 at 2.54 min
  2.56  [AIR][Rule] mex.assist builder=31863
  2.56  [AIR][Rule] commander.factory.guard builder=29509
  2.57  [AIR][Support] return to production bay=0
  2.60  [AIR][Capacity] own=15/4578 usage=36/785 gifts=15 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=176 shortage=1757 reason=funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=35 bank=19800 E=4578 bank=52475 pull=819 plants=1/1 aircraftDemand=14/453
  2.60  [AIR][Projects] energyQueued=0 committed=2614/28047
  2.60  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=2267 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.60  [AIR][Bay] 0 plant=1971 BP=550 nanos=2+0/2 available=yes firstSlot=3
  2.60  [AIR][Bay] 1 plant=28358 BP=0 nanos=0+1/20 available=yes firstSlot=2
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.65  [AIR][Produce] opening.screen armfig plant=1971 projected=5/6
  2.67  [AIR][Support] return to production bay=0
  2.72  [AIR][Screen] fighters=4 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.76  [AIR][NanoGate] armcom 29509 can=no busy=yes count=3
  2.76  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.76  [AIR][Rule] commander.idle.assist builder=29509
  2.76  [AIR][Produce] opening.screen armfig plant=1971 projected=6/6
  2.77  [AIR][Capacity] own=15/4580 usage=18/568 gifts=22 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=493 shortage=1543 reason=funded workload
  2.77  [AIR][Economy] T2_SUSTAIN M=33 bank=19800 E=4579 bank=52328 pull=763 plants=1/1 aircraftDemand=14/453
  2.77  [AIR][Projects] energyQueued=0 committed=2362/25076
  2.77  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=2053 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.77  [AIR][Bay] 0 plant=1971 BP=550 nanos=2+0/2 available=yes firstSlot=3
  2.77  [AIR][Bay] 1 plant=28358 BP=0 nanos=0+1/20 available=yes firstSlot=2
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Rule] commander.factory.guard builder=29509
  2.78  [AIR][Support] return to production bay=0
  2.83  [AIR][Rule] mex.assist builder=23975
  2.87  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.87  [AIR][Rule] commander.idle.assist builder=29509
  2.88  [AIR][Produce] constructor.expand armca plant=1971 projected=4/4
  2.90  [AIR][Rule] commander.factory.guard builder=29509
  2.90  [AIR][Support] return to production bay=0
  2.92  [AIR][Screen] fighters=6 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.93  [AIR][Capacity] own=15/4565 usage=54/554 gifts=21 sent=0 excess=0 pressure=true mobile=390 arriving=170 idle=0 ecoStatic=0 working=269 shortage=1113 reason=funded workload
  2.93  [AIR][Economy] T2_SUSTAIN M=29 bank=19800 E=4565 bank=52475 pull=758 plants=1/1 aircraftDemand=14/447
  2.93  [AIR][Projects] energyQueued=0 committed=2021/21147
  2.93  [AIR][Workforce] t1=4/5 t2=2/4 targetBP=1673 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.93  [AIR][Bay] 0 plant=1971 BP=550 nanos=2+0/2 available=yes firstSlot=3
  2.93  [AIR][Bay] 1 plant=28358 BP=0 nanos=0+1/20 available=yes firstSlot=2
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.98  [Playtest] finished armnanotc team 0 at 2.98 min
  2.99  [AIR][Rule] mex.assist builder=20639
... 2963 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(29509) at (2175, 11785) walks to (2216, 11852), 136 from the armmex site (2288, 11968)
  0.30  EXP: approach: armcom(29509) at (2253, 11911) walks to (2296, 11670), 136 from the armmex site (2320, 11536)
  0.52  RESERVE: zone 1 at (1976, 11232) facing 2, 9x6 cells: 54 of 54 held
  0.52  RESERVE: armap at (1976, 11232) facing 2 (id 1)
  0.52  RESERVE: zone 2 at (2024, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (2024, 11304) facing 2 (id 2)
  0.52  RESERVE: zone 3 at (1976, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1976, 11304) facing 2 (id 3)
  0.52  RESERVE: zone 4 at (1928, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1928, 11304) facing 2 (id 4)
  0.52  RESERVE: zone 5 at (2024, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (2024, 11352) facing 2 (id 5)
  0.52  RESERVE: zone 6 at (1976, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1976, 11352) facing 2 (id 6)
  0.52  RESERVE: zone 7 at (1832, 11208) facing 2, 9x9 cells: 81 of 81 held
  0.52  RESERVE: armaap at (1832, 11208) facing 2 (id 7)
  0.52  RESERVE: zone 8 at (1880, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1880, 11304) facing 2 (id 8)
  0.52  RESERVE: zone 9 at (1832, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1832, 11304) facing 2 (id 9)
  0.52  RESERVE: zone 10 at (1784, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1784, 11304) facing 2 (id 10)
  0.52  RESERVE: zone 11 at (1880, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1880, 11352) facing 2 (id 11)
  0.52  RESERVE: zone 12 at (1832, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1832, 11352) facing 2 (id 12)
  0.52  RESERVE: zone 13 at (1784, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1784, 11352) facing 2 (id 13)
  0.52  RESERVE: zone 14 at (1880, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1880, 11400) facing 2 (id 14)
  0.52  RESERVE: zone 15 at (1832, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1832, 11400) facing 2 (id 15)
  0.52  RESERVE: zone 16 at (1784, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1784, 11400) facing 2 (id 16)
  0.52  RESERVE: zone 17 at (1880, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1880, 11448) facing 2 (id 17)
  0.52  RESERVE: zone 18 at (1832, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1832, 11448) facing 2 (id 18)
  0.52  RESERVE: zone 19 at (1784, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1784, 11448) facing 2 (id 19)
  0.52  RESERVE: zone 20 at (1880, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1880, 11496) facing 2 (id 20)
  0.52  RESERVE: zone 21 at (1832, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1832, 11496) facing 2 (id 21)
  0.52  RESERVE: zone 22 at (1784, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1784, 11496) facing 2 (id 22)
  0.52  RESERVE: zone 23 at (1880, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1880, 11544) facing 2 (id 23)
  0.52  RESERVE: zone 24 at (1832, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1832, 11544) facing 2 (id 24)
  0.52  RESERVE: zone 25 at (1784, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1784, 11544) facing 2 (id 25)
  0.52  RESERVE: zone 26 at (1880, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1880, 11592) facing 2 (id 26)
  0.52  RESERVE: zone 27 at (1832, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1832, 11592) facing 2 (id 27)
  0.52  RESERVE: zone 28 at (1688, 11208) facing 2, 9x9 cells: 81 of 81 held
  0.52  RESERVE: armaap at (1688, 11208) facing 2 (id 28)
  0.52  RESERVE: zone 29 at (1736, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1736, 11304) facing 2 (id 29)
  0.52  RESERVE: zone 30 at (1688, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1688, 11304) facing 2 (id 30)
  0.52  RESERVE: zone 31 at (1640, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1640, 11304) facing 2 (id 31)
  0.52  RESERVE: zone 32 at (1736, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1736, 11352) facing 2 (id 32)
  0.52  RESERVE: zone 33 at (1688, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1688, 11352) facing 2 (id 33)
  0.52  RESERVE: zone 34 at (1640, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1640, 11352) facing 2 (id 34)
  0.52  RESERVE: zone 35 at (1736, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1736, 11400) facing 2 (id 35)
  0.52  RESERVE: zone 36 at (1688, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1688, 11400) facing 2 (id 36)
  0.52  RESERVE: zone 37 at (1640, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1640, 11400) facing 2 (id 37)
  0.52  RESERVE: zone 38 at (1736, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1736, 11448) facing 2 (id 38)
  0.52  RESERVE: zone 39 at (1688, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1688, 11448) facing 2 (id 39)
  0.52  RESERVE: zone 40 at (1640, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1640, 11448) facing 2 (id 40)
  0.52  RESERVE: zone 41 at (1736, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1736, 11496) facing 2 (id 41)
  0.52  RESERVE: zone 42 at (1688, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1688, 11496) facing 2 (id 42)
  0.52  RESERVE: zone 43 at (1640, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1640, 11496) facing 2 (id 43)
  0.52  RESERVE: zone 44 at (1736, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1736, 11544) facing 2 (id 44)
  0.52  RESERVE: zone 45 at (1688, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1688, 11544) facing 2 (id 45)
  0.52  RESERVE: zone 46 at (1640, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1640, 11544) facing 2 (id 46)
  0.52  RESERVE: zone 47 at (1736, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1736, 11592) facing 2 (id 47)
  0.52  RESERVE: zone 48 at (1688, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1688, 11592) facing 2 (id 48)
  0.52  RESERVE: zone 49 at (1976, 10728) facing 2, 9x9 cells: 81 of 81 held
  0.52  RESERVE: armaap at (1976, 10728) facing 2 (id 49)
  0.52  RESERVE: zone 50 at (2024, 10824) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (2024, 10824) facing 2 (id 50)
  0.52  RESERVE: zone 51 at (1976, 10824) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1976, 10824) facing 2 (id 51)
  0.52  RESERVE: zone 52 at (1928, 10824) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1928, 10824) facing 2 (id 52)
  0.52  RESERVE: zone 53 at (2024, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (2024, 10872) facing 2 (id 53)
  0.52  RESERVE: zone 54 at (1976, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1976, 10872) facing 2 (id 54)
  0.52  RESERVE: zone 55 at (1928, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1928, 10872) facing 2 (id 55)
  0.52  RESERVE: zone 56 at (2024, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (2024, 10920) facing 2 (id 56)
  0.52  RESERVE: zone 57 at (1976, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1976, 10920) facing 2 (id 57)
  0.52  RESERVE: zone 58 at (1928, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (1928, 10920) facing 2 (id 58)
  0.52  RESERVE: zone 59 at (2024, 10968) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: armnanotc at (2024, 10968) facing 2 (id 59)
```
