# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 16.1 min (frame 29010); wall 88 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T16:36:03
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=SUPPORT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_workforce_budget.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T193603Z-1cd22721\runs\20261003T193734Z-2cad4a2b\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `adoption` | seen at 0.5 min | `[WorkforceProbe] PASS named-state adoption support=12` |
| expect `sample` | seen at 0.1 min | `[AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload` |
| expect `donor-stop` | seen at 10.0 min | `[t=00:01:07.228562][f=0018000] [WorkforceFixture] donor stopped bursts=108` |
| expect `work` | seen at 1.0 min | `idle=1 guards=0 metal=404/19200 income=6.6 pull=55.1 received=0.0 energy=52093 incomeE=4568.8 usageM=55.1 usageE=152.8 sent=0.0 excess=0.0 workingBP=120.0 idleBP=120.0 nanoWorking=0 factoriesWorking=0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-076 unclaimed native nano order remains after AIR reconciliation` |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 14.5 min: [INVARIANT] INV-076 unclaimed native nano order remains after AIR reconciliation
- forbid 'invariant' hit at 15.5 min: [INVARIANT] INV-076 unclaimed native nano order remains after AIR reconciliation

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T193603Z-1cd22721\runs\20261003T193734Z-2cad4a2b\screen_2026-10-03_19-36-55-688.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T193603Z-1cd22721\runs\20261003T193734Z-2cad4a2b\screen_2026-10-03_19-37-03-851.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T193603Z-1cd22721\runs\20261003T193734Z-2cad4a2b\screen_2026-10-03_19-37-14-833.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T193603Z-1cd22721\runs\20261003T193734Z-2cad4a2b\screen_2026-10-03_19-37-29-792.png

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
  0.51  [Playtest] finished armmstor team 0 at 0.51 min
  0.51  [Playtest] finished armmstor team 0 at 0.51 min
  0.51  [Playtest] finished armmstor team 0 at 0.51 min
  0.51  [Playtest] finished armmstor team 0 at 0.51 min
  0.51  [Playtest] finished armmstor team 0 at 0.51 min
  0.51  [Playtest] finished armmstor team 0 at 0.51 min
  0.52  [AIR][Rule] opening.mex builder=5224
  0.52  [AIR][Layout] cluster=0 labs=6 at=2055,11617
  0.52  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 support=12 zone=134
  0.52  [AIR][Layout] cluster=1 labs=6 at=2535,11425
  0.52  [AIR][Rule] opening.plant builder=29542
  0.53  [Playtest] finished armmex team 0 at 0.53 min
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.53  [Playtest] finished armestor team 0 at 0.53 min
  0.53  [AIR][EcoLayout] reserved air.eco.1 reactor=1408,11792 converters=8 support=12 zone=283
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
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1037 E=30 bank=14647 pull=38 plants=0/0 aircraftDemand=0/0
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
  0.67  [Playtest] finished armdrag team 0 at 0.67 min
  0.77  [AIR][Capacity] own=6/4550 usage=19/92 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=120 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=928 E=4550 bank=52094 pull=92 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=1104/7999
  0.77  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=240 floating=false savingLab=false
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
  0.93  [AIR][Capacity] own=6/4561 usage=55/152 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=120 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=618 E=4561 bank=52100 pull=152 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=694/6769
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
  1.00  [Playtest] finished armap team 0 at 1.00 min
  1.00  [AIR][Claim] cancel unowned native order armnanotc
  1.00  [AIR][Claim] cancel unowned native order armnanotc
  1.00  [AIR][State] T1_CONTEST
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 404/19200, energy +4568.8 bank 52092/52200, units 27
  1.01  [AIR][Produce] opening.scout armpeep plant=1971 projected=1/1
  1.01  [AIR][Rule] mex.upgrade builder=29542
  1.10  [AIR][Capacity] own=6/4567 usage=12/256 gifts=0 sent=0 excess=0 pressure=true mobile=240 arriving=0 idle=0 ecoStatic=0 working=240 shortage=1864 reason=funded workload
  1.10  [AIR][Economy] T1_CONTEST M=6 bank=5395 E=4565 bank=52200 pull=256 plants=1/0 aircraftDemand=3/121
  1.10  [AIR][Projects] energyQueued=0 committed=1085/13479
  1.10  [AIR][Workforce] t1=0/3 t2=2/3 targetBP=2104 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
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
  1.17  [AIR][Produce] constructor.recovery armca plant=1971 projected=1/3
  1.27  [AIR][Capacity] own=6/4568 usage=8/109 gifts=0 sent=0 excess=0 pressure=true mobile=240 arriving=50 idle=0 ecoStatic=0 working=240 shortage=1968 reason=funded workload
  1.27  [AIR][Economy] T1_CONTEST M=6 bank=10289 E=4568 bank=52200 pull=298 plants=1/0 aircraftDemand=3/121
  1.27  [AIR][Projects] energyQueued=0 committed=985/12239
  1.27  [AIR][Workforce] t1=1/3 t2=2/3 targetBP=2258 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.27  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.35  [AIR][Growth] shared TECH economy enabled at M10=1006.6
  1.35  [AIR][State] T1_SCALE
  1.35  [AIR][Share] metal 19005 of 19200 (98%): sent 3840 to team 1 (39% full); the engine counts 0 metal sent in the last update (D-106)
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 16137) (D-106)
  1.39  [AIR][Produce] constructor.recovery armca plant=1971 projected=2/3
  1.39  [AIR][LabGate] M10=765 window=true bank=15143 cost=2900 reason=bank
  1.39  [AIR][Rule] production.banked builder=31863
  1.40  [AIR][State] T2_TRANSITION
  1.43  [AIR][Capacity] own=6/4568 usage=3/0 gifts=0 sent=0 excess=0 pressure=true mobile=290 arriving=50 idle=0 ecoStatic=0 working=240 shortage=1768 reason=funded workload
  1.43  [AIR][Economy] T2_TRANSITION M=765 bank=15133 E=4568 bank=52225 pull=189 plants=1/0 aircraftDemand=3/121
  1.43  [AIR][Projects] energyQueued=0 committed=3780/39950
  1.43  [AIR][Workforce] t1=2/3 t2=2/3 targetBP=2108 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.43  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/5 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.53  [AIR][Share] metal 18996 of 19200 (98%): sent 3840 to team 1 (77% full); the engine counts 0 metal sent in the last update (D-106)
  1.57  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 28013) (D-106)
  1.60  [AIR][Capacity] own=6/4573 usage=14/175 gifts=0 sent=0 excess=0 pressure=true mobile=290 arriving=50 idle=0 ecoStatic=0 working=240 shortage=1568 reason=funded workload
  1.60  [AIR][Economy] T2_TRANSITION M=6 bank=15104 E=4571 bank=52225 pull=364 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=3635/38257
  1.60  [AIR][Workforce] t1=2/3 t2=2/3 targetBP=1908 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.60  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.61  [AIR][Produce] constructor.recovery armca plant=1971 projected=3/3
  1.61  [AIR][Rule] mex.assist builder=20639
  1.62  [AIR][Share] metal 18993 of 19200 (98%): sent 896 to team 1 (97% full); the engine counts 0 metal sent in the last update (D-106)
  1.65  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30690) (D-106)
  1.77  [AIR][Capacity] own=6/4573 usage=14/163 gifts=19 sent=0 excess=0 pressure=true mobile=340 arriving=50 idle=0 ecoStatic=0 working=290 shortage=1368 reason=funded workload
  1.77  [AIR][Economy] T2_TRANSITION M=7 bank=19008 E=4573 bank=52250 pull=352 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=3479/36432
  1.77  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=1758 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.77  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.83  [AIR][Produce] opening.screen armfig plant=1971 projected=1/6
  1.83  [AIR][Rule] opening.support builder=29671
  1.84  [AIR][Commander] cleared factory guard for commander.idle.assist
  1.84  [AIR][Rule] commander.idle.assist builder=29509
  1.86  [AIR][Rule] commander.factory.guard builder=29509
  1.93  [AIR][Capacity] own=6/4578 usage=25/574 gifts=19 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=0 ecoStatic=0 working=290 shortage=1218 reason=funded workload
  1.93  [AIR][Economy] T2_TRANSITION M=21 bank=19008 E=4578 bank=52275 pull=574 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=3539/37634
  1.93  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=1608 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.93  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/3 available=yes firstSlot=2
  1.93  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 18988/19200, energy +4579.6 bank 52176/52275, units 34
  2.01  [Playtest] finished armaap team 0 at 2.01 min
  2.02  [AIR][Produce] opening.screen armfig plant=1971 projected=2/6
  2.02  [AIR][Screen] fighters=1 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.02  [AIR][State] T2_SUSTAIN
  2.02  [AIR][Produce] constructor.expand armaca plant=8690 projected=3/3
  2.06  [AIR][Commander] cleared factory guard for commander.local.assist
  2.06  [AIR][Rule] commander.local.assist builder=29509
  2.10  [AIR][Capacity] own=6/4577 usage=19/325 gifts=17 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=640 shortage=898 reason=funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=22 bank=19206 E=4578 bank=52422 pull=536 plants=1/1 aircraftDemand=3/127
  2.10  [AIR][Projects] energyQueued=0 committed=3336/35173
  2.10  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=1408 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.10  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.10  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.12  [AIR][Share] metal 19206 of 19400 (99%): sent 26 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.15  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30921) (D-106)
  2.18  [AIR][Screen] fighters=1 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.20  [AIR][Share] metal 19206 of 19400 (99%): sent 26 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.23  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30921) (D-106)
  2.27  [AIR][Capacity] own=6/4568 usage=19/325 gifts=28 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=640 shortage=698 reason=funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=26 bank=19206 E=4569 bank=52358 pull=536 plants=1/1 aircraftDemand=3/127
  2.27  [AIR][Projects] energyQueued=0 committed=3018/31108
  2.27  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=1208 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.27  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.27  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.28  [AIR][Share] metal 19206 of 19400 (99%): sent 26 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.31  [Playtest] finished armnanotc team 0 at 2.31 min
  2.32  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30925) (D-106)
  2.33  [AIR][Rule] mex.assist builder=29671
  2.33  [AIR][NanoGate] armcom 29509 can=no busy=no count=1
  2.35  [AIR][Screen] fighters=1 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.37  [AIR][Share] metal 19206 of 19400 (99%): sent 42 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.38  [AIR][Produce] opening.screen armfig plant=1971 projected=3/6
  2.38  [Playtest] finished armmoho team 0 at 2.38 min
  2.38  [AIR][Support] return to production bay=0
  2.40  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30690) (D-106)
  2.40  [AIR][Rule] mex.upgrade builder=5224
  2.43  [AIR][Capacity] own=6/4568 usage=46/721 gifts=2 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=170 shortage=322 reason=funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=33 bank=19351 E=4568 bank=52400 pull=721 plants=1/1 aircraftDemand=9/294
  2.43  [AIR][Projects] energyQueued=0 committed=3247/34482
  2.43  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=832 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.43  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+0/2 available=yes firstSlot=3
  2.43  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.45  [AIR][Share] metal 19800 of 20000 (99%): sent 28 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.48  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30909) (D-106)
  2.52  [AIR][Screen] fighters=2 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.53  [AIR][Share] metal 19800 of 20000 (99%): sent 35 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.57  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30898) (D-106)
  2.57  [AIR][Produce] opening.screen armfig plant=1971 projected=4/6
  2.58  [AIR][Support] return to production bay=0
  2.60  [AIR][Capacity] own=15/4569 usage=67/820 gifts=32 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=340 shortage=1968 reason=funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=49 bank=19800 E=4569 bank=52370 pull=820 plants=1/1 aircraftDemand=9/294
  2.60  [AIR][Projects] energyQueued=0 committed=2770/29409
  2.60  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=2478 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=online
  2.60  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+0/3 available=yes firstSlot=3
  2.60  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.62  [AIR][Share] metal 19800 of 20000 (99%): sent 35 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.65  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30894) (D-106)
  2.68  [AIR][Screen] fighters=3 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.70  [AIR][Share] metal 19800 of 20000 (99%): sent 35 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.73  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30894) (D-106)
  2.77  [AIR][Produce] opening.screen armfig plant=1971 projected=5/6
  2.77  [AIR][Capacity] own=15/4570 usage=53/808 gifts=37 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=340 shortage=1767 reason=funded workload
  2.77  [AIR][Economy] T2_SUSTAIN M=53 bank=19800 E=4570 bank=52475 pull=808 plants=1/1 aircraftDemand=9/294
  2.77  [AIR][Projects] energyQueued=0 committed=2311/24467
  2.77  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=2277 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=online
  2.77  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+0/3 available=yes firstSlot=3
  2.77  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.78  [AIR][Support] return to production bay=0
  2.78  [AIR][Share] metal 19800 of 20000 (99%): sent 49 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.82  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30867) (D-106)
  2.82  [Playtest] finished armmoho team 0 at 2.82 min
  2.84  [AIR][Rule] mex.assist builder=29542
  2.87  [AIR][Screen] fighters=4 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.93  [AIR][Capacity] own=15/4566 usage=47/754 gifts=23 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=320 shortage=1092 reason=funded workload
  2.93  [AIR][Economy] T2_SUSTAIN M=51 bank=20344 E=4568 bank=52475 pull=754 plants=1/1 aircraftDemand=9/294
  2.93  [AIR][Projects] energyQueued=0 committed=1865/19787
  2.93  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=1602 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.93  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+0/3 available=yes firstSlot=3
  2.93  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
... 2846 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(29509) at (2175, 11785) walks to (2216, 11852), 136 from the armmex site (2288, 11968)
  0.30  EXP: approach: armcom(29509) at (2253, 11912) walks to (2296, 11670), 136 from the armmex site (2320, 11536)
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
