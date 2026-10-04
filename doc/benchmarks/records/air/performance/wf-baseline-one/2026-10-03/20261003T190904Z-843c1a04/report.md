# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54042); wall 420 s
- DLL: build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T16:02:02
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TACTICAL/armada/test, 2=TECH/cortex/test, 3=FRONT/legion/test, 4=FRONT/armada/test, 5=FRONT/cortex/test, 6=SUPPORT/legion/test, 7=SEA/armada/test, 8=TACTICAL/cortex/test, 9=TECH/legion/test, 10=AIR/armada/test, 11=FRONT/cortex/test, 12=FRONT/legion/test, 13=FRONT/armada/test, 14=SUPPORT/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_workforce_performance.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-baseline-one\supreme\20261003T190202Z-89ce9b71\runs\20261003T190904Z-843c1a04\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `timing-minute` | seen at 1.0 min | `[t=00:00:52.278253][f=0001800] [WorkforcePerf] frame=1800 samples=1800 ai_all_p50_ms=0.370117 ai_all_p95_ms=1.270508 ai_all_max_ms=70.459961 sim_speed=0.000` |
| expect `timing-cumulative` | seen at 10.0 min | `[t=00:02:00.815792][f=0018000] [WorkforcePerfTotal] frame=18000 samples=18000 ai_all_p50_ms=0.701172 ai_all_p95_ms=2.376953 ai_all_max_ms=70.459961` |
| expect `commands` | seen at 1.0 min | `[t=00:00:52.277671][f=0001800] [AirOrders] frame=1800 team=0 all_apm=47 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 870 (3 by power), bank 272 + 8/s (1 by metal))` |

## Failures

