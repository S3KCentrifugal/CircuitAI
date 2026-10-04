# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54014); wall 453 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T16:24:45
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TACTICAL/armada/test, 2=TECH/cortex/test, 3=FRONT/legion/test, 4=FRONT/armada/test, 5=FRONT/cortex/test, 6=SUPPORT/legion/test, 7=SEA/armada/test, 8=TACTICAL/cortex/test, 9=TECH/legion/test, 10=AIR/armada/test, 11=FRONT/cortex/test, 12=FRONT/legion/test, 13=FRONT/armada/test, 14=SUPPORT/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_workforce_performance.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-revised-multi\supreme\20261003T192444Z-b1727f4c\runs\20261003T193220Z-7e15e396\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `timing-minute` | seen at 1.0 min | `[t=00:00:51.963480][f=0001800] [WorkforcePerf] frame=1800 samples=1800 ai_all_p50_ms=0.386719 ai_all_p95_ms=1.377930 ai_all_max_ms=69.894531 sim_speed=0.000` |
| expect `timing-cumulative` | seen at 10.0 min | `[t=00:02:03.191130][f=0018000] [WorkforcePerfTotal] frame=18000 samples=18000 ai_all_p50_ms=0.640625 ai_all_p95_ms=2.736328 ai_all_max_ms=69.894531` |
| expect `commands` | seen at 1.0 min | `[t=00:00:51.962892][f=0001800] [AirOrders] frame=1800 team=0 all_apm=47 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-028 metal bank over 50% for 60 s, 4 T2 constructors, none added` |

## Failures

