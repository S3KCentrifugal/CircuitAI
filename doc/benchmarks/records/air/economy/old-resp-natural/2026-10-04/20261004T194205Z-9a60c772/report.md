# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 20.0 min (frame 36032); wall 120 s
- DLL: build-theatres\d193-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T16:39:13
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\old-resp-natural\glacial\20261004T193912Z-b1ce0c7b\glacial\runs\20261004T194205Z-9a60c772\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=988 E=0 bank=911 pull=83 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-008 2 turret(s) in range of the reclaim of armlab 21663 are not on it` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 4.5 min: [INVARIANT] INV-008 2 turret(s) in range of the reclaim of armlab 21663 are not on it
- forbid 'invariant' hit at 5.4 min: [INVARIANT] INV-019 3 turret frames under construction, 1 allowed (build power 1620 (6 by power), bank 0 + 20/s (0 by metal))
- forbid 'invariant' hit at 6.4 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1860 (7 by power), bank 1 + 19/s (0 by metal))
- forbid 'invariant' hit at 13.4 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (1616, 2560) not upgraded
- forbid 'invariant' hit at 13.8 min: [INVARIANT] INV-010 combat unit armfast 7892 produced at +86 metal under the gate 200
- forbid 'invariant' hit at 15.2 min: [INVARIANT] INV-008 15 turret(s) in range of the reclaim of legalab 3984 are not on it
- forbid 'invariant' hit at 15.7 min: [INVARIANT] INV-010 combat unit armsptk 26359 produced at +121 metal under the gate 200
- forbid 'invariant' hit at 18.0 min: [INVARIANT] INV-010 combat unit armfast 793 produced at +113 metal under the gate 200
- forbid 'invariant' hit at 18.2 min: [INVARIANT] INV-010 combat unit armsptk 25475 produced at +119 metal under the gate 200
- forbid 'invariant' hit at 19.2 min: [INVARIANT] INV-010 combat unit armsptk 4771 produced at +119 metal under the gate 200
- forbid 'invariant' hit at 19.9 min: [t=00:01:56.795628][f=0035775] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\old-resp-natural\glacial\20261004T193912Z-b1ce0c7b\glacial\runs\20261004T194205Z-9a60c772\screen_2026-10-04_19-40-59-411.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\old-resp-natural\glacial\20261004T193912Z-b1ce0c7b\glacial\runs\20261004T194205Z-9a60c772\screen_2026-10-04_19-41-38-089.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\old-resp-natural\glacial\20261004T193912Z-b1ce0c7b\glacial\runs\20261004T194205Z-9a60c772\screen_2026-10-04_19-42-04-445.png

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
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=988 E=0 bank=911 pull=83 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=32/324
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (442, 1128), 48 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|490|1137|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(1800,1397) factory=armlab landLocked=no spot=1 known=1/1
  0.15  [Team][Roster] team 1 first mex at 1952,1408
  0.17  [Playtest] finished armmex team 0 at 0.17 min
  0.18  [AIR][Rule] opening.mex builder=14987
  0.18  [Team][Roster] first mex 26440 at 496,1296
  0.18  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|490|1137|0|0|1|496|1296
  0.27  [AIR][Capacity] own=2/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=954 E=18 bank=517 pull=86 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=13/138
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.43  [AIR][Capacity] own=3/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP RECOVERY M=3 bank=946 E=30 bank=155 pull=89 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/8
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.43  [Playtest] finished armmex team 0 at 0.43 min
  0.45  [AIR][Rule] recovery.energy builder=14987
  0.60  [AIR][Capacity] own=5/30 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=882 E=30 bank=327 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=4/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.60  [Playtest] finished armsolar team 0 at 0.60 min
  0.77  [AIR][Capacity] own=7/30 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=807 E=30 bank=734 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=4/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.77  [Playtest] finished armsolar team 0 at 0.77 min
  0.78  [AIR][Wind] cluster=0 slots=6 at=352,1272 local=false builder=14987
  0.78  [AIR][Rule] opening.energy builder=14987
  0.93  [AIR][Capacity] own=7/50 usage=7/41 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=843 E=50 bank=1058 pull=41 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=10/47
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.96  [Playtest] finished armwin team 0 at 0.96 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 855/1150, energy +82.8 bank 1087/1100, units 8
  1.06  [Playtest] finished armwin team 0 at 1.07 min
  1.10  [AIR][Capacity] own=7/70 usage=0/9 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=865 E=70 bank=1096 pull=9 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=33/144
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.17  [Playtest] finished armwin team 0 at 1.17 min
  1.19  [AIR][Starter] nearby distance=127
  1.19  [AIR][Rule] opening.plant builder=14987
  1.20  [AIR][Layout] cluster=0 labs=6 at=562,1017
  1.20  [AIR][EcoLayout] reserved air.eco.0 reactor=352,1776 converters=8 support=12 zone=140
  1.20  [AIR][Layout] cluster=1 labs=6 at=562,2841
  1.22  [AIR][EcoLayout] reserved air.eco.1 reactor=736,2160 converters=8 support=12 zone=292
  1.23  [AIR][EcoLayout] reserved air.eco.2 reactor=736,1392 converters=8 support=12 zone=314
  1.25  [AIR][EcoLayout] reserved air.eco.3 reactor=1888,752 converters=8 support=12 zone=336
  1.27  [AIR][Capacity] own=7/85 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=783 E=87 bank=1064 pull=69 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=493/835
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  1.27  [AIR][Bay] 12 plant=21039 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Capacity] own=7/86 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=506 E=87 bank=1046 pull=69 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=135/230
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 12 plant=21039 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.50  [Playtest] finished armap team 0 at 1.50 min
  1.50  [AIR][Claim] cancel unowned native order armnanotc
  1.50  [AIR][Claim] cancel unowned native order armnanotc
  1.50  [AIR][State] T1_CONTEST
  1.51  [AIR][Produce] opening.scout armpeep plant=21039 projected=1/1
  1.51  [AIR][Rule] opening.commander.guard builder=14987
  1.60  [AIR][Capacity] own=7/105 usage=8/258 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T1_CONTEST M=7 bank=380 E=100 bank=555 pull=258 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.63  [AIR][Produce] constructor.recovery armca plant=21039 projected=1/3
  1.77  [AIR][Capacity] own=7/115 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=385 E=113 bank=73 pull=134 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.90  [AIR][Produce] constructor.recovery armca plant=21039 projected=2/3
  1.90  [AIR][Rule] recovery.energy builder=9986
  1.93  [AIR][Capacity] own=7/126 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=410 E=126 bank=180 pull=69 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=1 committed=155/0
  1.93  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=100 floating=false savingLab=false
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
  1.93  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 402/1250, energy +131.9 bank 88/1226, units 14
  2.10  [AIR][Capacity] own=7/131 usage=4/46 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=24 reason=funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=395 E=129 bank=88 pull=134 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=127/0
  2.10  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=124 floating=false savingLab=false
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
  2.10  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.18  [AIR][Produce] constructor.recovery armca plant=21039 projected=3/3
  2.18  [AIR][Rule] recovery.energy builder=11504
  2.27  [AIR][Capacity] own=7/131 usage=5/9 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=99 shortage=0 reason=available or arriving power
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=372 E=131 bank=478 pull=197 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=245/0
  2.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  2.27  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.39  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.39  [AIR][Rule] commander.idle.assist builder=14987
  2.39  [AIR][Produce] opening.screen armfig plant=21039 projected=1/6
  2.39  [AIR][Rule] recovery.assist builder=20671
  2.40  [AIR][Rule] commander.factory.guard builder=14987
  2.43  [AIR][Capacity] own=7/136 usage=12/265 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=108 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=307 E=136 bank=996 pull=265 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=185/0
  2.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
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
  2.43  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.54  [AIR][Produce] opening.screen armfig plant=21039 projected=2/6
  2.54  [AIR][Screen] fighters=1 cells=8 centre=2200,1397 width=600 advance=400 responding=false
  2.60  [AIR][Capacity] own=7/139 usage=18/381 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=219 E=140 bank=7 pull=381 plants=1/0 aircraftDemand=3/127
  2.60  [AIR][Projects] energyQueued=0 committed=96/0
  2.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
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
  2.60  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.72  [AIR][Screen] fighters=1 cells=8 centre=2200,1397 width=600 advance=400 responding=false
  2.76  [Playtest] finished armsolar team 0 at 2.76 min
  2.77  [AIR][Capacity] own=7/131 usage=13/183 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=156 E=132 bank=14 pull=257 plants=1/0 aircraftDemand=3/127
  2.77  [AIR][Projects] energyQueued=0 committed=8/0
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
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
  2.77  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Rule] mex.expand builder=20671
  2.78  [AIR][Produce] opening.screen armfig plant=21039 projected=3/6
  2.78  [AIR][Rule] intel.radar builder=11504
  2.81  [Playtest] finished armsolar team 0 at 2.82 min
  2.83  [AIR][Rule] project.assist builder=9986
  2.88  [AIR][Screen] fighters=2 cells=8 centre=2200,1397 width=600 advance=400 responding=false
  2.93  [AIR][Capacity] own=3/141 usage=7/173 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=109 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=141 E=149 bank=4 pull=326 plants=1/0 aircraftDemand=3/127
  2.93  [AIR][Projects] energyQueued=0 committed=69/712
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
  2.93  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.0 bank 131/1250, energy +174.4 bank 0/1376, units 21
  3.05  [AIR][Screen] fighters=2 cells=8 centre=2200,1397 width=600 advance=400 responding=false
  3.05  [Playtest] finished armrad team 0 at 3.05 min
  3.07  [AIR][Rule] wait builder=11504
  3.10  [AIR][Capacity] own=5/173 usage=5/172 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=130 E=172 bank=46 pull=271 plants=1/0 aircraftDemand=3/127
  3.10  [AIR][Projects] energyQueued=0 committed=30/300
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
  3.10  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.16  [AIR][Produce] opening.screen armfig plant=21039 projected=4/6
  3.19  [AIR][Rule] project.assist builder=11504
  3.23  [AIR][Screen] fighters=3 cells=8 centre=2200,1397 width=600 advance=400 responding=false
  3.27  [AIR][Capacity] own=6/176 usage=6/181 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=149 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=147 E=175 bank=6 pull=296 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=3/31
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
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
  3.27  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.28  [Playtest] finished armmex team 0 at 3.28 min
  3.30  [AIR][Rule] wait builder=9986
  3.30  [AIR][Rule] wait builder=11504
  3.40  [AIR][Screen] fighters=3 cells=8 centre=2200,1397 width=600 advance=400 responding=false
  3.43  [AIR][Capacity] own=6/181 usage=4/177 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=100 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=190 E=181 bank=1 pull=260 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=50/500
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
  3.43  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.47  [AIR][Produce] opening.screen armfig plant=21039 projected=5/6
  3.48  [AIR][Rule] project.assist builder=9986
  3.49  [AIR][Rule] project.assist builder=11504
  3.58  [AIR][Screen] fighters=4 cells=8 centre=2200,1397 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=8/177 usage=6/249 gifts=0 sent=0 excess=0 pressure=true mobile=150 arriving=0 idle=0 ecoStatic=0 working=43 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=9 bank=229 E=180 bank=67 pull=266 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=37/371
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
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
  3.60  [AIR][Bay] 12 plant=21039 BP=150 nanos=0+0/0 available=yes firstSlot=0
... 2532 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(14987) at (490, 1137) walks to (491, 1160), 136 from the armmex site (496, 1296)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (1688, 1688) facing 1, 63x77 cells: 4467 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2184, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2136, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2088, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (2040, 1688) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (2264, 1448) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (2536, 1368) facing 1, 29x41 cells: 1155 of 1189 held
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
  0.09  RESERVE: zone 7 at (12757, 1016) facing 3, 63x77 cells: 4631 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12261, 1016) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12309, 1016) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12357, 1016) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (12405, 1016) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (12184, 1256) facing 3 (id 63)
  0.09  RESERVE: zone 8 at (11781, 1336) facing 3, 45x41 cells: 1697 of 1845 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11429, 1336) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11477, 1336) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11525, 1336) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (11573, 1336) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (10320, 1136) facing 3 (id 116)
  0.09  RESERVE: zone 9 at (10392, 1136) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (10368, 1136) facing 3: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (10344, 1040) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 11 at (10344, 1232) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: zone 12 at (10344, 1136) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 12 at (10096, 1136) facing 3, 20x10 cells: 180 of 200 held
  0.10  EXP: idle: armcom(14987) on armmex at (490, 1150), site (496, 1296), target yes, fails 1 (arrived at the approach point)
  0.17  EXP: approach: legcom(9312) at (12572, 1400) walks to (12675, 1663), 137 from the legmex site (12576, 1568)
  0.17  RESERVE: armlab at (4416, 1200) facing 1 (id 112)
  0.17  RESERVE: zone 13 at (4344, 1200) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (4368, 1200) facing 1: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 14 at (4392, 1296) facing 1, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (4392, 1200) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (4640, 1200) facing 1, 20x10 cells: 190 of 200 held
  0.17  RESERVE: leglab at (10048, 1440) facing 3 (id 119)
  0.17  RESERVE: zone 13 at (10120, 1440) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (10096, 1440) facing 3: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 14 at (10072, 1344) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (10072, 1440) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (9824, 1440) facing 3, 20x10 cells: 190 of 200 held
  0.18  EXP: approach: armcom(14987) at (490, 1150) walks to (472, 1148), 136 from the armmex site (336, 1136)
  0.22  EXP: approach: corcom(14767) at (13996, 1034) walks to (13970, 1024), 139 from the cormex site (13840, 976)
  0.25  RESERVE: armalab at (3512, 2760) facing 1 (id 115)
  0.25  RESERVE: zone 16 at (3392, 2760) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3440, 2760) facing 1: 4 of 4 slots (group 10, zone)
  0.25  RESERVE: zone 17 at (3464, 2760) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (3760, 2760) facing 1, 20x13 cells: 260 of 260 held
  0.25  RESERVE: zone 19 at (3104, 912) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 912) facing 0 (id 120)
  0.25  RESERVE: zone 20 at (3104, 944) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 944) facing 0 (id 121)
  0.25  RESERVE: zone 21 at (3104, 976) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 976) facing 0 (id 122)
  0.25  RESERVE: zone 22 at (3104, 1008) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1008) facing 0 (id 123)
  0.25  RESERVE: zone 23 at (3104, 1040) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1040) facing 0 (id 124)
  0.25  RESERVE: zone 24 at (3104, 1072) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1072) facing 0 (id 125)
  0.25  RESERVE: zone 25 at (3104, 1104) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1104) facing 0 (id 126)
  0.25  RESERVE: zone 26 at (3104, 1136) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1136) facing 0 (id 127)
  0.25  RESERVE: zone 27 at (3104, 1168) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1168) facing 0 (id 128)
  0.25  RESERVE: zone 28 at (3104, 1200) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1200) facing 0 (id 129)
  0.25  RESERVE: zone 29 at (3104, 1232) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1232) facing 0 (id 130)
  0.25  RESERVE: zone 30 at (3104, 1552) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1552) facing 0 (id 131)
  0.25  RESERVE: zone 31 at (3104, 1584) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1584) facing 0 (id 132)
  0.25  RESERVE: zone 32 at (3104, 1616) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1616) facing 0 (id 133)
  0.25  RESERVE: zone 33 at (3104, 1648) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1648) facing 0 (id 134)
  0.25  RESERVE: zone 34 at (3104, 1680) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1680) facing 0 (id 135)
  0.25  RESERVE: zone 35 at (3104, 1712) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1712) facing 0 (id 136)
  0.25  RESERVE: zone 36 at (3104, 1744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1744) facing 0 (id 137)
  0.25  RESERVE: zone 37 at (3104, 1776) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1776) facing 0 (id 138)
  0.25  RESERVE: zone 38 at (3104, 1808) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1808) facing 0 (id 139)
  0.25  RESERVE: zone 39 at (3104, 1840) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1840) facing 0 (id 140)
  0.25  RESERVE: zone 40 at (3104, 1872) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3104, 1872) facing 0 (id 141)
  0.25  RESERVE: zone 41 at (2992, 1136) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (2992, 1136) facing 0 (id 142)
  0.25  RESERVE: legalab at (11224, 2712) facing 3 (id 122)
  0.25  RESERVE: zone 16 at (11344, 2712) facing 3, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of legnanotc 2x2 gap 0 behind (11296, 2712) facing 3: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 17 at (11272, 2712) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 18 at (10976, 2712) facing 3, 20x13 cells: 260 of 260 held
  0.25  RESERVE: zone 19 at (11280, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11280, 1888) facing 0 (id 127)
  0.25  RESERVE: zone 20 at (11280, 1856) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11280, 1856) facing 0 (id 128)
  0.25  RESERVE: zone 21 at (11280, 1824) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (11280, 1824) facing 0 (id 129)
  0.25  RESERVE: zone 22 at (11280, 1792) facing 0, 2x2 cells: 4 of 4 held
```