- forbid 'invariant' hit at 5.4 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 870 (3 by power), bank 272 + 8/s (1 by metal))
- forbid 'invariant' hit at 14.4 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 3630 (13 by power), bank 0 + 38/s (0 by metal))
- forbid 'invariant' hit at 14.8 min: [INVARIANT] INV-008 4 turret(s) in range of the reclaim of coralab 6093 are not on it
- forbid 'invariant' hit at 20.7 min: [INVARIANT] INV-022 a new set of corafus starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.7 min: [INVARIANT] INV-022 a new set of corafus starts 2 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.4 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.4 min: [INVARIANT] INV-022 a new set of cormmkr starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.5 min: [INVARIANT] INV-022 a new set of legadveconv starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.8 min: [INVARIANT] INV-022 a new set of legadveconv starts 9 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-014 legadveconv packed at (10016, 1856) with no turret slot within 450
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-039 T1 land constructors released 483 s, 0 spam labs of 3 wanted, no forward order for 180 s

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-baseline-one\supreme\20261003T190202Z-89ce9b71\runs\20261003T190904Z-843c1a04\screen_2026-10-03_19-03-21-641.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-baseline-one\supreme\20261003T190202Z-89ce9b71\runs\20261003T190904Z-843c1a04\screen_2026-10-03_19-05-06-835.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\performance\wf-baseline-one\supreme\20261003T190202Z-89ce9b71\runs\20261003T190904Z-843c1a04\screen_2026-10-03_19-07-35-767.png

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
  0.10  [Team][Roster] Team 1 (AI 1): role=TACTICAL side=armada start=(701,7226) factory=armhp landLocked=no spot=0 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=TECH side=cortex start=(801,10451) factory=corlab landLocked=no spot=1 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=FRONT side=legion start=(2477,8018) factory=legvp landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=FRONT side=armada start=(4592,7449) factory=armlab landLocked=no spot=4 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=FRONT side=cortex start=(5002,8622) factory=corvp landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SUPPORT side=legion start=(4424,9815) factory=leglab landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=SEA side=armada start=(4774,11078) factory=armsy landLocked=no spot=7 known=7/7
  0.18  [Team][Roster] team 1 first mex at 544,7168
  0.19  [Team][Roster] team 4 first mex at 4512,7600
  0.20  [Team][Roster] team 3 first mex at 2368,8128
  0.20  [Team][Roster] team 5 first mex at 5023,8783
  0.20  [Team][Roster] team 7 first mex at 4608,11072
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=965 E=18 bank=722 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=322 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.30  [AIR][Rule] opening.mex builder=2198
  0.30  [Team][Roster] first mex 20637 at 2288,11968
  0.30  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2175|11785|0|2|1|2288|11968
  0.30  [Team][Roster] team 6 first mex at 4784,9856
  0.35  [Team][Roster] team 2 first mex at 672,10623
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=986 E=30 bank=943 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=50/500
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=350 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.53  [Playtest] finished armmex team 0 at 0.53 min
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=986 E=30 bank=704 pull=6 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=50/500
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=416 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=1015 E=30 bank=517 pull=89 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=4/49
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=517 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.78  [Playtest] finished armmex team 0 at 0.78 min
  0.79  [AIR][Wind] cluster=0 slots=6 at=2104,11696 local=true builder=2198
  0.79  [AIR][Rule] opening.energy builder=2198
  0.89  [Playtest] finished armwin team 0 at 0.89 min
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=1048 E=30 bank=593 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=521 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.9 bank 1070/1150, energy +31.0 bank 716/1000, units 6
  1.04  [Playtest] finished armwin team 0 at 1.04 min
  1.10  [AIR][Economy] BOOTSTRAP M=8 bank=1086 E=30 bank=990 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=21/95
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=627 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.15  [Playtest] finished armwin team 0 at 1.15 min
  1.26  [Playtest] finished armwin team 0 at 1.26 min
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=1109 E=34 bank=991 pull=41 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=641 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.37  [Playtest] finished armwin team 0 at 1.37 min
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=64 bank=1001 pull=41 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=21/95
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=658 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.48  [Playtest] finished armwin team 0 at 1.48 min
  1.49  [AIR][Wind] cluster=1 slots=6 at=2424,11936 local=false builder=2198
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=86 bank=1003 pull=9 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=1 committed=40/175
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=658 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Economy] BOOTSTRAP M=8 bank=1138 E=85 bank=977 pull=41 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=1 committed=40/175
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=658 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.80  [Playtest] finished armwin team 0 at 1.80 min
  1.81  [AIR][Starter] nearby distance=127
  1.81  [AIR][Rule] opening.plant builder=2198
  1.82  [AIR][Layout] cluster=0 labs=6 at=2727,11425
  1.82  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 zone=134
  1.83  [AIR][EcoLayout] reserved air.eco.1 reactor=1536,11920 converters=8 zone=144
  1.85  [AIR][EcoLayout] reserved air.eco.2 reactor=2048,11536 converters=8 zone=154
  1.87  [AIR][EcoLayout] reserved air.eco.3 reactor=3200,11408 converters=8 zone=172
  1.93  [AIR][Economy] BOOTSTRAP M=8 bank=1006 E=75 bank=960 pull=69 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=438/742
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=579 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=8005 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 873/1150, energy +75.8 bank 962/1003, units 12
  2.10  [AIR][Economy] BOOTSTRAP M=8 bank=737 E=73 bank=953 pull=69 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=81/137
  2.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=213 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=8005 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.14  [Playtest] finished armap team 0 at 2.14 min
  2.15  [AIR][Produce] opening.scout armpeep plant=8005 projected=1/1
  2.15  [AIR][Claim] cancel unowned native order armnanotc
  2.15  [AIR][Claim] cancel unowned native order armnanotc
  2.15  [AIR][State] T1_CONTEST
  2.15  [AIR][Rule] opening.commander.guard builder=2198
  2.27  [AIR][Economy] T1_CONTEST M=8 bank=672 E=77 bank=348 pull=258 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=213 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.29  [AIR][Produce] constructor.recovery armca plant=8005 projected=1/3
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=699 E=66 bank=11 pull=181 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=175 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=3 bank=715 E=49 bank=12 pull=168 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=92 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.76  [AIR][Produce] constructor.recovery armca plant=8005 projected=2/3
  2.76  [AIR][Rule] recovery.energy builder=20781
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=734 E=52 bank=39 pull=120 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=1 committed=155/0
  2.77  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=114 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=740 E=85 bank=14 pull=160 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=134/0
  2.93  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=147 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +7.8 bank 731/1250, energy +107.6 bank 1/1128, units 16
  3.09  [AIR][Produce] constructor.recovery armca plant=8005 projected=3/3
  3.09  [AIR][Rule] recovery.energy builder=9289
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=724 E=99 bank=86 pull=93 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=1 committed=259/0
  3.10  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=125 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=701 E=117 bank=852 pull=160 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=0 committed=207/0
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=186 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.36  [AIR][Produce] opening.screen armfig plant=8005 projected=1/6
  3.37  [AIR][Rule] mex.expand builder=10637
  3.42  [AIR][Commander] cleared factory guard for commander.energy.local
  3.42  [AIR][Rule] commander.energy.local builder=2198
  3.43  [AIR][Economy] T1_CONTEST M=8 bank=667 E=168 bank=947 pull=381 plants=1/0 aircraftDemand=3/121
  3.43  [AIR][Projects] energyQueued=1 committed=237/675
  3.43  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=213 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.48  [AIR][Layout] cluster=1 labs=1 at=2727,11041
  3.53  [Playtest] finished armwin team 0 at 3.53 min
  3.60  [AIR][Economy] T1_CONTEST M=8 bank=606 E=175 bank=1146 pull=179 plants=1/0 aircraftDemand=3/121
  3.60  [AIR][Projects] energyQueued=0 committed=156/540
  3.60  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=213 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.66  [Playtest] finished armwin team 0 at 3.66 min
  3.68  [Playtest] finished armsolar team 0 at 3.68 min
  3.69  [AIR][Produce] opening.screen armfig plant=8005 projected=2/6
  3.69  [AIR][Screen] fighters=1 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  3.70  [AIR][Rule] mex.assist builder=20781
  3.70  [AIR][Claim] cancel unowned native order armmakr
  3.76  [Playtest] finished armwin team 0 at 3.76 min
  3.77  [AIR][Economy] T1_CONTEST M=8 bank=540 E=194 bank=1209 pull=179 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=72/291
  3.77  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=213 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.87  [AIR][Screen] fighters=1 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  3.88  [Playtest] finished armwin team 0 at 3.88 min
  3.89  [AIR][Rule] commander.factory.guard builder=2198
  3.93  [AIR][Economy] T1_CONTEST M=8 bank=496 E=228 bank=1111 pull=293 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=19/58
  3.93  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=213 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.97  [Playtest] finished armmex team 0 at 3.97 min
  3.98  [AIR][Produce] opening.screen armfig plant=8005 projected=3/6
  3.98  [AIR][Rule] energy.grow builder=10637
  3.99  [AIR][Rule] energy.grow builder=20781
  3.99  [AIR][Commander] cleared factory guard for commander.idle.energy
  3.99  [AIR][Rule] commander.idle.energy builder=2198
  4.00  [AIR][Wind] cluster=2 slots=6 at=1896,12064 local=false builder=10637
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.2 bank 491/1300, energy +187.0 bank 867/1230, units 25
  4.01  [Playtest] finished armsolar team 0 at 4.01 min
  4.02  [AIR][Rule] energy.grow builder=9289
  4.03  [AIR][Screen] fighters=2 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  4.10  [Playtest] finished armwin team 0 at 4.10 min
  4.10  [AIR][Economy] T1_CONTEST M=8 bank=497 E=193 bank=1155 pull=169 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=3 committed=120/525
  4.10  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=213 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.11  [AIR][Rule] commander.factory.guard builder=2198
  4.20  [AIR][Screen] fighters=2 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  4.23  [AIR][Produce] opening.screen armfig plant=8005 projected=4/6
  4.27  [AIR][Economy] T1_CONTEST M=11 bank=530 E=221 bank=1224 pull=65 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=0 committed=102/446
  4.27  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.37  [AIR][Screen] fighters=3 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  4.40  [AIR][Produce] opening.screen armfig plant=8005 projected=5/6
  4.41  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.41  [AIR][Rule] commander.idle.assist builder=2198
  4.43  [AIR][Rule] commander.factory.guard builder=2198
  4.43  [AIR][Economy] T1_CONTEST M=11 bank=532 E=278 bank=1220 pull=57 plants=1/0 aircraftDemand=3/127
  4.43  [AIR][Projects] energyQueued=0 committed=64/282
  4.43  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.53  [AIR][Screen] fighters=4 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  4.58  [AIR][Produce] opening.screen armfig plant=8005 projected=6/6
  4.60  [AIR][Economy] T1_CONTEST M=11 bank=535 E=235 bank=565 pull=115 plants=1/0 aircraftDemand=3/127
  4.60  [AIR][Projects] energyQueued=0 committed=27/118
  4.60  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.67  [Playtest] finished armwin team 0 at 4.67 min
  4.72  [AIR][Screen] fighters=5 cells=8 centre=1111,10199 width=600 advance=400 responding=false
  4.74  [Playtest] finished armwin team 0 at 4.74 min
  4.75  [AIR][Rule] recovery.energy builder=10637
  4.76  [Playtest] finished armwin team 0 at 4.76 min
  4.77  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=539 E=237 bank=69 pull=289 plants=1/0 aircraftDemand=3/127
  4.77  [AIR][Projects] energyQueued=1 committed=191/160
  4.77  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=257 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=8005 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Rule] recovery.energy builder=20781
... 2313 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(2198) at (2175, 11785) walks to (2216, 11852), 136 from the armmex site (2288, 11968)
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
  0.09  EXP: approach: armcom(1486) at (10101, 506) walks to (10077, 458), 136 from the armmex site (10016, 336)
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
  0.26  RESERVE: zone 16 at (11160, 3912) facing 0, 9x15 cells: 12 of 135 held
  0.26  RESERVE: corridor 17 at (11160, 4208) facing 0, 13x20 cells: 260 of 260 held
  0.26  RESERVE: zone 18 at (11968, 3264) facing 0, 2x2 cells: 4 of 4 held
  0.26  RESERVE: legdrag at (11968, 3264) facing 0 (id 117)
  0.26  RESERVE: zone 19 at (11936, 3264) facing 0, 2x2 cells: 4 of 4 held
  0.26  RESERVE: legdrag at (11936, 3264) facing 0 (id 118)
  0.26  RESERVE: zone 20 at (11904, 3264) facing 0, 2x2 cells: 4 of 4 held
  0.26  RESERVE: legdrag at (11904, 3264) facing 0 (id 119)
```