- forbid 'invariant' hit at 12.4 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 4 T2 constructors, none added
- forbid 'invariant' hit at 15.2 min: [INVARIANT] INV-022 a new set of cormmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 15.3 min: [INVARIANT] INV-008 2 turret(s) in range of the reclaim of legalab 19568 are not on it
- forbid 'invariant' hit at 25.0 min: [INVARIANT] INV-022 a new set of cormmkr starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.1 min: [INVARIANT] INV-022 a new set of legafus starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.3 min: [INVARIANT] INV-022 a new set of cormmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.6 min: [INVARIANT] INV-022 a new set of cormmkr starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-039 T1 land constructors released 242 s, 0 spam labs of 3 wanted, no forward order for 180 s
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-016 the advanced lab 18680 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 336 elmos away, not flush (160)
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 0) with 0 structures in its exit lane
- forbid 'invariant' hit at 29.3 min: [INVARIANT] INV-022 a new set of cormmkr starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.7 min: [INVARIANT] INV-052 ferry run for cargo 25719 unloading for 16 s

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-revised-multi\supreme\20261003T192444Z-b1727f4c\runs\20261003T193220Z-7e15e396\screen_2026-10-03_19-26-05-398.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-revised-multi\supreme\20261003T192444Z-b1727f4c\runs\20261003T193220Z-7e15e396\screen_2026-10-03_19-27-53-173.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-revised-multi\supreme\20261003T192444Z-b1727f4c\runs\20261003T193220Z-7e15e396\screen_2026-10-03_19-30-25-076.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 3 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (711, 7218) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (2513, 7983) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (4595, 7440) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (4997, 8570) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (4375, 9800) units 1
  0.00  [Playtest] frame 1 team 7 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (11579, 5063) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (9764, 4339) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (7729, 4835) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (7292, 3727) units 1
  0.00  [Playtest] frame 1 team 14 ally 1 side cortex ai true dead false start (7925, 2500) units 1
  0.00  [Playtest] frame 1 team 15 ally 1 side legion ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 17 ally 3 side  ai false dead false start (0, 0) units 31
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (711, 7218) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (2513, 7983) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (4595, 7440) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (4997, 8570) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (4375, 9800) units 1
  0.05  [Playtest] frame 90 team 7 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (11579, 5063) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (9764, 4339) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (7729, 4835) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (7292, 3727) units 1
  0.05  [Playtest] frame 90 team 14 ally 1 side cortex ai true dead false start (7925, 2500) units 1
  0.05  [Playtest] frame 90 team 15 ally 1 side legion ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 17 ally 3 side  ai false dead false start (0, 0) units 31
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
  0.10  [Team][Roster] Team 1 (AI 1): role=AIR side=armada start=(701,7226) factory=armap landLocked=no spot=0 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=TECH side=cortex start=(801,10451) factory=corlab landLocked=no spot=1 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=FRONT side=legion start=(2477,8018) factory=legvp landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=FRONT side=armada start=(4592,7449) factory=armvp landLocked=no spot=4 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=FRONT side=cortex start=(5002,8622) factory=corlab landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=AIR side=legion start=(4424,9815) factory=legap landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=SEA side=armada start=(4774,11078) factory=armsy landLocked=no spot=7 known=7/7
  0.19  [Team][Roster] team 4 first mex at 4512,7600
  0.20  [Team][Roster] team 3 first mex at 2368,8128
  0.20  [Team][Roster] team 5 first mex at 5023,8783
  0.20  [Team][Roster] team 7 first mex at 4608,11072
  0.22  [Team][Roster] team 1 first mex at 544,7168
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=965 E=18 bank=768 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.30  [AIR][Rule] opening.mex builder=2198
  0.30  [Team][Roster] first mex 18552 at 2288,11968
  0.30  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2175|11785|0|2|1|2288|11968
  0.35  [Team][Roster] team 2 first mex at 672,10623
  0.35  [Team][Roster] team 6 first mex at 4784,9856
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=986 E=30 bank=977 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.53  [Playtest] finished armmex team 0 at 0.53 min
  0.60  [AIR][Capacity] own=4/30 usage=0/6 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=986 E=30 bank=711 pull=6 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=50/500
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=6/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1015 E=30 bank=549 pull=89 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=4/49
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.78  [Playtest] finished armmex team 0 at 0.78 min
  0.79  [AIR][Wind] cluster=0 slots=6 at=2104,11696 local=true builder=2198
  0.79  [AIR][Rule] opening.energy builder=2198
  0.88  [Playtest] finished armwin team 0 at 0.88 min
  0.93  [AIR][Capacity] own=6/30 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=1050 E=30 bank=671 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1072/1150, energy +48.9 bank 821/1000, units 6
  1.03  [Playtest] finished armwin team 0 at 1.03 min
  1.10  [AIR][Capacity] own=8/48 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=9 bank=1091 E=43 bank=996 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=18/78
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.14  [Playtest] finished armwin team 0 at 1.14 min
  1.25  [Playtest] finished armwin team 0 at 1.25 min
  1.27  [AIR][Capacity] own=8/67 usage=6/37 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=1114 E=66 bank=999 pull=37 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=1 committed=40/175
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.41  [Playtest] finished armwin team 0 at 1.41 min
  1.43  [AIR][Starter] nearby distance=128
  1.43  [AIR][Rule] opening.plant builder=2198
  1.43  [AIR][Layout] cluster=0 labs=6 at=2727,11425
  1.43  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 support=12 zone=140
  1.43  [AIR][Capacity] own=8/102 usage=6/37 gifts=0 sent=1 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=98 bank=1002 pull=37 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=650/1100
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.45  [AIR][EcoLayout] reserved air.eco.1 reactor=3200,11408 converters=8 support=12 zone=170
  1.47  [AIR][EcoLayout] reserved air.eco.2 reactor=3712,11152 converters=8 support=12 zone=198
  1.48  [AIR][EcoLayout] reserved air.eco.3 reactor=3072,10896 converters=8 support=12 zone=243
  1.60  [AIR][Capacity] own=8/119 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=926 E=113 bank=954 pull=69 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=331/561
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=3439 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.75  [Playtest] finished armap team 0 at 1.75 min
  1.76  [AIR][Produce] opening.scout armpeep plant=3439 projected=1/1
  1.76  [AIR][Rule] opening.commander.guard builder=2198
  1.77  [AIR][Claim] cancel unowned native order armnanotc
  1.77  [AIR][Claim] cancel unowned native order armnanotc
  1.77  [AIR][Capacity] own=8/121 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][State] T1_CONTEST
  1.77  [AIR][Economy] T1_CONTEST M=8 bank=658 E=120 bank=953 pull=69 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.90  [AIR][Produce] constructor.recovery armca plant=3439 projected=1/3
  1.93  [AIR][Capacity] own=8/124 usage=0/11 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST M=8 bank=686 E=124 bank=501 pull=11 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 688/1250, energy +125.0 bank 306/1102, units 12
  2.10  [AIR][Capacity] own=8/121 usage=1/34 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=686 E=124 bank=0 pull=158 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.15  [AIR][Produce] constructor.recovery armca plant=3439 projected=2/3
  2.15  [AIR][Rule] recovery.energy builder=18368
  2.27  [AIR][Capacity] own=4/115 usage=2/0 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=82 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=703 E=116 bank=107 pull=166 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=147/0
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=182 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Capacity] own=4/115 usage=6/67 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=0 idle=50 ecoStatic=0 working=50 shortage=27 reason=funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=675 E=115 bank=1 pull=170 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=117/0
  2.43  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=127 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.44  [AIR][Produce] constructor.recovery armca plant=3439 projected=3/3
  2.44  [AIR][Rule] recovery.energy builder=20840
  2.60  [AIR][Capacity] own=7/128 usage=4/0 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=99 shortage=90 reason=funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=660 E=123 bank=296 pull=143 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=226/0
  2.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=240 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.71  [AIR][Produce] opening.screen armfig plant=3439 projected=1/6
  2.71  [AIR][Rule] recovery.energy builder=6522
  2.74  [AIR][Rule] commander.factory.guard builder=2198
  2.77  [AIR][Capacity] own=8/134 usage=12/265 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=37 reason=funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=628 E=134 bank=273 pull=265 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=1 committed=322/0
  2.77  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=187 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Capacity] own=5/139 usage=13/177 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=571 E=138 bank=35 pull=352 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=234/0
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [AIR][Produce] opening.screen armfig plant=3439 projected=2/6
  3.00  [AIR][Screen] fighters=1 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 545/1250, energy +139.8 bank 144/1177, units 18
  3.09  [Playtest] finished armsolar team 0 at 3.09 min
  3.10  [AIR][Capacity] own=6/138 usage=16/299 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=520 E=139 bank=99 pull=299 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=146/0
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=144
  3.17  [AIR][Screen] fighters=1 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  3.23  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.23  [AIR][Rule] commander.idle.assist builder=2198
  3.23  [AIR][Produce] opening.screen armfig plant=3439 projected=3/6
  3.26  [AIR][Rule] commander.factory.guard builder=2198
  3.27  [AIR][Capacity] own=5/147 usage=8/9 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=467 E=154 bank=421 pull=9 plants=1/0 aircraftDemand=3/124
  3.27  [AIR][Projects] energyQueued=0 committed=215/0
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.35  [AIR][Screen] fighters=2 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  3.38  [Playtest] finished armsolar team 0 at 3.38 min
  3.39  [AIR][Rule] recovery.assist builder=20840
  3.43  [AIR][Layout] cluster=1 labs=1 at=1575,11137
  3.43  [AIR][Capacity] own=4/155 usage=13/196 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=422 E=157 bank=27 pull=286 plants=1/0 aircraftDemand=3/124
  3.43  [AIR][Projects] energyQueued=0 committed=131/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.45  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.45  [AIR][Rule] commander.idle.assist builder=2198
  3.46  [AIR][Produce] opening.screen armfig plant=3439 projected=4/6
  3.48  [AIR][Rule] commander.factory.guard builder=2198
  3.53  [AIR][Screen] fighters=3 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=6/173 usage=16/328 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=367 E=171 bank=74 pull=328 plants=1/0 aircraftDemand=3/125
  3.60  [AIR][Projects] energyQueued=0 committed=41/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=130
  3.64  [Playtest] finished armsolar team 0 at 3.64 min
  3.65  [AIR][Rule] mex.expand builder=6522
  3.69  [AIR][Produce] opening.screen armfig plant=3439 projected=5/6
  3.69  [Playtest] finished armsolar team 0 at 3.69 min
  3.71  [AIR][Rule] intel.radar builder=18368
  3.71  [AIR][Rule] wait builder=20840
  3.73  [AIR][Screen] fighters=4 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  3.77  [AIR][Capacity] own=5/173 usage=9/301 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=348 E=173 bank=555 pull=301 plants=1/0 aircraftDemand=3/125
  3.77  [AIR][Projects] energyQueued=0 committed=103/1059
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.78  [AIR][Rule] project.assist builder=20840
  3.88  [AIR][Produce] opening.screen armfig plant=3439 projected=6/6
  3.93  [AIR][Capacity] own=8/218 usage=8/152 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=96 reason=funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=328 E=216 bank=543 pull=152 plants=1/0 aircraftDemand=3/125
  3.93  [AIR][Projects] energyQueued=0 committed=50/511
  3.93  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=246 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Screen] fighters=5 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  3.97  [Playtest] finished armrad team 0 at 3.97 min
  3.98  [AIR][Rule] project.assist builder=18368
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.9 bank 312/1250, energy +219.7 bank 688/1377, units 25
  4.08  [AIR][Produce] intercept armfig plant=3439 projected=7/7
  4.10  [AIR][Capacity] own=8/218 usage=5/172 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=316 E=218 bank=1301 pull=172 plants=1/0 aircraftDemand=3/126
  4.10  [AIR][Projects] energyQueued=0 committed=26/262
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=3439 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=118
  4.13  [AIR][Screen] fighters=6 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  4.22  [Playtest] finished armmex team 0 at 4.22 min
  4.24  [AIR][Rule] energy.grow builder=18368
  4.24  [AIR][Wind] cluster=1 slots=6 at=2424,11936 local=false builder=20840
  4.24  [AIR][Rule] energy.grow builder=20840
  4.25  [AIR][Rule] energy.grow builder=6522
  4.25  [AIR][Produce] recon.replace armpeep plant=3439 projected=1/1
  4.26  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.26  [AIR][Rule] commander.idle.energy builder=2198
  4.27  [AIR][Capacity] own=8/219 usage=4/202 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST M=8 bank=309 E=219 bank=767 pull=202 plants=1/0 aircraftDemand=3/126
  4.27  [AIR][Projects] energyQueued=4 committed=160/700
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 2970 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(2198) at (2175, 11785) walks to (2216, 11852), 136 from the armmex site (2288, 11968)
  0.08  EXP: approach: armcom(5261) at (702, 7227) walks to (672, 7215), 136 from the armmex site (544, 7168)
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (1523, 10568) facing 2, 77x63 cells: 4489 of 4851 held
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (1523, 10072) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (1523, 10120) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (1523, 10168) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (1523, 10216) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: coralab at (1288, 9992) facing 2 (id 63)
  0.09  RESERVE: zone 8 at (1203, 9656) facing 2, 41x37 cells: 1481 of 1517 held
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (1203, 9368) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (1203, 9416) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (1203, 9464) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (1203, 9512) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: corlab at (1648, 8592) facing 2 (id 116)
  0.09  RESERVE: zone 9 at (1648, 8664) facing 2, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of cornanotc 2x1 gap 0 behind (1648, 8640) facing 2: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corlab at (1536, 8528) facing 2 (id 119)
  0.09  RESERVE: zone 10 at (1536, 8600) facing 2, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of cornanotc 2x1 gap 0 behind (1536, 8576) facing 2: 2 of 2 slots (group 8, zone)
  0.09  RESERVE: corridor 11 at (1632, 8552) facing 2, 6x21 cells: 111 of 126 held
  0.09  RESERVE: corridor 12 at (1440, 8552) facing 2, 6x21 cells: 126 of 126 held
  0.09  RESERVE: zone 13 at (1536, 8552) facing 0, 6x9 cells: 0 of 54 held
  0.09  RESERVE: corridor 13 at (1536, 8304) facing 2, 10x20 cells: 180 of 200 held
  0.09  EXP: approach: corcom(31217) at (802, 10452) walks to (755, 10513), 139 from the cormex site (672, 10624)
  0.09  EXP: approach: legcom(14851) at (4425, 9815) walks to (4648, 9841), 137 from the legmex site (4784, 9856)
  0.09  EXP: approach: corcom(30368) at (11602, 5076) walks to (11630, 5087), 139 from the cormex site (11760, 5136)
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.09  RESERVE: zone 7 at (10765, 1720) facing 0, 77x63 cells: 4557 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2216) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2168) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2120) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (10765, 2072) facing 0: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (11000, 2296) facing 0 (id 63)
  0.09  RESERVE: zone 8 at (11085, 2568) facing 0, 41x29 cells: 1087 of 1189 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2792) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2744) facing 0: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2696) facing 0: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11085, 2648) facing 0: 8 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (10640, 3696) facing 0 (id 106)
  0.09  RESERVE: zone 9 at (10640, 3624) facing 0, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (10640, 3648) facing 0: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (10736, 3672) facing 0, 6x21 cells: 126 of 126 held
  0.09  RESERVE: zone 11 at (10640, 3672) facing 0, 6x9 cells: 0 of 54 held
  0.09  RESERVE: corridor 11 at (10640, 3920) facing 0, 10x20 cells: 190 of 200 held
  0.09  EXP: approach: legcom(28410) at (11483, 1961) walks to (11504, 2016), 137 from the legmex site (11552, 2144)
  0.09  EXP: approach: armcom(1486) at (10101, 507) walks to (10077, 458), 136 from the armmex site (10016, 336)
  0.09  EXP: approach: corcom(27704) at (7863, 2499) walks to (7657, 2469), 139 from the cormex site (7520, 2448)
  0.12  EXP: idle: armcom(5261) on armmex at (681, 7221), site (544, 7168), target yes, fails 2 (arrived at the approach point)
  0.12  EXP: idle: corcom(30368) on cormex at (11624, 5085), site (11760, 5136), target yes, fails 2 (arrived at the approach point)
  0.17  RESERVE: corlab at (1296, 8416) facing 2 (id 122)
  0.17  RESERVE: zone 14 at (1296, 8488) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of cornanotc 2x1 gap 0 behind (1296, 8464) facing 2: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 15 at (1200, 8440) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (1296, 8440) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (1296, 8192) facing 2, 10x20 cells: 190 of 200 held
  0.17  RESERVE: leglab at (10864, 3808) facing 0 (id 109)
  0.17  RESERVE: zone 12 at (10864, 3736) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (10864, 3760) facing 0: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (10960, 3784) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (10864, 3784) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (10864, 4032) facing 0, 10x20 cells: 190 of 200 held
  0.23  EXP: approach: armcom(5261) at (680, 7221) walks to (735, 7167), 136 from the armmex site (832, 7072)
  0.23  EXP: approach: corcom(30368) at (11624, 5085) walks to (11572, 5136), 139 from the cormex site (11472, 5232)
  0.25  RESERVE: coralab at (1112, 7992) facing 2 (id 125)
  0.25  RESERVE: zone 17 at (1112, 8112) facing 2, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of cornanotc 2x2 gap 0 behind (1112, 8064) facing 2: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 18 at (1112, 8040) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 19 at (1112, 7744) facing 2, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 20 at (320, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (320, 9152) facing 0 (id 130)
  0.25  RESERVE: zone 21 at (352, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (352, 9152) facing 0 (id 131)
  0.25  RESERVE: zone 22 at (384, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (384, 9152) facing 0 (id 132)
  0.25  RESERVE: zone 23 at (416, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (416, 9152) facing 0 (id 133)
  0.25  RESERVE: zone 24 at (448, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (448, 9152) facing 0 (id 134)
  0.25  RESERVE: zone 25 at (480, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (480, 9152) facing 0 (id 135)
  0.25  RESERVE: zone 26 at (512, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (512, 9152) facing 0 (id 136)
  0.25  RESERVE: zone 27 at (544, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (544, 9152) facing 0 (id 137)
  0.25  RESERVE: zone 28 at (576, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (576, 9152) facing 0 (id 138)
  0.25  RESERVE: zone 29 at (608, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (608, 9152) facing 0 (id 139)
  0.25  RESERVE: zone 30 at (640, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (640, 9152) facing 0 (id 140)
  0.25  RESERVE: zone 31 at (960, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (960, 9152) facing 0 (id 141)
  0.25  RESERVE: zone 32 at (992, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (992, 9152) facing 0 (id 142)
  0.25  RESERVE: zone 33 at (1024, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (1024, 9152) facing 0 (id 143)
  0.25  RESERVE: zone 34 at (1056, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (1056, 9152) facing 0 (id 144)
  0.25  RESERVE: zone 35 at (1088, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (1088, 9152) facing 0 (id 145)
  0.25  RESERVE: zone 36 at (1120, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (1120, 9152) facing 0 (id 146)
  0.25  RESERVE: zone 37 at (1152, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (1152, 9152) facing 0 (id 147)
  0.25  RESERVE: zone 38 at (1184, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (1184, 9152) facing 0 (id 148)
  0.25  RESERVE: zone 39 at (1216, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (1216, 9152) facing 0 (id 149)
  0.25  RESERVE: zone 40 at (1248, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (1248, 9152) facing 0 (id 150)
  0.25  RESERVE: zone 41 at (1280, 9152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: cordrag at (1280, 9152) facing 0 (id 151)
  0.25  RESERVE: zone 42 at (544, 9264) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: corllt at (544, 9264) facing 0 (id 152)
  0.25  RESERVE: zone 43 at (1064, 9272) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: corrl at (1064, 9272) facing 0 (id 153)
  0.26  RESERVE: legalab at (11160, 3960) facing 0 (id 112)
  0.26  RESERVE: zone 15 at (11160, 3840) facing 0, 7x6 cells: 42 of 42 held
  0.26  RESERVE: grid of legnanotc 2x2 gap 0 behind (11160, 3888) facing 0: 4 of 4 slots (group 9, zone)
```
