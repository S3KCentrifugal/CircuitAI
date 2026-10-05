# Playtest report: PASS

- Verdict: **PASS** (reached 7 min)
- Game time reached: 7.0 min (frame 12600); wall 82 s
- DLL: build-theatres\d194-build\SkirmishAI.dll (d28b4dcb6a319109); AI BARbTest/test; staged 2026-10-04T18:19:03
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: naval-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\naval-factory-armada\glacial\20261004T211903Z-9c0ec882\runs\20261004T212029Z-25367a17\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:28.596304][f=-000001] [AirNavalWatch] loaded case=factory` |
| expect `launch` | seen at 1.0 min | `[AIR][Naval] launch=17 wanted=17 target=5034 reason=full ingress=2947,3915` |
| expect `attack` | seen at 1.3 min | `[AIR][Naval] attack=17 target=5034` |
| expect `damage` | seen at 1.3 min | `[t=00:00:44.398563][f=0002392] [AirNavalWatch] torpedo_damage frame=2392 victim=armroy amount=375.340546` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\naval-factory-armada\glacial\20261004T211903Z-9c0ec882\runs\20261004T212029Z-25367a17\screen_2026-10-04_21-19-52-835.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\naval-factory-armada\glacial\20261004T211903Z-9c0ec882\runs\20261004T212029Z-25367a17\screen_2026-10-04_21-19-55-843.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 10, 0 shots, end at 7.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (14000, 1100) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=100000 E=0 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (442, 1128), 48 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|490|1137|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=FRONT side=armada start=(1430,3997) factory=armlab landLocked=no spot=4 known=1/2
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
  0.18  [AIR][Layout] cluster=0 labs=6 at=754,1881
  0.18  [AIR][EcoLayout] reserved air.eco.0 reactor=352,1776 converters=8 support=12 zone=134
  0.18  [AIR][Layout] cluster=1 labs=6 at=1234,1017
  0.18  [AIR][State] T2_SUSTAIN
  0.18  [AIR][Share] metal 100002 of 100200 (99%): no teammate with room (2 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.19  [AIR][Screen] fighters=1 cells=8 centre=889,1135 width=600 advance=400 responding=false
  0.20  [Playtest] finished armfrad team 0 at 0.19 min
  0.20  [Playtest] finished armason team 0 at 0.20 min
  0.20  [AIR][EcoLayout] reserved air.eco.1 reactor=352,752 converters=8 support=12 zone=284
  0.22  [AIR][EcoLayout] reserved air.eco.2 reactor=736,2288 converters=8 support=12 zone=306
  0.23  [AIR][EcoLayout] reserved air.eco.3 reactor=352,2672 converters=8 support=12 zone=328
  0.27  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] T2_SUSTAIN M=1 bank=100010 E=18 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
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
  0.27  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.27  [AIR][Share] metal 100012 of 100200 (99%): sent 90 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100014) (D-106)
  0.35  [AIR][Share] metal 100022 of 100200 (99%): sent 80 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.37  [AIR][Screen] fighters=16 cells=8 centre=2808,1130 width=2400 advance=2318 responding=false
  0.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100024) (D-106)
  0.43  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] T2_SUSTAIN M=2 bank=100030 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
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
  0.43  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.43  [AIR][Share] metal 100032 of 100200 (99%): sent 70 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100034) (D-106)
  0.52  [AIR][Share] metal 100042 of 100200 (99%): sent 60 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.53  [AIR][Screen] fighters=16 cells=8 centre=2808,1130 width=2400 advance=2318 responding=false
  0.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100044) (D-106)
  0.60  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] T2_SUSTAIN M=2 bank=100050 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
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
  0.60  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.60  [AIR][Attack] home=16 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.60  [AIR][Share] metal 100052 of 100200 (99%): sent 50 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100054) (D-106)
  0.68  [AIR][Share] metal 100062 of 100200 (99%): sent 40 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.70  [AIR][Screen] fighters=16 cells=8 centre=2808,1130 width=2400 advance=2318 responding=false
  0.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100064) (D-106)
  0.77  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] T2_SUSTAIN M=2 bank=100070 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
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
  0.77  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  0.77  [AIR][Share] metal 100072 of 100200 (99%): sent 30 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  0.80  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 100074) (D-106)
  0.87  [AIR][Screen] fighters=16 cells=8 centre=2808,1130 width=2400 advance=2318 responding=false
  0.93  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] T2_SUSTAIN M=2 bank=100090 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
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
  0.93  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 100100/100200, energy +9065.0 bank 1027375/1027375, units 40
  1.02  [AIR][Naval] theatre=0:1:1 enemy=5280 friendly=0 subs=0 antiSub=0 deficit=5280
  1.02  [AIR][Naval] escorts=16
  1.02  [AIR][Naval] launch=17 wanted=17 target=5034 reason=full ingress=2947,3915
  1.10  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T2_SUSTAIN M=2 bank=100111 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
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
  1.10  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.27  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T2_SUSTAIN M=2 bank=100131 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
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
  1.27  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.27  [AIR][Naval] attack=17 target=5034
  1.43  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T2_SUSTAIN M=2 bank=100151 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
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
  1.43  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.43  [AIR][Naval] attack=17 target=10044
  1.60  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T2_SUSTAIN M=2 bank=100171 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
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
  1.60  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.68  [AIR][Naval] attack=17 target=20167
  1.77  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=0 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T2_SUSTAIN M=2 bank=100191 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
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
  1.77  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  1.85  [AIR][Share] metal 100200 of 100200 (100%): no teammate with room (2 teammates); the engine counts 0 metal sent in the last update (D-106)
  1.93  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T2_SUSTAIN M=2 bank=100200 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
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
  1.93  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 100200/100200, energy +9065.0 bank 1027375/1027375, units 59
  2.10  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T2_SUSTAIN M=2 bank=100200 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
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
  2.10  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.10  [AIR][Naval] return survivors=17
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.11  [AIR][Screen] fighters=1 cells=8 centre=889,1135 width=600 advance=400 responding=false
  2.27  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T2_SUSTAIN M=2 bank=100200 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
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
  2.27  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.28  [AIR][Screen] fighters=16 cells=8 centre=2808,1130 width=2400 advance=2318 responding=false
  2.43  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T2_SUSTAIN M=2 bank=100200 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
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
  2.43  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.45  [AIR][Screen] fighters=16 cells=8 centre=2808,1130 width=2400 advance=2318 responding=false
  2.60  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T2_SUSTAIN M=2 bank=100200 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.60  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.60  [AIR][Attack] home=16 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.62  [AIR][Screen] fighters=16 cells=8 centre=2808,1130 width=2400 advance=2318 responding=false
  2.77  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T2_SUSTAIN M=2 bank=100200 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.77  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.78  [AIR][Screen] fighters=16 cells=8 centre=2808,1130 width=2400 advance=2318 responding=false
  2.93  [AIR][Capacity] own=2/9065 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=390 arriving=0 idle=390 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T2_SUSTAIN M=2 bank=100200 E=9065 bank=1027375 pull=0 plants=0/1 aircraftDemand=34/1407
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=390 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=online
  2.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.93  [AIR][Bay] 12 plant=30476 BP=3000 nanos=12+0/20 available=yes firstSlot=0
  2.93  [AIR][Share] metal 100200 of 100200 (100%): no teammate with room (2 teammates); the engine counts 0 metal sent in the last update (D-106)
  2.95  [AIR][Screen] fighters=16 cells=8 centre=2808,1130 width=2400 advance=2318 responding=false
... 472 more
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (1136, 1800) facing 1, 6x9 cells: 54 of 54 held
  0.18  RESERVE: armap at (1136, 1800) facing 1 (id 1)
  0.18  RESERVE: zone 2 at (1064, 1848) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1064, 1848) facing 1 (id 2)
  0.18  RESERVE: zone 3 at (1064, 1800) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1064, 1800) facing 1 (id 3)
  0.18  RESERVE: zone 4 at (1064, 1752) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1064, 1752) facing 1 (id 4)
  0.18  RESERVE: zone 5 at (1016, 1848) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1016, 1848) facing 1 (id 5)
  0.18  RESERVE: zone 6 at (1016, 1800) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1016, 1800) facing 1 (id 6)
  0.18  RESERVE: zone 7 at (1160, 1656) facing 1, 9x9 cells: 81 of 81 held
  0.18  RESERVE: armaap at (1160, 1656) facing 1 (id 7)
  0.18  RESERVE: zone 8 at (1064, 1704) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1064, 1704) facing 1 (id 8)
  0.18  RESERVE: zone 9 at (1064, 1656) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1064, 1656) facing 1 (id 9)
  0.18  RESERVE: zone 10 at (1064, 1608) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1064, 1608) facing 1 (id 10)
  0.18  RESERVE: zone 11 at (1016, 1704) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1016, 1704) facing 1 (id 11)
  0.18  RESERVE: zone 12 at (1016, 1656) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1016, 1656) facing 1 (id 12)
  0.18  RESERVE: zone 13 at (1016, 1608) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1016, 1608) facing 1 (id 13)
  0.18  RESERVE: zone 14 at (968, 1704) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (968, 1704) facing 1 (id 14)
  0.18  RESERVE: zone 15 at (968, 1656) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (968, 1656) facing 1 (id 15)
  0.18  RESERVE: zone 16 at (968, 1608) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (968, 1608) facing 1 (id 16)
  0.18  RESERVE: zone 17 at (920, 1704) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (920, 1704) facing 1 (id 17)
  0.18  RESERVE: zone 18 at (920, 1656) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (920, 1656) facing 1 (id 18)
  0.18  RESERVE: zone 19 at (920, 1608) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (920, 1608) facing 1 (id 19)
  0.18  RESERVE: zone 20 at (872, 1704) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (872, 1704) facing 1 (id 20)
  0.18  RESERVE: zone 21 at (872, 1656) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (872, 1656) facing 1 (id 21)
  0.18  RESERVE: zone 22 at (872, 1608) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (872, 1608) facing 1 (id 22)
  0.18  RESERVE: zone 23 at (824, 1704) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (824, 1704) facing 1 (id 23)
  0.18  RESERVE: zone 24 at (824, 1656) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (824, 1656) facing 1 (id 24)
  0.18  RESERVE: zone 25 at (824, 1608) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (824, 1608) facing 1 (id 25)
  0.18  RESERVE: zone 26 at (776, 1704) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (776, 1704) facing 1 (id 26)
  0.18  RESERVE: zone 27 at (776, 1656) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (776, 1656) facing 1 (id 27)
  0.18  RESERVE: zone 28 at (1160, 1512) facing 1, 9x9 cells: 81 of 81 held
  0.18  RESERVE: armaap at (1160, 1512) facing 1 (id 28)
  0.18  RESERVE: zone 29 at (1064, 1560) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1064, 1560) facing 1 (id 29)
  0.18  RESERVE: zone 30 at (1064, 1512) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1064, 1512) facing 1 (id 30)
  0.18  RESERVE: zone 31 at (1064, 1464) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1064, 1464) facing 1 (id 31)
  0.18  RESERVE: zone 32 at (1016, 1560) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1016, 1560) facing 1 (id 32)
  0.18  RESERVE: zone 33 at (1016, 1512) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1016, 1512) facing 1 (id 33)
  0.18  RESERVE: zone 34 at (1016, 1464) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1016, 1464) facing 1 (id 34)
  0.18  RESERVE: zone 35 at (968, 1560) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (968, 1560) facing 1 (id 35)
  0.18  RESERVE: zone 36 at (968, 1512) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (968, 1512) facing 1 (id 36)
  0.18  RESERVE: zone 37 at (968, 1464) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (968, 1464) facing 1 (id 37)
  0.18  RESERVE: zone 38 at (920, 1560) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (920, 1560) facing 1 (id 38)
  0.18  RESERVE: zone 39 at (920, 1512) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (920, 1512) facing 1 (id 39)
  0.18  RESERVE: zone 40 at (920, 1464) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (920, 1464) facing 1 (id 40)
  0.18  RESERVE: zone 41 at (872, 1560) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (872, 1560) facing 1 (id 41)
  0.18  RESERVE: zone 42 at (872, 1512) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (872, 1512) facing 1 (id 42)
  0.18  RESERVE: zone 43 at (872, 1464) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (872, 1464) facing 1 (id 43)
  0.18  RESERVE: zone 44 at (824, 1560) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (824, 1560) facing 1 (id 44)
  0.18  RESERVE: zone 45 at (824, 1512) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (824, 1512) facing 1 (id 45)
  0.18  RESERVE: zone 46 at (824, 1464) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (824, 1464) facing 1 (id 46)
  0.18  RESERVE: zone 47 at (776, 1560) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (776, 1560) facing 1 (id 47)
  0.18  RESERVE: zone 48 at (776, 1512) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (776, 1512) facing 1 (id 48)
  0.18  RESERVE: zone 49 at (1640, 1800) facing 1, 9x9 cells: 81 of 81 held
  0.18  RESERVE: armaap at (1640, 1800) facing 1 (id 49)
  0.18  RESERVE: zone 50 at (1544, 1848) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1544, 1848) facing 1 (id 50)
  0.18  RESERVE: zone 51 at (1544, 1800) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1544, 1800) facing 1 (id 51)
  0.18  RESERVE: zone 52 at (1544, 1752) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1544, 1752) facing 1 (id 52)
  0.18  RESERVE: zone 53 at (1496, 1848) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1496, 1848) facing 1 (id 53)
  0.18  RESERVE: zone 54 at (1496, 1800) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1496, 1800) facing 1 (id 54)
  0.18  RESERVE: zone 55 at (1496, 1752) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1496, 1752) facing 1 (id 55)
  0.18  RESERVE: zone 56 at (1448, 1848) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1448, 1848) facing 1 (id 56)
  0.18  RESERVE: zone 57 at (1448, 1800) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1448, 1800) facing 1 (id 57)
  0.18  RESERVE: zone 58 at (1448, 1752) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1448, 1752) facing 1 (id 58)
  0.18  RESERVE: zone 59 at (1400, 1848) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1400, 1848) facing 1 (id 59)
  0.18  RESERVE: zone 60 at (1400, 1800) facing 1, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotc at (1400, 1800) facing 1 (id 60)
```
