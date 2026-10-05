# Playtest report: PASS

- Verdict: **PASS** (reached 7 min)
- Game time reached: 7.1 min (frame 12720); wall 100 s
- DLL: build-theatres\d193-build\SkirmishAI.dll (df4b5dd21490b768); AI BARbTest/test; staged 2026-10-04T16:28:43
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: response-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-armada\supreme\20261004T192843Z-061c9c13\runs\20261004T193028Z-5dc7a251\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:42.160153][f=-000001] [AirResponseWatch] loaded case=defense` |
| expect `dispatch` | seen at 1.5 min | `[AIR][BaseResponse] dispatched=29 total=29` |
| expect `production` | seen at 1.6 min | `[AIR][Produce] base.defence armbrawl plant=25549 projected=1/1` |
| expect `bomber_damage` | seen at 1.7 min | `[t=00:01:04.267563][f=0003126] [AirResponseWatch] damage frame=3126 attacker=armpnix victim=armmar amount=335.750946 emp=false` |
| expect `gunship_finished` | seen at 1.7 min | `[t=00:01:03.996524][f=0003050] [AirResponseWatch] finished frame=3050 def=armbrawl id=30049` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-armada\supreme\20261004T192843Z-061c9c13\runs\20261004T193028Z-5dc7a251\screen_2026-10-04_19-29-50-179.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-armada\supreme\20261004T192843Z-061c9c13\runs\20261004T193028Z-5dc7a251\screen_2026-10-04_19-29-53-793.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-armada\supreme\20261004T192843Z-061c9c13\runs\20261004T193028Z-5dc7a251\screen_2026-10-04_19-29-55-674.png

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
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 35
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 35
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
  0.10  [Team][Roster] Team 1 (AI 1): role=FRONT side=armada start=(837,10404) factory=armlab landLocked=no spot=1 known=1/1
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
  0.18  [AIR][Layout] cluster=0 labs=6 at=2131,11672
  0.18  [AIR][EcoLayout] reserved air.eco.0 reactor=1520,11872 converters=8 support=12 zone=134
  0.18  [AIR][Layout] cluster=1 labs=6 at=1651,10808
  0.18  [AIR][State] T2_SUSTAIN
  0.18  [AIR][Share] metal 100003 of 100200 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.19  [Playtest] finished armarad team 0 at 0.19 min
  0.20  [AIR][EcoLayout] reserved air.eco.1 reactor=3056,11616 converters=8 support=12 zone=295
  0.22  [AIR][EcoLayout] reserved air.eco.2 reactor=3184,11104 converters=8 support=12 zone=319
  0.22  [AIR][Waves] opening size drawn=13
  0.22  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.22  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=8; request fresh reconnaissance
  0.23  [AIR][EcoLayout] reserved air.eco.3 reactor=3824,11360 converters=8 support=12 zone=353
  0.27  [AIR][Capacity] own=2/30 usage=0/26 gifts=0 sent=0 excess=0 pressure=false mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] T2_SUSTAIN M=1 bank=100011 E=18 bank=1027375 pull=26 plants=0/1 aircraftDemand=34/1407
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.35  [AIR][Produce] intercept armhawk plant=25549 projected=1/6
  0.38  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.43  [AIR][Capacity] own=2/9065 usage=39/1617 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] T2_SUSTAIN M=2 bank=99923 E=9065 bank=1027375 pull=1617 plants=0/1 aircraftDemand=34/1407
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.45  [AIR][Screen] fighters=1 cells=8 centre=2386,11418 width=600 advance=400 responding=false
  0.45  [AIR][Produce] intercept armhawk plant=25549 projected=2/6
  0.55  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.56  [AIR][Produce] intercept armhawk plant=25549 projected=3/6
  0.60  [AIR][Capacity] own=2/9065 usage=25/1072 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] T2_SUSTAIN M=2 bank=99719 E=9065 bank=1027375 pull=1072 plants=0/1 aircraftDemand=34/1407
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.60  [AIR][Attack] home=2 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  0.62  [AIR][Screen] fighters=2 cells=8 centre=2386,11418 width=600 advance=400 responding=false
  0.66  [AIR][Produce] intercept armhawk plant=25549 projected=4/6
  0.72  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.72  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  0.76  [AIR][Produce] intercept armhawk plant=25549 projected=5/6
  0.77  [AIR][Capacity] own=2/9065 usage=13/556 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] T2_SUSTAIN M=2 bank=99478 E=9065 bank=1027375 pull=556 plants=0/1 aircraftDemand=34/1407
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.80  [AIR][Screen] fighters=4 cells=8 centre=2386,11418 width=600 advance=400 responding=false
  0.86  [AIR][Produce] intercept armhawk plant=25549 projected=6/6
  0.88  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.93  [AIR][Capacity] own=2/9065 usage=37/1564 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] T2_SUSTAIN M=2 bank=99271 E=9065 bank=1027375 pull=1564 plants=0/1 aircraftDemand=34/1407
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  0.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.97  [AIR][Produce] air.control armhawk plant=25549 projected=7/7
  1.00  [AIR][Screen] fighters=6 cells=8 centre=2386,11418 width=600 advance=400 responding=false
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99175/100200, energy +9065.0 bank 1027109/1027375, units 50
  1.02  [AIR][Share] metal 99198 of 100200 (99%): sent 53 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.05  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.05  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99879) (D-106)
  1.07  [AIR][Produce] air.control armhawk plant=25549 projected=8/8
  1.10  [AIR][Capacity] own=2/9065 usage=6/280 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T2_SUSTAIN M=2 bank=99198 E=9065 bank=1027375 pull=280 plants=0/1 aircraftDemand=34/1407
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.10  [AIR][Attack] home=7 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  1.10  [AIR][Share] metal 99198 of 100200 (99%): sent 133 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.13  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99804) (D-106)
  1.17  [AIR][Screen] fighters=7 cells=8 centre=2386,11418 width=600 advance=400 responding=false
  1.18  [AIR][Produce] air.control armhawk plant=25549 projected=9/9
  1.18  [AIR][Share] metal 99199 of 100200 (99%): sent 238 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.22  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.22  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  1.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99725) (D-106)
  1.27  [AIR][Capacity] own=2/9065 usage=39/1617 gifts=36 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T2_SUSTAIN M=18 bank=99198 E=9065 bank=1027375 pull=1617 plants=0/1 aircraftDemand=34/1407
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
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
  1.27  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.27  [AIR][Share] metal 99198 of 100200 (99%): sent 365 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.28  [AIR][Produce] air.control armhawk plant=25549 projected=10/10
  1.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99625) (D-106)
  1.35  [AIR][Screen] fighters=9 cells=8 centre=2765,10886 width=1200 advance=1052 responding=false
  1.35  [AIR][Share] metal 99198 of 100200 (99%): sent 467 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.38  [AIR][Produce] air.control armhawk plant=25549 projected=11/11
  1.38  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99512) (D-106)
  1.43  [AIR][Capacity] own=2/9065 usage=26/1101 gifts=14 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T2_SUSTAIN M=21 bank=99198 E=9065 bank=1027375 pull=1101 plants=0/1 aircraftDemand=34/1407
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.43  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.43  [AIR][Share] metal 99198 of 100200 (99%): sent 556 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99386) (D-106)
  1.48  [AIR][Produce] air.control armhawk plant=25549 projected=12/12
  1.52  [AIR][BaseResponse] contact=true
  1.52  [AIR][BaseResponse] group=0 target=27539
  1.52  [AIR][BaseResponse] group=1 target=27539
  1.52  [AIR][BaseResponse] group=2 target=27539
  1.52  [AIR][BaseResponse] dispatched=29 total=29
  1.52  [AIR][Share] metal 99198 of 100200 (99%): sent 645 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99284) (D-106)
  1.57  [AIR][BaseResponse] dispatched=1 total=30
  1.58  [AIR][Produce] base.defence armbrawl plant=25549 projected=1/1
  1.60  [AIR][Capacity] own=2/9065 usage=0/6 gifts=24 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T2_SUSTAIN M=21 bank=99200 E=9065 bank=1027375 pull=6 plants=0/1 aircraftDemand=34/1407
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.60  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [AIR][Share] metal 99198 of 100200 (99%): sent 754 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99164) (D-106)
  1.68  [AIR][Share] metal 99198 of 100200 (99%): sent 991 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.70  [AIR][BaseResponse] dispatched=1 total=30
  1.72  [AIR][Produce] base.defence armbrawl plant=25549 projected=2/2
  1.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 98978) (D-106)
  1.77  [AIR][Capacity] own=2/9060 usage=30/605 gifts=10 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T2_SUSTAIN M=24 bank=99198 E=9063 bank=1027350 pull=605 plants=0/1 aircraftDemand=34/1407
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.77  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.78  [AIR][BaseResponse] group=0 target=3272
  1.78  [AIR][BaseResponse] group=1 target=3272
  1.78  [AIR][BaseResponse] group=2 target=3272
  1.86  [AIR][Produce] base.defence armbrawl plant=25549 projected=3/3
  1.87  [AIR][BaseResponse] group=0 target=7477
  1.87  [AIR][BaseResponse] group=1 target=7477
  1.87  [AIR][BaseResponse] group=2 target=7477
  1.90  [AIR][BaseResponse] group=0 target=9037
  1.90  [AIR][BaseResponse] group=1 target=9037
  1.90  [AIR][BaseResponse] group=2 target=9037
  1.93  [AIR][Capacity] own=2/9060 usage=54/1084 gifts=34 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T2_SUSTAIN M=21 bank=99198 E=9060 bank=1027350 pull=1084 plants=0/1 aircraftDemand=34/1407
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  1.93  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.97  [AIR][BaseResponse] group=0 target=25820
  1.97  [AIR][BaseResponse] group=1 target=25820
  1.97  [AIR][BaseResponse] group=2 target=25820
  1.98  [AIR][BaseResponse] dispatched=1 total=26
  2.00  [AIR][BaseResponse] group=0 target=17218
  2.00  [AIR][BaseResponse] group=1 target=17218
  2.00  [AIR][BaseResponse] group=2 target=17218
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 99070/100200, energy +9060.0 bank 1027350/1027350, units 47
  2.00  [AIR][Produce] base.defence armbrawl plant=25549 projected=4/4
  2.03  [AIR][BaseResponse] contact=false
  2.03  [AIR][BaseResponse] group=0 target=-1
  2.03  [AIR][BaseResponse] group=1 target=-1
  2.03  [AIR][BaseResponse] group=2 target=-1
  2.10  [AIR][Capacity] own=2/9060 usage=54/1094 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=2 bank=98856 E=9060 bank=1027350 pull=1094 plants=0/1 aircraftDemand=34/1407
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.10  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.13  [AIR][Produce] intercept armhawk plant=25549 projected=7/12
  2.22  [AIR][Screen] fighters=1 cells=8 centre=2386,11418 width=600 advance=400 responding=false
  2.24  [AIR][Produce] intercept armhawk plant=25549 projected=8/12
  2.27  [AIR][Capacity] own=2/9060 usage=17/724 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=2 bank=98618 E=9060 bank=1027350 pull=724 plants=0/1 aircraftDemand=34/1407
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.27  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.33  [AIR][Produce] intercept armhawk plant=25549 projected=9/12
  2.38  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.38  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=4; request fresh reconnaissance
  2.39  [AIR][Screen] fighters=7 cells=8 centre=2386,11418 width=600 advance=400 responding=false
  2.43  [AIR][Capacity] own=2/9060 usage=37/1527 gifts=0 sent=0 excess=0 pressure=true mobile=340 arriving=0 idle=340 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=2 bank=98359 E=9060 bank=1027350 pull=1527 plants=0/1 aircraftDemand=34/1407
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=340 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
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
  2.43  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.44  [AIR][Produce] air.control armhawk plant=25549 projected=10/10
  2.54  [AIR][Produce] air.control armhawk plant=25549 projected=11/11
... 625 more
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (2056, 11280) facing 2, 9x6 cells: 54 of 54 held
  0.18  RESERVE: armap at (2056, 11280) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (2104, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2104, 11352) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (2056, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2056, 11352) facing 2 (id 3)
  0.18  RESERVE: zone 4 at (2008, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2008, 11352) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (2104, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2104, 11400) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (2056, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2056, 11400) facing 2 (id 6)
  0.18  RESERVE: zone 7 at (1912, 11256) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: armaap at (1912, 11256) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (1960, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1960, 11352) facing 2 (id 8)
  0.18  RESERVE: zone 9 at (1912, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1912, 11352) facing 2 (id 9)
  0.18  RESERVE: zone 10 at (1864, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1864, 11352) facing 2 (id 10)
  0.18  RESERVE: zone 11 at (1960, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1960, 11400) facing 2 (id 11)
  0.18  RESERVE: zone 12 at (1912, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1912, 11400) facing 2 (id 12)
  0.18  RESERVE: zone 13 at (1864, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1864, 11400) facing 2 (id 13)
  0.18  RESERVE: zone 14 at (1960, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1960, 11448) facing 2 (id 14)
  0.18  RESERVE: zone 15 at (1912, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1912, 11448) facing 2 (id 15)
  0.18  RESERVE: zone 16 at (1864, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1864, 11448) facing 2 (id 16)
  0.18  RESERVE: zone 17 at (1960, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1960, 11496) facing 2 (id 17)
  0.18  RESERVE: zone 18 at (1912, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1912, 11496) facing 2 (id 18)
  0.18  RESERVE: zone 19 at (1864, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1864, 11496) facing 2 (id 19)
  0.18  RESERVE: zone 20 at (1960, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1960, 11544) facing 2 (id 20)
  0.18  RESERVE: zone 21 at (1912, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1912, 11544) facing 2 (id 21)
  0.18  RESERVE: zone 22 at (1864, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1864, 11544) facing 2 (id 22)
  0.18  RESERVE: zone 23 at (1960, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1960, 11592) facing 2 (id 23)
  0.18  RESERVE: zone 24 at (1912, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1912, 11592) facing 2 (id 24)
  0.18  RESERVE: zone 25 at (1864, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1864, 11592) facing 2 (id 25)
  0.18  RESERVE: zone 26 at (1960, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1960, 11640) facing 2 (id 26)
  0.18  RESERVE: zone 27 at (1912, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1912, 11640) facing 2 (id 27)
  0.18  RESERVE: zone 28 at (1768, 11256) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: armaap at (1768, 11256) facing 2 (id 28)
  0.18  RESERVE: zone 29 at (1816, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1816, 11352) facing 2 (id 29)
  0.18  RESERVE: zone 30 at (1768, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1768, 11352) facing 2 (id 30)
  0.18  RESERVE: zone 31 at (1720, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1720, 11352) facing 2 (id 31)
  0.18  RESERVE: zone 32 at (1816, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1816, 11400) facing 2 (id 32)
  0.18  RESERVE: zone 33 at (1768, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1768, 11400) facing 2 (id 33)
  0.18  RESERVE: zone 34 at (1720, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1720, 11400) facing 2 (id 34)
  0.18  RESERVE: zone 35 at (1816, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1816, 11448) facing 2 (id 35)
  0.18  RESERVE: zone 36 at (1768, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1768, 11448) facing 2 (id 36)
  0.18  RESERVE: zone 37 at (1720, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1720, 11448) facing 2 (id 37)
  0.18  RESERVE: zone 38 at (1816, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1816, 11496) facing 2 (id 38)
  0.18  RESERVE: zone 39 at (1768, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1768, 11496) facing 2 (id 39)
  0.18  RESERVE: zone 40 at (1720, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1720, 11496) facing 2 (id 40)
  0.18  RESERVE: zone 41 at (1816, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1816, 11544) facing 2 (id 41)
  0.18  RESERVE: zone 42 at (1768, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1768, 11544) facing 2 (id 42)
  0.18  RESERVE: zone 43 at (1720, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1720, 11544) facing 2 (id 43)
  0.18  RESERVE: zone 44 at (1816, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1816, 11592) facing 2 (id 44)
  0.18  RESERVE: zone 45 at (1768, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1768, 11592) facing 2 (id 45)
  0.18  RESERVE: zone 46 at (1720, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1720, 11592) facing 2 (id 46)
  0.18  RESERVE: zone 47 at (1816, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1816, 11640) facing 2 (id 47)
  0.18  RESERVE: zone 48 at (1768, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1768, 11640) facing 2 (id 48)
  0.18  RESERVE: zone 49 at (2056, 10776) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: armaap at (2056, 10776) facing 2 (id 49)
  0.18  RESERVE: zone 50 at (2104, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2104, 10872) facing 2 (id 50)
  0.18  RESERVE: zone 51 at (2056, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2056, 10872) facing 2 (id 51)
  0.18  RESERVE: zone 52 at (2008, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2008, 10872) facing 2 (id 52)
  0.18  RESERVE: zone 53 at (2104, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2104, 10920) facing 2 (id 53)
  0.18  RESERVE: zone 54 at (2056, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2056, 10920) facing 2 (id 54)
  0.18  RESERVE: zone 55 at (2008, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2008, 10920) facing 2 (id 55)
  0.18  RESERVE: zone 56 at (2104, 10968) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2104, 10968) facing 2 (id 56)
  0.18  RESERVE: zone 57 at (2056, 10968) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2056, 10968) facing 2 (id 57)
  0.18  RESERVE: zone 58 at (2008, 10968) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2008, 10968) facing 2 (id 58)
  0.18  RESERVE: zone 59 at (2104, 11016) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2104, 11016) facing 2 (id 59)
  0.18  RESERVE: zone 60 at (2056, 11016) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (2056, 11016) facing 2 (id 60)
```
