# Playtest report: PASS

- Verdict: **PASS** (reached 16 min)
- Game time reached: 16.0 min (frame 28888); wall 164 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-baseline\cohort\20261003T164015Z-53db5088\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T15:22:59
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=SUPPORT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_workforce_budget.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-six-labs\supreme\20261003T182259Z-8c8d85a6\runs\20261003T182546Z-5f1781f1\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `adoption` | seen at 0.5 min | `[WorkforceProbe] PASS named-state adoption support=12` |
| expect `sample` | seen at 0.1 min | `[AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload` |
| expect `donor-stop` | seen at 10.0 min | `[t=00:01:46.045149][f=0018000] [WorkforceFixture] donor stopped bursts=108` |
| expect `work` | seen at 1.0 min | `2 idle=0 guards=0 metal=448/19100 income=6.6 pull=52.7 received=0.0 energy=52083 incomeE=5169.0 usageM=52.7 usageE=162.5 sent=0.0 excess=0.0 workingBP=260.0 idleBP=0.0 nanoWorking=0 factoriesWorking=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `probe` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-six-labs\supreme\20261003T182259Z-8c8d85a6\runs\20261003T182546Z-5f1781f1\screen_2026-10-03_18-24-06-198.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-six-labs\supreme\20261003T182259Z-8c8d85a6\runs\20261003T182546Z-5f1781f1\screen_2026-10-03_18-24-21-708.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-six-labs\supreme\20261003T182259Z-8c8d85a6\runs\20261003T182546Z-5f1781f1\screen_2026-10-03_18-24-50-003.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-six-labs\supreme\20261003T182259Z-8c8d85a6\runs\20261003T182546Z-5f1781f1\screen_2026-10-03_18-25-35-205.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 4 shots, end at 16.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4700, 11000) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 29
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (2155, 11747) units 1
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
  0.10  [AIR][Claim] cancel unowned native order corap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 59 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|cortex|corap|2176|11788|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SUPPORT side=armada start=(4700,10997) factory=armlab landLocked=no spot=7 known=1/1
  0.27  [AIR][Capacity] own=2/30 usage=8/80 gifts=6 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=990 E=18 bank=919 pull=80 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.28  [Playtest] finished cormex team 0 at 0.28 min
  0.28  [Team][Roster] first mex 27610 at 2287,11967
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|cortex|corap|2176|11788|0|2|1|2287|11967
  0.29  [AIR][Rule] opening.mex builder=29509
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=5 bank=1035 E=30 bank=986 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=46/465
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.52  [AIR][Layout] cluster=0 labs=6 at=2056,11620
  0.52  [AIR][EcoLayout] reserved air.eco.0 reactor=2816,11920 converters=8 support=12 zone=134
  0.52  [AIR][Layout] cluster=1 labs=6 at=2536,11428
  0.52  [Playtest] finished cormstor team 0 at 0.52 min
  0.52  [Playtest] finished cormstor team 0 at 0.52 min
  0.52  [Playtest] finished cormstor team 0 at 0.52 min
  0.52  [Playtest] finished cormstor team 0 at 0.52 min
  0.52  [Playtest] finished cormstor team 0 at 0.52 min
  0.52  [Playtest] finished cormstor team 0 at 0.52 min
  0.53  [AIR][Rule] opening.mex builder=29542
  0.53  [Playtest] finished cormex team 0 at 0.53 min
  0.53  [Playtest] finished corestor team 0 at 0.53 min
  0.53  [Playtest] finished corestor team 0 at 0.53 min
  0.53  [Playtest] finished corestor team 0 at 0.53 min
  0.53  [Playtest] finished corestor team 0 at 0.53 min
  0.53  [Playtest] finished corestor team 0 at 0.53 min
  0.53  [Playtest] finished corestor team 0 at 0.53 min
  0.53  [AIR][EcoLayout] reserved air.eco.1 reactor=1408,11792 converters=8 support=12 zone=283
  0.53  [AIR][Rule] opening.plant builder=5224
  0.54  [Playtest] finished corfus team 0 at 0.54 min
  0.54  [Playtest] finished corfus team 0 at 0.54 min
  0.54  [Playtest] finished corfus team 0 at 0.54 min
  0.54  [Playtest] finished corfus team 0 at 0.54 min
  0.54  [Playtest] finished corfus team 0 at 0.54 min
  0.54  [Playtest] finished corfus team 0 at 0.54 min
  0.54  [AIR][Wind] cluster=0 slots=6 at=2328,11680 local=true builder=29509
  0.54  [AIR][Rule] opening.energy builder=29509
  0.55  [AIR][EcoLayout] reserved air.eco.2 reactor=3072,11152 converters=8 support=12 zone=312
  0.57  [AIR][EcoLayout] reserved air.eco.3 reactor=4096,11664 converters=8 support=12 zone=345
  0.60  [AIR][Capacity] own=4/30 usage=7/37 gifts=0 sent=0 excess=0 pressure=false mobile=260 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=6 bank=1045 E=30 bank=13893 pull=37 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=1297/9313
  0.60  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=260 floating=false savingLab=false
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
  0.66  [Playtest] finished corwin team 0 at 0.66 min
  0.67  [AIR][Rule] opening.commander.guard builder=29509
  0.77  [AIR][Capacity] own=6/5150 usage=21/107 gifts=0 sent=0 excess=0 pressure=false mobile=260 arriving=0 idle=0 ecoStatic=0 working=130 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=926 E=4640 bank=52100 pull=107 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=1099/8307
  0.77  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=260 floating=false savingLab=false
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
  0.93  [AIR][Capacity] own=6/5168 usage=56/168 gifts=0 sent=0 excess=0 pressure=false mobile=260 arriving=0 idle=0 ecoStatic=0 working=129 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=692 E=5168 bank=52100 pull=168 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=765/7080
  0.93  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=260 floating=false savingLab=false
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 448/19100, energy +5169.0 bank 52082/52100, units 26
  1.01  [Playtest] finished corap team 0 at 1.01 min
  1.02  [AIR][Claim] cancel unowned native order cornanotc
  1.02  [AIR][State] T1_CONTEST
  1.02  [AIR][Produce] opening.scout corfink plant=1971 projected=1/1
  1.03  [AIR][Rule] mex.upgrade builder=5224
  1.10  [AIR][Capacity] own=6/5168 usage=9/195 gifts=0 sent=0 excess=0 pressure=false mobile=260 arriving=0 idle=0 ecoStatic=0 working=129 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T1_CONTEST M=6 bank=402 E=5168 bank=52200 pull=195 plants=1/0 aircraftDemand=3/123
  1.10  [AIR][Projects] energyQueued=0 committed=1107/14016
  1.10  [AIR][Workforce] t1=0/3 t2=2/2 targetBP=260 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=online
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
  1.18  [AIR][Produce] constructor.recovery corca plant=1971 projected=1/3
  1.27  [AIR][Capacity] own=6/5168 usage=13/193 gifts=0 sent=0 excess=0 pressure=true mobile=260 arriving=55 idle=0 ecoStatic=0 working=259 shortage=1889 reason=funded workload
  1.27  [AIR][Economy] T1_CONTEST M=6 bank=5300 E=5168 bank=52200 pull=345 plants=1/0 aircraftDemand=3/123
  1.27  [AIR][Projects] energyQueued=0 committed=1008/12767
  1.27  [AIR][Workforce] t1=1/3 t2=2/3 targetBP=2204 floating=false savingLab=false
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
  1.37  [AIR][State] T1_CONTEST
  1.40  [AIR][Produce] constructor.recovery corca plant=1971 projected=2/3
  1.41  [AIR][LabGate] M10=6 window=true bank=15172 cost=2900 reason=bank
  1.41  [AIR][Rule] production.banked builder=28358
  1.42  [AIR][State] T2_TRANSITION
  1.43  [AIR][Capacity] own=6/5168 usage=6/62 gifts=0 sent=0 excess=0 pressure=true mobile=315 arriving=55 idle=0 ecoStatic=0 working=259 shortage=1672 reason=funded workload
  1.43  [AIR][Economy] T2_TRANSITION M=6 bank=15165 E=5168 bank=52225 pull=189 plants=1/0 aircraftDemand=3/123
  1.43  [AIR][Projects] energyQueued=0 committed=3787/39238
  1.43  [AIR][Workforce] t1=2/3 t2=2/3 targetBP=2042 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.43  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/1 available=yes firstSlot=0
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
  1.45  [AIR][Share] metal 18988 of 19200 (98%): sent 3840 to team 1 (58% full); the engine counts 0 metal sent in the last update (D-106)
  1.48  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 22082) (D-106)
  1.53  [AIR][Share] metal 18982 of 19200 (98%): sent 3840 to team 1 (77% full); the engine counts 0 metal sent in the last update (D-106)
  1.57  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 28000) (D-106)
  1.60  [AIR][Capacity] own=6/5173 usage=16/203 gifts=0 sent=0 excess=0 pressure=true mobile=315 arriving=55 idle=0 ecoStatic=0 working=259 shortage=1455 reason=funded workload
  1.60  [AIR][Economy] T2_TRANSITION M=778 bank=15084 E=5171 bank=52225 pull=393 plants=1/0 aircraftDemand=3/123
  1.60  [AIR][Projects] energyQueued=0 committed=3619/37263
  1.60  [AIR][Workforce] t1=2/3 t2=2/3 targetBP=1825 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.60  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/5 available=yes firstSlot=0
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
  1.62  [AIR][Share] metal 18980 of 19200 (98%): sent 930 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  1.63  [AIR][Produce] constructor.recovery corca plant=1971 projected=3/3
  1.63  [AIR][Rule] mex.assist builder=31863
  1.65  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30690) (D-106)
  1.77  [AIR][Capacity] own=6/5173 usage=18/222 gifts=22 sent=0 excess=0 pressure=true mobile=370 arriving=55 idle=0 ecoStatic=0 working=314 shortage=1092 reason=funded workload
  1.77  [AIR][Economy] T2_TRANSITION M=147 bank=19008 E=5173 bank=52250 pull=412 plants=1/0 aircraftDemand=3/123
  1.77  [AIR][Projects] energyQueued=0 committed=3441/35161
  1.77  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=1517 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.77  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/5 available=yes firstSlot=0
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
  1.84  [AIR][Commander] cleared factory guard for commander.idle.assist
  1.84  [AIR][Rule] commander.idle.assist builder=29509
  1.85  [AIR][Produce] opening.screen corveng plant=1971 projected=1/6
  1.85  [AIR][Rule] opening.support builder=20639
  1.87  [AIR][Rule] commander.factory.guard builder=29509
  1.93  [AIR][Capacity] own=6/5176 usage=28/605 gifts=19 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=0 ecoStatic=0 working=314 shortage=838 reason=funded workload
  1.93  [AIR][Economy] T2_TRANSITION M=26 bank=19008 E=5177 bank=52275 pull=605 plants=1/0 aircraftDemand=3/123
  1.93  [AIR][Projects] energyQueued=0 committed=3464/35930
  1.93  [AIR][Workforce] t1=3/4 t2=2/3 targetBP=1263 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  1.93  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+0/4 available=yes firstSlot=2
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
  1.97  [AIR][Commander] cleared factory guard for opening.support.assist
  1.97  [AIR][Rule] opening.support.assist builder=29509
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.6 bank 18976/19200, energy +5178.9 bank 52175/52275, units 34
  2.00  [Playtest] finished coraap team 0 at 2.01 min
  2.02  [AIR][Produce] constructor.expand coraca plant=8690 projected=3/3
  2.02  [AIR][State] T2_SUSTAIN
  2.02  [Playtest] finished coraap team 0 at 2.02 min
  2.03  [Playtest] finished coraap team 0 at 2.03 min
  2.03  [AIR][Produce] constructor.expand coraca plant=20311 projected=4/4
  2.03  [AIR][State] MULTIPLANT
  2.03  [AIR][Share] metal 19486 of 19800 (98%): sent 310 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.04  [Playtest] finished coraap team 0 at 2.04 min
  2.04  [AIR][Produce] constructor.expand coraca plant=21367 projected=5/5
  2.04  [Playtest] finished coraap team 0 at 2.05 min
  2.05  [AIR][Produce] constructor.expand coraca plant=5104 projected=6/6
  2.05  [Playtest] finished coraap team 0 at 2.05 min
  2.06  [AIR][Produce] constructor.expand coraca plant=5820 projected=7/7
  2.06  [AIR][Produce] intercept corvamp plant=8081 projected=1/6
  2.07  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30690) (D-106)
  2.10  [AIR][Capacity] own=6/5177 usage=21/329 gifts=2 sent=0 excess=0 pressure=true mobile=425 arriving=650 idle=0 ecoStatic=0 working=669 shortage=0 reason=available or arriving power
  2.10  [AIR][Economy] MULTIPLANT M=23 bank=19332 E=5178 bank=53475 pull=1743 plants=1/6 aircraftDemand=43/1540
  2.10  [AIR][Projects] energyQueued=0 committed=3154/32011
  2.10  [AIR][Workforce] t1=3/3 t2=6/7 targetBP=1075 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.10  [AIR][Bay] 0 plant=1971 BP=150 nanos=0+1/2 available=yes firstSlot=2
  2.10  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=20311 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=21367 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=5104 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=5820 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=8081 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.12  [AIR][Share] metal 20196 of 20400 (99%): sent 77 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.15  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30768) (D-106)
  2.17  [AIR][Produce] opening.screen corveng plant=1971 projected=2/6
  2.17  [AIR][Screen] fighters=1 cells=8 centre=2450,11497 width=600 advance=400 responding=false
  2.20  [AIR][Share] metal 20196 of 20400 (99%): sent 77 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.22  [Playtest] finished cornanotc team 0 at 2.22 min
  2.23  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30779) (D-106)
  2.24  [AIR][NanoGate] corcom 29509 can=no busy=no count=1
  2.24  [AIR][Rule] commander.factory.guard builder=29509
  2.24  [AIR][Rule] mex.assist builder=20639
  2.27  [AIR][Capacity] own=6/5176 usage=32/705 gifts=68 sent=0 excess=0 pressure=true mobile=425 arriving=650 idle=0 ecoStatic=0 working=314 shortage=0 reason=available or arriving power
  2.27  [AIR][Economy] MULTIPLANT M=82 bank=20196 E=5176 bank=53475 pull=1905 plants=1/6 aircraftDemand=36/1825
  2.27  [AIR][Projects] energyQueued=0 committed=2848/28148
  2.27  [AIR][Workforce] t1=3/3 t2=6/7 targetBP=1075 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.27  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+0/2 available=yes firstSlot=3
  2.27  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=20311 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=21367 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=5104 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=5820 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=8081 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.28  [AIR][Share] metal 20196 of 20400 (99%): sent 72 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.32  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30776) (D-106)
  2.33  [AIR][Produce] opening.screen corveng plant=1971 projected=3/6
  2.33  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.33  [AIR][Rule] commander.idle.assist builder=29509
  2.35  [AIR][Support] return to production bay=0
  2.36  [AIR][Rule] commander.factory.guard builder=29509
  2.37  [AIR][Screen] fighters=2 cells=8 centre=2450,11497 width=600 advance=400 responding=false
  2.37  [AIR][Share] metal 20196 of 20400 (99%): sent 107 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.38  [AIR][Produce] intercept corvamp plant=8081 projected=2/6
  2.40  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30746) (D-106)
  2.42  [Playtest] finished cormoho team 0 at 2.42 min
  2.43  [AIR][Rule] mex.upgrade builder=29542
  2.43  [AIR][Capacity] own=6/5176 usage=44/1104 gifts=74 sent=0 excess=0 pressure=true mobile=425 arriving=650 idle=0 ecoStatic=0 working=239 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] MULTIPLANT M=78 bank=20176 E=5176 bank=53322 pull=2304 plants=1/6 aircraftDemand=36/1825
  2.43  [AIR][Projects] energyQueued=0 committed=3201/32993
  2.43  [AIR][Workforce] t1=3/3 t2=6/7 targetBP=1075 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.43  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+0/2 available=yes firstSlot=3
  2.43  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=20311 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=21367 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=5104 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=5820 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=8081 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.45  [AIR][Share] metal 20790 of 21000 (99%): sent 57 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.45  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.45  [AIR][Rule] commander.idle.assist builder=29509
  2.46  [AIR][Produce] opening.screen corveng plant=1971 projected=4/5
  2.48  [AIR][Rule] commander.factory.guard builder=29509
  2.48  [AIR][Support] return to production bay=0
  2.48  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30806) (D-106)
  2.52  [Playtest] finished cormoho team 0 at 2.52 min
  2.53  [AIR][Screen] fighters=4 cells=8 centre=2450,11497 width=600 advance=400 responding=false
  2.54  [AIR][Rule] mex.assist builder=5224
  2.60  [AIR][Produce] opening.screen corveng plant=1971 projected=5/5
  2.60  [AIR][Capacity] own=15/5176 usage=33/993 gifts=50 sent=0 excess=0 pressure=true mobile=425 arriving=650 idle=0 ecoStatic=0 working=166 shortage=1020 reason=funded workload
  2.60  [AIR][Economy] MULTIPLANT M=97 bank=21334 E=5176 bank=53475 pull=2193 plants=1/6 aircraftDemand=36/1825
  2.60  [AIR][Projects] energyQueued=0 committed=2960/30387
  2.60  [AIR][Workforce] t1=3/4 t2=6/8 targetBP=2095 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=online
  2.60  [AIR][Bay] 0 plant=1971 BP=350 nanos=1+0/2 available=yes firstSlot=3
  2.60  [AIR][Bay] 1 plant=23975 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=20311 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=21367 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=5104 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=5820 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=8081 BP=600 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.62  [AIR][Support] return to production bay=0
  2.62  [AIR][Share] metal 21334 of 21550 (99%): sent 55 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.65  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30814) (D-106)
  2.67  [AIR][Produce] constructor.expand coraca plant=20311 projected=8/8
  2.67  [AIR][Rule] mex.assist builder=11162
  2.67  [AIR][Produce] constructor.expand coraca plant=21367 projected=9/9
  2.68  [AIR][Rule] mex.assist builder=110
  2.69  [AIR][Produce] constructor.expand coraca plant=5104 projected=10/10
  2.69  [AIR][Reclaim] corwin id=6397 worker=1661
  2.69  [AIR][Rule] energy.reclaim builder=1661
  2.69  [AIR][Produce] constructor.expand coraca plant=8081 projected=11/11
  2.70  [AIR][Produce] intercept corvamp plant=5820 projected=3/4
  2.70  [AIR][NanoGate] coraca 28172 can=no busy=no count=1
  2.70  [AIR][Growth] deferred=fusion by=coraca reason=metal floating at 21334; best payback energy energyBuilding=false reactor=false can=true busy=false mexReady=false M=61 bank=21334
  2.70  [AIR][Rule] mex.expand builder=28172
  2.70  [AIR][Share] metal 21334 of 21550 (99%): sent 28 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  2.73  [AIR][Screen] fighters=7 cells=8 centre=2450,11497 width=600 advance=400 responding=false
  2.73  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 30875) (D-106)
  2.76  [AIR][Produce] constructor.expand corca plant=1971 projected=4/4
  2.77  [AIR][Capacity] own=22/5178 usage=48/770 gifts=50 sent=0 excess=0 pressure=true mobile=945 arriving=705 idle=0 ecoStatic=0 working=369 shortage=0 reason=available or arriving power
  2.77  [AIR][Economy] MULTIPLANT M=61 bank=21334 E=5177 bank=53675 pull=1970 plants=1/6 aircraftDemand=36/1825
  2.77  [AIR][Projects] energyQueued=0 committed=3312/35237
  2.77  [AIR][Workforce] t1=4/4 t2=10/11 targetBP=1650 floating=true savingLab=false
... 4809 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: corcom(29509) at (2176, 11789) walks to (2215, 11850), 139 from the cormex site (2288, 11968)
  0.29  EXP: approach: corcom(29509) at (2253, 11914) walks to (2296, 11673), 139 from the cormex site (2320, 11536)
  0.52  RESERVE: zone 1 at (1976, 11232) facing 2, 9x6 cells: 54 of 54 held
  0.52  RESERVE: corap at (1976, 11232) facing 2 (id 1)
  0.52  RESERVE: zone 2 at (2024, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (2024, 11304) facing 2 (id 2)
  0.52  RESERVE: zone 3 at (1976, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1976, 11304) facing 2 (id 3)
  0.52  RESERVE: zone 4 at (1928, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1928, 11304) facing 2 (id 4)
  0.52  RESERVE: zone 5 at (2024, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (2024, 11352) facing 2 (id 5)
  0.52  RESERVE: zone 6 at (1976, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1976, 11352) facing 2 (id 6)
  0.52  RESERVE: zone 7 at (1832, 11208) facing 2, 9x9 cells: 81 of 81 held
  0.52  RESERVE: coraap at (1832, 11208) facing 2 (id 7)
  0.52  RESERVE: zone 8 at (1880, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1880, 11304) facing 2 (id 8)
  0.52  RESERVE: zone 9 at (1832, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1832, 11304) facing 2 (id 9)
  0.52  RESERVE: zone 10 at (1784, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1784, 11304) facing 2 (id 10)
  0.52  RESERVE: zone 11 at (1880, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1880, 11352) facing 2 (id 11)
  0.52  RESERVE: zone 12 at (1832, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1832, 11352) facing 2 (id 12)
  0.52  RESERVE: zone 13 at (1784, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1784, 11352) facing 2 (id 13)
  0.52  RESERVE: zone 14 at (1880, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1880, 11400) facing 2 (id 14)
  0.52  RESERVE: zone 15 at (1832, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1832, 11400) facing 2 (id 15)
  0.52  RESERVE: zone 16 at (1784, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1784, 11400) facing 2 (id 16)
  0.52  RESERVE: zone 17 at (1880, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1880, 11448) facing 2 (id 17)
  0.52  RESERVE: zone 18 at (1832, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1832, 11448) facing 2 (id 18)
  0.52  RESERVE: zone 19 at (1784, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1784, 11448) facing 2 (id 19)
  0.52  RESERVE: zone 20 at (1880, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1880, 11496) facing 2 (id 20)
  0.52  RESERVE: zone 21 at (1832, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1832, 11496) facing 2 (id 21)
  0.52  RESERVE: zone 22 at (1784, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1784, 11496) facing 2 (id 22)
  0.52  RESERVE: zone 23 at (1880, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1880, 11544) facing 2 (id 23)
  0.52  RESERVE: zone 24 at (1832, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1832, 11544) facing 2 (id 24)
  0.52  RESERVE: zone 25 at (1784, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1784, 11544) facing 2 (id 25)
  0.52  RESERVE: zone 26 at (1880, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1880, 11592) facing 2 (id 26)
  0.52  RESERVE: zone 27 at (1832, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1832, 11592) facing 2 (id 27)
  0.52  RESERVE: zone 28 at (1688, 11208) facing 2, 9x9 cells: 81 of 81 held
  0.52  RESERVE: coraap at (1688, 11208) facing 2 (id 28)
  0.52  RESERVE: zone 29 at (1736, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1736, 11304) facing 2 (id 29)
  0.52  RESERVE: zone 30 at (1688, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1688, 11304) facing 2 (id 30)
  0.52  RESERVE: zone 31 at (1640, 11304) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1640, 11304) facing 2 (id 31)
  0.52  RESERVE: zone 32 at (1736, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1736, 11352) facing 2 (id 32)
  0.52  RESERVE: zone 33 at (1688, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1688, 11352) facing 2 (id 33)
  0.52  RESERVE: zone 34 at (1640, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1640, 11352) facing 2 (id 34)
  0.52  RESERVE: zone 35 at (1736, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1736, 11400) facing 2 (id 35)
  0.52  RESERVE: zone 36 at (1688, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1688, 11400) facing 2 (id 36)
  0.52  RESERVE: zone 37 at (1640, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1640, 11400) facing 2 (id 37)
  0.52  RESERVE: zone 38 at (1736, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1736, 11448) facing 2 (id 38)
  0.52  RESERVE: zone 39 at (1688, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1688, 11448) facing 2 (id 39)
  0.52  RESERVE: zone 40 at (1640, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1640, 11448) facing 2 (id 40)
  0.52  RESERVE: zone 41 at (1736, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1736, 11496) facing 2 (id 41)
  0.52  RESERVE: zone 42 at (1688, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1688, 11496) facing 2 (id 42)
  0.52  RESERVE: zone 43 at (1640, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1640, 11496) facing 2 (id 43)
  0.52  RESERVE: zone 44 at (1736, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1736, 11544) facing 2 (id 44)
  0.52  RESERVE: zone 45 at (1688, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1688, 11544) facing 2 (id 45)
  0.52  RESERVE: zone 46 at (1640, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1640, 11544) facing 2 (id 46)
  0.52  RESERVE: zone 47 at (1736, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1736, 11592) facing 2 (id 47)
  0.52  RESERVE: zone 48 at (1688, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1688, 11592) facing 2 (id 48)
  0.52  RESERVE: zone 49 at (1976, 10728) facing 2, 9x9 cells: 81 of 81 held
  0.52  RESERVE: coraap at (1976, 10728) facing 2 (id 49)
  0.52  RESERVE: zone 50 at (2024, 10824) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (2024, 10824) facing 2 (id 50)
  0.52  RESERVE: zone 51 at (1976, 10824) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1976, 10824) facing 2 (id 51)
  0.52  RESERVE: zone 52 at (1928, 10824) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1928, 10824) facing 2 (id 52)
  0.52  RESERVE: zone 53 at (2024, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (2024, 10872) facing 2 (id 53)
  0.52  RESERVE: zone 54 at (1976, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1976, 10872) facing 2 (id 54)
  0.52  RESERVE: zone 55 at (1928, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1928, 10872) facing 2 (id 55)
  0.52  RESERVE: zone 56 at (2024, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (2024, 10920) facing 2 (id 56)
  0.52  RESERVE: zone 57 at (1976, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1976, 10920) facing 2 (id 57)
  0.52  RESERVE: zone 58 at (1928, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (1928, 10920) facing 2 (id 58)
  0.52  RESERVE: zone 59 at (2024, 10968) facing 2, 3x3 cells: 9 of 9 held
  0.52  RESERVE: cornanotc at (2024, 10968) facing 2 (id 59)
```
