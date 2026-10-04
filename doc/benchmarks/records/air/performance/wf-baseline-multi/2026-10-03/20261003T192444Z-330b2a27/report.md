# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54000); wall 491 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T16:16:30
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TACTICAL/armada/test, 2=TECH/cortex/test, 3=FRONT/legion/test, 4=FRONT/armada/test, 5=FRONT/cortex/test, 6=SUPPORT/legion/test, 7=SEA/armada/test, 8=TACTICAL/cortex/test, 9=TECH/legion/test, 10=AIR/armada/test, 11=FRONT/cortex/test, 12=FRONT/legion/test, 13=FRONT/armada/test, 14=SUPPORT/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_workforce_performance.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-baseline-multi\supreme\20261003T191630Z-85f819f4\runs\20261003T192444Z-330b2a27\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `timing-minute` | seen at 1.0 min | `[t=00:00:52.991916][f=0001800] [WorkforcePerf] frame=1800 samples=1800 ai_all_p50_ms=0.383789 ai_all_p95_ms=1.439453 ai_all_max_ms=68.746094 sim_speed=0.000` |
| expect `timing-cumulative` | seen at 10.0 min | `[t=00:02:06.733058][f=0018000] [WorkforcePerfTotal] frame=18000 samples=18000 ai_all_p50_ms=0.675781 ai_all_p95_ms=2.736328 ai_all_max_ms=68.746094` |
| expect `commands` | seen at 1.0 min | `[t=00:00:52.991290][f=0001800] [AirOrders] frame=1800 team=0 all_apm=47 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 3307 (12 by power), bank 0 + 47/s (0 by metal))` |

## Failures

