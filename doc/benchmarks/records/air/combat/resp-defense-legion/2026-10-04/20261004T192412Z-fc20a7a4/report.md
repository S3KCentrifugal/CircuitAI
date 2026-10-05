# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 7.0 min (frame 12600); wall 115 s
- DLL: build-theatres\d193-build\SkirmishAI.dll (df4b5dd21490b768); AI BARbTest/test; staged 2026-10-04T16:22:13
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: response-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-legion\supreme\20261004T192213Z-7815052a\runs\20261004T192412Z-fc20a7a4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:44.616087][f=-000001] [AirResponseWatch] loaded case=defense` |
| expect `dispatch` | seen at 1.5 min | `[AIR][BaseResponse] dispatched=30 total=30` |
| expect `production` | seen at 1.5 min | `[AIR][Produce] base.defence legstronghold plant=30163 projected=1/1` |
| expect `bomber_damage` | seen at 1.6 min | `[t=00:01:18.962184][f=0002949] [AirResponseWatch] damage frame=2949 attacker=legphoenix victim=armmar amount=45.4247665 emp=false` |
| expect `gunship_finished` | seen at 1.7 min | `[t=00:01:20.329747][f=0003051] [AirResponseWatch] finished frame=3051 def=legstronghold id=8697` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-050 no factory 300 s into the game (layout planned)` |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Failures

