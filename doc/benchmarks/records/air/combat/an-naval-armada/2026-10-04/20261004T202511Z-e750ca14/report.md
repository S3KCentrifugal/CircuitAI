# Playtest report: PASS

- Verdict: **PASS** (reached 7 min)
- Game time reached: 7.0 min (frame 12662); wall 99 s
- DLL: build-theatres\d194-build\SkirmishAI.dll (f2ac10b0200fc41a); AI BARbTest/test; staged 2026-10-04T17:23:29
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: naval-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\an-naval-armada\supreme\20261004T202328Z-dff151d0\runs\20261004T202511Z-e750ca14\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:41.573974][f=-000001] [AirNavalWatch] loaded case=naval` |
| expect `launch` | seen at 2.7 min | `[AIR][Naval] launch=11 wanted=14 target=6948 reason=deadline ingress=6548,9421` |
| expect `attack` | seen at 3.0 min | `[AIR][Naval] attack=11 target=6948` |
| expect `damage` | seen at 3.1 min | `[t=00:01:11.572139][f=0005500] [AirNavalWatch] torpedo_damage frame=5500 victim=armroy amount=375.031342` |
| expect `recruit` | seen at 1.1 min | `[AIR][Produce] naval.relief armlance plant=26003 projected=1/1` |
| expect `finish` | seen at 1.2 min | `[t=00:00:58.962328][f=0002122] [AirNavalWatch] torpedo_finished frame=2122 id=20312` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\an-naval-armada\supreme\20261004T202328Z-dff151d0\runs\20261004T202511Z-e750ca14\screen_2026-10-04_20-24-36-319.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\an-naval-armada\supreme\20261004T202328Z-dff151d0\runs\20261004T202511Z-e750ca14\screen_2026-10-04_20-24-46-003.png

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
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 20
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 20
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
  0.10  [Team][Roster] Team 1 (AI 1): role=FRONT side=armada start=(837,10404) factory=armvp landLocked=no spot=1 known=1/1
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
  0.18  [AIR][Growth] growth objective reached; completed AFUS=3
  0.18  [AIR][Layout] cluster=0 labs=6 at=2131,11672
  0.18  [AIR][EcoLayout] reserved air.eco.0 reactor=1520,11872 converters=8 support=12 zone=134
  0.18  [AIR][Layout] cluster=1 labs=6 at=1651,10808
  0.18  [AIR][State] T2_SUSTAIN
  0.18  [AIR][Share] metal 100003 of 100200 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.20  [AIR][EcoLayout] reserved air.eco.1 reactor=3056,11616 converters=8 support=12 zone=295
  0.20  [Playtest] finished armfrad team 0 at 0.20 min
  0.20  [Playtest] finished armason team 0 at 0.20 min
  0.21  [AIR][Screen] fighters=1 cells=8 centre=2386,11418 width=600 advance=400 responding=false
  0.22  [AIR][EcoLayout] reserved air.eco.2 reactor=3184,11104 converters=8 support=12 zone=319
  0.23  [AIR][EcoLayout] reserved air.eco.3 reactor=3824,11360 converters=8 support=12 zone=353
  0.27  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] T2_SUSTAIN M=1 bank=100011 E=18 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
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
  0.27  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.27  [AIR][Share] metal 100013 of 100200 (99%): sent 90 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100014) (D-106)
  0.35  [AIR][Share] metal 100023 of 100200 (99%): sent 80 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.35  [AIR][Produce] air.control armhawk plant=26003 projected=17/17
  0.38  [AIR][Screen] fighters=16 cells=8 centre=3522,9822 width=2400 advance=2358 responding=false
  0.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100024) (D-106)
  0.43  [AIR][Capacity] own=2/9065 usage=39/1591 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] T2_SUSTAIN M=2 bank=99924 E=9065 bank=1027375 pull=1591 plants=0/1 aircraftDemand=34/1407
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
  0.43  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.43  [AIR][Share] metal 99887 of 100200 (99%): sent 70 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.45  [AIR][Produce] air.control armhawk plant=26003 projected=18/18
  0.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100034) (D-106)
  0.52  [AIR][Share] metal 99760 of 100200 (99%): sent 60 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.55  [AIR][Produce] air.control armhawk plant=26003 projected=19/19
  0.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100044) (D-106)
  0.58  [AIR][Screen] fighters=18 cells=8 centre=3522,9822 width=2400 advance=2358 responding=false
  0.60  [AIR][Capacity] own=2/9065 usage=28/1159 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] T2_SUSTAIN M=2 bank=99708 E=9065 bank=1027375 pull=1159 plants=0/1 aircraftDemand=34/1407
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
  0.60  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.60  [AIR][Attack] home=18 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.60  [AIR][Share] metal 99671 of 100200 (99%): sent 50 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100054) (D-106)
  0.65  [AIR][Produce] air.control armhawk plant=26003 projected=20/20
  0.68  [AIR][Share] metal 99564 of 100200 (99%): sent 40 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100064) (D-106)
  0.74  [AIR][Produce] air.control armhawk plant=26003 projected=21/21
  0.77  [AIR][Capacity] own=2/9065 usage=5/222 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] T2_SUSTAIN M=2 bank=99472 E=9065 bank=1027375 pull=222 plants=0/1 aircraftDemand=34/1407
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
  0.77  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.77  [AIR][Share] metal 99456 of 100200 (99%): sent 30 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.78  [AIR][Screen] fighters=20 cells=8 centre=3901,9290 width=3000 advance=3011 responding=false
  0.80  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100074) (D-106)
  0.85  [AIR][Produce] air.control armhawk plant=26003 projected=22/22
  0.93  [AIR][Capacity] own=2/9065 usage=39/1591 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] T2_SUSTAIN M=2 bank=99237 E=9065 bank=1027375 pull=1591 plants=0/1 aircraftDemand=34/1407
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
  0.93  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.95  [AIR][Produce] air.control armhawk plant=26003 projected=23/23
  0.98  [AIR][Screen] fighters=22 cells=8 centre=3901,9290 width=3000 advance=3011 responding=false
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99162/100200, energy +9065.0 bank 1027001/1027375, units 47
  1.02  [AIR][Naval] theatre=2:3:4 enemy=5280 friendly=880 subs=0 antiSub=880 deficit=4400
  1.02  [AIR][Share] metal 99198 of 100200 (99%): sent 104 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.05  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99973) (D-106)
  1.05  [AIR][Produce] naval.relief armlance plant=26003 projected=1/1
  1.10  [AIR][Capacity] own=2/9065 usage=29/583 gifts=12 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T2_SUSTAIN M=2 bank=99198 E=9065 bank=1027375 pull=583 plants=0/1 aircraftDemand=34/1407
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
  1.10  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.10  [AIR][Attack] home=23 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.10  [AIR][Share] metal 99198 of 100200 (99%): sent 215 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.13  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99766) (D-106)
  1.15  [AIR][Screen] fighters=23 cells=8 centre=3901,9290 width=3000 advance=3011 responding=false
  1.18  [AIR][Share] metal 99198 of 100200 (99%): sent 493 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.19  [AIR][Produce] naval.relief armlance plant=26003 projected=2/2
  1.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99558) (D-106)
  1.27  [AIR][Capacity] own=2/9065 usage=63/1263 gifts=60 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T2_SUSTAIN M=22 bank=99198 E=9065 bank=1027375 pull=1263 plants=0/1 aircraftDemand=34/1407
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/3 available=yes firstSlot=0
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
  1.27  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.27  [AIR][Share] metal 99198 of 100200 (99%): sent 719 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99262) (D-106)
  1.32  [AIR][Screen] fighters=23 cells=8 centre=3901,9290 width=3000 advance=3011 responding=false
  1.33  [AIR][Produce] naval.relief armlance plant=26003 projected=3/3
  1.35  [AIR][Share] metal 99198 of 100200 (99%): sent 893 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99099) (D-106)
  1.43  [AIR][Capacity] own=2/9065 usage=63/1263 gifts=2 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T2_SUSTAIN M=31 bank=99076 E=9065 bank=1027375 pull=1263 plants=0/1 aircraftDemand=26/1414
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
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
  1.43  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.43  [AIR][Share] metal 99017 of 100200 (98%): sent 1001 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 98872) (D-106)
  1.47  [AIR][Produce] naval.relief armlance plant=26003 projected=4/4
  1.48  [AIR][Screen] fighters=23 cells=8 centre=3901,9290 width=3000 advance=3011 responding=false
  1.52  [AIR][Share] metal 99071 of 100200 (98%): sent 1221 to team 1 (98% full); the engine counts 0 metal sent in the last update (D-106)
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 98690) (D-106)
  1.60  [AIR][Capacity] own=2/9065 usage=63/1263 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T2_SUSTAIN M=25 bank=99018 E=9065 bank=1027375 pull=1263 plants=0/1 aircraftDemand=34/1407
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
  1.60  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.60  [AIR][Attack] home=23 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [AIR][Share] metal 99005 of 100200 (98%): sent 1403 to team 1 (98% full); the engine counts 0 metal sent in the last update (D-106)
  1.60  [AIR][Produce] naval.relief armlance plant=26003 projected=5/5
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 98491) (D-106)
  1.65  [AIR][Screen] fighters=23 cells=8 centre=3901,9290 width=3000 advance=3011 responding=false
  1.68  [AIR][Share] metal 98972 of 100200 (98%): sent 1602 to team 1 (98% full); the engine counts 0 metal sent in the last update (D-106)
  1.72  [AIR][Growth] shared TECH economy enabled at M10=84.4016
  1.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 98209) (D-106)
  1.75  [AIR][Produce] naval.relief armlance plant=26003 projected=6/6
  1.77  [AIR][Capacity] own=2/9065 usage=2/42 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T2_SUSTAIN M=84 bank=99121 E=9065 bank=1027375 pull=42 plants=0/1 aircraftDemand=26/1414
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
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
  1.77  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.77  [AIR][Share] metal 99088 of 100200 (98%): sent 1884 to team 1 (98% full); the engine counts 0 metal sent in the last update (D-106)
  1.80  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 98050) (D-106)
  1.82  [AIR][Screen] fighters=23 cells=8 centre=3901,9290 width=3000 advance=3011 responding=false
  1.85  [AIR][Share] metal 98959 of 100200 (98%): sent 2043 to team 1 (97% full); the engine counts 0 metal sent in the last update (D-106)
  1.88  [AIR][Produce] naval.relief armlance plant=26003 projected=7/7
  1.88  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 97768) (D-106)
  1.93  [AIR][Capacity] own=2/9065 usage=56/1122 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T2_SUSTAIN M=180 bank=99110 E=9065 bank=1027375 pull=1122 plants=0/1 aircraftDemand=26/1414
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
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
  1.93  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.93  [AIR][Share] metal 99049 of 100200 (98%): sent 2325 to team 1 (97% full); the engine counts 0 metal sent in the last update (D-106)
  1.97  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 97558) (D-106)
  1.98  [AIR][Screen] fighters=23 cells=8 centre=3901,9290 width=3000 advance=3011 responding=false
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 99032/100200, energy +9065.0 bank 1027169/1027375, units 54
  2.01  [AIR][Produce] naval.relief armlance plant=26003 projected=8/8
  2.02  [AIR][Share] metal 99033 of 100200 (98%): sent 2535 to team 1 (97% full); the engine counts 0 metal sent in the last update (D-106)
  2.05  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 97373) (D-106)
  2.10  [AIR][Capacity] own=2/9065 usage=63/1263 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=268 bank=99031 E=9065 bank=1027375 pull=1263 plants=0/1 aircraftDemand=26/1414
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
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
  2.10  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.10  [AIR][Attack] home=23 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.10  [AIR][Share] metal 98970 of 100200 (98%): sent 2720 to team 1 (97% full); the engine counts 0 metal sent in the last update (D-106)
  2.13  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 97090) (D-106)
  2.15  [AIR][Produce] naval.relief armlance plant=26003 projected=9/9
  2.15  [AIR][Screen] fighters=23 cells=8 centre=3901,9290 width=3000 advance=3011 responding=false
  2.18  [AIR][Share] metal 99051 of 100200 (98%): sent 3003 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  2.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 96884) (D-106)
  2.27  [AIR][Capacity] own=2/9065 usage=63/1263 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=347 bank=99022 E=9065 bank=1027375 pull=1263 plants=0/1 aircraftDemand=26/1414
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
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
  2.27  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.27  [AIR][Share] metal 98967 of 100200 (98%): sent 3209 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  2.28  [AIR][Produce] naval.relief armlance plant=26003 projected=10/10
  2.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 96664) (D-106)
  2.32  [AIR][Screen] fighters=23 cells=8 centre=3901,9290 width=3000 advance=3011 responding=false
  2.35  [AIR][Share] metal 98996 of 100200 (98%): sent 3429 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  2.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 96405) (D-106)
  2.42  [AIR][Produce] naval.relief armlance plant=26003 projected=11/11
  2.43  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=445 bank=99084 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=26/1414
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
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
  2.43  [AIR][Bay] 12 plant=26003 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.43  [AIR][Share] metal 99081 of 100200 (98%): sent 3688 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  2.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 96271) (D-106)
  2.48  [AIR][Screen] fighters=23 cells=8 centre=3901,9290 width=3000 advance=3011 responding=false
  2.52  [AIR][Share] metal 98973 of 100200 (98%): sent 3822 to team 1 (96% full); the engine counts 0 metal sent in the last update (D-106)
  2.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 95989) (D-106)
  2.57  [AIR][Produce] naval.relief armlance plant=26003 projected=12/12
  2.60  [AIR][Capacity] own=2/9065 usage=20/407 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=541 bank=99118 E=9065 bank=1027375 pull=407 plants=0/1 aircraftDemand=26/1414
... 697 more
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
