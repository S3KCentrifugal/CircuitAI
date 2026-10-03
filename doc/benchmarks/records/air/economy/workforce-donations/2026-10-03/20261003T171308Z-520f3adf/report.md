# Playtest report: PASS

- Verdict: **PASS** (reached 16 min)
- Game time reached: 16.0 min (frame 28889); wall 93 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:11:33
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=SUPPORT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_workforce_budget.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-donations\supreme\20261003T171132Z-9aac3149\runs\20261003T171308Z-520f3adf\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `adoption` | seen at 0.5 min | `[WorkforceProbe] PASS named-state adoption support=12` |
| expect `sample` | seen at 0.1 min | `[AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload` |
| expect `donor-stop` | seen at 10.0 min | `[t=00:01:08.588789][f=0018000] [WorkforceFixture] donor stopped bursts=108` |
| expect `work` | seen at 1.0 min | `2 idle=0 guards=0 metal=416/19100 income=6.6 pull=55.1 received=0.0 energy=52081 incomeE=4559.0 usageM=55.1 usageE=152.8 sent=0.0 excess=0.0 workingBP=240.0 idleBP=0.0 nanoWorking=0 factoriesWorking=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-donations\supreme\20261003T171132Z-9aac3149\runs\20261003T171308Z-520f3adf\screen_2026-10-03_17-12-25-168.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-donations\supreme\20261003T171132Z-9aac3149\runs\20261003T171308Z-520f3adf\screen_2026-10-03_17-12-33-746.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-donations\supreme\20261003T171132Z-9aac3149\runs\20261003T171308Z-520f3adf\screen_2026-10-03_17-12-45-826.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-donations\supreme\20261003T171132Z-9aac3149\runs\20261003T171308Z-520f3adf\screen_2026-10-03_17-13-03-681.png

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
  0.43  [AIR][Capacity] own=4/30 usage=0/3 gifts=2 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
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
  0.60  [AIR][Capacity] own=6/4550 usage=7/38 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1037 E=30 bank=16899 pull=38 plants=0/0 aircraftDemand=0/0
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
  0.77  [AIR][Capacity] own=6/4561 usage=19/92 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=120 shortage=21 reason=funded workload
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
  0.93  [AIR][Capacity] own=6/4558 usage=55/152 gifts=0 sent=0 excess=0 pressure=false mobile=240 arriving=0 idle=0 ecoStatic=0 working=120 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=650 E=4559 bank=52080 pull=152 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=727/6824
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 416/19100, energy +4559.0 bank 52080/52100, units 26
  1.00  [Playtest] finished armap team 0 at 1.00 min
  1.02  [AIR][Produce] opening.scout armpeep plant=1971 projected=1/1
  1.02  [AIR][State] T1_CONTEST
  1.02  [AIR][LabGate] M10=6 window=true bank=5406 cost=2900 reason=bank
  1.02  [AIR][Rule] production.banked builder=29542
  1.03  [AIR][State] T2_TRANSITION
  1.10  [AIR][Capacity] own=6/4558 usage=24/425 gifts=0 sent=0 excess=0 pressure=true mobile=240 arriving=0 idle=0 ecoStatic=0 working=120 shortage=1768 reason=funded workload
  1.10  [AIR][Economy] T2_TRANSITION M=6 bank=5384 E=4558 bank=52200 pull=425 plants=1/0 aircraftDemand=3/121
  1.10  [AIR][Projects] energyQueued=0 committed=3350/34642
  1.10  [AIR][Workforce] t1=0/3 t2=2/3 targetBP=2008 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.10  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.10  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.18  [AIR][Growth] shared TECH economy enabled at M10=1006.6
  1.27  [AIR][Capacity] own=6/4557 usage=14/155 gifts=0 sent=0 excess=0 pressure=true mobile=240 arriving=50 idle=0 ecoStatic=0 working=120 shortage=1518 reason=funded workload
  1.27  [AIR][Economy] T2_TRANSITION M=1006 bank=15220 E=4557 bank=52200 pull=344 plants=1/0 aircraftDemand=3/121
  1.27  [AIR][Projects] energyQueued=0 committed=3191/32934
  1.27  [AIR][Workforce] t1=1/3 t2=2/3 targetBP=1808 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.27  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/5 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.27  [AIR][Share] metal 19002 of 19200 (98%): sent 3840 to team 1 (20% full); the engine counts 0 metal sent in the last update (D-106)
  1.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 10120) (D-106)
  1.35  [AIR][Share] metal 19004 of 19200 (98%): sent 3840 to team 1 (39% full); the engine counts 0 metal sent in the last update (D-106)
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 16034) (D-106)
  1.39  [AIR][Produce] constructor.recovery armca plant=1971 projected=2/3
  1.39  [AIR][Rule] mex.assist builder=28358
  1.43  [AIR][Capacity] own=6/4569 usage=15/176 gifts=0 sent=0 excess=0 pressure=true mobile=290 arriving=50 idle=0 ecoStatic=0 working=120 shortage=1218 reason=funded workload
  1.43  [AIR][Economy] T2_TRANSITION M=766 bank=15100 E=4557 bank=52225 pull=365 plants=1/0 aircraftDemand=3/121
  1.43  [AIR][Projects] energyQueued=0 committed=3032/31226
  1.43  [AIR][Workforce] t1=2/3 t2=2/3 targetBP=1558 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.43  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/5 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.43  [AIR][Share] metal 19001 of 19200 (98%): sent 3840 to team 1 (58% full); the engine counts 0 metal sent in the last update (D-106)
  1.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 21964) (D-106)
  1.52  [AIR][Share] metal 19008 of 19200 (99%): sent 3840 to team 1 (77% full); the engine counts 0 metal sent in the last update (D-106)
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 27865) (D-106)
  1.60  [AIR][Capacity] own=6/4572 usage=23/318 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=50 ecoStatic=0 working=170 shortage=993 reason=funded workload
  1.60  [AIR][Economy] T2_TRANSITION M=790 bank=15086 E=4566 bank=52225 pull=391 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=2855/29285
  1.60  [AIR][Workforce] t1=2/3 t2=2/3 targetBP=1333 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.60  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/5 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.60  [AIR][Share] metal 19008 of 19200 (99%): sent 1065 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  1.60  [AIR][Produce] constructor.recovery armca plant=1971 projected=3/3
  1.60  [AIR][Rule] mex.assist builder=31863
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30690) (D-106)
  1.77  [AIR][Capacity] own=6/4578 usage=19/224 gifts=23 sent=0 excess=0 pressure=true mobile=340 arriving=50 idle=0 ecoStatic=0 working=220 shortage=613 reason=funded workload
  1.77  [AIR][Economy] T2_TRANSITION M=6 bank=19008 E=4573 bank=52250 pull=413 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=2664/27176
  1.77  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=1003 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.77  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.83  [AIR][Rule] opening.support builder=23975
  1.84  [AIR][Rule] commander.factory.guard builder=29509
  1.93  [AIR][Capacity] own=6/4583 usage=23/352 gifts=16 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=0 ecoStatic=0 working=270 shortage=816 reason=funded workload
  1.93  [AIR][Economy] T2_TRANSITION M=24 bank=19008 E=4578 bank=52275 pull=382 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=2689/28091
  1.93  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=1206 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  1.93  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/4 available=yes firstSlot=2
  1.93  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.93  [AIR][Commander] cleared factory guard for opening.support.assist
  1.93  [AIR][Rule] opening.support.assist builder=29509
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 18976/19200, energy +4584.0 bank 52180/52275, units 33
  2.00  [Playtest] finished armaap team 0 at 2.00 min
  2.02  [AIR][Produce] constructor.expand armaca plant=11178 projected=3/3
  2.02  [AIR][State] T2_SUSTAIN
  2.10  [AIR][Capacity] own=6/4583 usage=23/352 gifts=31 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=570 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=24 bank=19206 E=4583 bank=52475 pull=564 plants=1/1 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=2340/23796
  2.10  [AIR][Workforce] t1=3/3 t2=2/3 targetBP=510 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  2.10  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.10  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.17  [AIR][Produce] opening.screen armfig plant=1971 projected=2/6
  2.17  [AIR][Screen] fighters=1 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.17  [Playtest] finished armmoho team 0 at 2.17 min
  2.18  [AIR][Reclaim] armwin id=6397 worker=28358
  2.18  [AIR][Rule] energy.reclaim builder=28358
  2.18  [Playtest] finished armnanotc team 0 at 2.18 min
  2.19  [AIR][NanoGate] armca 31863 can=yes busy=no count=1
  2.19  [AIR][Rule] overflow.support builder=31863
  2.19  [AIR][Rule] mex.upgrade builder=5224
  2.20  [AIR][NanoGate] armca 23975 can=yes busy=yes count=1
  2.20  [AIR][Rule] overflow.support builder=23975
  2.20  [AIR][NanoGate] armcom 29509 can=no busy=yes count=1
  2.20  [AIR][Rule] commander.convert builder=29509
  2.27  [AIR][Capacity] own=15/4584 usage=18/557 gifts=4 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=350 shortage=712 reason=funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=35 bank=19800 E=4583 bank=52438 pull=587 plants=1/1 aircraftDemand=9/294
  2.27  [AIR][Projects] energyQueued=0 committed=3190/35919
  2.27  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=1222 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
  2.27  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+1/2 available=yes firstSlot=3
  2.27  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+1/20 available=yes firstSlot=2
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
  2.35  [AIR][Screen] fighters=1 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.36  [Playtest] finished armmakr team 0 at 2.36 min
  2.37  [AIR][Produce] opening.screen armfig plant=1971 projected=3/6
  2.37  [AIR][Rule] commander.idle.assist builder=29509
  2.38  [AIR][Support] return to production bay=0
  2.43  [AIR][Capacity] own=16/4583 usage=25/537 gifts=19 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=520 shortage=2068 reason=funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=17 bank=19800 E=4583 bank=52204 pull=778 plants=1/1 aircraftDemand=9/290
  2.43  [AIR][Projects] energyQueued=0 committed=2945/32261
  2.43  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=2578 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.43  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+1/2 available=yes firstSlot=3
  2.43  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+1/20 available=yes firstSlot=2
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
  2.52  [AIR][Screen] fighters=2 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.57  [AIR][Produce] opening.screen armfig plant=1971 projected=4/6
  2.58  [AIR][Support] return to production bay=0
  2.60  [AIR][Capacity] own=16/4582 usage=12/230 gifts=21 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=720 shortage=1867 reason=funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=31 bank=19800 E=4583 bank=52475 pull=593 plants=1/1 aircraftDemand=9/294
  2.60  [AIR][Projects] energyQueued=0 committed=2599/27949
  2.60  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=2377 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.60  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+1/2 available=yes firstSlot=3
  2.60  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+1/20 available=yes firstSlot=2
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
  2.61  [Playtest] finished armnanotc team 0 at 2.61 min
  2.62  [AIR][Rule] mex.assist builder=31863
  2.63  [AIR][Rule] commander.factory.guard builder=29509
  2.68  [AIR][Screen] fighters=3 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.68  [AIR][Share] metal 19800 of 20000 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  2.71  [AIR][Produce] opening.screen armfig plant=1971 projected=5/6
  2.73  [AIR][NanoGate] armcom 29509 can=no busy=yes count=3
  2.73  [AIR][Support] return to production bay=0
  2.77  [AIR][Capacity] own=16/4574 usage=32/632 gifts=23 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=400 shortage=1591 reason=funded workload
  2.77  [AIR][Economy] T2_SUSTAIN M=30 bank=19800 E=4575 bank=52475 pull=771 plants=1/1 aircraftDemand=14/453
  2.77  [AIR][Projects] energyQueued=0 committed=2347/24949
  2.77  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=2101 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.77  [AIR][Bay] 0 plant=1971 BP=550 nanos=2+0/2 available=yes firstSlot=3
  2.77  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+1/20 available=yes firstSlot=2
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
  2.80  [AIR][Rule] mex.assist builder=28358
  2.82  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.82  [AIR][Rule] commander.idle.assist builder=29509
  2.83  [AIR][Produce] opening.screen armfig plant=1971 projected=6/6
  2.85  [AIR][Rule] commander.factory.guard builder=29509
  2.85  [AIR][Support] return to production bay=0
  2.87  [AIR][Screen] fighters=5 cells=8 centre=2448,11493 width=600 advance=400 responding=false
  2.93  [AIR][Capacity] own=16/4565 usage=37/1022 gifts=23 sent=0 excess=0 pressure=true mobile=390 arriving=120 idle=0 ecoStatic=0 working=269 shortage=1200 reason=funded workload
  2.93  [AIR][Economy] T2_SUSTAIN M=34 bank=19800 E=4565 bank=52475 pull=1052 plants=1/1 aircraftDemand=14/453
  2.93  [AIR][Projects] energyQueued=0 committed=2042/21567
  2.93  [AIR][Workforce] t1=3/4 t2=2/4 targetBP=1710 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.93  [AIR][Bay] 0 plant=1971 BP=550 nanos=2+0/2 available=yes firstSlot=3
  2.93  [AIR][Bay] 1 plant=16418 BP=0 nanos=0+1/20 available=yes firstSlot=2
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
  2.95  [AIR][Commander] cleared factory guard for commander.idle.assist
... 2528 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(29509) at (2175, 11785) walks to (2216, 11852), 136 from the armmex site (2288, 11968)
  0.30  EXP: approach: armcom(29509) at (2254, 11913) walks to (2297, 11670), 136 from the armmex site (2320, 11536)
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