- forbid 'invariant' hit at 5.0 min: [INVARIANT] INV-050 no factory 300 s into the game (layout planned)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-legion\supreme\20261004T192213Z-7815052a\runs\20261004T192412Z-fc20a7a4\screen_2026-10-04_19-23-33-776.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-defense-legion\supreme\20261004T192213Z-7815052a\runs\20261004T192412Z-fc20a7a4\screen_2026-10-04_19-23-37-801.png

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
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 31
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 31
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
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(837,10404) factory=armlab landLocked=no spot=1 known=1/1
  0.18  [Playtest] finished legaap team 0 at 0.18 min
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
  0.18  [AIR][Layout] cluster=0 labs=6 at=4147,11291
  0.18  [AIR][EcoLayout] reserved air.eco.0 reactor=1648,11872 converters=8 support=12 zone=2038
  0.18  [AIR][State] T2_SUSTAIN
  0.18  [AIR][Share] metal 100003 of 100200 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.20  [Playtest] finished armarad team 0 at 0.20 min
  0.20  [AIR][EcoLayout] reserved air.eco.1 reactor=3056,11616 converters=8 support=12 zone=2072
  0.22  [AIR][EcoLayout] reserved air.eco.2 reactor=2032,11488 converters=8 support=12 zone=2094
  0.22  [AIR][Waves] opening size drawn=19
  0.22  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.22  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=3; request fresh reconnaissance
  0.23  [AIR][EcoLayout] reserved air.eco.3 reactor=3184,11104 converters=8 support=12 zone=2118
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
  0.27  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.36  [AIR][Produce] intercept legvenator plant=30163 projected=1/6
  0.38  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.43  [AIR][Capacity] own=2/9065 usage=33/1012 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] T2_SUSTAIN M=2 bank=99949 E=9065 bank=1027375 pull=1012 plants=0/1 aircraftDemand=29/854
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.43  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.44  [AIR][Screen] fighters=1 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  0.46  [AIR][Produce] intercept legvenator plant=30163 projected=2/6
  0.55  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.56  [AIR][Produce] intercept legvenator plant=30163 projected=3/6
  0.60  [AIR][Capacity] own=2/9065 usage=18/552 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] T2_SUSTAIN M=2 bank=99806 E=9065 bank=1027375 pull=552 plants=0/1 aircraftDemand=29/854
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.60  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.60  [AIR][Attack] home=2 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  0.62  [AIR][Screen] fighters=2 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  0.66  [AIR][Produce] intercept legvenator plant=30163 projected=4/6
  0.72  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.72  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  0.75  [AIR][Produce] intercept legvenator plant=30163 projected=5/6
  0.77  [AIR][Capacity] own=2/9065 usage=0/26 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] T2_SUSTAIN M=2 bank=99618 E=9065 bank=1027375 pull=26 plants=0/1 aircraftDemand=29/854
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.77  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.78  [AIR][Screen] fighters=4 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  0.85  [AIR][Produce] intercept legvenator plant=30163 projected=6/6
  0.88  [AIR][Waves] home focus replaced by enemy start 10129,541
  0.93  [AIR][Capacity] own=2/9065 usage=31/943 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] T2_SUSTAIN M=2 bank=99412 E=9071 bank=1027375 pull=943 plants=0/1 aircraftDemand=29/854
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  0.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  0.93  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.94  [AIR][Produce] air.control legvenator plant=30163 projected=7/7
  0.97  [AIR][Screen] fighters=6 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99348/100200, energy +9065.0 bank 1027165/1027375, units 50
  1.05  [AIR][Produce] air.control legvenator plant=30163 projected=8/8
  1.05  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.10  [AIR][Capacity] own=2/9065 usage=29/883 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T2_SUSTAIN M=2 bank=99268 E=9065 bank=1027375 pull=883 plants=0/1 aircraftDemand=29/854
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.10  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.10  [AIR][Attack] home=7 target=6 heldBombers=18 escorts=0 wave=0 enemyAir=0
  1.14  [AIR][Produce] air.control legvenator plant=30163 projected=9/9
  1.17  [AIR][Screen] fighters=8 cells=8 centre=1551,9645 width=1200 advance=1041 responding=false
  1.18  [AIR][Share] metal 99198 of 100200 (99%): sent 26 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.22  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.22  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=18; request fresh reconnaissance
  1.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99919) (D-106)
  1.24  [AIR][Produce] air.control legvenator plant=30163 projected=10/10
  1.27  [AIR][Capacity] own=2/9065 usage=6/212 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T2_SUSTAIN M=2 bank=99198 E=9065 bank=1027375 pull=212 plants=0/1 aircraftDemand=29/854
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.27  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.27  [AIR][Share] metal 99198 of 100200 (99%): sent 93 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99851) (D-106)
  1.34  [AIR][Produce] air.control legvenator plant=30163 projected=11/11
  1.35  [AIR][Share] metal 99198 of 100200 (99%): sent 167 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.37  [AIR][Screen] fighters=10 cells=8 centre=1551,9645 width=1200 advance=1041 responding=false
  1.38  [AIR][Waves] home focus replaced by enemy start 10129,541
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99798) (D-106)
  1.43  [AIR][Capacity] own=2/9065 usage=28/864 gifts=32 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T2_SUSTAIN M=14 bank=99198 E=9065 bank=1027375 pull=864 plants=0/1 aircraftDemand=29/854
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.43  [AIR][Share] metal 99200 of 100200 (99%): sent 256 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.44  [AIR][Produce] air.control legvenator plant=30163 projected=12/12
  1.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99732) (D-106)
  1.52  [AIR][BaseResponse] contact=true
  1.52  [AIR][BaseResponse] group=0 target=15428
  1.52  [AIR][BaseResponse] group=1 target=15428
  1.52  [AIR][BaseResponse] group=2 target=15428
  1.52  [AIR][BaseResponse] dispatched=30 total=30
  1.52  [AIR][Share] metal 99198 of 100200 (99%): sent 347 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.54  [AIR][Produce] base.defence legstronghold plant=30163 projected=1/1
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99656) (D-106)
  1.60  [AIR][Capacity] own=2/9065 usage=64/1551 gifts=24 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T2_SUSTAIN M=17 bank=99198 E=9065 bank=1027375 pull=1551 plants=0/1 aircraftDemand=29/854
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [AIR][Share] metal 99198 of 100200 (99%): sent 488 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99385) (D-106)
  1.68  [AIR][Share] metal 99198 of 100200 (99%): sent 803 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.70  [AIR][BaseResponse] dispatched=1 total=28
  1.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99157) (D-106)
  1.72  [AIR][Produce] base.defence legstronghold plant=30163 projected=2/2
  1.73  [AIR][BaseResponse] group=0 target=30751
  1.73  [AIR][BaseResponse] group=1 target=30751
  1.73  [AIR][BaseResponse] group=2 target=30751
  1.75  [AIR][BaseResponse] group=0 target=21900
  1.75  [AIR][BaseResponse] group=1 target=21900
  1.75  [AIR][BaseResponse] group=2 target=21900
  1.77  [AIR][Capacity] own=2/9062 usage=22/537 gifts=6 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T2_SUSTAIN M=23 bank=99198 E=9064 bank=1027350 pull=537 plants=0/1 aircraftDemand=29/854
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.77  [AIR][BaseResponse] group=0 target=27265
  1.77  [AIR][BaseResponse] group=1 target=27265
  1.77  [AIR][BaseResponse] group=2 target=27265
  1.82  [AIR][BaseResponse] contact=false
  1.82  [AIR][BaseResponse] group=0 target=-1
  1.82  [AIR][BaseResponse] group=1 target=-1
  1.82  [AIR][BaseResponse] group=2 target=-1
  1.91  [AIR][Produce] intercept legvenator plant=30163 projected=6/11
  1.93  [AIR][Capacity] own=2/9060 usage=0/0 gifts=18 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T2_SUSTAIN M=22 bank=99200 E=9060 bank=1027350 pull=0 plants=0/1 aircraftDemand=29/854
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 99176/100200, energy +9060.0 bank 1027350/1027350, units 46
  2.01  [AIR][Screen] fighters=1 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  2.02  [AIR][Produce] intercept legvenator plant=30163 projected=7/11
  2.10  [AIR][Capacity] own=2/9060 usage=33/986 gifts=14 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=13 bank=99146 E=9060 bank=1027350 pull=986 plants=0/1 aircraftDemand=29/854
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.12  [AIR][Produce] intercept legvenator plant=30163 projected=8/11
  2.17  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.17  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=4; request fresh reconnaissance
  2.20  [AIR][Screen] fighters=7 cells=8 centre=1111,10112 width=600 advance=400 responding=false
  2.22  [AIR][Produce] air.control legvenator plant=30163 projected=9/9
  2.27  [AIR][Capacity] own=2/9060 usage=18/524 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=2 bank=99004 E=9060 bank=1027350 pull=524 plants=0/1 aircraftDemand=29/854
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.31  [AIR][Produce] air.control legvenator plant=30163 projected=10/10
  2.33  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.38  [AIR][Screen] fighters=9 cells=8 centre=1551,9645 width=1200 advance=1041 responding=false
  2.42  [AIR][Produce] air.control legvenator plant=30163 projected=11/11
  2.43  [AIR][Capacity] own=2/9060 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=2 bank=98831 E=9060 bank=1027350 pull=0 plants=0/1 aircraftDemand=29/854
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.50  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.53  [AIR][Produce] air.control legvenator plant=30163 projected=12/12
  2.55  [AIR][Screen] fighters=11 cells=8 centre=1551,9645 width=1200 advance=1041 responding=false
  2.60  [AIR][Capacity] own=2/9060 usage=33/986 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=2 bank=98665 E=9060 bank=1027350 pull=986 plants=0/1 aircraftDemand=29/854
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.60  [AIR][Attack] home=11 target=6 heldBombers=17 escorts=0 wave=0 enemyAir=0
  2.63  [AIR][Produce] air.control legvenator plant=30163 projected=13/13
  2.67  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.67  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=17; request fresh reconnaissance
  2.72  [AIR][Screen] fighters=12 cells=8 centre=1991,9178 width=1800 advance=1683 responding=false
  2.74  [AIR][Produce] air.control legvenator plant=30163 projected=14/14
  2.77  [AIR][Capacity] own=2/9060 usage=5/151 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T2_SUSTAIN M=2 bank=98526 E=9060 bank=1027350 pull=151 plants=0/1 aircraftDemand=29/854
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.77  [AIR][Share] metal 98517 of 100200 (98%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  2.83  [AIR][Waves] home focus replaced by enemy start 10129,541
  2.85  [AIR][Produce] air.control legvenator plant=30163 projected=15/15
  2.90  [AIR][Screen] fighters=14 cells=8 centre=1991,9178 width=1800 advance=1683 responding=false
  2.93  [AIR][Capacity] own=2/9060 usage=33/986 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T2_SUSTAIN M=2 bank=98342 E=9060 bank=1027350 pull=986 plants=0/1 aircraftDemand=29/854
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.95  [AIR][Produce] air.control legvenator plant=30163 projected=16/16
  3.00  [AIR][Waves] home focus replaced by enemy start 10129,541
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 98303/100200, energy +9060.0 bank 1027190/1027350, units 56
  3.07  [AIR][Produce] air.control legvenator plant=30163 projected=17/17
  3.10  [AIR][Capacity] own=2/9060 usage=7/221 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T2_SUSTAIN M=2 bank=98225 E=9060 bank=1027350 pull=221 plants=0/1 aircraftDemand=29/854
  3.10  [AIR][Projects] energyQueued=0 committed=0/0
  3.10  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.10  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  3.10  [AIR][Screen] fighters=16 cells=8 centre=2431,8711 width=2400 advance=2325 responding=false
  3.10  [AIR][Attack] home=16 target=6 heldBombers=17 escorts=0 wave=0 enemyAir=0
  3.17  [AIR][Waves] home focus replaced by enemy start 10129,541
  3.17  [AIR][Waves] held: no feasible known target; defensive minimum=0 available=17; request fresh reconnaissance
  3.17  [AIR][Produce] air.control legvenator plant=30163 projected=18/18
  3.18  [AIR][Layout] cluster=1 labs=3 at=2227,10139
  3.27  [AIR][Capacity] own=2/9060 usage=11/338 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T2_SUSTAIN M=2 bank=98027 E=9060 bank=1027350 pull=338 plants=0/1 aircraftDemand=29/854
  3.27  [AIR][Projects] energyQueued=0 committed=0/0
  3.27  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 6 plant=30163 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  3.27  [AIR][Produce] air.control legvenator plant=30163 projected=19/19
  3.30  [AIR][Screen] fighters=18 cells=8 centre=2431,8711 width=2400 advance=2325 responding=false
  3.33  [AIR][Waves] home focus replaced by enemy start 10129,541
  3.37  [AIR][Produce] air.control legvenator plant=30163 projected=20/20
  3.43  [AIR][Capacity] own=2/9060 usage=33/986 gifts=0 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T2_SUSTAIN M=2 bank=97864 E=9060 bank=1027350 pull=986 plants=0/1 aircraftDemand=29/854
  3.43  [AIR][Projects] energyQueued=0 committed=0/0
  3.43  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 422 more
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
  0.18  RESERVE: zone 1 at (3968, 9936) facing 2, 6x6 cells: 36 of 36 held
  0.18  RESERVE: legap at (3968, 9936) facing 2 (id 1)
  0.18  RESERVE: zone 2 at (4024, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (4024, 10008) facing 2 (id 2)
  0.18  RESERVE: zone 3 at (3976, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3976, 10008) facing 2 (id 3)
  0.18  RESERVE: zone 4 at (3928, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3928, 10008) facing 2 (id 4)
  0.18  RESERVE: zone 5 at (4024, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (4024, 10056) facing 2 (id 5)
  0.18  RESERVE: zone 6 at (3976, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3976, 10056) facing 2 (id 6)
  0.18  RESERVE: zone 7 at (3832, 9912) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: legaap at (3832, 9912) facing 2 (id 7)
  0.18  RESERVE: zone 8 at (3880, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3880, 10008) facing 2 (id 8)
  0.18  RESERVE: zone 9 at (3832, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3832, 10008) facing 2 (id 9)
  0.18  RESERVE: zone 10 at (3784, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3784, 10008) facing 2 (id 10)
  0.18  RESERVE: zone 11 at (3880, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3880, 10056) facing 2 (id 11)
  0.18  RESERVE: zone 12 at (3832, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3832, 10056) facing 2 (id 12)
  0.18  RESERVE: zone 13 at (3784, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3784, 10056) facing 2 (id 13)
  0.18  RESERVE: zone 14 at (3880, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3880, 10104) facing 2 (id 14)
  0.18  RESERVE: zone 15 at (3832, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3832, 10104) facing 2 (id 15)
  0.18  RESERVE: zone 16 at (3784, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3784, 10104) facing 2 (id 16)
  0.18  RESERVE: zone 17 at (3880, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3880, 10152) facing 2 (id 17)
  0.18  RESERVE: zone 18 at (3832, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3832, 10152) facing 2 (id 18)
  0.18  RESERVE: zone 19 at (3784, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3784, 10152) facing 2 (id 19)
  0.18  RESERVE: zone 20 at (3880, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3880, 10200) facing 2 (id 20)
  0.18  RESERVE: zone 21 at (3832, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3832, 10200) facing 2 (id 21)
  0.18  RESERVE: zone 22 at (3784, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3784, 10200) facing 2 (id 22)
  0.18  RESERVE: zone 23 at (3880, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3880, 10248) facing 2 (id 23)
  0.18  RESERVE: zone 24 at (3832, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3832, 10248) facing 2 (id 24)
  0.18  RESERVE: zone 25 at (3784, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3784, 10248) facing 2 (id 25)
  0.18  RESERVE: zone 26 at (3880, 10296) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3880, 10296) facing 2 (id 26)
  0.18  RESERVE: zone 27 at (3832, 10296) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3832, 10296) facing 2 (id 27)
  0.18  RESERVE: zone 28 at (3688, 9912) facing 2, 9x9 cells: 81 of 81 held
  0.18  RESERVE: legaap at (3688, 9912) facing 2 (id 28)
  0.18  RESERVE: zone 29 at (3736, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3736, 10008) facing 2 (id 29)
  0.18  RESERVE: zone 30 at (3688, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3688, 10008) facing 2 (id 30)
  0.18  RESERVE: zone 31 at (3640, 10008) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3640, 10008) facing 2 (id 31)
  0.18  RESERVE: zone 32 at (3736, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3736, 10056) facing 2 (id 32)
  0.18  RESERVE: zone 33 at (3688, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3688, 10056) facing 2 (id 33)
  0.18  RESERVE: zone 34 at (3640, 10056) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3640, 10056) facing 2 (id 34)
  0.18  RESERVE: zone 35 at (3736, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3736, 10104) facing 2 (id 35)
  0.18  RESERVE: zone 36 at (3688, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3688, 10104) facing 2 (id 36)
  0.18  RESERVE: zone 37 at (3640, 10104) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3640, 10104) facing 2 (id 37)
  0.18  RESERVE: zone 38 at (3736, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3736, 10152) facing 2 (id 38)
  0.18  RESERVE: zone 39 at (3688, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3688, 10152) facing 2 (id 39)
  0.18  RESERVE: zone 40 at (3640, 10152) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3640, 10152) facing 2 (id 40)
  0.18  RESERVE: zone 41 at (3736, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3736, 10200) facing 2 (id 41)
  0.18  RESERVE: zone 42 at (3688, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3688, 10200) facing 2 (id 42)
  0.18  RESERVE: zone 43 at (3640, 10200) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3640, 10200) facing 2 (id 43)
  0.18  RESERVE: zone 44 at (3736, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3736, 10248) facing 2 (id 44)
  0.18  RESERVE: zone 45 at (3688, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3688, 10248) facing 2 (id 45)
  0.18  RESERVE: zone 46 at (3640, 10248) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: legnanotc at (3640, 10248) facing 2 (id 46)
```
