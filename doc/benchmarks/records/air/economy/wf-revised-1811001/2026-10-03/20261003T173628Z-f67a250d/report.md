# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54020); wall 228 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:32:37
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\glacial\runs\20261003T173628Z-f67a250d\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=992 E=0 bank=975 pull=83 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-008 2 turret(s) in range of the reclaim of armlab 24874 are not on it` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 4.6 min: [INVARIANT] INV-008 2 turret(s) in range of the reclaim of armlab 24874 are not on it
- forbid 'invariant' hit at 5.2 min: [INVARIANT] INV-008 3 turret(s) in range of the reclaim of leglab 16094 are not on it
- forbid 'invariant' hit at 5.8 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1860 (7 by power), bank 0 + 15/s (0 by metal))
- forbid 'invariant' hit at 6.7 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1335 (5 by power), bank 8 + 15/s (0 by metal))
- forbid 'invariant' hit at 6.8 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 2160 (8 by power), bank 2 + 18/s (0 by metal))
- forbid 'invariant' hit at 13.8 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (1776, 2720) not upgraded
- forbid 'invariant' hit at 14.2 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (12720, 1408) not upgraded
- forbid 'invariant' hit at 19.5 min: [INVARIANT] INV-010 combat unit legstr 11512 produced at +87 metal under the gate 200
- forbid 'invariant' hit at 20.2 min: [INVARIANT] INV-022 a new set of armafus starts 4 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 20.5 min: [INVARIANT] INV-010 combat unit legsrail 11789 produced at +95 metal under the gate 200
- forbid 'invariant' hit at 21.7 min: [INVARIANT] INV-035 dedicated 22022 (armmmkr) holds armfort
- forbid 'invariant' hit at 21.9 min: [INVARIANT] INV-010 combat unit legsrail 4828 produced at +122 metal under the gate 200
- forbid 'invariant' hit at 23.1 min: [INVARIANT] INV-010 combat unit legsrail 31890 produced at +99 metal under the gate 200
- forbid 'invariant' hit at 23.3 min: [INVARIANT] INV-022 a new set of armmmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.6 min: [INVARIANT] INV-022 a new set of legadveconv starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 24.2 min: [INVARIANT] INV-010 combat unit legsrail 13188 produced at +95 metal under the gate 200
- forbid 'invariant' hit at 24.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.0 min: [INVARIANT] INV-010 combat unit leggob 20899 produced at +95 metal under the gate 200
- forbid 'invariant' hit at 25.1 min: [INVARIANT] INV-035 dedicated 14266 (legadveconv) holds legforti
- forbid 'invariant' hit at 25.6 min: [INVARIANT] INV-010 combat unit legsrail 31919 produced at +131 metal under the gate 200
- forbid 'invariant' hit at 26.0 min: [INVARIANT] INV-010 combat unit leggob 26053 produced at +136 metal under the gate 200
- forbid 'invariant' hit at 26.7 min: [INVARIANT] INV-010 combat unit legsrail 31472 produced at +184 metal under the gate 200
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-010 combat unit leggob 730 produced at +185 metal under the gate 200
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-039 T1 land constructors released 418 s, 0 spam labs of 1 wanted, no forward order for 180 s
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-010 combat unit legsrail 2625 produced at +178 metal under the gate 200
- forbid 'invariant' hit at 27.9 min: [INVARIANT] INV-010 combat unit armsptk 19582 produced at +17 metal under the gate 200
- forbid 'invariant' hit at 27.9 min: [t=00:03:16.337129][f=0050278] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 28.0 min: [INVARIANT] INV-039 T1 land constructors released 353 s, 1 spam labs of 2 wanted, no forward order for 180 s
- forbid 'invariant' hit at 28.2 min: [INVARIANT] INV-022 a new set of legadveconv starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.4 min: [INVARIANT] INV-010 combat unit leggob 8278 produced at +184 metal under the gate 200
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 3 T2 constructors, none added
- forbid 'invariant' hit at 29.7 min: [INVARIANT] INV-022 a new set of legadveconv starts 7 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 3 T2 constructors, none added

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\glacial\runs\20261003T173628Z-f67a250d\screen_2026-10-03_17-33-36-783.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\glacial\runs\20261003T173628Z-f67a250d\screen_2026-10-03_17-34-18-342.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\glacial\runs\20261003T173628Z-f67a250d\screen_2026-10-03_17-34-43-988.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-revised-1811001\cohort\20261003T172752Z-f3ec5e2c\glacial\runs\20261003T173628Z-f67a250d\screen_2026-10-03_17-36-27-881.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12572, 1400) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12572, 1400) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=992 E=0 bank=975 pull=83 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (442, 1128), 48 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|490|1137|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(1847,1405) factory=armlab landLocked=no spot=1 known=1/1
  0.18  [Playtest] finished armmex team 0 at 0.18 min
  0.18  [Team][Roster] first mex 12607 at 496,1296
  0.18  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|490|1137|0|0|1|496|1296
  0.19  [AIR][Rule] opening.mex builder=2274
  0.22  [Team][Roster] team 1 first mex at 1952,1408
  0.27  [AIR][Capacity] own=2/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=962 E=18 bank=637 pull=86 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=18/180
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.30  [Playtest] finished armmex team 0 at 0.30 min
  0.43  [AIR][Capacity] own=3/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=950 E=30 bank=220 pull=89 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=1/13
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.44  [Playtest] finished armmex team 0 at 0.44 min
  0.45  [AIR][Wind] cluster=0 slots=6 at=544,1160 local=true builder=2274
  0.45  [AIR][Rule] opening.energy builder=2274
  0.55  [Playtest] finished armwin team 0 at 0.55 min
  0.56  [AIR][Rule] recovery.energy builder=2274
  0.60  [AIR][Capacity] own=5/30 usage=16/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=38 reason=funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=962 E=30 bank=225 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=121/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=38 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.71  [Playtest] finished armsolar team 0 at 0.71 min
  0.77  [AIR][Capacity] own=7/40 usage=16/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=38 reason=funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=886 E=37 bank=639 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=121/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=38 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.88  [Playtest] finished armsolar team 0 at 0.88 min
  0.89  [AIR][Rule] opening.energy builder=2274
  0.93  [AIR][Capacity] own=7/63 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=828 E=63 bank=1081 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 850/1150, energy +78.6 bank 1083/1100, units 8
  1.05  [Playtest] finished armwin team 0 at 1.05 min
  1.10  [AIR][Capacity] own=7/78 usage=7/39 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=861 E=78 bank=1045 pull=39 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=25/112
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.16  [Playtest] finished armwin team 0 at 1.16 min
  1.27  [AIR][Capacity] own=7/86 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=878 E=84 bank=1088 pull=41 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=2/13
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.27  [Playtest] finished armwin team 0 at 1.27 min
  1.28  [AIR][Starter] nearby distance=127
  1.28  [AIR][Rule] opening.plant builder=2274
  1.30  [AIR][Layout] cluster=0 labs=6 at=562,1017
  1.30  [AIR][EcoLayout] reserved air.eco.0 reactor=352,1776 converters=8 support=12 zone=140
  1.32  [AIR][EcoLayout] reserved air.eco.1 reactor=736,2288 converters=8 support=12 zone=165
  1.33  [AIR][EcoLayout] reserved air.eco.2 reactor=736,1392 converters=8 support=12 zone=187
  1.35  [AIR][EcoLayout] reserved air.eco.3 reactor=352,2672 converters=8 support=12 zone=209
  1.43  [AIR][Capacity] own=7/82 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=683 E=91 bank=1046 pull=69 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=350/593
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=17770 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [Playtest] finished armap team 0 at 1.60 min
  1.60  [AIR][Claim] cancel unowned native order armnanotc
  1.60  [AIR][Claim] cancel unowned native order armnanotc
  1.60  [AIR][Capacity] own=7/73 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][State] T1_CONTEST
  1.60  [AIR][Economy] T1_CONTEST M=7 bank=405 E=74 bank=1046 pull=69 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.61  [AIR][Produce] opening.scout armpeep plant=17770 projected=1/1
  1.61  [AIR][Rule] opening.commander.guard builder=2274
  1.74  [AIR][Produce] constructor.recovery armca plant=17770 projected=1/3
  1.77  [AIR][Capacity] own=7/82 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=404 E=78 bank=280 pull=36 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Capacity] own=6/104 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=417 E=103 bank=11 pull=105 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 428/1250, energy +119.7 bank 1/1202, units 13
  2.05  [AIR][Produce] constructor.recovery armca plant=17770 projected=2/3
  2.05  [AIR][Rule] recovery.energy builder=14452
  2.10  [AIR][Capacity] own=7/114 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=450 E=110 bank=235 pull=69 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=1 committed=155/0
  2.10  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=5/117 usage=3/8 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=82 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=433 E=117 bank=9 pull=170 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=127/0
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=182 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.37  [AIR][Produce] constructor.recovery armca plant=17770 projected=3/3
  2.37  [AIR][Rule] recovery.energy builder=15154
  2.43  [AIR][Capacity] own=6/117 usage=1/0 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=99 shortage=99 reason=funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=429 E=118 bank=172 pull=124 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=248/0
  2.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=249 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.49  [AIR][Commander] cleared factory guard for commander.energy.assist
  2.49  [AIR][Rule] commander.energy.assist builder=2274
  2.60  [AIR][Capacity] own=5/116 usage=21/0 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=400 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=316 E=117 bank=500 pull=23 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=84/0
  2.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.61  [Playtest] finished armsolar team 0 at 2.61 min
  2.63  [AIR][Rule] opening.commander.guard builder=2274
  2.63  [AIR][Rule] recovery.assist builder=15154
  2.72  [AIR][Produce] opening.screen armfig plant=17770 projected=1/6
  2.72  [AIR][Rule] mex.expand builder=19803
  2.73  [AIR][Commander] cleared factory guard for commander.local.assist
  2.73  [AIR][Rule] commander.local.assist builder=2274
  2.77  [AIR][Capacity] own=7/125 usage=18/230 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=450 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=237 E=120 bank=1293 pull=230 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=42/283
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.81  [Playtest] finished armsolar team 0 at 2.81 min
  2.81  [Playtest] finished armmex team 0 at 2.82 min
  2.82  [AIR][Claim] cancel unowned native order armmakr
  2.82  [AIR][Rule] mex.expand builder=15154
  2.82  [AIR][Rule] energy.grow builder=14452
  2.83  [AIR][Rule] commander.energy.local builder=2274
  2.83  [AIR][Wind] cluster=1 slots=6 at=208,1208 local=false builder=19803
  2.83  [AIR][Rule] energy.grow builder=19803
  2.93  [AIR][Capacity] own=7/173 usage=13/180 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=400 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST M=7 bank=204 E=169 bank=1346 pull=180 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=123/822
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/2 available=yes firstSlot=0
  2.94  [Playtest] finished armwin team 0 at 2.94 min
  2.95  [AIR][Rule] commander.factory.guard builder=2274
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 198/1300, energy +196.6 bank 1060/1377, units 23
  3.03  [AIR][Produce] opening.screen armfig plant=17770 projected=2/6
  3.03  [AIR][Screen] fighters=1 cells=8 centre=2247,1404 width=600 advance=400 responding=false
  3.10  [AIR][Capacity] own=9/184 usage=13/409 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST M=9 bank=202 E=187 bank=1203 pull=409 plants=1/0 aircraftDemand=3/127
  3.10  [AIR][Projects] energyQueued=0 committed=83/573
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.19  [AIR][Produce] opening.screen armfig plant=17770 projected=3/6
  3.19  [AIR][Screen] fighters=2 cells=8 centre=2247,1404 width=600 advance=400 responding=false
  3.27  [AIR][Capacity] own=9/191 usage=13/409 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST M=9 bank=192 E=192 bank=598 pull=409 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=44/325
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.37  [AIR][Screen] fighters=2 cells=8 centre=2247,1404 width=600 advance=400 responding=false
  3.38  [AIR][Produce] opening.screen armfig plant=17770 projected=4/6
  3.39  [Playtest] finished armwin team 0 at 3.39 min
  3.40  [AIR][Rule] intel.radar builder=14452
  3.43  [AIR][Capacity] own=6/194 usage=9/288 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=191 E=193 bank=342 pull=288 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=68/712
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.45  [Playtest] finished armwin team 0 at 3.45 min
  3.47  [AIR][Layout] cluster=1 labs=1 at=1522,2553
  3.47  [AIR][Rule] project.assist builder=19803
  3.55  [AIR][Screen] fighters=3 cells=8 centre=2247,1404 width=600 advance=400 responding=false
  3.59  [Playtest] finished armmex team 0 at 3.59 min
  3.60  [AIR][Capacity] own=4/209 usage=8/224 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=68 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=177 E=205 bank=3 pull=387 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=32/338
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.64  [AIR][Commander] cleared factory guard for commander.idle.wait
  3.64  [AIR][Rule] commander.idle.wait builder=2274
  3.64  [AIR][Produce] opening.screen armfig plant=17770 projected=5/6
  3.67  [AIR][Rule] commander.factory.guard builder=2274
  3.71  [Playtest] finished armrad team 0 at 3.71 min
  3.72  [AIR][Screen] fighters=4 cells=8 centre=2247,1404 width=600 advance=400 responding=false
  3.73  [AIR][Rule] project.assist builder=14452
  3.77  [AIR][Capacity] own=8/230 usage=7/254 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=194 E=226 bank=4 pull=352 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=37/378
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.88  [AIR][Produce] opening.screen armfig plant=17770 projected=6/6
  3.92  [AIR][Screen] fighters=5 cells=8 centre=2247,1404 width=600 advance=400 responding=false
  3.93  [AIR][Capacity] own=9/247 usage=11/346 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=232 E=249 bank=212 pull=346 plants=1/0 aircraftDemand=3/125
  3.93  [AIR][Projects] energyQueued=0 committed=13/139
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.99  [Playtest] finished armmex team 0 at 3.99 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.0 bank 245/1400, energy +245.5 bank 2/1378, units 30
  4.00  [AIR][Rule] wait builder=15154
  4.01  [AIR][Rule] wait builder=19803
  4.01  [AIR][Rule] wait builder=14452
  4.10  [AIR][Capacity] own=12/239 usage=5/233 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=288 E=242 bank=13 pull=250 plants=1/0 aircraftDemand=3/125
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Screen] fighters=5 cells=8 centre=2247,1404 width=600 advance=400 responding=false
  4.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=140
  4.16  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.16  [AIR][Rule] commander.idle.wait builder=2274
  4.27  [AIR][Capacity] own=14/209 usage=0/18 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=14 bank=422 E=213 bank=1309 pull=18 plants=1/0 aircraftDemand=3/126
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.28  [AIR][Screen] fighters=6 cells=8 centre=2247,1404 width=600 advance=400 responding=false
  4.34  [AIR][Rule] commander.idle.energy builder=2274
  4.36  [AIR][Produce] recon.replace armpeep plant=17770 projected=1/1
  4.38  [AIR][Layout] repaired support air.bay.6 viable=4/5 slot=322 at=472,920
  4.38  [AIR][Rule] opening.support builder=15154
  4.38  [AIR][Rule] energy.grow builder=19803
  4.39  [AIR][Rule] energy.grow builder=14452
  4.43  [AIR][Capacity] own=14/199 usage=2/101 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST M=14 bank=554 E=201 bank=1309 pull=101 plants=1/0 aircraftDemand=3/126
  4.43  [AIR][Projects] energyQueued=3 committed=350/3725
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=17770 BP=150 nanos=0+0/2 available=yes firstSlot=2
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.45  [AIR][Screen] fighters=6 cells=8 centre=2247,1404 width=600 advance=400 responding=false
... 3601 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(2274) at (490, 1137) walks to (491, 1160), 136 from the armmex site (496, 1296)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (1688, 1784) facing 1, 63x77 cells: 4530 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2184, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2136, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2088, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2040, 1784) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (2264, 1544) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (2536, 1464) facing 1, 29x41 cells: 1116 of 1189 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2760, 1464) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2712, 1464) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2664, 1464) facing 1: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2616, 1464) facing 1: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (4080, 1264) facing 1 (id 106)
  0.08  RESERVE: zone 9 at (4008, 1264) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (4032, 1264) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (4368, 1440) facing 1 (id 109)
  0.08  RESERVE: zone 10 at (4296, 1440) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (4320, 1440) facing 1: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: corridor 11 at (4344, 1536) facing 1, 21x6 cells: 126 of 126 held
  0.08  RESERVE: zone 12 at (4344, 1440) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 12 at (4592, 1440) facing 1, 20x10 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 3
  0.09  RESERVE: zone 7 at (12757, 1112) facing 3, 63x77 cells: 4568 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12261, 1112) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12309, 1112) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12357, 1112) facing 3: 12 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12405, 1112) facing 3: 12 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (12184, 1352) facing 3 (id 61)
  0.09  RESERVE: zone 8 at (11845, 1432) facing 3, 37x41 cells: 1410 of 1517 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11557, 1432) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11605, 1432) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11653, 1432) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11701, 1432) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (10320, 1136) facing 3 (id 114)
  0.09  RESERVE: zone 9 at (10392, 1136) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (10368, 1136) facing 3: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (10344, 1040) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 11 at (10344, 1232) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: zone 12 at (10344, 1136) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 12 at (10096, 1136) facing 3, 20x10 cells: 180 of 200 held
  0.10  EXP: idle: armcom(2274) on armmex at (490, 1150), site (496, 1296), target yes, fails 2 (arrived at the approach point)
  0.17  RESERVE: armlab at (4416, 1200) facing 1 (id 112)
  0.17  RESERVE: zone 13 at (4344, 1200) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (4368, 1200) facing 1: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 14 at (4392, 1296) facing 1, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (4392, 1200) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (4640, 1200) facing 1, 20x10 cells: 190 of 200 held
  0.17  RESERVE: leglab at (10048, 1440) facing 3 (id 117)
  0.17  RESERVE: zone 13 at (10120, 1440) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (10096, 1440) facing 3: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 14 at (10072, 1344) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (10072, 1440) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (9824, 1440) facing 3, 20x10 cells: 190 of 200 held
  0.19  EXP: approach: armcom(2274) at (490, 1150) walks to (472, 1148), 136 from the armmex site (336, 1136)
  0.22  EXP: approach: corcom(24492) at (13994, 1034) walks to (13970, 1025), 139 from the cormex site (13840, 976)
  0.23  EXP: approach: armcom(1901) at (1884, 1405) walks to (1773, 1113), 136 from the armmex site (1792, 1248)
  0.25  RESERVE: armalab at (3512, 2760) facing 1 (id 115)
  0.25  RESERVE: zone 16 at (3392, 2760) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3440, 2760) facing 1: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 17 at (3464, 2760) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (3760, 2760) facing 1, 20x13 cells: 260 of 260 held
  0.25  RESERVE: zone 19 at (3136, 928) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 928) facing 0 (id 120)
  0.25  RESERVE: zone 20 at (3136, 960) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 960) facing 0 (id 121)
  0.25  RESERVE: zone 21 at (3136, 992) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 992) facing 0 (id 122)
  0.25  RESERVE: zone 22 at (3136, 1024) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1024) facing 0 (id 123)
  0.25  RESERVE: zone 23 at (3136, 1056) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1056) facing 0 (id 124)
  0.25  RESERVE: zone 24 at (3136, 1088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1088) facing 0 (id 125)
  0.25  RESERVE: zone 25 at (3136, 1120) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1120) facing 0 (id 126)
  0.25  RESERVE: zone 26 at (3136, 1152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1152) facing 0 (id 127)
  0.25  RESERVE: zone 27 at (3136, 1184) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1184) facing 0 (id 128)
  0.25  RESERVE: zone 28 at (3136, 1216) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1216) facing 0 (id 129)
  0.25  RESERVE: zone 29 at (3136, 1248) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1248) facing 0 (id 130)
  0.25  RESERVE: zone 30 at (3136, 1568) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1568) facing 0 (id 131)
  0.25  RESERVE: zone 31 at (3136, 1600) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1600) facing 0 (id 132)
  0.25  RESERVE: zone 32 at (3136, 1632) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1632) facing 0 (id 133)
  0.25  RESERVE: zone 33 at (3136, 1664) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1664) facing 0 (id 134)
  0.25  RESERVE: zone 34 at (3136, 1696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1696) facing 0 (id 135)
  0.25  RESERVE: zone 35 at (3136, 1728) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1728) facing 0 (id 136)
  0.25  RESERVE: zone 36 at (3136, 1760) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1760) facing 0 (id 137)
  0.25  RESERVE: zone 37 at (3136, 1792) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1792) facing 0 (id 138)
  0.25  RESERVE: zone 38 at (3136, 1824) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1824) facing 0 (id 139)
  0.25  RESERVE: zone 39 at (3136, 1856) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1856) facing 0 (id 140)
  0.25  RESERVE: zone 40 at (3136, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3136, 1888) facing 0 (id 141)
  0.25  RESERVE: zone 41 at (3024, 1152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (3024, 1152) facing 0 (id 142)
  0.25  RESERVE: legalab at (11224, 2712) facing 3 (id 120)
  0.25  RESERVE: zone 16 at (11344, 2712) facing 3, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of legnanotc 2x2 gap 0 behind (11296, 2712) facing 3: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 17 at (11272, 2712) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (10976, 2712) facing 3, 20x13 cells: 260 of 260 held
  0.25  RESERVE: zone 19 at (11328, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11328, 1888) facing 0 (id 125)
  0.25  RESERVE: zone 20 at (11328, 1856) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11328, 1856) facing 0 (id 126)
  0.25  RESERVE: zone 21 at (11328, 1824) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11328, 1824) facing 0 (id 127)
  0.25  RESERVE: zone 22 at (11328, 1792) facing 0, 2x2 cells: 4 of 4 held
```
