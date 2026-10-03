# Playtest report: PASS

- Verdict: **PASS** (reached 16 min)
- Game time reached: 16.2 min (frame 29130); wall 132 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:46:28
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=SUPPORT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_workforce_budget.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T174628Z-6be0262c\runs\20261003T174844Z-889a51fd\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `adoption` | seen at 0.5 min | `[WorkforceProbe] PASS named-state adoption support=12` |
| expect `sample` | seen at 0.1 min | `[AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload` |
| expect `donor-stop` | seen at 10.0 min | `[t=00:01:41.218614][f=0018000] [WorkforceFixture] donor stopped bursts=108` |
| expect `work` | seen at 1.0 min | `2 idle=0 guards=0 metal=416/19100 income=6.6 pull=55.1 received=0.0 energy=52081 incomeE=4560.8 usageM=55.1 usageE=152.8 sent=0.0 excess=0.0 workingBP=240.0 idleBP=0.0 nanoWorking=0 factoriesWorking=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T174628Z-6be0262c\runs\20261003T174844Z-889a51fd\screen_2026-10-03_17-47-43-207.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T174628Z-6be0262c\runs\20261003T174844Z-889a51fd\screen_2026-10-03_17-47-59-136.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T174628Z-6be0262c\runs\20261003T174844Z-889a51fd\screen_2026-10-03_17-48-15-575.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-lifecycle\supreme\20261003T174628Z-6be0262c\runs\20261003T174844Z-889a51fd\screen_2026-10-03_17-48-38-561.png

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
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.54  [Playtest] finished armfus team 0 at 0.54 min
  0.54  [AIR][Wind] cluster=0 slots=6 at=2328,11696 local=true builder=29509
  0.54  [AIR][Rule] opening.energy builder=29509
  0.55  [AIR][EcoLayout] reserved air.eco.2 reactor=3200,11280 converters=8 support=12 zone=311
  0.57  [AIR][EcoLayout] reserved air.eco.3 reactor=4096,11664 converters=8 support=12 zone=344
  0.60  [AIR][Capacity] own=4/30 usage=7/38 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1037 E=30 bank=16893 pull=38 plants=0/0 aircraftDemand=0/0
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
  0.77  [AIR][Capacity] own=6/4550 usage=19/92 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=120 shortage=21 reason=funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=928 E=4550 bank=52094 pull=92 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=1104/7999
  0.77  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=261 floating=false savingLab=false
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
  0.93  [AIR][Capacity] own=6/4560 usage=55/152 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=120 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=652 E=4561 bank=52068 pull=152 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=728/6826
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 416/19100, energy +4560.8 bank 52081/52100, units 27
  1.00  [Playtest] finished armap team 0 at 1.00 min
  1.02  [AIR][Produce] opening.scout armpeep plant=1971 projected=1/1
  1.02  [AIR][Claim] cancel unowned native order armnanotc
  1.02  [AIR][State] T1_CONTEST
  1.02  [AIR][Rule] mex.upgrade builder=29542
  1.10  [AIR][Capacity] own=6/4560 usage=10/239 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=120 shortage=16 reason=funded workload
  1.10  [AIR][Economy] T1_CONTEST M=6 bank=398 E=4560 bank=52200 pull=239 plants=1/0 aircraftDemand=3/121
  1.10  [AIR][Projects] energyQueued=0 committed=1090/13541
  1.10  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=256 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.10  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.17  [AIR][Produce] constructor.recovery armca plant=1971 projected=1/3
  1.27  [AIR][Capacity] own=6/4561 usage=13/188 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=50 idle=0 ecoStatic=0 working=240 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T1_CONTEST M=6 bank=297 E=4561 bank=52158 pull=319 plants=1/0 aircraftDemand=3/121
  1.27  [AIR][Projects] energyQueued=0 committed=990/12301
  1.27  [AIR][Workforce] t1=1/3 t2=2/2 targetBP=290 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.27  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.40  [AIR][Produce] constructor.recovery armca plant=1971 projected=2/3
  1.41  [AIR][LabGate] M10=6 window=true bank=5588 cost=2900 reason=bank
  1.41  [AIR][Rule] production.banked builder=31863
  1.42  [AIR][State] T2_TRANSITION
  1.43  [AIR][Capacity] own=6/4562 usage=2/0 gifts=0 sent=0 excess=0 pressure=true mobile=290 arriving=50 idle=0 ecoStatic=0 working=240 shortage=1908 reason=funded workload
  1.43  [AIR][Economy] T2_TRANSITION M=6 bank=5582 E=4562 bank=52225 pull=178 plants=1/0 aircraftDemand=3/121
  1.43  [AIR][Projects] energyQueued=0 committed=3786/40021
  1.43  [AIR][Workforce] t1=2/3 t2=2/3 targetBP=2248 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.43  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=20639 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.60  [AIR][Capacity] own=6/4571 usage=14/175 gifts=2 sent=0 excess=0 pressure=true mobile=290 arriving=50 idle=0 ecoStatic=0 working=240 shortage=1708 reason=funded workload
  1.60  [AIR][Economy] T2_TRANSITION M=6 bank=12435 E=4568 bank=52225 pull=364 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=3641/38328
  1.60  [AIR][Workforce] t1=2/3 t2=2/3 targetBP=2048 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.60  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=20639 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.60  [AIR][Share] metal 18419 of 19200 (95%): sent 310 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.61  [AIR][Produce] constructor.recovery armca plant=1971 projected=3/3
  1.61  [AIR][Rule] mex.assist builder=23975
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30690) (D-106)
  1.70  [AIR][Growth] shared TECH economy enabled at M10=208.603
  1.77  [AIR][Capacity] own=6/4572 usage=14/167 gifts=19 sent=0 excess=0 pressure=true mobile=340 arriving=50 idle=0 ecoStatic=0 working=290 shortage=1508 reason=funded workload
  1.77  [AIR][Economy] T2_TRANSITION M=137 bank=19008 E=4572 bank=52250 pull=356 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=3486/36516
  1.77  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=1898 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.77  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/5 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=20639 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.83  [AIR][Commander] cleared factory guard for commander.idle.assist
  1.83  [AIR][Rule] commander.idle.assist builder=29509
  1.84  [AIR][Produce] opening.screen armfig plant=1971 projected=1/6
  1.84  [AIR][Rule] opening.support builder=29671
  1.93  [AIR][Capacity] own=6/4579 usage=34/470 gifts=14 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=0 ecoStatic=0 working=340 shortage=1358 reason=funded workload
  1.93  [AIR][Economy] T2_TRANSITION M=24 bank=19008 E=4578 bank=52275 pull=500 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=3477/37007
  1.93  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=1748 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.93  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/4 available=yes firstSlot=2
  1.93  [AIR][Bay] 1 plant=20639 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 18966/19200, energy +4584.0 bank 52168/52275, units 35
  2.02  [Playtest] finished armaap team 0 at 2.02 min
  2.03  [AIR][Produce] constructor.expand armaca plant=20311 projected=3/3
  2.03  [AIR][State] T2_SUSTAIN
  2.10  [AIR][Capacity] own=6/4583 usage=46/597 gifts=42 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=340 shortage=1038 reason=funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=26 bank=19206 E=4583 bank=52475 pull=627 plants=1/1 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=3017/32034
  2.10  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=1548 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.10  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.10  [AIR][Bay] 1 plant=20639 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.24  [AIR][Produce] opening.screen armfig plant=1971 projected=2/6
  2.24  [AIR][Screen] fighters=1 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.27  [AIR][Capacity] own=6/4583 usage=43/473 gifts=42 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=340 shortage=838 reason=funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=44 bank=19206 E=4583 bank=52475 pull=503 plants=1/1 aircraftDemand=4/128
  2.27  [AIR][Projects] energyQueued=0 committed=2558/27062
  2.27  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=1348 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.27  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.27  [AIR][Bay] 1 plant=20639 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.38  [Playtest] finished armmoho team 0 at 2.38 min
  2.40  [AIR][Rule] mex.upgrade builder=5224
  2.42  [AIR][Screen] fighters=1 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.43  [AIR][Capacity] own=6/4583 usage=39/529 gifts=231 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=170 shortage=538 reason=funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=48 bank=19386 E=4583 bank=52475 pull=559 plants=1/1 aircraftDemand=4/128
  2.43  [AIR][Projects] energyQueued=0 committed=2739/30047
  2.43  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=1048 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.43  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/3 available=yes firstSlot=2
  2.43  [AIR][Bay] 1 plant=20639 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.58  [AIR][Screen] fighters=1 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.60  [AIR][Capacity] own=15/4582 usage=46/617 gifts=33 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=340 shortage=2118 reason=funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=44 bank=19800 E=4583 bank=52475 pull=647 plants=1/1 aircraftDemand=4/128
  2.60  [AIR][Projects] energyQueued=0 committed=2301/25342
  2.60  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=2628 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=online
  2.60  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.60  [AIR][Bay] 1 plant=20639 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.60  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.66  [AIR][Produce] opening.screen armfig plant=1971 projected=3/6
  2.68  [AIR][Share] metal 19800 of 20000 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  2.77  [AIR][Capacity] own=15/4577 usage=46/617 gifts=33 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=340 shortage=1917 reason=funded workload
  2.77  [AIR][Economy] T2_SUSTAIN M=46 bank=19800 E=4577 bank=52475 pull=647 plants=1/1 aircraftDemand=4/128
  2.77  [AIR][Projects] energyQueued=0 committed=1841/20369
  2.77  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=2427 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=online
  2.77  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/3 available=yes firstSlot=2
  2.77  [AIR][Bay] 1 plant=20639 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.77  [AIR][Screen] fighters=2 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.93  [AIR][Capacity] own=15/4574 usage=46/617 gifts=33 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=340 shortage=1717 reason=funded workload
  2.93  [AIR][Economy] T2_SUSTAIN M=44 bank=19800 E=4575 bank=52373 pull=647 plants=1/1 aircraftDemand=4/128
  2.93  [AIR][Projects] energyQueued=0 committed=1382/15396
  2.93  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=2227 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=online
  2.93  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.93  [AIR][Bay] 1 plant=20639 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.93  [AIR][Screen] fighters=2 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.96  [Playtest] finished armmoho team 0 at 2.96 min
  2.97  [AIR][Rule] mex.assist builder=29542
  3.00  [Playtest] eco team 0 at 3.0 min: metal +22.7 bank 20069/20550, energy +4573.3 bank 52342/52475, units 38
  3.00  [Playtest] target team 0 at (2155, 11747) from its start position
  3.00  [Playtest] camera requested (1976,11232) height=2200
  3.02  [Playtest] camera captured name=ta position=(1976,11232) height=2200
  3.02  [Playtest] screenshot at 3.0 min of team 0 at (1976, 11232)
  3.06  [AIR][Produce] opening.screen armfig plant=1971 projected=4/6
  3.10  [AIR][Capacity] own=15/4572 usage=39/468 gifts=18 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=219 shortage=1189 reason=funded workload
  3.10  [AIR][Economy] T2_SUSTAIN M=49 bank=20344 E=4572 bank=52336 pull=498 plants=1/1 aircraftDemand=4/128
  3.10  [AIR][Projects] energyQueued=0 committed=973/11058
  3.10  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=1699 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  3.10  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/3 available=yes firstSlot=2
  3.10  [AIR][Bay] 1 plant=20639 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Screen] fighters=3 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  3.10  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.27  [AIR][Capacity] own=22/4572 usage=46/634 gifts=26 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=340 shortage=879 reason=funded workload
  3.27  [AIR][Economy] T2_SUSTAIN M=42 bank=20344 E=4572 bank=52475 pull=664 plants=1/1 aircraftDemand=4/128
  3.27  [AIR][Projects] energyQueued=0 committed=527/6250
  3.27  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=1389 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
... 2411 more
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