- forbid 'invariant' hit at 13.4 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 3307 (12 by power), bank 0 + 47/s (0 by metal))
- forbid 'invariant' hit at 15.0 min: [INVARIANT] INV-052 ferry run for cargo 17561 unloading for 16 s
- forbid 'invariant' hit at 16.2 min: [INVARIANT] INV-008 4 turret(s) in range of the reclaim of legalab 26091 are not on it
- forbid 'invariant' hit at 16.4 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 4380 (16 by power), bank 8 + 49/s (0 by metal))
- forbid 'invariant' hit at 18.1 min: [INVARIANT] INV-052 ferry run for cargo 31013 unloading for 16 s
- forbid 'invariant' hit at 19.7 min: [INVARIANT] INV-052 ferry run for cargo 31013 unloading for 16 s
- forbid 'invariant' hit at 22.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.2 min: [INVARIANT] INV-022 a new set of cormmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.8 min: [INVARIANT] INV-022 a new set of cormmkr starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.6 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.1 min: [INVARIANT] INV-022 a new set of cormmkr starts 8 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.4 min: [INVARIANT] INV-014 cormmkr packed at (1968, 10688) with no turret slot within 450
- forbid 'invariant' hit at 29.0 min: [INVARIANT] INV-039 T1 land constructors released 486 s, 0 spam labs of 3 wanted, no forward order for 180 s
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-014 legadveconv packed at (10304, 1584) with no turret slot within 450
- forbid 'invariant' hit at 29.1 min: [INVARIANT] INV-022 a new set of legadveconv starts 10 cell(s) from the turrets, not flush

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-baseline-multi\supreme\20261003T191630Z-85f819f4\runs\20261003T192444Z-330b2a27\screen_2026-10-03_19-17-52-802.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-baseline-multi\supreme\20261003T191630Z-85f819f4\runs\20261003T192444Z-330b2a27\screen_2026-10-03_19-19-38-715.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-baseline-multi\supreme\20261003T191630Z-85f819f4\runs\20261003T192444Z-330b2a27\screen_2026-10-03_19-22-29-483.png

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
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=307 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 55 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|2175|11785|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=AIR side=armada start=(701,7226) factory=armap landLocked=no spot=0 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=TECH side=cortex start=(802,10450) factory=corlab landLocked=no spot=1 known=2/7
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
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=966 E=18 bank=782 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=322 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.30  [AIR][Rule] opening.mex builder=2198
  0.30  [Team][Roster] first mex 18552 at 2288,11968
  0.30  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2175|11785|0|2|1|2288|11968
  0.35  [Team][Roster] team 2 first mex at 672,10623
  0.37  [Team][Roster] team 6 first mex at 4784,9856
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=987 E=30 bank=977 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=354 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.53  [Playtest] finished armmex team 0 at 0.53 min
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=987 E=30 bank=711 pull=6 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=50/500
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=417 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1016 E=30 bank=523 pull=89 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=4/49
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=517 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.78  [Playtest] finished armmex team 0 at 0.78 min
  0.79  [AIR][Wind] cluster=0 slots=6 at=2088,11696 local=true builder=2198
  0.79  [AIR][Rule] opening.energy builder=2198
  0.88  [Playtest] finished armwin team 0 at 0.88 min
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=1048 E=30 bank=548 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=521 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1067/1150, energy +44.2 bank 617/1000, units 6
  1.03  [Playtest] finished armwin team 0 at 1.03 min
  1.10  [AIR][Economy] BOOTSTRAP M=8 bank=1086 E=39 bank=852 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=21/95
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=627 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.15  [Playtest] finished armwin team 0 at 1.15 min
  1.26  [Playtest] finished armwin team 0 at 1.26 min
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=1112 E=58 bank=1000 pull=41 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=643 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.36  [Playtest] finished armwin team 0 at 1.36 min
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=97 bank=1002 pull=9 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=1 committed=40/175
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=659 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.52  [Playtest] finished armwin team 0 at 1.52 min
  1.53  [AIR][Starter] nearby distance=127
  1.53  [AIR][Rule] opening.plant builder=2198
  1.55  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 zone=16
  1.57  [AIR][EcoLayout] reserved air.eco.1 reactor=1792,11536 converters=8 zone=26
  1.58  [AIR][EcoLayout] reserved air.eco.2 reactor=3200,11408 converters=8 zone=45
  1.60  [AIR][EcoLayout] reserved air.eco.3 reactor=3712,10896 converters=8 zone=68
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=1087 E=122 bank=989 pull=69 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=546/924
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=627 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=28551 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Economy] BOOTSTRAP M=8 bank=818 E=135 bank=990 pull=69 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=188/318
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=213 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=28551 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.85  [Playtest] finished armap team 0 at 1.85 min
  1.86  [AIR][Produce] opening.scout armpeep plant=28551 projected=1/1
  1.87  [AIR][Claim] cancel unowned native order armnanotc
  1.87  [AIR][Claim] cancel unowned native order armnanotc
  1.87  [AIR][State] T1_CONTEST
  1.87  [AIR][Rule] opening.commander.guard builder=2198
  1.93  [AIR][Economy] T1_CONTEST M=8 bank=667 E=134 bank=789 pull=258 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=213 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 676/1250, energy +143.6 bank 486/1103, units 12
  2.00  [AIR][Produce] constructor.recovery armca plant=28551 projected=1/3
  2.10  [AIR][Economy] T1_CONTEST M=8 bank=691 E=139 bank=584 pull=151 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=213 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.23  [AIR][Produce] constructor.recovery armca plant=28551 projected=3/3
  2.24  [AIR][Rule] recovery.energy builder=18003
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=700 E=141 bank=413 pull=71 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=1 committed=155/0
  2.27  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=213 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=677 E=146 bank=72 pull=197 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=132/0
  2.43  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=213 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.46  [AIR][Produce] constructor.recovery armca plant=28551 projected=3/3
  2.46  [AIR][Rule] recovery.energy builder=11678
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=666 E=148 bank=434 pull=116 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=246/0
  2.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=213 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.73  [AIR][Produce] opening.screen armfig plant=28551 projected=1/6
  2.73  [AIR][Rule] recovery.energy builder=17127
  2.75  [AIR][Rule] commander.factory.guard builder=2198
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=629 E=149 bank=751 pull=58 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=1 committed=341/0
  2.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=213 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=564 E=141 bank=68 pull=257 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=254/0
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=191 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.94  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.94  [AIR][Rule] commander.idle.assist builder=2198
  2.95  [AIR][Produce] opening.screen armfig plant=28551 projected=2/6
  2.95  [AIR][Screen] fighters=1 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  2.96  [AIR][Rule] commander.factory.guard builder=2198
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.9 bank 541/1250, energy +133.7 bank 0/1178, units 20
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=506 E=129 bank=42 pull=270 plants=1/0 aircraftDemand=3/124
  3.10  [AIR][Projects] energyQueued=0 committed=165/0
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=158 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=71
  3.12  [AIR][Screen] fighters=1 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  3.17  [Playtest] finished armsolar team 0 at 3.17 min
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=458 E=112 bank=21 pull=319 plants=1/0 aircraftDemand=3/124
  3.27  [AIR][Projects] energyQueued=0 committed=239/0
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=125 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Produce] opening.screen armfig plant=28551 projected=3/6
  3.32  [AIR][Screen] fighters=2 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  3.38  [AIR][Layout] cluster=0 labs=1 at=2151,11041
  3.40  [AIR][Layout] cluster=1 labs=1 at=2151,10561
  3.40  [Playtest] finished armsolar team 0 at 3.40 min
  3.41  [AIR][Rule] recovery.assist builder=11678
  3.42  [AIR][Layout] cluster=2 labs=1 at=2919,10561
  3.43  [AIR][Layout] cluster=3 labs=1 at=3111,10561
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=407 E=110 bank=35 pull=290 plants=1/0 aircraftDemand=3/125
  3.43  [AIR][Projects] energyQueued=0 committed=155/0
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=136 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.45  [AIR][Layout] cluster=4 labs=1 at=711,10273
  3.47  [AIR][Layout] cluster=5 labs=1 at=3111,10081
  3.48  [AIR][Layout] cluster=6 labs=1 at=2343,11713
  3.48  [AIR][Screen] fighters=2 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  3.58  [AIR][Produce] opening.screen armfig plant=28551 projected=4/6
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=346 E=142 bank=251 pull=21 plants=1/0 aircraftDemand=3/126
  3.60  [AIR][Projects] energyQueued=0 committed=65/0
  3.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=125 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=68
  3.65  [Playtest] finished armsolar team 0 at 3.65 min
  3.65  [AIR][Screen] fighters=3 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  3.66  [AIR][Rule] mex.expand builder=17127
  3.76  [Playtest] finished armsolar team 0 at 3.76 min
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=304 E=157 bank=6 pull=344 plants=1/0 aircraftDemand=3/126
  3.77  [AIR][Projects] energyQueued=0 committed=50/500
  3.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=169 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Rule] intel.radar builder=18003
  3.78  [AIR][Rule] wait builder=11678
  3.82  [AIR][Screen] fighters=3 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  3.82  [AIR][Produce] opening.screen armfig plant=28551 projected=5/6
  3.85  [AIR][Rule] project.assist builder=11678
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=308 E=174 bank=47 pull=387 plants=1/0 aircraftDemand=3/126
  3.93  [AIR][Projects] energyQueued=0 committed=84/860
  3.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=147 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.00  [AIR][Screen] fighters=4 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.9 bank 300/1250, energy +214.8 bank 0/1378, units 26
  4.07  [AIR][Produce] opening.screen armfig plant=28551 projected=6/6
  4.07  [Playtest] finished armrad team 0 at 4.07 min
  4.08  [AIR][Rule] project.assist builder=18003
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=297 E=195 bank=539 pull=83 plants=1/0 aircraftDemand=3/126
  4.10  [AIR][Projects] energyQueued=0 committed=39/392
  4.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=70
  4.17  [AIR][Screen] fighters=5 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  4.26  [AIR][Produce] intercept armfig plant=28551 projected=7/7
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=297 E=219 bank=1364 pull=226 plants=1/0 aircraftDemand=3/126
  4.27  [AIR][Projects] energyQueued=0 committed=19/196
  4.27  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=202 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.33  [AIR][Screen] fighters=6 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  4.34  [Playtest] finished armmex team 0 at 4.34 min
  4.36  [AIR][Wind] cluster=1 slots=6 at=2104,12064 local=false builder=17127
  4.36  [AIR][Rule] energy.grow builder=17127
  4.36  [AIR][Rule] energy.grow builder=18003
  4.37  [AIR][Rule] energy.grow builder=11678
  4.43  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.43  [AIR][Rule] commander.idle.energy builder=2198
  4.43  [AIR][Economy] T1_CONTEST M=8 bank=300 E=237 bank=1378 pull=49 plants=1/0 aircraftDemand=3/126
  4.43  [AIR][Projects] energyQueued=4 committed=160/700
  4.43  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=213 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.52  [AIR][Screen] fighters=7 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  4.60  [AIR][Economy] T1_CONTEST M=11 bank=399 E=238 bank=1378 pull=28 plants=1/0 aircraftDemand=3/126
  4.60  [AIR][Projects] energyQueued=1 committed=142/625
  4.60  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=63
  4.68  [AIR][Screen] fighters=7 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  4.69  [Playtest] finished armwin team 0 at 4.69 min
  4.70  [AIR][Rule] commander.energy.local builder=2198
  4.77  [AIR][Economy] T1_CONTEST M=11 bank=422 E=233 bank=1372 pull=61 plants=1/0 aircraftDemand=3/126
  4.77  [AIR][Projects] energyQueued=0 committed=86/380
  4.77  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.81  [Playtest] finished armwin team 0 at 4.81 min
  4.85  [AIR][Screen] fighters=7 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  4.93  [AIR][Economy] T1_CONTEST M=11 bank=438 E=247 bank=1365 pull=61 plants=1/0 aircraftDemand=3/126
  4.93  [AIR][Projects] energyQueued=0 committed=30/134
  4.93  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.94  [Playtest] finished armwin team 0 at 4.94 min
  4.95  [AIR][Wind] cluster=2 slots=6 at=1704,12016 local=false builder=2198
  4.95  [AIR][Rule] commander.idle.energy builder=2198
  5.00  [Playtest] eco team 0 at 5.0 min: metal +11.2 bank 464/1300, energy +295.2 bank 1378/1379, units 33
  5.00  [Playtest] target team 0 at (2155, 11747) from its start position
  5.00  [Playtest] camera requested (1824,11688) height=2200
  5.01  [Playtest] camera captured name=ta position=(1824,11688) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1824, 11688)
  5.02  [AIR][Screen] fighters=7 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  5.05  [Playtest] finished armwin team 0 at 5.05 min
  5.06  [AIR][Rule] storage.buffer builder=18003
  5.06  [Playtest] finished armwin team 0 at 5.06 min
  5.06  [Playtest] finished armwin team 0 at 5.06 min
  5.10  [AIR][Economy] T1_CONTEST M=11 bank=505 E=271 bank=1381 pull=27 plants=1/0 aircraftDemand=3/126
  5.10  [AIR][Projects] energyQueued=2 committed=279/2177
  5.10  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=268 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=57
  5.16  [Playtest] finished armwin team 0 at 5.16 min
  5.18  [AIR][Rule] commander.convert builder=2198
  5.18  [AIR][Screen] fighters=7 cells=8 centre=1112,10198 width=600 advance=400 responding=false
  5.27  [AIR][Economy] T1_CONTEST M=11 bank=548 E=335 bank=1367 pull=176 plants=1/0 aircraftDemand=3/126
  5.27  [AIR][Projects] energyQueued=0 committed=214/2407
  5.27  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=268 floating=false savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=28551 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
... 3108 more
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
  0.09  EXP: approach: corcom(31217) at (802, 10451) walks to (756, 10513), 139 from the cormex site (672, 10624)
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
