# Playtest report: PASS

- Verdict: **PASS** (reached 16 min)
- Game time reached: 16.2 min (frame 29145); wall 104 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:29:20
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=SUPPORT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_workforce_budget.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-energy-starved\supreme\20261003T172920Z-c7cc002c\runs\20261003T173107Z-fbfc435c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `adoption` | seen at 0.5 min | `[WorkforceProbe] PASS named-state adoption support=12` |
| expect `sample` | seen at 0.1 min | `[AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload` |
| expect `donor-stop` | seen at 10.0 min | `[t=00:01:16.429498][f=0018000] [WorkforceFixture] donor stopped bursts=108` |
| expect `work` | seen at 1.0 min | `ing=2 idle=0 guards=0 metal=776/19100 income=6.6 pull=33.2 received=0.0 energy=969 incomeE=69.0 usageM=33.2 usageE=143.6 sent=0.0 excess=0.0 workingBP=230.0 idleBP=0.0 nanoWorking=0 factoriesWorking=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-energy-starved\supreme\20261003T172920Z-c7cc002c\runs\20261003T173107Z-fbfc435c\screen_2026-10-03_17-30-18-392.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-energy-starved\supreme\20261003T172920Z-c7cc002c\runs\20261003T173107Z-fbfc435c\screen_2026-10-03_17-30-28-043.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-energy-starved\supreme\20261003T172920Z-c7cc002c\runs\20261003T173107Z-fbfc435c\screen_2026-10-03_17-30-41-718.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-energy-starved\supreme\20261003T172920Z-c7cc002c\runs\20261003T173107Z-fbfc435c\screen_2026-10-03_17-31-01-131.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 4 shots, end at 16.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4700, 11000) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 29
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2155, 11747) units 1
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
  0.10  [AIR][Claim] cancel unowned native order legap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 58 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|legion|legap|2176|11787|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SUPPORT side=armada start=(4700,10997) factory=armlab landLocked=no spot=7 known=1/1
  0.27  [AIR][Capacity] own=2/30 usage=7/79 gifts=5 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=990 E=18 bank=921 pull=79 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished legmex team 0 at 0.28 min
  0.28  [Team][Roster] first mex 27610 at 2288,11968
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|legion|legap|2176|11787|0|2|1|2288|11968
  0.29  [AIR][Rule] opening.mex builder=29509
  0.43  [AIR][Capacity] own=2/30 usage=3/40 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=5 bank=1031 E=30 bank=949 pull=40 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=38/385
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.51  [Playtest] finished legmex team 0 at 0.51 min
  0.51  [Playtest] finished legmstor team 0 at 0.51 min
  0.51  [Playtest] finished legmstor team 0 at 0.51 min
  0.51  [Playtest] finished legmstor team 0 at 0.51 min
  0.51  [Playtest] finished legmstor team 0 at 0.51 min
  0.51  [Playtest] finished legmstor team 0 at 0.51 min
  0.51  [Playtest] finished legmstor team 0 at 0.51 min
  0.52  [AIR][Rule] opening.mex builder=29542
  0.52  [AIR][Layout] cluster=0 labs=6 at=2056,11619
  0.52  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 support=12 zone=134
  0.52  [AIR][Layout] cluster=1 labs=6 at=2536,11427
  0.52  [AIR][Rule] opening.plant builder=5224
  0.53  [AIR][Wind] cluster=0 slots=6 at=2328,11696 local=true builder=29509
  0.53  [AIR][Rule] opening.energy builder=29509
  0.53  [AIR][EcoLayout] reserved air.eco.1 reactor=1408,11792 converters=8 support=12 zone=289
  0.53  [Playtest] finished legestor team 0 at 0.53 min
  0.53  [Playtest] finished legestor team 0 at 0.53 min
  0.53  [Playtest] finished legestor team 0 at 0.53 min
  0.53  [Playtest] finished legestor team 0 at 0.53 min
  0.53  [Playtest] finished legestor team 0 at 0.53 min
  0.53  [Playtest] finished legestor team 0 at 0.53 min
  0.55  [AIR][EcoLayout] reserved air.eco.2 reactor=3200,11280 converters=8 support=12 zone=313
  0.57  [AIR][EcoLayout] reserved air.eco.3 reactor=3712,11152 converters=8 support=12 zone=335
  0.60  [AIR][Capacity] own=4/30 usage=7/37 gifts=0 sent=0 excess=0 pressure=false mobile=230 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=6 bank=1038 E=30 bank=1186 pull=37 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=1090/9282
  0.60  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=230 floating=false savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
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
  0.69  [Playtest] finished legwin team 0 at 0.69 min
  0.70  [AIR][Rule] opening.commander.guard builder=29509
  0.77  [AIR][Capacity] own=6/50 usage=12/91 gifts=0 sent=0 excess=0 pressure=false mobile=230 arriving=0 idle=0 ecoStatic=0 working=114 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=6 bank=979 E=50 bank=1177 pull=91 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=959/8404
  0.77  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=230 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.77  [AIR][Bay] 0 plant=5222 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  0.93  [AIR][Capacity] own=6/68 usage=23/119 gifts=0 sent=0 excess=0 pressure=false mobile=230 arriving=0 idle=0 ecoStatic=0 working=115 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP RECOVERY M=6 bank=904 E=68 bank=1220 pull=119 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=799/7467
  0.93  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=230 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.93  [AIR][Bay] 0 plant=5222 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 776/19100, energy +69.0 bank 968/37100, units 20
  1.10  [AIR][Capacity] own=6/68 usage=33/143 gifts=0 sent=0 excess=0 pressure=true mobile=230 arriving=0 idle=0 ecoStatic=0 working=115 shortage=59 reason=funded workload
  1.10  [AIR][Economy] BOOTSTRAP RECOVERY M=6 bank=5653 E=68 bank=6748 pull=143 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=489/6148
  1.10  [AIR][Workforce] t1=0/3 t2=2/3 targetBP=289 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Bay] 0 plant=5222 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  1.11  [Playtest] finished legap team 0 at 1.11 min
  1.12  [AIR][Claim] cancel unowned native order legnanotc
  1.12  [AIR][State] T1_CONTEST
  1.12  [AIR][Produce] opening.scout legfig plant=5222 projected=1/1
  1.12  [AIR][LabGate] M10=6 window=true bank=10631 cost=2900 reason=bank
  1.12  [AIR][Rule] production.banked builder=5224
  1.13  [AIR][State] T2_TRANSITION
  1.18  [AIR][Growth] shared TECH economy enabled at M10=1006.6
  1.23  [AIR][Produce] constructor.recovery legca plant=5222 projected=1/3
  1.23  [AIR][Scout] opening drone=29236 enemy starts=1
  1.27  [AIR][Capacity] own=6/68 usage=10/56 gifts=0 sent=0 excess=0 pressure=true mobile=230 arriving=45 idle=0 ecoStatic=0 working=114 shortage=398 reason=funded workload
  1.27  [AIR][Economy] T2_TRANSITION RECOVERY M=6 bank=10569 E=68 bank=17088 pull=188 plants=1/0 aircraftDemand=2/115
  1.27  [AIR][Projects] energyQueued=0 committed=3289/33060
  1.27  [AIR][Workforce] t1=1/3 t2=2/3 targetBP=673 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.27  [AIR][Bay] 0 plant=5222 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=21666 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  1.43  [AIR][Capacity] own=6/68 usage=15/175 gifts=0 sent=0 excess=0 pressure=true mobile=230 arriving=45 idle=0 ecoStatic=0 working=114 shortage=517 reason=funded workload
  1.43  [AIR][Economy] T2_TRANSITION M=6 bank=10393 E=68 bank=26511 pull=373 plants=1/0 aircraftDemand=2/115
  1.43  [AIR][Projects] energyQueued=0 committed=3130/31362
  1.43  [AIR][Workforce] t1=1/3 t2=2/3 targetBP=792 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=5222 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=21666 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.46  [AIR][Produce] constructor.recovery legca plant=5222 projected=2/3
  1.46  [AIR][Rule] mex.assist builder=17935
  1.52  [AIR][Share] metal 19004 of 19200 (98%): sent 3840 to team 1 (78% full); the engine counts 0 metal sent in the last update (D-106)
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 28246) (D-106)
  1.60  [AIR][Capacity] own=6/68 usage=17/184 gifts=0 sent=0 excess=0 pressure=true mobile=275 arriving=45 idle=0 ecoStatic=0 working=160 shortage=754 reason=funded workload
  1.60  [AIR][Economy] T2_TRANSITION M=747 bank=15083 E=68 bank=35593 pull=382 plants=1/0 aircraftDemand=2/115
  1.60  [AIR][Projects] energyQueued=0 committed=2961/29546
  1.60  [AIR][Workforce] t1=2/3 t2=2/3 targetBP=1074 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=5222 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=21666 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.60  [AIR][Share] metal 19000 of 19200 (98%): sent 684 to team 1 (97% full); the engine counts 0 metal sent in the last update (D-106)
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30690) (D-106)
  1.68  [AIR][Produce] constructor.recovery legca plant=5222 projected=3/3
  1.68  [AIR][Rule] mex.assist builder=6397
  1.77  [AIR][Capacity] own=6/71 usage=18/201 gifts=20 sent=0 excess=0 pressure=true mobile=320 arriving=45 idle=0 ecoStatic=0 working=185 shortage=649 reason=funded workload
  1.77  [AIR][Economy] T2_TRANSITION M=8 bank=19008 E=72 bank=35822 pull=399 plants=1/0 aircraftDemand=2/115
  1.77  [AIR][Projects] energyQueued=0 committed=2779/27575
  1.77  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=1014 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=5222 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=21666 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.89  [AIR][Produce] opening.screen legfig plant=5222 projected=2/7
  1.89  [AIR][Rule] opening.support builder=21369
  1.93  [AIR][Capacity] own=6/73 usage=23/347 gifts=14 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=0 ecoStatic=0 working=205 shortage=437 reason=funded workload
  1.93  [AIR][Economy] T2_TRANSITION M=26 bank=19008 E=74 bank=35936 pull=347 plants=1/0 aircraftDemand=2/115
  1.93  [AIR][Projects] energyQueued=0 committed=2808/28546
  1.93  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=802 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=5222 BP=150 nanos=0+1/2 available=yes firstSlot=2
  1.93  [AIR][Bay] 1 plant=21666 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.97  [AIR][Commander] cleared factory guard for opening.support.assist
  1.97  [AIR][Rule] opening.support.assist builder=29509
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 18976/19200, energy +75.8 bank 35008/37275, units 27
  2.01  [Playtest] finished legaap team 0 at 2.01 min
  2.02  [AIR][State] T2_SUSTAIN
  2.02  [AIR][Produce] constructor.expand legaca plant=16418 projected=3/3
  2.05  [AIR][Produce] opening.screen legfig plant=5222 projected=3/7
  2.05  [AIR][Screen] fighters=1 cells=8 centre=2450,11495 width=600 advance=400 responding=false
  2.10  [AIR][Capacity] own=6/74 usage=23/347 gifts=29 sent=0 excess=0 pressure=true mobile=365 arriving=115 idle=0 ecoStatic=0 working=550 shortage=0 reason=available or arriving power
  2.10  [AIR][Economy] T2_SUSTAIN M=24 bank=19206 E=75 bank=35507 pull=555 plants=1/1 aircraftDemand=3/84
  2.10  [AIR][Projects] energyQueued=0 committed=2491/24713
  2.10  [AIR][Workforce] t1=3/3 t2=2/3 targetBP=480 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=5222 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.10  [AIR][Bay] 1 plant=21666 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.21  [Playtest] finished legmoho team 0 at 2.20 min
  2.22  [AIR][Screen] fighters=1 cells=8 centre=2450,11495 width=600 advance=400 responding=false
  2.22  [AIR][NanoGate] legca 6397 can=yes busy=yes count=1
  2.22  [AIR][Rule] overflow.support builder=6397
  2.22  [AIR][NanoGate] legaca 29542 can=no busy=yes count=1
  2.22  [AIR][Growth] deferred=fusion by=legaca reason=metal floating at 19473; best payback energy energyBuilding=false reactor=false can=true busy=false mexReady=false M=36 bank=19473
  2.22  [AIR][Rule] mex.expand builder=29542
  2.23  [Playtest] finished legnanotc team 0 at 2.22 min
  2.23  [AIR][NanoGate] legca 17935 can=yes busy=yes count=1
  2.23  [AIR][Growth] advsolar reason=metal floating at 19473; best payback energy AFUS=0 M=36 E=73
  2.23  [AIR][Rule] economy.shared.advsolar builder=17935
  2.24  [AIR][NanoGate] legcom 29509 can=no busy=yes count=1
  2.24  [AIR][Rule] commander.factory.guard builder=29509
  2.24  [AIR][NanoGate] legca 21369 can=yes busy=yes count=1
  2.24  [AIR][Rule] intel.radar builder=21369
  2.27  [AIR][Capacity] own=6/73 usage=13/249 gifts=2 sent=0 excess=0 pressure=true mobile=365 arriving=115 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=36 bank=19473 E=73 bank=35918 pull=249 plants=1/1 aircraftDemand=8/190
  2.27  [AIR][Projects] energyQueued=1 committed=3606/37360
  2.27  [AIR][Workforce] t1=3/3 t2=2/3 targetBP=480 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=5222 BP=350 nanos=1+0/2 available=yes firstSlot=3
  2.27  [AIR][Bay] 1 plant=21666 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.27  [AIR][Produce] opening.screen legfig plant=5222 projected=3/6
  2.30  [AIR][Support] return to production bay=0
  2.33  [AIR][Commander] cleared factory guard for commander.local.assist
  2.33  [AIR][Rule] commander.local.assist builder=29509
  2.38  [AIR][Produce] opening.screen legfig plant=5222 projected=4/6
  2.40  [AIR][Support] return to production bay=0
  2.42  [AIR][Screen] fighters=3 cells=8 centre=2450,11495 width=600 advance=400 responding=false
  2.43  [AIR][Capacity] own=15/70 usage=26/407 gifts=28 sent=0 excess=0 pressure=true mobile=365 arriving=115 idle=0 ecoStatic=0 working=663 shortage=0 reason=available or arriving power
  2.43  [AIR][Economy] T2_SUSTAIN M=30 bank=19800 E=71 bank=35240 pull=684 plants=1/1 aircraftDemand=8/190
  2.43  [AIR][Projects] energyQueued=0 committed=3301/33923
  2.43  [AIR][Workforce] t1=3/3 t2=2/3 targetBP=480 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=5222 BP=350 nanos=1+1/2 available=yes firstSlot=3
  2.43  [AIR][Bay] 1 plant=21666 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.52  [AIR][Produce] opening.screen legfig plant=5222 projected=5/6
  2.55  [AIR][Support] return to production bay=0
  2.57  [Playtest] finished legnanotc team 0 at 2.57 min
  2.58  [AIR][Rule] commander.factory.guard builder=29509
  2.59  [AIR][Rule] mex.assist builder=6397
  2.60  [AIR][Capacity] own=15/68 usage=37/578 gifts=40 sent=0 excess=0 pressure=true mobile=365 arriving=115 idle=0 ecoStatic=0 working=204 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=37 bank=19800 E=68 bank=34981 pull=578 plants=1/1 aircraftDemand=12/291
  2.60  [AIR][Projects] energyQueued=0 committed=2925/29602
  2.60  [AIR][Workforce] t1=3/3 t2=2/3 targetBP=480 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=5222 BP=550 nanos=2+0/2 available=yes firstSlot=3
  2.60  [AIR][Bay] 1 plant=21666 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.60  [AIR][Screen] fighters=4 cells=8 centre=2450,11495 width=600 advance=400 responding=false
  2.60  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.64  [AIR][Produce] opening.screen legfig plant=5222 projected=6/6
  2.65  [AIR][Support] return to production bay=0
  2.68  [AIR][Share] metal 19800 of 20000 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  2.76  [Playtest] finished legrad team 0 at 2.76 min
  2.77  [AIR][Capacity] own=15/71 usage=59/621 gifts=30 sent=0 excess=0 pressure=true mobile=365 arriving=115 idle=45 ecoStatic=0 working=204 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T2_SUSTAIN M=32 bank=19800 E=69 bank=34883 pull=621 plants=1/1 aircraftDemand=12/291
  2.77  [AIR][Projects] energyQueued=0 committed=2564/25941
  2.77  [AIR][Workforce] t1=3/3 t2=2/3 targetBP=480 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=5222 BP=550 nanos=2+0/2 available=yes firstSlot=3
  2.77  [AIR][Bay] 1 plant=21666 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.78  [AIR][NanoGate] legcom 29509 can=no busy=no count=2
  2.78  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.78  [AIR][Rule] commander.idle.assist builder=29509
  2.78  [AIR][Rule] mex.assist builder=21369
  2.78  [AIR][Screen] fighters=6 cells=8 centre=2450,11495 width=600 advance=400 responding=false
  2.93  [AIR][Capacity] own=15/71 usage=85/867 gifts=69 sent=0 excess=0 pressure=true mobile=365 arriving=115 idle=0 ecoStatic=0 working=204 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T2_SUSTAIN M=40 bank=19800 E=73 bank=34093 pull=867 plants=1/1 aircraftDemand=12/291
  2.93  [AIR][Projects] energyQueued=0 committed=1840/18744
  2.93  [AIR][Workforce] t1=3/3 t2=2/3 targetBP=480 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=5222 BP=550 nanos=2+0/2 available=yes firstSlot=3
  2.93  [AIR][Bay] 1 plant=21666 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.95  [AIR][Screen] fighters=6 cells=8 centre=2450,11495 width=600 advance=400 responding=false
  3.00  [Playtest] eco team 0 at 3.0 min: metal +15.8 bank 19730/20000, energy +69.1 bank 33966/37475, units 36
  3.00  [Playtest] target team 0 at (2155, 11747) from its start position
  3.00  [Playtest] camera requested (1968,11232) height=2200
  3.01  [Playtest] camera captured name=ta position=(1968,11232) height=2200
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (1968, 11232)
  3.10  [AIR][Capacity] own=15/68 usage=87/893 gifts=71 sent=0 excess=0 pressure=true mobile=365 arriving=115 idle=0 ecoStatic=0 working=250 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T2_SUSTAIN M=82 bank=19800 E=68 bank=33504 pull=893 plants=1/1 aircraftDemand=12/291
  3.10  [AIR][Projects] energyQueued=0 committed=970/10079
... 2456 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: legcom(29509) at (2177, 11788) walks to (2216, 11851), 137 from the legmex site (2288, 11968)
  0.29  EXP: approach: legcom(29509) at (2255, 11915) walks to (2297, 11671), 137 from the legmex site (2320, 11536)
  0.52  RESERVE: zone 1 at (1968, 11232) facing 2, 6x6 cells: 36 of 36 held
  0.52  RESERVE: legap at (1968, 11232) facing 2 (id 1)
  0.52  RESERVE: zone 2 at (2024, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (2024, 11304) facing 2 (id 2)
  0.52  RESERVE: zone 3 at (1976, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1976, 11304) facing 2 (id 3)
  0.52  RESERVE: zone 4 at (1928, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1928, 11304) facing 2 (id 4)
  0.52  RESERVE: zone 5 at (2024, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (2024, 11352) facing 2 (id 5)
  0.52  RESERVE: zone 6 at (1976, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1976, 11352) facing 2 (id 6)
  0.52  RESERVE: zone 7 at (1832, 11208) facing 2, 9x9 cells: 81 of 81 held
  0.52  RESERVE: legaap at (1832, 11208) facing 2 (id 7)
  0.52  RESERVE: zone 8 at (1880, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1880, 11304) facing 2 (id 8)
  0.52  RESERVE: zone 9 at (1832, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1832, 11304) facing 2 (id 9)
  0.52  RESERVE: zone 10 at (1784, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1784, 11304) facing 2 (id 10)
  0.52  RESERVE: zone 11 at (1880, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1880, 11352) facing 2 (id 11)
  0.52  RESERVE: zone 12 at (1832, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1832, 11352) facing 2 (id 12)
  0.52  RESERVE: zone 13 at (1784, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1784, 11352) facing 2 (id 13)
  0.52  RESERVE: zone 14 at (1880, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1880, 11400) facing 2 (id 14)
  0.52  RESERVE: zone 15 at (1832, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1832, 11400) facing 2 (id 15)
  0.52  RESERVE: zone 16 at (1784, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1784, 11400) facing 2 (id 16)
  0.52  RESERVE: zone 17 at (1880, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1880, 11448) facing 2 (id 17)
  0.52  RESERVE: zone 18 at (1832, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1832, 11448) facing 2 (id 18)
  0.52  RESERVE: zone 19 at (1784, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1784, 11448) facing 2 (id 19)
  0.52  RESERVE: zone 20 at (1880, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1880, 11496) facing 2 (id 20)
  0.52  RESERVE: zone 21 at (1832, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1832, 11496) facing 2 (id 21)
  0.52  RESERVE: zone 22 at (1784, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1784, 11496) facing 2 (id 22)
  0.52  RESERVE: zone 23 at (1880, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1880, 11544) facing 2 (id 23)
  0.52  RESERVE: zone 24 at (1832, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1832, 11544) facing 2 (id 24)
  0.52  RESERVE: zone 25 at (1784, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1784, 11544) facing 2 (id 25)
  0.52  RESERVE: zone 26 at (1880, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1880, 11592) facing 2 (id 26)
  0.52  RESERVE: zone 27 at (1832, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1832, 11592) facing 2 (id 27)
  0.52  RESERVE: zone 28 at (1688, 11208) facing 2, 9x9 cells: 81 of 81 held
  0.52  RESERVE: legaap at (1688, 11208) facing 2 (id 28)
  0.52  RESERVE: zone 29 at (1736, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1736, 11304) facing 2 (id 29)
  0.52  RESERVE: zone 30 at (1688, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1688, 11304) facing 2 (id 30)
  0.52  RESERVE: zone 31 at (1640, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1640, 11304) facing 2 (id 31)
  0.52  RESERVE: zone 32 at (1736, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1736, 11352) facing 2 (id 32)
  0.52  RESERVE: zone 33 at (1688, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1688, 11352) facing 2 (id 33)
  0.52  RESERVE: zone 34 at (1640, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1640, 11352) facing 2 (id 34)
  0.52  RESERVE: zone 35 at (1736, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1736, 11400) facing 2 (id 35)
  0.52  RESERVE: zone 36 at (1688, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1688, 11400) facing 2 (id 36)
  0.52  RESERVE: zone 37 at (1640, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1640, 11400) facing 2 (id 37)
  0.52  RESERVE: zone 38 at (1736, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1736, 11448) facing 2 (id 38)
  0.52  RESERVE: zone 39 at (1688, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1688, 11448) facing 2 (id 39)
  0.52  RESERVE: zone 40 at (1640, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1640, 11448) facing 2 (id 40)
  0.52  RESERVE: zone 41 at (1736, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1736, 11496) facing 2 (id 41)
  0.52  RESERVE: zone 42 at (1688, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1688, 11496) facing 2 (id 42)
  0.52  RESERVE: zone 43 at (1640, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1640, 11496) facing 2 (id 43)
  0.52  RESERVE: zone 44 at (1736, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1736, 11544) facing 2 (id 44)
  0.52  RESERVE: zone 45 at (1688, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1688, 11544) facing 2 (id 45)
  0.52  RESERVE: zone 46 at (1640, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1640, 11544) facing 2 (id 46)
  0.52  RESERVE: zone 47 at (1736, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1736, 11592) facing 2 (id 47)
  0.52  RESERVE: zone 48 at (1688, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1688, 11592) facing 2 (id 48)
  0.52  RESERVE: zone 49 at (1976, 10728) facing 2, 9x9 cells: 81 of 81 held
  0.52  RESERVE: legaap at (1976, 10728) facing 2 (id 49)
  0.52  RESERVE: zone 50 at (2024, 10824) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (2024, 10824) facing 2 (id 50)
  0.52  RESERVE: zone 51 at (1976, 10824) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1976, 10824) facing 2 (id 51)
  0.52  RESERVE: zone 52 at (1928, 10824) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1928, 10824) facing 2 (id 52)
  0.52  RESERVE: zone 53 at (2024, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (2024, 10872) facing 2 (id 53)
  0.52  RESERVE: zone 54 at (1976, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1976, 10872) facing 2 (id 54)
  0.52  RESERVE: zone 55 at (1928, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1928, 10872) facing 2 (id 55)
  0.52  RESERVE: zone 56 at (2024, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (2024, 10920) facing 2 (id 56)
  0.52  RESERVE: zone 57 at (1976, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1976, 10920) facing 2 (id 57)
  0.52  RESERVE: zone 58 at (1928, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (1928, 10920) facing 2 (id 58)
  0.52  RESERVE: zone 59 at (2024, 10968) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: legnanotc at (2024, 10968) facing 2 (id 59)
```
