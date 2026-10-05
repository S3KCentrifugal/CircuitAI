# Playtest report: PASS

- Verdict: **PASS** (reached 7 min)
- Game time reached: 7.1 min (frame 12782); wall 100 s
- DLL: build-theatres\d193-build\SkirmishAI.dll (df4b5dd21490b768); AI BARbTest/test; staged 2026-10-04T16:28:43
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: response-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-legion\supreme\20261004T192843Z-14cf2d4a\runs\20261004T193027Z-e79c5014\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:41.887198][f=-000001] [AirResponseWatch] loaded case=defense` |
| expect `dispatch` | seen at 1.5 min | `[AIR][BaseResponse] dispatched=32 total=32` |
| expect `production` | seen at 1.5 min | `[AIR][Produce] base.defence legstronghold plant=25549 projected=1/1` |
| expect `bomber_damage` | seen at 1.6 min | `[t=00:01:02.868195][f=0002962] [AirResponseWatch] damage frame=2962 attacker=legphoenix victim=armmar amount=28.3126411 emp=false` |
| expect `gunship_finished` | seen at 1.7 min | `[t=00:01:04.136782][f=0003034] [AirResponseWatch] finished frame=3034 def=legstronghold id=20480` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-legion\supreme\20261004T192843Z-14cf2d4a\runs\20261004T193027Z-e79c5014\screen_2026-10-04_19-29-49-416.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-legion\supreme\20261004T192843Z-14cf2d4a\runs\20261004T193027Z-e79c5014\screen_2026-10-04_19-29-52-399.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-legion\supreme\20261004T192843Z-14cf2d4a\runs\20261004T193027Z-e79c5014\screen_2026-10-04_19-30-05-907.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 10, 0 shots, end at 7.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 35
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 35
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order legap
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=100000 E=0 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 18 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|legion|legap|2155|11747|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=FRONT side=armada start=(837,10404) factory=armvp landLocked=no spot=1 known=1/1
  0.17  [Playtest] finished legaap team 0 at 0.17 min
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
  0.18  [AIR][Layout] cluster=0 labs=6 at=2131,11675
  0.18  [AIR][EcoLayout] reserved air.eco.0 reactor=1520,11872 converters=8 support=12 zone=134
  0.18  [AIR][Layout] cluster=1 labs=6 at=1651,10811
  0.18  [AIR][State] T2_SUSTAIN
  0.18  [AIR][Share] metal 100003 of 100200 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.19  [Playtest] finished armarad team 0 at 0.19 min
  0.20  [AIR][EcoLayout] reserved air.eco.1 reactor=3056,11616 converters=8 support=12 zone=295
  0.22  [AIR][EcoLayout] reserved air.eco.2 reactor=3184,11104 converters=8 support=12 zone=319
  0.22  [AIR][Waves] opening size drawn=19
  0.22  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.22  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=6; request fresh reconnaissance
  0.23  [AIR][EcoLayout] reserved air.eco.3 reactor=3824,11360 converters=8 support=12 zone=353
  0.27  [AIR][Capacity] own=2/30 usage=0/26 gifts=0 sent=0 excess=0 pressure=false mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] T2_SUSTAIN M=1 bank=100011 E=18 bank=1027375 pull=26 plants=0/1 aircraftDemand=29/854
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
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
  0.27  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.35  [AIR][Produce] intercept legvenator plant=25549 projected=1/6
  0.38  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.43  [AIR][Capacity] own=2/9065 usage=33/1012 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] T2_SUSTAIN M=2 bank=99935 E=9065 bank=1027375 pull=1012 plants=0/1 aircraftDemand=29/854
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
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
  0.43  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.44  [AIR][Produce] intercept legvenator plant=25549 projected=2/7
  0.44  [AIR][Screen] fighters=1 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  0.53  [AIR][Produce] intercept legvenator plant=25549 projected=3/6
  0.55  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.60  [AIR][Capacity] own=2/9065 usage=33/1012 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] T2_SUSTAIN M=2 bank=99738 E=9067 bank=1027375 pull=1012 plants=0/1 aircraftDemand=29/854
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
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
  0.60  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.60  [AIR][Attack] home=2 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  0.61  [AIR][Screen] fighters=3 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  0.62  [AIR][Produce] intercept legvenator plant=25549 projected=4/6
  0.70  [AIR][Produce] intercept legvenator plant=25549 projected=5/7
  0.72  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.72  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  0.77  [AIR][Capacity] own=2/9065 usage=32/968 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] T2_SUSTAIN M=2 bank=99545 E=9065 bank=1027375 pull=968 plants=0/1 aircraftDemand=29/854
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
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
  0.77  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.78  [AIR][Produce] intercept legvenator plant=25549 projected=6/7
  0.78  [AIR][Screen] fighters=5 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  0.86  [AIR][Produce] air.control legvenator plant=25549 projected=7/7
  0.88  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.93  [AIR][Capacity] own=2/9065 usage=33/1012 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] T2_SUSTAIN M=2 bank=99336 E=9065 bank=1027375 pull=1012 plants=0/1 aircraftDemand=29/854
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
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
  0.93  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.95  [AIR][Produce] air.control legvenator plant=25549 projected=8/8
  0.95  [AIR][Screen] fighters=7 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99225/100200, energy +9065.0 bank 1027165/1027375, units 51
  1.03  [AIR][Produce] air.control legvenator plant=25549 projected=9/9
  1.05  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.10  [AIR][Capacity] own=2/9065 usage=33/997 gifts=19 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T2_SUSTAIN M=2 bank=99198 E=9065 bank=1027375 pull=997 plants=0/1 aircraftDemand=29/854
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
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
  1.10  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.10  [AIR][Attack] home=8 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  1.10  [AIR][Share] metal 99198 of 100200 (99%): sent 86 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.12  [AIR][Produce] air.control legvenator plant=25549 projected=10/10
  1.12  [AIR][Screen] fighters=9 cells=8 centre=2765,10889 width=1200 advance=1052 responding=false
  1.13  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99895) (D-106)
  1.18  [AIR][Share] metal 99198 of 100200 (99%): sent 187 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.21  [AIR][Produce] air.control legvenator plant=25549 projected=11/11
  1.22  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.22  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  1.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99812) (D-106)
  1.27  [AIR][Capacity] own=2/9065 usage=31/949 gifts=15 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T2_SUSTAIN M=14 bank=99198 E=9065 bank=1027375 pull=949 plants=0/1 aircraftDemand=29/854
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
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
  1.27  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.27  [AIR][Share] metal 99198 of 100200 (99%): sent 260 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.29  [AIR][Produce] air.control legvenator plant=25549 projected=12/12
  1.29  [AIR][Screen] fighters=11 cells=8 centre=2765,10889 width=1200 advance=1052 responding=false
  1.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99718) (D-106)
  1.35  [AIR][Share] metal 99198 of 100200 (99%): sent 365 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.37  [AIR][Produce] air.control legvenator plant=25549 projected=13/13
  1.38  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99615) (D-106)
  1.43  [AIR][Capacity] own=2/9065 usage=33/1012 gifts=26 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T2_SUSTAIN M=18 bank=99198 E=9065 bank=1027375 pull=1012 plants=0/1 aircraftDemand=29/854
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
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
  1.43  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.43  [AIR][Share] metal 99198 of 100200 (99%): sent 466 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.44  [AIR][Produce] air.control legvenator plant=25549 projected=14/14
  1.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99513) (D-106)
  1.48  [AIR][Screen] fighters=13 cells=8 centre=3144,10357 width=1800 advance=1705 responding=false
  1.52  [AIR][BaseResponse] contact=true
  1.52  [AIR][BaseResponse] group=0 target=4759
  1.52  [AIR][BaseResponse] group=1 target=4759
  1.52  [AIR][BaseResponse] group=2 target=4759
  1.52  [AIR][BaseResponse] dispatched=32 total=32
  1.52  [AIR][Share] metal 99198 of 100200 (99%): sent 559 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.53  [AIR][Produce] base.defence legstronghold plant=25549 projected=1/1
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99424) (D-106)
  1.60  [AIR][Capacity] own=2/9065 usage=66/1585 gifts=39 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T2_SUSTAIN M=21 bank=99198 E=9065 bank=1027375 pull=1585 plants=0/1 aircraftDemand=29/854
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
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
  1.60  [AIR][Share] metal 99198 of 100200 (99%): sent 737 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99136) (D-106)
  1.68  [AIR][Share] metal 99145 of 100200 (98%): sent 1000 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.70  [AIR][Produce] base.defence legstronghold plant=25549 projected=2/2
  1.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 98932) (D-106)
  1.73  [AIR][BaseResponse] group=0 target=8278
  1.73  [AIR][BaseResponse] group=1 target=8278
  1.73  [AIR][BaseResponse] group=2 target=8278
  1.77  [AIR][Capacity] own=2/9060 usage=49/1171 gifts=26 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T2_SUSTAIN M=30 bank=99198 E=9062 bank=1027350 pull=1171 plants=0/1 aircraftDemand=29/854
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
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
  1.77  [AIR][BaseResponse] group=0 target=13725
  1.77  [AIR][BaseResponse] group=1 target=13725
  1.77  [AIR][BaseResponse] group=2 target=13725
  1.78  [AIR][BaseResponse] group=0 target=25820
  1.78  [AIR][BaseResponse] group=1 target=25820
  1.78  [AIR][BaseResponse] group=2 target=25820
  1.80  [AIR][BaseResponse] contact=false
  1.80  [AIR][BaseResponse] group=0 target=-1
  1.80  [AIR][BaseResponse] group=1 target=-1
  1.80  [AIR][BaseResponse] group=2 target=-1
  1.87  [AIR][Produce] intercept legvenator plant=25549 projected=10/15
  1.93  [AIR][Capacity] own=2/9060 usage=33/984 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T2_SUSTAIN M=21 bank=99049 E=9060 bank=1027350 pull=984 plants=0/1 aircraftDemand=29/854
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
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
  1.93  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.95  [AIR][Screen] fighters=1 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  1.96  [AIR][Produce] intercept legvenator plant=25549 projected=11/15
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 98991/100200, energy +9060.0 bank 1027214/1027350, units 52
  2.06  [AIR][Produce] intercept legvenator plant=25549 projected=12/15
  2.10  [AIR][Capacity] own=2/9060 usage=12/366 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=2 bank=98900 E=9060 bank=1027350 pull=366 plants=0/1 aircraftDemand=29/854
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
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
  2.10  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.10  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.13  [AIR][Screen] fighters=3 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  2.15  [AIR][Produce] air.control legvenator plant=25549 projected=13/13
  2.15  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.15  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=5; request fresh reconnaissance
  2.24  [AIR][Produce] air.control legvenator plant=25549 projected=14/14
  2.27  [AIR][Capacity] own=2/9060 usage=7/212 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=2 bank=98700 E=9060 bank=1027350 pull=212 plants=0/1 aircraftDemand=29/854
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
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
  2.27  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.30  [AIR][Screen] fighters=13 cells=8 centre=3144,10357 width=1800 advance=1705 responding=false
  2.32  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.32  [AIR][Produce] air.control legvenator plant=25549 projected=15/15
  2.40  [AIR][Produce] air.control legvenator plant=25549 projected=16/16
  2.43  [AIR][Capacity] own=2/9060 usage=18/526 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=2 bank=98483 E=9060 bank=1027350 pull=526 plants=0/1 aircraftDemand=29/854
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
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
  2.43  [AIR][Bay] 12 plant=25549 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.48  [AIR][Screen] fighters=16 cells=8 centre=3522,9825 width=2400 advance=2358 responding=false
  2.48  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.49  [AIR][Produce] air.control legvenator plant=25549 projected=17/17
  2.57  [AIR][Produce] air.control legvenator plant=25549 projected=18/18
  2.60  [AIR][Capacity] own=2/9060 usage=10/293 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=2 bank=98285 E=9060 bank=1027350 pull=293 plants=0/1 aircraftDemand=29/854
... 650 more
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (2048, 11280) facing 2, 6x6 cells: 36 of 36 held
  0.18  RESERVE: legap at (2048, 11280) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (2104, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2104, 11352) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (2056, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2056, 11352) facing 2 (id 3)
  0.18  RESERVE: zone 4 at (2008, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2008, 11352) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (2104, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2104, 11400) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (2056, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2056, 11400) facing 2 (id 6)
  0.18  RESERVE: zone 7 at (1912, 11256) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: legaap at (1912, 11256) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (1960, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1960, 11352) facing 2 (id 8)
  0.18  RESERVE: zone 9 at (1912, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1912, 11352) facing 2 (id 9)
  0.18  RESERVE: zone 10 at (1864, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1864, 11352) facing 2 (id 10)
  0.18  RESERVE: zone 11 at (1960, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1960, 11400) facing 2 (id 11)
  0.18  RESERVE: zone 12 at (1912, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1912, 11400) facing 2 (id 12)
  0.18  RESERVE: zone 13 at (1864, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1864, 11400) facing 2 (id 13)
  0.18  RESERVE: zone 14 at (1960, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1960, 11448) facing 2 (id 14)
  0.18  RESERVE: zone 15 at (1912, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1912, 11448) facing 2 (id 15)
  0.18  RESERVE: zone 16 at (1864, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1864, 11448) facing 2 (id 16)
  0.18  RESERVE: zone 17 at (1960, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1960, 11496) facing 2 (id 17)
  0.18  RESERVE: zone 18 at (1912, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1912, 11496) facing 2 (id 18)
  0.18  RESERVE: zone 19 at (1864, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1864, 11496) facing 2 (id 19)
  0.18  RESERVE: zone 20 at (1960, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1960, 11544) facing 2 (id 20)
  0.18  RESERVE: zone 21 at (1912, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1912, 11544) facing 2 (id 21)
  0.18  RESERVE: zone 22 at (1864, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1864, 11544) facing 2 (id 22)
  0.18  RESERVE: zone 23 at (1960, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1960, 11592) facing 2 (id 23)
  0.18  RESERVE: zone 24 at (1912, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1912, 11592) facing 2 (id 24)
  0.18  RESERVE: zone 25 at (1864, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1864, 11592) facing 2 (id 25)
  0.18  RESERVE: zone 26 at (1960, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1960, 11640) facing 2 (id 26)
  0.18  RESERVE: zone 27 at (1912, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1912, 11640) facing 2 (id 27)
  0.18  RESERVE: zone 28 at (1768, 11256) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: legaap at (1768, 11256) facing 2 (id 28)
  0.18  RESERVE: zone 29 at (1816, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1816, 11352) facing 2 (id 29)
  0.18  RESERVE: zone 30 at (1768, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1768, 11352) facing 2 (id 30)
  0.18  RESERVE: zone 31 at (1720, 11352) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1720, 11352) facing 2 (id 31)
  0.18  RESERVE: zone 32 at (1816, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1816, 11400) facing 2 (id 32)
  0.18  RESERVE: zone 33 at (1768, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1768, 11400) facing 2 (id 33)
  0.18  RESERVE: zone 34 at (1720, 11400) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1720, 11400) facing 2 (id 34)
  0.18  RESERVE: zone 35 at (1816, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1816, 11448) facing 2 (id 35)
  0.18  RESERVE: zone 36 at (1768, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1768, 11448) facing 2 (id 36)
  0.18  RESERVE: zone 37 at (1720, 11448) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1720, 11448) facing 2 (id 37)
  0.18  RESERVE: zone 38 at (1816, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1816, 11496) facing 2 (id 38)
  0.18  RESERVE: zone 39 at (1768, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1768, 11496) facing 2 (id 39)
  0.18  RESERVE: zone 40 at (1720, 11496) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1720, 11496) facing 2 (id 40)
  0.18  RESERVE: zone 41 at (1816, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1816, 11544) facing 2 (id 41)
  0.18  RESERVE: zone 42 at (1768, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1768, 11544) facing 2 (id 42)
  0.18  RESERVE: zone 43 at (1720, 11544) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1720, 11544) facing 2 (id 43)
  0.18  RESERVE: zone 44 at (1816, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1816, 11592) facing 2 (id 44)
  0.18  RESERVE: zone 45 at (1768, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1768, 11592) facing 2 (id 45)
  0.18  RESERVE: zone 46 at (1720, 11592) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1720, 11592) facing 2 (id 46)
  0.18  RESERVE: zone 47 at (1816, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1816, 11640) facing 2 (id 47)
  0.18  RESERVE: zone 48 at (1768, 11640) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (1768, 11640) facing 2 (id 48)
  0.18  RESERVE: zone 49 at (2056, 10776) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: legaap at (2056, 10776) facing 2 (id 49)
  0.18  RESERVE: zone 50 at (2104, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2104, 10872) facing 2 (id 50)
  0.18  RESERVE: zone 51 at (2056, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2056, 10872) facing 2 (id 51)
  0.18  RESERVE: zone 52 at (2008, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2008, 10872) facing 2 (id 52)
  0.18  RESERVE: zone 53 at (2104, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2104, 10920) facing 2 (id 53)
  0.18  RESERVE: zone 54 at (2056, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2056, 10920) facing 2 (id 54)
  0.18  RESERVE: zone 55 at (2008, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2008, 10920) facing 2 (id 55)
  0.18  RESERVE: zone 56 at (2104, 10968) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2104, 10968) facing 2 (id 56)
  0.18  RESERVE: zone 57 at (2056, 10968) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2056, 10968) facing 2 (id 57)
  0.18  RESERVE: zone 58 at (2008, 10968) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2008, 10968) facing 2 (id 58)
  0.18  RESERVE: zone 59 at (2104, 11016) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2104, 11016) facing 2 (id 59)
  0.18  RESERVE: zone 60 at (2056, 11016) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (2056, 11016) facing 2 (id 60)
```
