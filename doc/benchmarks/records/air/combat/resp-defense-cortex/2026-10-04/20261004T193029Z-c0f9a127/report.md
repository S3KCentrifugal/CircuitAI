# Playtest report: PASS

- Verdict: **PASS** (reached 7 min)
- Game time reached: 7.0 min (frame 12600); wall 101 s
- DLL: build-theatres\d193-build\SkirmishAI.dll (df4b5dd21490b768); AI BARbTest/test; staged 2026-10-04T16:28:43
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: response-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-cortex\supreme\20261004T192843Z-670861e3\runs\20261004T193029Z-c0f9a127\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:43.512256][f=-000001] [AirResponseWatch] loaded case=defense` |
| expect `dispatch` | seen at 1.5 min | `[AIR][BaseResponse] dispatched=29 total=29` |
| expect `production` | seen at 1.5 min | `[AIR][Produce] base.defence corape plant=19074 projected=1/1` |
| expect `bomber_damage` | seen at 1.7 min | `[t=00:01:05.733501][f=0003148] [AirResponseWatch] damage frame=3148 attacker=corhurc victim=armmar amount=459.520477 emp=false` |
| expect `gunship_finished` | seen at 1.7 min | `[t=00:01:05.150276][f=0002985] [AirResponseWatch] finished frame=2985 def=corape id=9037` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-cortex\supreme\20261004T192843Z-670861e3\runs\20261004T193029Z-c0f9a127\screen_2026-10-04_19-29-51-251.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-cortex\supreme\20261004T192843Z-670861e3\runs\20261004T193029Z-c0f9a127\screen_2026-10-04_19-29-55-272.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-cortex\supreme\20261004T192843Z-670861e3\runs\20261004T193029Z-c0f9a127\screen_2026-10-04_19-29-56-932.png

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
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 34
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 34
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
  0.10  [Team][Roster] Team 1 (AI 1): role=FRONT side=armada start=(837,10404) factory=armlab landLocked=no spot=1 known=1/1
  0.17  [Playtest] finished coraap team 0 at 0.17 min
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
  0.18  [AIR][Layout] cluster=0 labs=6 at=2130,11676
  0.18  [AIR][EcoLayout] reserved air.eco.0 reactor=1520,11888 converters=8 support=12 zone=134
  0.18  [AIR][Layout] cluster=1 labs=6 at=1650,10812
  0.18  [AIR][State] T2_SUSTAIN
  0.18  [AIR][Share] metal 100003 of 100200 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.19  [Playtest] finished armarad team 0 at 0.19 min
  0.20  [AIR][EcoLayout] reserved air.eco.1 reactor=3056,11632 converters=8 support=12 zone=295
  0.22  [AIR][EcoLayout] reserved air.eco.2 reactor=3696,11120 converters=8 support=12 zone=317
  0.22  [AIR][Waves] opening size drawn=13
  0.22  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.22  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=6; request fresh reconnaissance
  0.23  [AIR][EcoLayout] reserved air.eco.3 reactor=3184,11120 converters=8 support=12 zone=339
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
  0.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.27  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.36  [AIR][Produce] intercept corvamp plant=19074 projected=1/6
  0.38  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.43  [AIR][Capacity] own=2/9065 usage=41/1483 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] T2_SUSTAIN M=2 bank=99921 E=9065 bank=1027375 pull=1483 plants=0/1 aircraftDemand=36/1275
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  0.43  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.44  [AIR][Screen] fighters=1 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  0.46  [AIR][Produce] intercept corvamp plant=19074 projected=2/6
  0.55  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.56  [AIR][Produce] intercept corvamp plant=19074 projected=3/6
  0.60  [AIR][Capacity] own=2/9065 usage=8/317 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] T2_SUSTAIN M=2 bank=99748 E=9065 bank=1027375 pull=317 plants=0/1 aircraftDemand=36/1275
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  0.60  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.60  [AIR][Attack] home=2 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  0.62  [AIR][Screen] fighters=2 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  0.67  [AIR][Produce] intercept corvamp plant=19074 projected=4/6
  0.72  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.72  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  0.77  [AIR][Capacity] own=2/9065 usage=41/1483 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] T2_SUSTAIN M=2 bank=99494 E=9065 bank=1027375 pull=1483 plants=0/1 aircraftDemand=36/1275
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  0.77  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.78  [AIR][Produce] intercept corvamp plant=19074 projected=5/6
  0.80  [AIR][Screen] fighters=4 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  0.88  [AIR][Produce] intercept corvamp plant=19074 projected=6/6
  0.88  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.93  [AIR][Capacity] own=2/9065 usage=16/621 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] T2_SUSTAIN M=2 bank=99328 E=9071 bank=1027375 pull=621 plants=0/1 aircraftDemand=36/1275
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  0.93  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.98  [AIR][Screen] fighters=6 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  0.99  [AIR][Produce] air.control corvamp plant=19074 projected=7/7
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99214/100200, energy +9065.0 bank 1027225/1027375, units 50
  1.05  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.09  [AIR][Produce] air.control corvamp plant=19074 projected=8/8
  1.10  [AIR][Capacity] own=2/9065 usage=3/139 gifts=39 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T2_SUSTAIN M=2 bank=99198 E=9065 bank=1027375 pull=139 plants=0/1 aircraftDemand=36/1275
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  1.10  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.10  [AIR][Attack] home=7 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  1.10  [AIR][Share] metal 99198 of 100200 (99%): sent 101 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.13  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99870) (D-106)
  1.15  [AIR][Screen] fighters=7 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  1.18  [AIR][Share] metal 99198 of 100200 (99%): sent 226 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.21  [AIR][Produce] air.control corvamp plant=19074 projected=9/9
  1.22  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.22  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  1.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99775) (D-106)
  1.27  [AIR][Capacity] own=2/9065 usage=30/1081 gifts=10 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T2_SUSTAIN M=16 bank=99198 E=9065 bank=1027375 pull=1081 plants=0/1 aircraftDemand=36/1275
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  1.27  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.27  [AIR][Share] metal 99198 of 100200 (99%): sent 296 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99655) (D-106)
  1.32  [AIR][Produce] air.control corvamp plant=19074 projected=10/10
  1.35  [AIR][Screen] fighters=9 cells=8 centre=2764,10890 width=1200 advance=1053 responding=false
  1.35  [AIR][Share] metal 99198 of 100200 (99%): sent 369 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.38  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99555) (D-106)
  1.42  [AIR][Produce] air.control corvamp plant=19074 projected=11/11
  1.43  [AIR][Capacity] own=2/9065 usage=0/26 gifts=25 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T2_SUSTAIN M=15 bank=99200 E=9065 bank=1027375 pull=26 plants=0/1 aircraftDemand=36/1275
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
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
  1.43  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.43  [AIR][Share] metal 99198 of 100200 (99%): sent 466 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99483) (D-106)
  1.52  [AIR][BaseResponse] contact=true
  1.52  [AIR][BaseResponse] group=0 target=16267
  1.52  [AIR][BaseResponse] group=1 target=16267
  1.52  [AIR][BaseResponse] group=2 target=16267
  1.52  [AIR][BaseResponse] dispatched=29 total=29
  1.52  [AIR][Share] metal 99200 of 100200 (99%): sent 588 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.53  [AIR][Produce] base.defence corape plant=19074 projected=1/1
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99409) (D-106)
  1.60  [AIR][Capacity] own=2/9065 usage=53/993 gifts=25 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T2_SUSTAIN M=15 bank=99198 E=9065 bank=1027375 pull=993 plants=0/1 aircraftDemand=36/1275
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
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
  1.60  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [AIR][Share] metal 99198 of 100200 (99%): sent 723 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99158) (D-106)
  1.67  [AIR][BaseResponse] dispatched=1 total=30
  1.68  [AIR][Produce] base.defence corape plant=19074 projected=2/2
  1.68  [AIR][Share] metal 99200 of 100200 (99%): sent 926 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99000) (D-106)
  1.77  [AIR][Capacity] own=2/9065 usage=61/1133 gifts=2 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T2_SUSTAIN M=18 bank=99198 E=9065 bank=1027375 pull=1133 plants=0/1 aircraftDemand=36/1275
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
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
  1.77  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.78  [AIR][BaseResponse] group=0 target=18267
  1.78  [AIR][BaseResponse] group=1 target=18267
  1.78  [AIR][BaseResponse] group=2 target=18267
  1.80  [AIR][BaseResponse] dispatched=1 total=28
  1.82  [AIR][Produce] base.defence corape plant=19074 projected=3/3
  1.87  [AIR][BaseResponse] group=0 target=27539
  1.87  [AIR][BaseResponse] group=1 target=27539
  1.87  [AIR][BaseResponse] group=2 target=27539
  1.90  [AIR][BaseResponse] contact=false
  1.90  [AIR][BaseResponse] group=0 target=-1
  1.90  [AIR][BaseResponse] group=1 target=-1
  1.90  [AIR][BaseResponse] group=2 target=-1
  1.93  [AIR][Capacity] own=2/9060 usage=61/1133 gifts=61 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T2_SUSTAIN M=23 bank=99159 E=9060 bank=1027350 pull=1133 plants=0/1 aircraftDemand=36/1275
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
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
  1.93  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.97  [AIR][Produce] intercept corvamp plant=19074 projected=7/12
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 99021/100200, energy +9060.0 bank 1027135/1027350, units 47
  2.06  [AIR][Screen] fighters=1 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  2.07  [AIR][Produce] intercept corvamp plant=19074 projected=7/11
  2.10  [AIR][Capacity] own=2/9060 usage=15/534 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=2 bank=98904 E=9060 bank=1027350 pull=534 plants=0/1 aircraftDemand=36/1275
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  2.10  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.17  [AIR][Produce] intercept corvamp plant=19074 projected=8/11
  2.23  [AIR][Screen] fighters=2 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  2.25  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.25  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=6; request fresh reconnaissance
  2.27  [AIR][Capacity] own=2/9060 usage=33/1162 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=2 bank=98646 E=9067 bank=1027350 pull=1162 plants=0/1 aircraftDemand=36/1275
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  2.27  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.27  [AIR][Produce] air.control corvamp plant=19074 projected=9/9
  2.38  [AIR][Produce] air.control corvamp plant=19074 projected=10/10
  2.42  [AIR][Screen] fighters=9 cells=8 centre=2764,10890 width=1200 advance=1053 responding=false
  2.42  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.43  [AIR][Capacity] own=2/9060 usage=24/874 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=2 bank=98479 E=9060 bank=1027350 pull=874 plants=0/1 aircraftDemand=36/1275
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  2.43  [AIR][Bay] 12 plant=19074 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.48  [AIR][Produce] air.control corvamp plant=19074 projected=11/11
  2.58  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.59  [AIR][Produce] air.control corvamp plant=19074 projected=12/12
  2.60  [AIR][Capacity] own=2/9060 usage=4/158 gifts=0 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=2 bank=98247 E=9060 bank=1027350 pull=158 plants=0/1 aircraftDemand=36/1275
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
... 608 more
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (2056, 11296) facing 2, 9x6 cells: 54 of 54 held
  0.18  RESERVE: corap at (2056, 11296) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (2104, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2104, 11368) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (2056, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2056, 11368) facing 2 (id 3)
  0.18  RESERVE: zone 4 at (2008, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2008, 11368) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (2104, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2104, 11416) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (2056, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2056, 11416) facing 2 (id 6)
  0.18  RESERVE: zone 7 at (1912, 11272) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: coraap at (1912, 11272) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (1960, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1960, 11368) facing 2 (id 8)
  0.18  RESERVE: zone 9 at (1912, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1912, 11368) facing 2 (id 9)
  0.18  RESERVE: zone 10 at (1864, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1864, 11368) facing 2 (id 10)
  0.18  RESERVE: zone 11 at (1960, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1960, 11416) facing 2 (id 11)
  0.18  RESERVE: zone 12 at (1912, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1912, 11416) facing 2 (id 12)
  0.18  RESERVE: zone 13 at (1864, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1864, 11416) facing 2 (id 13)
  0.18  RESERVE: zone 14 at (1960, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1960, 11464) facing 2 (id 14)
  0.18  RESERVE: zone 15 at (1912, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1912, 11464) facing 2 (id 15)
  0.18  RESERVE: zone 16 at (1864, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1864, 11464) facing 2 (id 16)
  0.18  RESERVE: zone 17 at (1960, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1960, 11512) facing 2 (id 17)
  0.18  RESERVE: zone 18 at (1912, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1912, 11512) facing 2 (id 18)
  0.18  RESERVE: zone 19 at (1864, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1864, 11512) facing 2 (id 19)
  0.18  RESERVE: zone 20 at (1960, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1960, 11560) facing 2 (id 20)
  0.18  RESERVE: zone 21 at (1912, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1912, 11560) facing 2 (id 21)
  0.18  RESERVE: zone 22 at (1864, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1864, 11560) facing 2 (id 22)
  0.18  RESERVE: zone 23 at (1960, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1960, 11608) facing 2 (id 23)
  0.18  RESERVE: zone 24 at (1912, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1912, 11608) facing 2 (id 24)
  0.18  RESERVE: zone 25 at (1864, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1864, 11608) facing 2 (id 25)
  0.18  RESERVE: zone 26 at (1960, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1960, 11656) facing 2 (id 26)
  0.18  RESERVE: zone 27 at (1912, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1912, 11656) facing 2 (id 27)
  0.18  RESERVE: zone 28 at (1768, 11272) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: coraap at (1768, 11272) facing 2 (id 28)
  0.18  RESERVE: zone 29 at (1816, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1816, 11368) facing 2 (id 29)
  0.18  RESERVE: zone 30 at (1768, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1768, 11368) facing 2 (id 30)
  0.18  RESERVE: zone 31 at (1720, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1720, 11368) facing 2 (id 31)
  0.18  RESERVE: zone 32 at (1816, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1816, 11416) facing 2 (id 32)
  0.18  RESERVE: zone 33 at (1768, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1768, 11416) facing 2 (id 33)
  0.18  RESERVE: zone 34 at (1720, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1720, 11416) facing 2 (id 34)
  0.18  RESERVE: zone 35 at (1816, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1816, 11464) facing 2 (id 35)
  0.18  RESERVE: zone 36 at (1768, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1768, 11464) facing 2 (id 36)
  0.18  RESERVE: zone 37 at (1720, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1720, 11464) facing 2 (id 37)
  0.18  RESERVE: zone 38 at (1816, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1816, 11512) facing 2 (id 38)
  0.18  RESERVE: zone 39 at (1768, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1768, 11512) facing 2 (id 39)
  0.18  RESERVE: zone 40 at (1720, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1720, 11512) facing 2 (id 40)
  0.18  RESERVE: zone 41 at (1816, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1816, 11560) facing 2 (id 41)
  0.18  RESERVE: zone 42 at (1768, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1768, 11560) facing 2 (id 42)
  0.18  RESERVE: zone 43 at (1720, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1720, 11560) facing 2 (id 43)
  0.18  RESERVE: zone 44 at (1816, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1816, 11608) facing 2 (id 44)
  0.18  RESERVE: zone 45 at (1768, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1768, 11608) facing 2 (id 45)
  0.18  RESERVE: zone 46 at (1720, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1720, 11608) facing 2 (id 46)
  0.18  RESERVE: zone 47 at (1816, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1816, 11656) facing 2 (id 47)
  0.18  RESERVE: zone 48 at (1768, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (1768, 11656) facing 2 (id 48)
  0.18  RESERVE: zone 49 at (2056, 10792) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: coraap at (2056, 10792) facing 2 (id 49)
  0.18  RESERVE: zone 50 at (2104, 10888) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2104, 10888) facing 2 (id 50)
  0.18  RESERVE: zone 51 at (2056, 10888) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2056, 10888) facing 2 (id 51)
  0.18  RESERVE: zone 52 at (2008, 10888) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2008, 10888) facing 2 (id 52)
  0.18  RESERVE: zone 53 at (2104, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2104, 10936) facing 2 (id 53)
  0.18  RESERVE: zone 54 at (2056, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2056, 10936) facing 2 (id 54)
  0.18  RESERVE: zone 55 at (2008, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2008, 10936) facing 2 (id 55)
  0.18  RESERVE: zone 56 at (2104, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2104, 10984) facing 2 (id 56)
  0.18  RESERVE: zone 57 at (2056, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2056, 10984) facing 2 (id 57)
  0.18  RESERVE: zone 58 at (2008, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2008, 10984) facing 2 (id 58)
  0.18  RESERVE: zone 59 at (2104, 11032) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2104, 11032) facing 2 (id 59)
  0.18  RESERVE: zone 60 at (2056, 11032) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: cornanotc at (2056, 11032) facing 2 (id 60)
```
