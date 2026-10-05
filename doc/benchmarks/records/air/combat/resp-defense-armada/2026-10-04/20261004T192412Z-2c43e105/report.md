# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 7.0 min (frame 12600); wall 114 s
- DLL: build-theatres\d193-build\SkirmishAI.dll (df4b5dd21490b768); AI BARbTest/test; staged 2026-10-04T16:22:15
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: response-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-armada\supreme\20261004T192214Z-d6170caf\runs\20261004T192412Z-2c43e105\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:43.548231][f=-000001] [AirResponseWatch] loaded case=defense` |
| expect `dispatch` | seen at 1.5 min | `[AIR][BaseResponse] dispatched=28 total=28` |
| expect `production` | seen at 1.6 min | `[AIR][Produce] base.defence armbrawl plant=25758 projected=1/1` |
| expect `bomber_damage` | seen at 1.7 min | `[t=00:01:16.160105][f=0003101] [AirResponseWatch] damage frame=3101 attacker=armpnix victim=armmar amount=176.858368 emp=false` |
| expect `gunship_finished` | seen at 1.7 min | `[t=00:01:16.167389][f=0003103] [AirResponseWatch] finished frame=3103 def=armbrawl id=20137` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-050 no factory 300 s into the game (layout planned)` |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Failures

- forbid 'invariant' hit at 5.0 min: [INVARIANT] INV-050 no factory 300 s into the game (layout planned)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-armada\supreme\20261004T192214Z-d6170caf\runs\20261004T192412Z-2c43e105\screen_2026-10-04_19-23-31-436.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-armada\supreme\20261004T192214Z-d6170caf\runs\20261004T192412Z-2c43e105\screen_2026-10-04_19-23-34-766.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-armada\supreme\20261004T192214Z-d6170caf\runs\20261004T192412Z-2c43e105\screen_2026-10-04_19-23-36-486.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-armada\supreme\20261004T192214Z-d6170caf\runs\20261004T192412Z-2c43e105\screen_2026-10-04_19-23-38-725.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 10, 0 shots, end at 7.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 41
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 41
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=100000 E=0 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 15 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|2155|11744|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(837,10404) factory=armlab landLocked=no spot=1 known=1/1
  0.17  [Playtest] finished armaap team 0 at 0.17 min
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
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.18  [AIR][Growth] growth objective reached; completed AFUS=3
  0.18  [AIR][Layout] cluster=0 labs=6 at=4147,11288
  0.18  [AIR][EcoLayout] reserved air.eco.0 reactor=1648,11872 converters=8 support=12 zone=2038
  0.18  [AIR][State] T2_SUSTAIN
  0.18  [AIR][Share] metal 100002 of 100200 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.20  [Playtest] finished armarad team 0 at 0.20 min
  0.20  [AIR][EcoLayout] reserved air.eco.1 reactor=3056,11616 converters=8 support=12 zone=2072
  0.22  [AIR][EcoLayout] reserved air.eco.2 reactor=2032,11488 converters=8 support=12 zone=2094
  0.22  [AIR][Waves] opening size drawn=13
  0.22  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.22  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=3; request fresh reconnaissance
  0.23  [AIR][EcoLayout] reserved air.eco.3 reactor=3184,11104 converters=8 support=12 zone=2118
  0.27  [AIR][Capacity] own=2/30 usage=0/26 gifts=0 sent=0 excess=0 pressure=false mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] T2_SUSTAIN M=1 bank=100010 E=21 bank=1027375 pull=26 plants=0/1 aircraftDemand=34/1407
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.36  [AIR][Produce] intercept armhawk plant=25758 projected=1/6
  0.38  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.43  [AIR][Capacity] own=2/9065 usage=36/1500 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] T2_SUSTAIN M=2 bank=99946 E=9065 bank=1027375 pull=1500 plants=0/1 aircraftDemand=34/1407
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.46  [AIR][Screen] fighters=1 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  0.47  [AIR][Produce] intercept armhawk plant=25758 projected=2/6
  0.55  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.60  [AIR][Produce] intercept armhawk plant=25758 projected=3/6
  0.60  [AIR][Capacity] own=2/9065 usage=2/121 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] T2_SUSTAIN M=2 bank=99753 E=9065 bank=1027375 pull=121 plants=0/1 aircraftDemand=34/1407
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.60  [AIR][Attack] home=2 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  0.65  [AIR][Screen] fighters=2 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  0.71  [AIR][Produce] intercept armhawk plant=25758 projected=4/6
  0.72  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.72  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  0.77  [AIR][Capacity] own=2/9065 usage=32/1341 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] T2_SUSTAIN M=2 bank=99566 E=9065 bank=1027375 pull=1341 plants=0/1 aircraftDemand=34/1407
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.82  [AIR][Produce] intercept armhawk plant=25758 projected=5/6
  0.85  [AIR][Screen] fighters=4 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  0.88  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.93  [AIR][Capacity] own=2/9065 usage=32/1334 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] T2_SUSTAIN M=2 bank=99348 E=9065 bank=1027375 pull=1334 plants=0/1 aircraftDemand=34/1407
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.94  [AIR][Produce] intercept armhawk plant=25758 projected=6/6
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99284/100200, energy +9065.0 bank 1027041/1027375, units 49
  1.03  [AIR][Screen] fighters=5 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  1.05  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.06  [AIR][Produce] air.control armhawk plant=25758 projected=7/7
  1.10  [AIR][Capacity] own=2/9065 usage=17/747 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T2_SUSTAIN M=2 bank=99203 E=9065 bank=1027375 pull=747 plants=0/1 aircraftDemand=34/1407
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.10  [AIR][Attack] home=6 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  1.17  [AIR][Produce] air.control armhawk plant=25758 projected=8/8
  1.18  [AIR][Share] metal 99198 of 100200 (99%): sent 116 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.20  [AIR][Screen] fighters=7 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  1.22  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.22  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  1.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99829) (D-106)
  1.27  [AIR][Capacity] own=2/9065 usage=33/1390 gifts=36 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T2_SUSTAIN M=2 bank=99198 E=9065 bank=1027375 pull=1390 plants=0/1 aircraftDemand=34/1407
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.27  [AIR][Share] metal 99200 of 100200 (99%): sent 231 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.28  [AIR][Produce] air.control armhawk plant=25758 projected=9/9
  1.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99757) (D-106)
  1.35  [AIR][Share] metal 99198 of 100200 (99%): sent 339 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.37  [AIR][Screen] fighters=8 cells=8 centre=1551,9645 width=1200 advance=1041 responding=false
  1.38  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99647) (D-106)
  1.39  [AIR][Produce] air.control armhawk plant=25758 projected=10/10
  1.43  [AIR][Capacity] own=2/9065 usage=19/832 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T2_SUSTAIN M=17 bank=99198 E=9065 bank=1027375 pull=832 plants=0/1 aircraftDemand=34/1407
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.43  [AIR][Share] metal 99198 of 100200 (99%): sent 392 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99537) (D-106)
  1.50  [AIR][Produce] air.control armhawk plant=25758 projected=11/11
  1.52  [AIR][BaseResponse] contact=true
  1.52  [AIR][BaseResponse] group=0 target=27601
  1.52  [AIR][BaseResponse] group=1 target=27601
  1.52  [AIR][BaseResponse] group=2 target=27601
  1.52  [AIR][BaseResponse] dispatched=28 total=28
  1.52  [AIR][Share] metal 99198 of 100200 (99%): sent 474 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99472) (D-106)
  1.60  [AIR][Capacity] own=2/9065 usage=39/1612 gifts=36 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T2_SUSTAIN M=14 bank=99198 E=9065 bank=1027375 pull=1612 plants=0/1 aircraftDemand=34/1407
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [AIR][Share] metal 99198 of 100200 (99%): sent 594 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.61  [AIR][Produce] base.defence armbrawl plant=25758 projected=1/1
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99389) (D-106)
  1.68  [AIR][Share] metal 99198 of 100200 (99%): sent 755 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99137) (D-106)
  1.73  [AIR][BaseResponse] dispatched=1 total=25
  1.75  [AIR][Produce] base.defence armbrawl plant=25758 projected=2/2
  1.77  [AIR][Capacity] own=2/9060 usage=0/0 gifts=21 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T2_SUSTAIN M=20 bank=99200 E=9064 bank=1027350 pull=0 plants=0/1 aircraftDemand=34/1407
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.80  [AIR][BaseResponse] group=0 target=21220
  1.80  [AIR][BaseResponse] group=1 target=21220
  1.80  [AIR][BaseResponse] group=2 target=21220
  1.82  [AIR][BaseResponse] group=0 target=28929
  1.82  [AIR][BaseResponse] group=1 target=28929
  1.82  [AIR][BaseResponse] group=2 target=28929
  1.88  [AIR][BaseResponse] dispatched=1 total=22
  1.91  [AIR][Produce] base.defence armbrawl plant=25758 projected=3/3
  1.93  [AIR][Capacity] own=2/9060 usage=6/124 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T2_SUSTAIN M=16 bank=99198 E=9060 bank=1027350 pull=124 plants=0/1 aircraftDemand=34/1407
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.95  [AIR][BaseResponse] group=0 target=26483
  1.95  [AIR][BaseResponse] group=1 target=26483
  1.95  [AIR][BaseResponse] group=2 target=26483
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 99144/100200, energy +9060.0 bank 1027130/1027350, units 43
  2.03  [AIR][BaseResponse] dispatched=1 total=21
  2.05  [AIR][BaseResponse] group=0 target=23533
  2.05  [AIR][BaseResponse] group=1 target=23533
  2.05  [AIR][BaseResponse] group=2 target=23533
  2.06  [AIR][Produce] base.defence armbrawl plant=25758 projected=4/4
  2.10  [AIR][Capacity] own=2/9060 usage=22/454 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=18 bank=99193 E=9060 bank=1027350 pull=454 plants=0/1 aircraftDemand=34/1407
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.10  [AIR][BaseResponse] contact=false
  2.10  [AIR][BaseResponse] group=0 target=-1
  2.10  [AIR][BaseResponse] group=1 target=-1
  2.10  [AIR][BaseResponse] group=2 target=-1
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.20  [AIR][Produce] intercept armhawk plant=25758 projected=4/9
  2.27  [AIR][Capacity] own=2/9060 usage=37/1538 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=2 bank=98854 E=9060 bank=1027350 pull=1538 plants=0/1 aircraftDemand=34/1407
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.30  [AIR][Screen] fighters=1 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  2.31  [AIR][Produce] intercept armhawk plant=25758 projected=5/9
  2.43  [AIR][Produce] intercept armhawk plant=25758 projected=6/9
  2.43  [AIR][Capacity] own=2/9060 usage=0/35 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=2 bank=98643 E=9060 bank=1027350 pull=35 plants=0/1 aircraftDemand=34/1407
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.45  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.45  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=4; request fresh reconnaissance
  2.48  [AIR][Screen] fighters=5 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  2.54  [AIR][Produce] air.control armhawk plant=25758 projected=7/7
  2.60  [AIR][Capacity] own=2/9060 usage=27/1131 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=2 bank=98467 E=9060 bank=1027350 pull=1131 plants=0/1 aircraftDemand=34/1407
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.60  [AIR][Attack] home=6 target=6 heldBombers=14 escorts=0 wave=0 enemyAir=0
  2.62  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.66  [AIR][Produce] air.control armhawk plant=25758 projected=8/8
  2.68  [AIR][Screen] fighters=7 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  2.77  [AIR][Capacity] own=2/9060 usage=14/601 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T2_SUSTAIN M=2 bank=98238 E=9060 bank=1027350 pull=601 plants=0/1 aircraftDemand=34/1407
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.77  [AIR][Share] metal 98240 of 100200 (98%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  2.77  [AIR][Produce] air.control armhawk plant=25758 projected=9/9
  2.78  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.86  [AIR][Screen] fighters=9 cells=8 centre=1551,9645 width=1200 advance=1041 responding=false
  2.88  [AIR][Produce] air.control armhawk plant=25758 projected=10/10
  2.93  [AIR][Capacity] own=2/9060 usage=30/1237 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T2_SUSTAIN M=2 bank=98060 E=9060 bank=1027350 pull=1237 plants=0/1 aircraftDemand=34/1407
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.95  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.95  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=14; request fresh reconnaissance
  2.99  [AIR][Produce] air.control armhawk plant=25758 projected=11/11
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 97967/100200, energy +9060.0 bank 1027243/1027350, units 50
  3.05  [AIR][Screen] fighters=10 cells=8 centre=1551,9645 width=1200 advance=1041 responding=false
  3.10  [AIR][Produce] air.control armhawk plant=25758 projected=12/12
  3.10  [AIR][Capacity] own=2/9060 usage=7/314 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T2_SUSTAIN M=2 bank=97833 E=9060 bank=1027350 pull=314 plants=0/1 aircraftDemand=34/1407
  3.10  [AIR][Projects] energyQueued=0 committed=0/0
  3.10  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  3.10  [AIR][Attack] home=11 target=6 heldBombers=14 escorts=0 wave=0 enemyAir=0
  3.12  [AIR][Waves] home focus replaced by enemy start 10129,541
  3.18  [AIR][Layout] cluster=1 labs=3 at=4243,10808
  3.21  [AIR][Produce] air.control armhawk plant=25758 projected=13/13
  3.23  [AIR][Screen] fighters=12 cells=8 centre=1991,9178 width=1800 advance=1683 responding=false
  3.27  [AIR][Capacity] own=2/9060 usage=36/1471 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T2_SUSTAIN M=2 bank=97641 E=9060 bank=1027350 pull=1471 plants=0/1 aircraftDemand=34/1407
  3.27  [AIR][Projects] energyQueued=0 committed=0/0
  3.27  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=25758 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.28  [AIR][Waves] home focus replaced by enemy start 10129,541
  3.31  [AIR][Produce] air.control armhawk plant=25758 projected=14/14
  3.40  [AIR][Screen] fighters=13 cells=8 centre=1991,9178 width=1800 advance=1683 responding=false
  3.43  [AIR][Capacity] own=2/9060 usage=12/512 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T2_SUSTAIN M=2 bank=97428 E=9060 bank=1027350 pull=512 plants=0/1 aircraftDemand=34/1407
  3.43  [AIR][Projects] energyQueued=0 committed=0/0
  3.43  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
... 416 more
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
  0.18  RESERVE: zone 1 at (3976, 9936) facing 2, 9x6 cells: 54 of 54 held
  0.18  RESERVE: armap at (3976, 9936) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (4024, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (4024, 10008) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (3976, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3976, 10008) facing 2 (id 3)
  0.18  RESERVE: zone 4 at (3928, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3928, 10008) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (4024, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (4024, 10056) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (3976, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3976, 10056) facing 2 (id 6)
  0.18  RESERVE: zone 7 at (3832, 9912) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: armaap at (3832, 9912) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (3880, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3880, 10008) facing 2 (id 8)
  0.18  RESERVE: zone 9 at (3832, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3832, 10008) facing 2 (id 9)
  0.18  RESERVE: zone 10 at (3784, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3784, 10008) facing 2 (id 10)
  0.18  RESERVE: zone 11 at (3880, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3880, 10056) facing 2 (id 11)
  0.18  RESERVE: zone 12 at (3832, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3832, 10056) facing 2 (id 12)
  0.18  RESERVE: zone 13 at (3784, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3784, 10056) facing 2 (id 13)
  0.18  RESERVE: zone 14 at (3880, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3880, 10104) facing 2 (id 14)
  0.18  RESERVE: zone 15 at (3832, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3832, 10104) facing 2 (id 15)
  0.18  RESERVE: zone 16 at (3784, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3784, 10104) facing 2 (id 16)
  0.18  RESERVE: zone 17 at (3880, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3880, 10152) facing 2 (id 17)
  0.18  RESERVE: zone 18 at (3832, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3832, 10152) facing 2 (id 18)
  0.18  RESERVE: zone 19 at (3784, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3784, 10152) facing 2 (id 19)
  0.18  RESERVE: zone 20 at (3880, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3880, 10200) facing 2 (id 20)
  0.18  RESERVE: zone 21 at (3832, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3832, 10200) facing 2 (id 21)
  0.18  RESERVE: zone 22 at (3784, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3784, 10200) facing 2 (id 22)
  0.18  RESERVE: zone 23 at (3880, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3880, 10248) facing 2 (id 23)
  0.18  RESERVE: zone 24 at (3832, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3832, 10248) facing 2 (id 24)
  0.18  RESERVE: zone 25 at (3784, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3784, 10248) facing 2 (id 25)
  0.18  RESERVE: zone 26 at (3880, 10296) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3880, 10296) facing 2 (id 26)
  0.18  RESERVE: zone 27 at (3832, 10296) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3832, 10296) facing 2 (id 27)
  0.18  RESERVE: zone 28 at (3688, 9912) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: armaap at (3688, 9912) facing 2 (id 28)
  0.18  RESERVE: zone 29 at (3736, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3736, 10008) facing 2 (id 29)
  0.18  RESERVE: zone 30 at (3688, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3688, 10008) facing 2 (id 30)
  0.18  RESERVE: zone 31 at (3640, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3640, 10008) facing 2 (id 31)
  0.18  RESERVE: zone 32 at (3736, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3736, 10056) facing 2 (id 32)
  0.18  RESERVE: zone 33 at (3688, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3688, 10056) facing 2 (id 33)
  0.18  RESERVE: zone 34 at (3640, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3640, 10056) facing 2 (id 34)
  0.18  RESERVE: zone 35 at (3736, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3736, 10104) facing 2 (id 35)
  0.18  RESERVE: zone 36 at (3688, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3688, 10104) facing 2 (id 36)
  0.18  RESERVE: zone 37 at (3640, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3640, 10104) facing 2 (id 37)
  0.18  RESERVE: zone 38 at (3736, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3736, 10152) facing 2 (id 38)
  0.18  RESERVE: zone 39 at (3688, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3688, 10152) facing 2 (id 39)
  0.18  RESERVE: zone 40 at (3640, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3640, 10152) facing 2 (id 40)
  0.18  RESERVE: zone 41 at (3736, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3736, 10200) facing 2 (id 41)
  0.18  RESERVE: zone 42 at (3688, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3688, 10200) facing 2 (id 42)
  0.18  RESERVE: zone 43 at (3640, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3640, 10200) facing 2 (id 43)
  0.18  RESERVE: zone 44 at (3736, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3736, 10248) facing 2 (id 44)
  0.18  RESERVE: zone 45 at (3688, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3688, 10248) facing 2 (id 45)
  0.18  RESERVE: zone 46 at (3640, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (3640, 10248) facing 2 (id 46)
```
