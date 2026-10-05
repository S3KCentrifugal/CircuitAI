# Playtest report: PASS

- Verdict: **PASS** (reached 7 min)
- Game time reached: 7.1 min (frame 12691); wall 89 s
- DLL: build-theatres\d194-build\SkirmishAI.dll (8a05e13b0b70c836); AI BARbTest/test; staged 2026-10-04T17:46:44
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: naval-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\an-naval-legion\supreme\20261004T204644Z-43943fef\runs\20261004T204817Z-633871ec\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:33.987810][f=-000001] [AirNavalWatch] loaded case=naval` |
| expect `launch` | seen at 2.7 min | `[AIR][Naval] launch=11 wanted=12 target=11191 reason=deadline ingress=6548,9357` |
| expect `attack` | seen at 3.0 min | `[AIR][Naval] attack=11 target=11191` |
| expect `damage` | seen at 3.1 min | `[t=00:01:02.242333][f=0005526] [AirNavalWatch] torpedo_damage frame=5526 victim=armroy amount=750.083862` |
| expect `recruit` | seen at 1.0 min | `[AIR][Produce] naval.relief legatorpbomber plant=30735 projected=1/1` |
| expect `finish` | seen at 1.2 min | `[t=00:00:49.841548][f=0002100] [AirNavalWatch] torpedo_finished frame=2100 id=930` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\an-naval-legion\supreme\20261004T204644Z-43943fef\runs\20261004T204817Z-633871ec\screen_2026-10-04_20-47-43-072.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\an-naval-legion\supreme\20261004T204644Z-43943fef\runs\20261004T204817Z-633871ec\screen_2026-10-04_20-47-52-470.png

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
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 28
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 28
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
  0.18  [AIR][Growth] growth objective reached; completed AFUS=3
  0.18  [AIR][Layout] cluster=0 labs=6 at=2131,11675
  0.18  [AIR][EcoLayout] reserved air.eco.0 reactor=1520,11872 converters=8 support=12 zone=134
  0.18  [AIR][Layout] cluster=1 labs=6 at=1651,10811
  0.18  [AIR][State] T2_SUSTAIN
  0.18  [AIR][Share] metal 100003 of 100200 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.20  [AIR][EcoLayout] reserved air.eco.1 reactor=3056,11616 converters=8 support=12 zone=295
  0.20  [Playtest] finished armfrad team 0 at 0.20 min
  0.20  [Playtest] finished armason team 0 at 0.20 min
  0.21  [AIR][Screen] fighters=1 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  0.22  [AIR][EcoLayout] reserved air.eco.2 reactor=3184,11104 converters=8 support=12 zone=319
  0.23  [AIR][EcoLayout] reserved air.eco.3 reactor=3824,11360 converters=8 support=12 zone=353
  0.27  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] T2_SUSTAIN M=1 bank=100011 E=18 bank=1027375 pull=0 plants=0/1 aircraftDemand=29/854
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
  0.27  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.27  [AIR][Share] metal 100013 of 100200 (99%): sent 90 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100014) (D-106)
  0.35  [AIR][Share] metal 100023 of 100200 (99%): sent 80 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.35  [AIR][Produce] air.control legvenator plant=30735 projected=17/17
  0.38  [AIR][Screen] fighters=16 cells=8 centre=3522,9825 width=2400 advance=2358 responding=false
  0.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100024) (D-106)
  0.43  [AIR][Capacity] own=2/9065 usage=33/986 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] T2_SUSTAIN M=2 bank=99935 E=9065 bank=1027375 pull=986 plants=0/1 aircraftDemand=29/854
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
  0.43  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.43  [AIR][Share] metal 99919 of 100200 (99%): sent 70 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.44  [AIR][Produce] air.control legvenator plant=30735 projected=18/18
  0.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100034) (D-106)
  0.52  [AIR][Share] metal 99816 of 100200 (99%): sent 60 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.52  [AIR][Produce] air.control legvenator plant=30735 projected=19/19
  0.55  [AIR][Screen] fighters=18 cells=8 centre=3522,9825 width=2400 advance=2358 responding=false
  0.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100044) (D-106)
  0.60  [AIR][Capacity] own=2/9065 usage=33/986 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] T2_SUSTAIN M=2 bank=99721 E=9065 bank=1027375 pull=986 plants=0/1 aircraftDemand=29/854
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
  0.60  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.60  [AIR][Attack] home=18 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.60  [AIR][Share] metal 99713 of 100200 (99%): sent 50 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.60  [AIR][Produce] air.control legvenator plant=30735 projected=20/20
  0.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100054) (D-106)
  0.68  [AIR][Share] metal 99610 of 100200 (99%): sent 40 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.69  [AIR][Produce] air.control legvenator plant=30735 projected=21/21
  0.72  [AIR][Screen] fighters=20 cells=8 centre=3901,9292 width=3000 advance=3011 responding=false
  0.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100064) (D-106)
  0.77  [AIR][Capacity] own=2/9065 usage=33/986 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] T2_SUSTAIN M=2 bank=99524 E=9065 bank=1027375 pull=986 plants=0/1 aircraftDemand=29/854
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
  0.77  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.77  [AIR][Share] metal 99507 of 100200 (99%): sent 30 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.77  [AIR][Produce] air.control legvenator plant=30735 projected=22/22
  0.80  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100074) (D-106)
  0.85  [AIR][Produce] air.control legvenator plant=30735 projected=23/23
  0.88  [AIR][Screen] fighters=22 cells=8 centre=3901,9292 width=3000 advance=3011 responding=false
  0.93  [AIR][Produce] air.control legvenator plant=30735 projected=24/24
  0.93  [AIR][Capacity] own=2/9065 usage=33/986 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] T2_SUSTAIN M=2 bank=99300 E=9065 bank=1027375 pull=986 plants=0/1 aircraftDemand=29/854
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
  0.93  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99197/100200, energy +9065.0 bank 1027145/1027375, units 48
  1.02  [AIR][Naval] theatre=2:3:4 enemy=5280 friendly=880 subs=0 antiSub=880 deficit=4400
  1.02  [AIR][Produce] naval.relief legatorpbomber plant=30735 projected=1/1
  1.05  [AIR][Screen] fighters=24 cells=8 centre=4279,8760 width=3600 advance=3664 responding=false
  1.10  [AIR][Capacity] own=2/9065 usage=65/1294 gifts=51 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T2_SUSTAIN M=2 bank=99198 E=9065 bank=1027375 pull=1294 plants=0/1 aircraftDemand=29/854
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
  1.10  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.10  [AIR][Attack] home=24 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.10  [AIR][Share] metal 99198 of 100200 (99%): sent 200 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.13  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99774) (D-106)
  1.18  [AIR][Produce] naval.relief legatorpbomber plant=30735 projected=2/2
  1.18  [AIR][Share] metal 99198 of 100200 (99%): sent 449 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.22  [AIR][Screen] fighters=24 cells=8 centre=4279,8760 width=3600 advance=3664 responding=false
  1.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99566) (D-106)
  1.27  [AIR][Capacity] own=2/9065 usage=65/1294 gifts=64 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T2_SUSTAIN M=31 bank=99198 E=9065 bank=1027375 pull=1294 plants=0/1 aircraftDemand=28/1520
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
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
  1.27  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.27  [AIR][Share] metal 99198 of 100200 (99%): sent 721 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99253) (D-106)
  1.33  [AIR][Produce] naval.relief legatorpbomber plant=30735 projected=3/3
  1.35  [AIR][Share] metal 99198 of 100200 (99%): sent 948 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.38  [AIR][Screen] fighters=24 cells=8 centre=4279,8760 width=3600 advance=3664 responding=false
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99090) (D-106)
  1.43  [AIR][Capacity] own=2/9065 usage=65/1294 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T2_SUSTAIN M=25 bank=99008 E=9065 bank=1027375 pull=1294 plants=0/1 aircraftDemand=29/854
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  1.43  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.43  [AIR][Share] metal 98944 of 100200 (98%): sent 1003 to team 1 (98% full); the engine counts 0 metal sent in the last update (D-106)
  1.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 98777) (D-106)
  1.47  [AIR][Produce] naval.relief legatorpbomber plant=30735 projected=4/4
  1.52  [AIR][Share] metal 99038 of 100200 (98%): sent 1316 to team 1 (98% full); the engine counts 0 metal sent in the last update (D-106)
  1.55  [AIR][Screen] fighters=24 cells=8 centre=4279,8760 width=3600 advance=3664 responding=false
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 98556) (D-106)
  1.60  [AIR][Capacity] own=2/9065 usage=65/1294 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T2_SUSTAIN M=15 bank=99010 E=9065 bank=1027375 pull=1294 plants=0/1 aircraftDemand=29/854
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
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
  1.60  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.60  [AIR][Attack] home=24 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [AIR][Share] metal 98946 of 100200 (98%): sent 1537 to team 1 (98% full); the engine counts 0 metal sent in the last update (D-106)
  1.62  [AIR][Produce] naval.relief legatorpbomber plant=30735 projected=5/5
  1.63  [AIR][Growth] shared TECH economy enabled at M10=67.125
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 98297) (D-106)
  1.68  [AIR][Share] metal 99006 of 100200 (98%): sent 1796 to team 1 (98% full); the engine counts 0 metal sent in the last update (D-106)
  1.72  [AIR][Screen] fighters=24 cells=8 centre=4279,8760 width=3600 advance=3664 responding=false
  1.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 98047) (D-106)
  1.77  [AIR][Capacity] own=2/9065 usage=65/1294 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T2_SUSTAIN M=111 bank=99008 E=9065 bank=1027375 pull=1294 plants=0/1 aircraftDemand=28/1520
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
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
  1.77  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.77  [AIR][Share] metal 98988 of 100200 (98%): sent 2046 to team 1 (97% full); the engine counts 0 metal sent in the last update (D-106)
  1.77  [AIR][Produce] naval.relief legatorpbomber plant=30735 projected=6/6
  1.80  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 97808) (D-106)
  1.85  [AIR][Share] metal 98957 of 100200 (98%): sent 2285 to team 1 (97% full); the engine counts 0 metal sent in the last update (D-106)
  1.88  [AIR][Screen] fighters=24 cells=8 centre=4279,8760 width=3600 advance=3664 responding=false
  1.88  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 97506) (D-106)
  1.91  [AIR][Produce] naval.relief legatorpbomber plant=30735 projected=7/7
  1.93  [AIR][Capacity] own=2/9065 usage=4/92 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T2_SUSTAIN M=213 bank=99075 E=9065 bank=1027375 pull=92 plants=0/1 aircraftDemand=28/1520
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
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
  1.93  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.93  [AIR][Share] metal 99037 of 100200 (98%): sent 2587 to team 1 (97% full); the engine counts 0 metal sent in the last update (D-106)
  1.97  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 97289) (D-106)
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 99012/100200, energy +9065.0 bank 1027030/1027375, units 55
  2.02  [AIR][Share] metal 98946 of 100200 (98%): sent 2804 to team 1 (97% full); the engine counts 0 metal sent in the last update (D-106)
  2.05  [AIR][Screen] fighters=24 cells=8 centre=4279,8760 width=3600 advance=3664 responding=false
  2.05  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 96976) (D-106)
  2.06  [AIR][Produce] naval.relief legatorpbomber plant=30735 projected=8/8
  2.10  [AIR][Capacity] own=2/9065 usage=38/750 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=321 bank=99118 E=9065 bank=1027375 pull=750 plants=0/1 aircraftDemand=28/1520
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
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
  2.10  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.10  [AIR][Attack] home=24 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.10  [AIR][Share] metal 99058 of 100200 (98%): sent 3117 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  2.13  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 96778) (D-106)
  2.18  [AIR][Share] metal 98944 of 100200 (98%): sent 3315 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  2.21  [AIR][Produce] naval.relief legatorpbomber plant=30735 projected=9/9
  2.22  [AIR][Screen] fighters=24 cells=8 centre=4279,8760 width=3600 advance=3664 responding=false
  2.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 96488) (D-106)
  2.27  [AIR][Capacity] own=2/9065 usage=64/1271 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=427 bank=99075 E=9065 bank=1027375 pull=1271 plants=0/1 aircraftDemand=28/1520
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
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
  2.27  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.27  [AIR][Share] metal 99010 of 100200 (98%): sent 3605 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  2.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 96239) (D-106)
  2.35  [AIR][Share] metal 98987 of 100200 (98%): sent 3854 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  2.35  [AIR][Produce] naval.relief legatorpbomber plant=30735 projected=10/10
  2.38  [AIR][Screen] fighters=24 cells=8 centre=4279,8760 width=3600 advance=3664 responding=false
  2.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 96009) (D-106)
  2.43  [AIR][Capacity] own=2/9065 usage=65/1294 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=524 bank=99021 E=9065 bank=1027375 pull=1294 plants=0/1 aircraftDemand=28/1520
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/5 available=yes firstSlot=0
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
  2.43  [AIR][Bay] 12 plant=30735 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.43  [AIR][Share] metal 98957 of 100200 (98%): sent 4084 to team 1 (95% full); the engine counts 0 metal sent in the last update (D-106)
  2.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 95709) (D-106)
  2.50  [AIR][Produce] naval.relief legatorpbomber plant=30735 projected=11/11
  2.52  [AIR][Share] metal 99035 of 100200 (98%): sent 4384 to team 1 (95% full); the engine counts 0 metal sent in the last update (D-106)
  2.55  [AIR][Screen] fighters=24 cells=8 centre=4279,8760 width=3600 advance=3664 responding=false
  2.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 95503) (D-106)
  2.60  [AIR][Capacity] own=2/9065 usage=65/1294 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=620 bank=99008 E=9065 bank=1027375 pull=1294 plants=0/1 aircraftDemand=28/1520
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
... 686 more
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
