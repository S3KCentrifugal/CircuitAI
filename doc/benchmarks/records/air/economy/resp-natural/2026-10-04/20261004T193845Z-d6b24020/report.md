# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 20.0 min (frame 36002); wall 143 s
- DLL: build-theatres\d193-build\SkirmishAI.dll (df4b5dd21490b768); AI BARbTest/test; staged 2026-10-04T16:36:19
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\resp-natural\glacial\20261004T193619Z-90f97487\glacial\runs\20261004T193845Z-d6b24020\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=992 E=0 bank=915 pull=83 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 27702 are not on it` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 4.4 min: [INVARIANT] INV-008 1 turret(s) in range of the reclaim of leglab 27702 are not on it
- forbid 'invariant' hit at 13.7 min: [INVARIANT] INV-008 11 turret(s) in range of the reclaim of armalab 28602 are not on it
- forbid 'invariant' hit at 15.8 min: [INVARIANT] INV-010 combat unit legsrail 4604 produced at +151 metal under the gate 200
- forbid 'invariant' hit at 16.9 min: [INVARIANT] INV-010 combat unit legstr 25475 produced at +83 metal under the gate 200
- forbid 'invariant' hit at 17.0 min: [INVARIANT] INV-010 combat unit legsrail 14780 produced at +83 metal under the gate 200
- forbid 'invariant' hit at 18.1 min: [INVARIANT] INV-010 combat unit legsrail 27810 produced at +83 metal under the gate 200
- forbid 'invariant' hit at 19.5 min: [INVARIANT] INV-010 combat unit legsrail 22510 produced at +119 metal under the gate 200

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\resp-natural\glacial\20261004T193619Z-90f97487\glacial\runs\20261004T193845Z-d6b24020\screen_2026-10-04_19-37-29-658.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\resp-natural\glacial\20261004T193619Z-90f97487\glacial\runs\20261004T193845Z-d6b24020\screen_2026-10-04_19-38-19-056.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\resp-natural\glacial\20261004T193619Z-90f97487\glacial\runs\20261004T193845Z-d6b24020\screen_2026-10-04_19-38-45-164.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 20, 5 shots, end at 20.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12572, 1400) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1800, 1400) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12572, 1400) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=992 E=0 bank=915 pull=83 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=32/324
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (442, 1128), 48 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|490|1137|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(1802,1407) factory=armlab landLocked=no spot=1 known=1/1
  0.17  [Team][Roster] team 1 first mex at 1952,1408
  0.18  [Playtest] finished armmex team 0 at 0.18 min
  0.20  [AIR][Rule] opening.mex builder=14987
  0.20  [Team][Roster] first mex 5661 at 496,1296
  0.20  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|490|1137|0|0|1|496|1296
  0.27  [AIR][Capacity] own=2/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=961 E=18 bank=619 pull=86 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=22/222
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.31  [Playtest] finished armmex team 0 at 0.31 min
  0.43  [AIR][Capacity] own=3/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=952 E=30 bank=225 pull=89 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=9/97
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.45  [Playtest] finished armmex team 0 at 0.45 min
  0.47  [AIR][Rule] recovery.energy builder=14987
  0.60  [AIR][Capacity] own=5/30 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=895 E=30 bank=335 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=22/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.62  [Playtest] finished armsolar team 0 at 0.62 min
  0.63  [AIR][Wind] cluster=0 slots=6 at=352,1272 local=false builder=14987
  0.63  [AIR][Rule] opening.energy builder=14987
  0.77  [AIR][Capacity] own=7/30 usage=7/41 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=913 E=30 bank=598 pull=41 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=10/47
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.79  [Playtest] finished armwin team 0 at 0.79 min
  0.90  [Playtest] finished armwin team 0 at 0.90 min
  0.93  [AIR][Capacity] own=7/50 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=935 E=50 bank=826 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=33/145
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 938/1150, energy +57.3 bank 887/1051, units 8
  1.01  [Playtest] finished armwin team 0 at 1.01 min
  1.10  [AIR][Capacity] own=7/57 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=949 E=57 bank=998 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=6/30
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.11  [Playtest] finished armwin team 0 at 1.12 min
  1.22  [Playtest] finished armwin team 0 at 1.22 min
  1.27  [AIR][Capacity] own=7/58 usage=3/24 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=971 E=59 bank=1029 pull=24 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=29/127
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.33  [Playtest] finished armwin team 0 at 1.33 min
  1.34  [AIR][Wind] cluster=1 slots=6 at=288,936 local=false builder=14987
  1.43  [AIR][Capacity] own=7/66 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=1015 E=68 bank=1012 pull=9 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=36/160
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.51  [Playtest] finished armwin team 0 at 1.51 min
  1.60  [AIR][Capacity] own=7/69 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=7 bank=1044 E=68 bank=1024 pull=41 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=22/96
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.65  [Playtest] finished armwin team 0 at 1.65 min
  1.76  [Playtest] finished armwin team 0 at 1.76 min
  1.77  [AIR][Capacity] own=7/85 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=7 bank=1057 E=83 bank=1001 pull=41 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Starter] nearby distance=128
  1.77  [AIR][Rule] opening.plant builder=14987
  1.78  [AIR][Layout] cluster=0 labs=6 at=562,1017
  1.78  [AIR][EcoLayout] reserved air.eco.0 reactor=352,1776 converters=8 support=12 zone=146
  1.78  [AIR][Layout] cluster=1 labs=6 at=562,2841
  1.80  [AIR][EcoLayout] reserved air.eco.1 reactor=736,2160 converters=8 support=12 zone=296
  1.82  [AIR][EcoLayout] reserved air.eco.2 reactor=736,1392 converters=8 support=12 zone=318
  1.83  [AIR][EcoLayout] reserved air.eco.3 reactor=1888,752 converters=8 support=12 zone=340
  1.93  [AIR][Capacity] own=7/133 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=7 bank=833 E=130 bank=1054 pull=69 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=313/530
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 12 plant=11504 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 695/1150, energy +193.3 bank 1048/1054, units 15
  2.08  [Playtest] finished armap team 0 at 2.08 min
  2.08  [AIR][Claim] cancel unowned native order armnanotc
  2.08  [AIR][Claim] cancel unowned native order armnanotc
  2.08  [AIR][State] T1_CONTEST
  2.09  [AIR][Produce] opening.scout armpeep plant=11504 projected=1/1
  2.09  [AIR][Rule] opening.commander.guard builder=14987
  2.10  [AIR][Capacity] own=7/180 usage=26/53 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST M=7 bank=565 E=168 bank=1154 pull=53 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.23  [AIR][Produce] constructor.recovery armca plant=11504 projected=1/3
  2.23  [AIR][Scout] opening drone=20671 enemy starts=2
  2.27  [AIR][Capacity] own=7/199 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST M=7 bank=593 E=197 bank=1154 pull=19 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/1 available=yes firstSlot=0
  2.30  [AIR][BaseResponse] contact=true
  2.30  [AIR][BaseResponse] group=0 target=4281
  2.30  [AIR][BaseResponse] group=2 target=4281
  2.33  [AIR][BaseResponse] contact=false
  2.33  [AIR][BaseResponse] group=0 target=-1
  2.33  [AIR][BaseResponse] group=2 target=-1
  2.43  [AIR][Capacity] own=7/175 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=7 bank=581 E=188 bank=1120 pull=160 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/1 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/1 available=yes firstSlot=0
  2.46  [AIR][Produce] constructor.recovery armca plant=11504 projected=2/3
  2.46  [AIR][Rule] mex.expand builder=2931
  2.60  [AIR][Capacity] own=7/148 usage=4/77 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=88 reason=funded workload
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=573 E=153 bank=831 pull=211 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=39/397
  2.60  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=188 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.68  [AIR][Produce] constructor.recovery armca plant=11504 projected=3/3
  2.69  [AIR][Rule] mex.assist builder=19368
  2.77  [AIR][Capacity] own=7/138 usage=2/36 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST M=7 bank=553 E=140 bank=430 pull=225 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=19/197
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.91  [AIR][Produce] opening.screen armfig plant=11504 projected=1/6
  2.91  [AIR][Rule] recovery.energy builder=9712
  2.91  [Playtest] finished armmex team 0 at 2.91 min
  2.92  [AIR][Rule] recovery.energy builder=19368
  2.93  [AIR][Rule] recovery.energy builder=2931
  2.93  [AIR][Capacity] own=6/147 usage=1/29 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=533 E=145 bank=252 pull=29 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=3 committed=465/0
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.97  [AIR][Rule] commander.factory.guard builder=14987
  3.00  [Playtest] eco team 0 at 3.0 min: metal +11.0 bank 541/1300, energy +178.8 bank 1/1229, units 24
  3.10  [AIR][Capacity] own=6/163 usage=12/169 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=522 E=165 bank=6 pull=285 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=396/0
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.26  [AIR][Produce] opening.screen armfig plant=11504 projected=2/6
  3.26  [AIR][Screen] fighters=1 cells=8 centre=2202,1406 width=600 advance=400 responding=false
  3.27  [AIR][Capacity] own=8/91 usage=10/86 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=31 reason=funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=502 E=100 bank=9 pull=310 plants=1/0 aircraftDemand=3/124
  3.27  [AIR][Projects] energyQueued=0 committed=307/0
  3.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=181 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Commander] cleared factory guard for commander.idle.assist
  3.27  [AIR][Rule] commander.idle.assist builder=14987
  3.29  [AIR][Rule] commander.factory.guard builder=14987
  3.43  [AIR][Capacity] own=7/81 usage=11/107 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=471 E=84 bank=5 pull=206 plants=1/0 aircraftDemand=3/124
  3.43  [AIR][Projects] energyQueued=0 committed=202/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Screen] fighters=1 cells=8 centre=2202,1406 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=8/110 usage=12/136 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=451 E=96 bank=11 pull=260 plants=1/0 aircraftDemand=3/124
  3.60  [AIR][Projects] energyQueued=0 committed=112/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Screen] fighters=1 cells=8 centre=2202,1406 width=600 advance=400 responding=false
  3.60  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=71
  3.71  [AIR][Produce] opening.screen armfig plant=11504 projected=3/6
  3.76  [Playtest] finished armsolar team 0 at 3.76 min
  3.77  [AIR][Capacity] own=7/141 usage=15/289 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=426 E=136 bank=142 pull=289 plants=1/0 aircraftDemand=3/125
  3.77  [AIR][Projects] energyQueued=0 committed=25/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Rule] mex.expand builder=2931
  3.78  [AIR][Screen] fighters=2 cells=8 centre=2202,1406 width=600 advance=400 responding=false
  3.83  [Playtest] finished armsolar team 0 at 3.83 min
  3.84  [AIR][Rule] intel.radar builder=9712
  3.85  [Playtest] finished armsolar team 0 at 3.85 min
  3.86  [AIR][Rule] wait builder=19368
  3.92  [AIR][Rule] project.assist builder=19368
  3.93  [AIR][Capacity] own=5/180 usage=8/265 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=45 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=426 E=185 bank=0 pull=337 plants=1/0 aircraftDemand=3/125
  3.93  [AIR][Projects] energyQueued=0 committed=100/1028
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 12 plant=11504 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.95  [AIR][Screen] fighters=2 cells=8 centre=2202,1406 width=600 advance=400 responding=false
  3.97  [AIR][Produce] opening.screen armfig plant=11504 projected=4/6
  3.97  [AIR][Commander] cleared factory guard for commander.idle.wait
  3.97  [AIR][Rule] commander.idle.wait builder=14987
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 432/1300, energy +228.5 bank 281/1379, units 28
  4.00  [AIR][Rule] commander.factory.guard builder=14987
  4.10  [AIR][Capacity] own=5/225 usage=8/246 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=71 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=427 E=224 bank=0 pull=419 plants=1/0 aircraftDemand=3/126
  4.10  [AIR][Projects] energyQueued=0 committed=50/505
... 2557 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(14987) at (490, 1137) walks to (491, 1160), 136 from the armmex site (496, 1296)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (1688, 1688) facing 1, 63x77 cells: 4441 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2184, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2136, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2088, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2040, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (2264, 1448) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (2536, 1368) facing 1, 29x41 cells: 1153 of 1189 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2760, 1368) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2712, 1368) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2664, 1368) facing 1: 8 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2616, 1368) facing 1: 8 of 13 slots (group 6, held, zone)
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
  0.10  EXP: idle: armcom(14987) on armmex at (490, 1150), site (496, 1296), target yes, fails 2 (arrived at the approach point)
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
  0.20  EXP: approach: armcom(14987) at (490, 1150) walks to (472, 1148), 136 from the armmex site (336, 1136)
  0.22  EXP: approach: corcom(14767) at (13991, 1051) walks to (13964, 1038), 139 from the cormex site (13840, 976)
  0.25  RESERVE: armalab at (3512, 2760) facing 1 (id 115)
  0.25  RESERVE: zone 16 at (3392, 2760) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3440, 2760) facing 1: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 17 at (3464, 2760) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (3760, 2760) facing 1, 20x13 cells: 260 of 260 held
  0.25  RESERVE: zone 19 at (3104, 928) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 928) facing 0 (id 120)
  0.25  RESERVE: zone 20 at (3104, 960) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 960) facing 0 (id 121)
  0.25  RESERVE: zone 21 at (3104, 992) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 992) facing 0 (id 122)
  0.25  RESERVE: zone 22 at (3104, 1024) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1024) facing 0 (id 123)
  0.25  RESERVE: zone 23 at (3104, 1056) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1056) facing 0 (id 124)
  0.25  RESERVE: zone 24 at (3104, 1088) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1088) facing 0 (id 125)
  0.25  RESERVE: zone 25 at (3104, 1120) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1120) facing 0 (id 126)
  0.25  RESERVE: zone 26 at (3104, 1152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1152) facing 0 (id 127)
  0.25  RESERVE: zone 27 at (3104, 1184) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1184) facing 0 (id 128)
  0.25  RESERVE: zone 28 at (3104, 1216) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1216) facing 0 (id 129)
  0.25  RESERVE: zone 29 at (3104, 1248) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1248) facing 0 (id 130)
  0.25  RESERVE: zone 30 at (3104, 1568) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1568) facing 0 (id 131)
  0.25  RESERVE: zone 31 at (3104, 1600) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1600) facing 0 (id 132)
  0.25  RESERVE: zone 32 at (3104, 1632) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1632) facing 0 (id 133)
  0.25  RESERVE: zone 33 at (3104, 1664) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1664) facing 0 (id 134)
  0.25  RESERVE: zone 34 at (3104, 1696) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1696) facing 0 (id 135)
  0.25  RESERVE: zone 35 at (3104, 1728) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1728) facing 0 (id 136)
  0.25  RESERVE: zone 36 at (3104, 1760) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1760) facing 0 (id 137)
  0.25  RESERVE: zone 37 at (3104, 1792) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1792) facing 0 (id 138)
  0.25  RESERVE: zone 38 at (3104, 1824) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1824) facing 0 (id 139)
  0.25  RESERVE: zone 39 at (3104, 1856) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1856) facing 0 (id 140)
  0.25  RESERVE: zone 40 at (3104, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1888) facing 0 (id 141)
  0.25  RESERVE: zone 41 at (2992, 1152) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (2992, 1152) facing 0 (id 142)
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
  0.25  RESERVE: legdrag at (11328, 1792) facing 0 (id 128)
```
