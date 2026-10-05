# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 7.0 min (frame 12600); wall 116 s
- DLL: build-theatres\d193-build\SkirmishAI.dll (df4b5dd21490b768); AI BARbTest/test; staged 2026-10-04T16:22:14
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: response-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-cortex\supreme\20261004T192213Z-57a9886f\runs\20261004T192413Z-52046375\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:44.780834][f=-000001] [AirResponseWatch] loaded case=defense` |
| expect `dispatch` | seen at 1.5 min | `[AIR][BaseResponse] dispatched=29 total=29` |
| expect `production` | seen at 1.5 min | `[AIR][Produce] base.defence corape plant=30163 projected=1/1` |
| expect `bomber_damage` | seen at 1.8 min | `[t=00:01:17.831331][f=0003186] [AirResponseWatch] damage frame=3186 attacker=corhurc victim=armmar amount=291.726593 emp=false` |
| expect `gunship_finished` | seen at 1.7 min | `[t=00:01:17.117759][f=0003008] [AirResponseWatch] finished frame=3008 def=corape id=15428` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-050 no factory 300 s into the game (layout planned)` |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Failures

- forbid 'invariant' hit at 5.0 min: [INVARIANT] INV-050 no factory 300 s into the game (layout planned)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-cortex\supreme\20261004T192213Z-57a9886f\runs\20261004T192413Z-52046375\screen_2026-10-04_19-23-32-437.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-cortex\supreme\20261004T192213Z-57a9886f\runs\20261004T192413Z-52046375\screen_2026-10-04_19-23-36-940.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-cortex\supreme\20261004T192213Z-57a9886f\runs\20261004T192413Z-52046375\screen_2026-10-04_19-23-40-555.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 10, 0 shots, end at 7.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 31
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 31
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order corap
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=100000 E=0 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 19 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|cortex|corap|2154|11748|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(837,10404) factory=armlab landLocked=no spot=1 known=1/1
  0.18  [Playtest] finished coraap team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armnanotc team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [AIR][Growth] growth objective reached; completed AFUS=3
  0.18  [AIR][Layout] cluster=0 labs=6 at=4050,11100
  0.18  [AIR][EcoLayout] reserved air.eco.0 reactor=1648,11888 converters=8 support=12 zone=1030
  0.18  [AIR][State] T2_SUSTAIN
  0.18  [AIR][Share] metal 100003 of 100200 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.20  [Playtest] finished armarad team 0 at 0.20 min
  0.20  [AIR][EcoLayout] reserved air.eco.1 reactor=3056,11632 converters=8 support=12 zone=1572
  0.22  [AIR][EcoLayout] reserved air.eco.2 reactor=2032,11504 converters=8 support=12 zone=1594
  0.23  [AIR][EcoLayout] reserved air.eco.3 reactor=3184,11120 converters=8 support=12 zone=1622
  0.23  [AIR][Waves] opening size drawn=13
  0.23  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.23  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=9; request fresh reconnaissance
  0.27  [AIR][Capacity] own=2/30 usage=0/26 gifts=0 sent=0 excess=0 pressure=false mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] T2_SUSTAIN M=1 bank=100011 E=18 bank=1027375 pull=26 plants=0/1 aircraftDemand=36/1275
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.36  [AIR][Produce] intercept corvamp plant=30163 projected=1/6
  0.40  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.43  [AIR][Capacity] own=2/9065 usage=40/1457 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] T2_SUSTAIN M=2 bank=99947 E=9065 bank=1027375 pull=1457 plants=0/1 aircraftDemand=36/1275
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.45  [AIR][Screen] fighters=1 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  0.47  [AIR][Produce] intercept corvamp plant=30163 projected=2/6
  0.57  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.57  [AIR][Produce] intercept corvamp plant=30163 projected=3/6
  0.60  [AIR][Capacity] own=2/9065 usage=14/524 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] T2_SUSTAIN M=2 bank=99743 E=9065 bank=1027375 pull=524 plants=0/1 aircraftDemand=36/1275
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.60  [AIR][Attack] home=2 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  0.63  [AIR][Screen] fighters=2 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  0.67  [AIR][Produce] intercept corvamp plant=30163 projected=4/6
  0.73  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.73  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  0.77  [AIR][Capacity] own=2/9065 usage=20/731 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] T2_SUSTAIN M=2 bank=99484 E=9065 bank=1027375 pull=731 plants=0/1 aircraftDemand=36/1275
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.77  [AIR][Produce] intercept corvamp plant=30163 projected=5/6
  0.80  [AIR][Screen] fighters=4 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  0.88  [AIR][Produce] intercept corvamp plant=30163 projected=6/6
  0.90  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.93  [AIR][Capacity] own=2/9065 usage=26/958 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] T2_SUSTAIN M=2 bank=99324 E=9065 bank=1027375 pull=958 plants=0/1 aircraftDemand=36/1275
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.98  [AIR][Screen] fighters=6 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  0.99  [AIR][Produce] air.control corvamp plant=30163 projected=7/7
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99215/100200, energy +9065.0 bank 1027245/1027375, units 50
  1.07  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.10  [AIR][Capacity] own=2/9065 usage=15/566 gifts=39 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T2_SUSTAIN M=2 bank=99198 E=9065 bank=1027375 pull=566 plants=0/1 aircraftDemand=36/1275
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.10  [AIR][Attack] home=7 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  1.10  [AIR][Share] metal 99200 of 100200 (99%): sent 103 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.10  [AIR][Produce] air.control corvamp plant=30163 projected=8/8
  1.13  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99885) (D-106)
  1.17  [AIR][Screen] fighters=7 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  1.18  [AIR][Share] metal 99198 of 100200 (99%): sent 223 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.21  [AIR][Produce] air.control corvamp plant=30163 projected=9/9
  1.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99778) (D-106)
  1.23  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.23  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  1.27  [AIR][Capacity] own=2/9065 usage=26/945 gifts=15 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T2_SUSTAIN M=14 bank=99198 E=9065 bank=1027375 pull=945 plants=0/1 aircraftDemand=36/1275
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.27  [AIR][Share] metal 99198 of 100200 (99%): sent 295 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99653) (D-106)
  1.32  [AIR][Produce] air.control corvamp plant=30163 projected=10/10
  1.35  [AIR][Screen] fighters=9 cells=8 centre=1551,9645 width=1200 advance=1041 responding=false
  1.35  [AIR][Share] metal 99198 of 100200 (99%): sent 351 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99578) (D-106)
  1.40  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.43  [AIR][Produce] air.control corvamp plant=30163 projected=11/11
  1.43  [AIR][Capacity] own=2/9065 usage=9/343 gifts=39 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T2_SUSTAIN M=13 bank=99198 E=9065 bank=1027375 pull=343 plants=0/1 aircraftDemand=36/1275
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.43  [AIR][Share] metal 99199 of 100200 (99%): sent 462 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99498) (D-106)
  1.52  [AIR][BaseResponse] contact=true
  1.52  [AIR][BaseResponse] group=0 target=6960
  1.52  [AIR][BaseResponse] group=1 target=6960
  1.52  [AIR][BaseResponse] group=2 target=6960
  1.52  [AIR][BaseResponse] dispatched=29 total=29
  1.52  [AIR][Share] metal 99198 of 100200 (99%): sent 587 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.53  [AIR][Produce] base.defence corape plant=30163 projected=1/1
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99416) (D-106)
  1.60  [AIR][Capacity] own=2/9065 usage=33/635 gifts=7 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T2_SUSTAIN M=14 bank=99198 E=9065 bank=1027375 pull=635 plants=0/1 aircraftDemand=36/1275
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [AIR][Share] metal 99198 of 100200 (99%): sent 677 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99204) (D-106)
  1.68  [AIR][Share] metal 99198 of 100200 (99%): sent 925 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.70  [AIR][Produce] base.defence corape plant=30163 projected=2/2
  1.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99049) (D-106)
  1.77  [AIR][Capacity] own=2/9062 usage=60/1115 gifts=37 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T2_SUSTAIN M=12 bank=99198 E=9065 bank=1027350 pull=1115 plants=0/1 aircraftDemand=36/1275
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.82  [AIR][BaseResponse] group=2 target=6960
  1.82  [AIR][BaseResponse] dispatched=1 total=20
  1.83  [AIR][BaseResponse] group=0 target=21900
  1.83  [AIR][BaseResponse] group=1 target=21900
  1.83  [AIR][BaseResponse] group=2 target=21900
  1.84  [AIR][Produce] base.defence corape plant=30163 projected=3/3
  1.93  [AIR][Capacity] own=2/9060 usage=61/1133 gifts=61 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T2_SUSTAIN M=30 bank=99197 E=9060 bank=1027350 pull=1133 plants=0/1 aircraftDemand=36/1275
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.97  [AIR][BaseResponse] dispatched=1 total=19
  1.98  [AIR][BaseResponse] group=0 target=18519
  1.98  [AIR][BaseResponse] group=1 target=18519
  1.98  [AIR][BaseResponse] group=2 target=18519
  1.99  [AIR][Produce] base.defence corape plant=30163 projected=4/4
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 99040/100200, energy +9060.0 bank 1027244/1027350, units 41
  2.07  [AIR][BaseResponse] group=0 target=28208
  2.07  [AIR][BaseResponse] group=1 target=28208
  2.07  [AIR][BaseResponse] group=2 target=28208
  2.10  [AIR][Capacity] own=2/9060 usage=61/1133 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=2 bank=98774 E=9060 bank=1027350 pull=1133 plants=0/1 aircraftDemand=36/1275
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.12  [AIR][BaseResponse] dispatched=1 total=19
  2.13  [AIR][Produce] base.defence corape plant=30163 projected=5/5
  2.17  [AIR][BaseResponse] contact=false
  2.17  [AIR][BaseResponse] group=0 target=-1
  2.17  [AIR][BaseResponse] group=1 target=-1
  2.17  [AIR][BaseResponse] group=2 target=-1
  2.27  [AIR][Capacity] own=2/9060 usage=61/1133 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=2 bank=98328 E=9060 bank=1027350 pull=1133 plants=0/1 aircraftDemand=36/1275
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.28  [AIR][Produce] intercept corvamp plant=30163 projected=1/6
  2.37  [AIR][Screen] fighters=1 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  2.39  [AIR][Produce] intercept corvamp plant=30163 projected=2/6
  2.43  [AIR][Capacity] own=2/9060 usage=21/767 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=2 bank=98171 E=9060 bank=1027350 pull=767 plants=0/1 aircraftDemand=36/1275
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.49  [AIR][Produce] intercept corvamp plant=30163 projected=3/6
  2.52  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.52  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=6; request fresh reconnaissance
  2.55  [AIR][Screen] fighters=2 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  2.60  [AIR][Capacity] own=2/9060 usage=11/404 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=2 bank=97928 E=9060 bank=1027350 pull=404 plants=0/1 aircraftDemand=36/1275
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.60  [AIR][Attack] home=3 target=6 heldBombers=15 escorts=0 wave=0 enemyAir=0
  2.60  [AIR][Produce] intercept corvamp plant=30163 projected=4/6
  2.68  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.71  [AIR][Produce] intercept corvamp plant=30163 projected=5/6
  2.73  [AIR][Screen] fighters=4 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  2.77  [AIR][Capacity] own=2/9060 usage=36/1288 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T2_SUSTAIN M=2 bank=97741 E=9060 bank=1027350 pull=1288 plants=0/1 aircraftDemand=36/1275
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.77  [AIR][Share] metal 97701 of 100200 (97%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  2.81  [AIR][Produce] intercept corvamp plant=30163 projected=6/6
  2.85  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.90  [AIR][Screen] fighters=5 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  2.93  [AIR][Produce] air.control corvamp plant=30163 projected=7/7
  2.93  [AIR][Capacity] own=2/9060 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T2_SUSTAIN M=2 bank=97528 E=9060 bank=1027350 pull=0 plants=0/1 aircraftDemand=36/1275
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 97390/100200, energy +9060.0 bank 1027324/1027350, units 48
  3.02  [AIR][Waves] home focus replaced by enemy start 10129,541
  3.02  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=15; request fresh reconnaissance
  3.02  [AIR][Produce] air.control corvamp plant=30163 projected=8/8
  3.08  [AIR][Screen] fighters=7 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  3.10  [AIR][Capacity] own=2/9060 usage=41/1457 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T2_SUSTAIN M=2 bank=97288 E=9060 bank=1027350 pull=1457 plants=0/1 aircraftDemand=36/1275
  3.10  [AIR][Projects] energyQueued=0 committed=0/0
  3.10  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  3.10  [AIR][Attack] home=7 target=6 heldBombers=15 escorts=0 wave=0 enemyAir=0
  3.12  [AIR][Produce] air.control corvamp plant=30163 projected=9/9
  3.18  [AIR][Waves] home focus replaced by enemy start 10129,541
  3.22  [AIR][Produce] air.control corvamp plant=30163 projected=10/10
  3.25  [AIR][Screen] fighters=9 cells=8 centre=1551,9645 width=1200 advance=1041 responding=false
  3.27  [AIR][Capacity] own=2/9060 usage=19/702 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T2_SUSTAIN M=2 bank=97106 E=9060 bank=1027350 pull=702 plants=0/1 aircraftDemand=36/1275
  3.27  [AIR][Projects] energyQueued=0 committed=0/0
  3.27  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  3.33  [AIR][Produce] air.control corvamp plant=30163 projected=11/11
  3.35  [AIR][Layout] cluster=1 labs=1 at=2322,11676
  3.35  [AIR][Waves] home focus replaced by enemy start 10129,541
  3.42  [AIR][Screen] fighters=10 cells=8 centre=1551,9645 width=1200 advance=1041 responding=false
  3.43  [AIR][Capacity] own=2/9060 usage=34/1198 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T2_SUSTAIN M=2 bank=96855 E=9060 bank=1027350 pull=1198 plants=0/1 aircraftDemand=36/1275
  3.43  [AIR][Projects] energyQueued=0 committed=0/0
  3.43  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
... 379 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.08  RESERVE: zone 7 at (1523, 10568) facing 2, 77x63 cells: 4511 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1523, 10072) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1523, 10120) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1523, 10168) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1523, 10216) facing 2: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1288, 9992) facing 2 (id 63)
  0.08  RESERVE: zone 8 at (1203, 9656) facing 2, 41x37 cells: 1499 of 1517 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1203, 9368) facing 2: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1203, 9416) facing 2: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1203, 9464) facing 2: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1203, 9512) facing 2: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (1648, 8592) facing 2 (id 116)
  0.08  RESERVE: zone 9 at (1648, 8664) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1648, 8640) facing 2: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (1536, 8528) facing 2 (id 119)
  0.08  RESERVE: zone 10 at (1536, 8600) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1536, 8576) facing 2: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: corridor 11 at (1632, 8552) facing 2, 6x21 cells: 111 of 126 held
  0.08  RESERVE: corridor 12 at (1440, 8552) facing 2, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 13 at (1536, 8552) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 13 at (1536, 8304) facing 2, 10x20 cells: 180 of 200 held
  0.17  RESERVE: armlab at (1296, 8416) facing 2 (id 122)
  0.17  RESERVE: zone 14 at (1296, 8488) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1296, 8464) facing 2: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: corridor 15 at (1200, 8440) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (1296, 8440) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (1296, 8192) facing 2, 10x20 cells: 190 of 200 held
  0.18  RESERVE: zone 1 at (3976, 9952) facing 2, 9x6 cells: 54 of 54 held
  0.18  RESERVE: corap at (3976, 9952) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (4024, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (4024, 10024) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (3976, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3976, 10024) facing 2 (id 3)
  0.18  RESERVE: zone 4 at (3928, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3928, 10024) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (4024, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (4024, 10072) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (3976, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3976, 10072) facing 2 (id 6)
  0.18  RESERVE: zone 7 at (3832, 9928) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: coraap at (3832, 9928) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (3880, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3880, 10024) facing 2 (id 8)
  0.18  RESERVE: zone 9 at (3832, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3832, 10024) facing 2 (id 9)
  0.18  RESERVE: zone 10 at (3784, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3784, 10024) facing 2 (id 10)
  0.18  RESERVE: zone 11 at (3880, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3880, 10072) facing 2 (id 11)
  0.18  RESERVE: zone 12 at (3832, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3832, 10072) facing 2 (id 12)
  0.18  RESERVE: zone 13 at (3784, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3784, 10072) facing 2 (id 13)
  0.18  RESERVE: zone 14 at (3880, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3880, 10120) facing 2 (id 14)
  0.18  RESERVE: zone 15 at (3832, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3832, 10120) facing 2 (id 15)
  0.18  RESERVE: zone 16 at (3784, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3784, 10120) facing 2 (id 16)
  0.18  RESERVE: zone 17 at (3880, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3880, 10168) facing 2 (id 17)
  0.18  RESERVE: zone 18 at (3832, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3832, 10168) facing 2 (id 18)
  0.18  RESERVE: zone 19 at (3784, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3784, 10168) facing 2 (id 19)
  0.18  RESERVE: zone 20 at (3880, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3880, 10216) facing 2 (id 20)
  0.18  RESERVE: zone 21 at (3832, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3832, 10216) facing 2 (id 21)
  0.18  RESERVE: zone 22 at (3784, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3784, 10216) facing 2 (id 22)
  0.18  RESERVE: zone 23 at (3880, 10264) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3880, 10264) facing 2 (id 23)
  0.18  RESERVE: zone 24 at (3832, 10264) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3832, 10264) facing 2 (id 24)
  0.18  RESERVE: zone 25 at (3784, 10264) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3784, 10264) facing 2 (id 25)
  0.18  RESERVE: zone 26 at (3880, 10312) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3880, 10312) facing 2 (id 26)
  0.18  RESERVE: zone 27 at (3832, 10312) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3832, 10312) facing 2 (id 27)
  0.18  RESERVE: zone 28 at (3688, 9928) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: coraap at (3688, 9928) facing 2 (id 28)
  0.18  RESERVE: zone 29 at (3736, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3736, 10024) facing 2 (id 29)
  0.18  RESERVE: zone 30 at (3688, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3688, 10024) facing 2 (id 30)
  0.18  RESERVE: zone 31 at (3640, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3640, 10024) facing 2 (id 31)
  0.18  RESERVE: zone 32 at (3736, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3736, 10072) facing 2 (id 32)
  0.18  RESERVE: zone 33 at (3688, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3688, 10072) facing 2 (id 33)
  0.18  RESERVE: zone 34 at (3640, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3640, 10072) facing 2 (id 34)
  0.18  RESERVE: zone 35 at (3736, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3736, 10120) facing 2 (id 35)
  0.18  RESERVE: zone 36 at (3688, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3688, 10120) facing 2 (id 36)
  0.18  RESERVE: zone 37 at (3640, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3640, 10120) facing 2 (id 37)
  0.18  RESERVE: zone 38 at (3736, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3736, 10168) facing 2 (id 38)
  0.18  RESERVE: zone 39 at (3688, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3688, 10168) facing 2 (id 39)
  0.18  RESERVE: zone 40 at (3640, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3640, 10168) facing 2 (id 40)
  0.18  RESERVE: zone 41 at (3736, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3736, 10216) facing 2 (id 41)
  0.18  RESERVE: zone 42 at (3688, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3688, 10216) facing 2 (id 42)
  0.18  RESERVE: zone 43 at (3640, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3640, 10216) facing 2 (id 43)
  0.18  RESERVE: zone 44 at (3736, 10264) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3736, 10264) facing 2 (id 44)
  0.18  RESERVE: zone 45 at (3688, 10264) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3688, 10264) facing 2 (id 45)
  0.18  RESERVE: zone 46 at (3640, 10264) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (3640, 10264) facing 2 (id 46)
```
