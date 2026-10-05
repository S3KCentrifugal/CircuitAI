# Playtest report: PASS

- Verdict: **PASS** (reached 7 min)
- Game time reached: 7.1 min (frame 12782); wall 99 s
- DLL: build-theatres\d193-build\SkirmishAI.dll (df4b5dd21490b768); AI BARbTest/test; staged 2026-10-04T16:34:05
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: response-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-t1-cortex\supreme\20261004T193405Z-5ae1f991\runs\20261004T193547Z-bbce6a7f\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:40.482677][f=-000001] [AirResponseWatch] loaded case=t1` |
| expect `production` | seen at 1.7 min | `[AIR][Produce] base.defence corshad plant=15409 projected=10/10` |
| expect `damage` | seen at 1.7 min | `[t=00:01:02.384466][f=0003100] [AirResponseWatch] damage frame=3100 attacker=corshad victim=armmar amount=150.275375 emp=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-t1-cortex\supreme\20261004T193405Z-5ae1f991\runs\20261004T193547Z-bbce6a7f\screen_2026-10-04_19-35-09-308.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-t1-cortex\supreme\20261004T193405Z-5ae1f991\runs\20261004T193547Z-bbce6a7f\screen_2026-10-04_19-35-12-927.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-t1-cortex\supreme\20261004T193405Z-5ae1f991\runs\20261004T193547Z-bbce6a7f\screen_2026-10-04_19-35-18-861.png

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
  0.10  [Team][Roster] Team 1 (AI 1): role=FRONT side=armada start=(837,10404) factory=armlab landLocked=no spot=1 known=1/1
  0.17  [Playtest] finished corap team 0 at 0.17 min
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
  0.18  [AIR][State] T1_CONTEST
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.18  [Playtest] finished armeyes team 0 at 0.18 min
  0.18  [AIR][Share] metal 100003 of 100100 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.19  [AIR][Produce] opening.scout corfink plant=15409 projected=1/1
  0.19  [Playtest] finished armarad team 0 at 0.19 min
  0.20  [AIR][EcoLayout] reserved air.eco.1 reactor=3056,11632 converters=8 support=12 zone=283
  0.22  [AIR][EcoLayout] reserved air.eco.2 reactor=3696,11120 converters=8 support=12 zone=305
  0.23  [AIR][EcoLayout] reserved air.eco.3 reactor=3184,11120 converters=8 support=12 zone=327
  0.24  [AIR][Scout] opening drone=23237 enemy starts=2
  0.26  [AIR][Produce] opening.screen corveng plant=15409 projected=1/6
  0.27  [AIR][Capacity] own=2/30 usage=0/26 gifts=0 sent=0 excess=0 pressure=false mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] T1_CONTEST M=1 bank=99960 E=18 bank=1027275 pull=26 plants=1/0 aircraftDemand=40/1550
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
  0.27  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  0.31  [AIR][Screen] fighters=1 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  0.34  [AIR][Produce] opening.screen corveng plant=15409 projected=2/6
  0.42  [AIR][Produce] opening.screen corveng plant=15409 projected=3/6
  0.43  [AIR][Capacity] own=2/9065 usage=0/26 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] T1_CONTEST M=2 bank=99832 E=9065 bank=1027275 pull=26 plants=1/0 aircraftDemand=53/1755
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
  0.43  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  0.48  [AIR][Screen] fighters=3 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  0.51  [AIR][Produce] opening.screen corveng plant=15409 projected=4/6
  0.59  [AIR][Produce] opening.screen corveng plant=15409 projected=5/6
  0.60  [AIR][Capacity] own=2/9065 usage=0/26 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] T1_CONTEST M=2 bank=99704 E=9065 bank=1027275 pull=26 plants=1/0 aircraftDemand=53/1755
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
  0.60  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  0.60  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.65  [AIR][Screen] fighters=5 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  0.67  [AIR][Produce] opening.screen corveng plant=15409 projected=6/6
  0.76  [AIR][Raid] opening size drawn=9
  0.76  [AIR][Produce] opening.raid corshad plant=15409 projected=1/9
  0.77  [AIR][Capacity] own=2/9065 usage=0/26 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] T1_CONTEST M=2 bank=99576 E=9065 bank=1027275 pull=26 plants=1/0 aircraftDemand=53/1755
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
  0.77  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  0.82  [AIR][Screen] fighters=6 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  0.84  [AIR][Produce] opening.raid corshad plant=15409 projected=2/9
  0.93  [AIR][Produce] opening.raid corshad plant=15409 projected=3/9
  0.93  [AIR][Capacity] own=2/9065 usage=9/320 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] T1_CONTEST M=2 bank=99299 E=9065 bank=1027275 pull=320 plants=1/0 aircraftDemand=53/1755
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
  0.93  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  1.00  [AIR][Screen] fighters=6 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99160/100100, energy +9065.0 bank 1027263/1027275, units 34
  1.02  [AIR][Produce] opening.raid corshad plant=15409 projected=4/9
  1.10  [AIR][Capacity] own=2/9065 usage=39/1242 gifts=38 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T1_CONTEST M=2 bank=99099 E=9065 bank=1027275 pull=1242 plants=1/0 aircraftDemand=53/1755
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
  1.10  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  1.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.10  [AIR][Share] metal 99101 of 100100 (99%): sent 69 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.10  [AIR][Produce] opening.raid corshad plant=15409 projected=5/9
  1.13  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99919) (D-106)
  1.17  [AIR][Screen] fighters=6 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  1.18  [AIR][Share] metal 99101 of 100100 (99%): sent 197 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.19  [AIR][Produce] opening.raid corshad plant=15409 projected=6/9
  1.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99785) (D-106)
  1.27  [AIR][Capacity] own=2/9065 usage=63/1958 gifts=56 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][State] T1_SCALE
  1.27  [AIR][Economy] T1_SCALE M=17 bank=99099 E=9065 bank=1027275 pull=1958 plants=1/0 aircraftDemand=53/1755
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
  1.27  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  1.27  [AIR][Share] metal 99101 of 100100 (99%): sent 325 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.27  [AIR][Produce] opening.raid corshad plant=15409 projected=7/9
  1.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99655) (D-106)
  1.33  [AIR][Screen] fighters=6 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  1.35  [AIR][Share] metal 99101 of 100100 (99%): sent 453 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.36  [AIR][Produce] opening.raid corshad plant=15409 projected=8/9
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99524) (D-106)
  1.43  [AIR][Capacity] own=2/9065 usage=54/1688 gifts=61 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T1_SCALE M=29 bank=99099 E=9065 bank=1027275 pull=1688 plants=1/0 aircraftDemand=53/1755
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  1.43  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/4 available=yes firstSlot=-1
  1.43  [AIR][Share] metal 99101 of 100100 (99%): sent 581 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.44  [AIR][Produce] opening.raid corshad plant=15409 projected=9/9
  1.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99394) (D-106)
  1.50  [AIR][Screen] fighters=6 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  1.52  [AIR][BaseResponse] contact=true
  1.52  [AIR][BaseResponse] group=0 target=19801
  1.52  [AIR][BaseResponse] group=1 target=19801
  1.52  [AIR][BaseResponse] group=2 target=19801
  1.52  [AIR][BaseResponse] dispatched=15 total=15
  1.52  [AIR][Share] metal 99101 of 100100 (99%): sent 710 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.52  [AIR][Produce] base.emp corbw plant=15409 projected=1/4
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99278) (D-106)
  1.58  [AIR][Produce] base.emp corbw plant=15409 projected=2/4
  1.60  [AIR][Capacity] own=2/9065 usage=0/11 gifts=35 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T1_SCALE M=21 bank=99101 E=9065 bank=1027275 pull=11 plants=1/0 aircraftDemand=40/1550
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  1.60  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/3 available=yes firstSlot=-1
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [AIR][Share] metal 99101 of 100100 (99%): sent 751 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.62  [AIR][State] T1_CONTEST
  1.63  [AIR][Produce] base.emp corbw plant=15409 projected=3/4
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99201) (D-106)
  1.67  [AIR][Produce] base.emp corbw plant=15409 projected=4/4
  1.68  [AIR][Share] metal 99099 of 100100 (99%): sent 897 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.70  [AIR][Produce] base.defence corshad plant=15409 projected=10/10
  1.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99078) (D-106)
  1.75  [AIR][BaseResponse] dispatched=1 total=16
  1.77  [AIR][Capacity] own=2/9060 usage=53/1653 gifts=69 sent=0 excess=0 pressure=true mobile=370 arriving=0 idle=370 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST M=12 bank=99099 E=9065 bank=1027250 pull=1653 plants=1/0 aircraftDemand=40/1550
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=370 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  1.77  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  1.78  [AIR][Produce] constructor.recovery corca plant=15409 projected=3/3
  1.80  [AIR][State] T1_SCALE
  1.87  [AIR][Produce] base.emp corbw plant=15409 projected=2/3
  1.92  [AIR][BaseResponse] dispatched=1 total=10
  1.93  [AIR][Produce] base.emp corbw plant=15409 projected=3/3
  1.93  [AIR][Capacity] own=2/9060 usage=37/847 gifts=14 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_SCALE M=18 bank=99099 E=9060 bank=1027275 pull=847 plants=1/0 aircraftDemand=40/1550
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  1.93  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/3 available=yes firstSlot=-1
  1.97  [AIR][Produce] base.defence corshad plant=15409 projected=7/7
  1.97  [AIR][State] T1_CONTEST
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 99029/100100, energy +9122.5 bank 1026813/1027275, units 30
  2.02  [AIR][BaseResponse] group=0 target=24014
  2.02  [AIR][BaseResponse] group=1 target=24014
  2.02  [AIR][BaseResponse] group=2 target=24014
  2.02  [AIR][BaseResponse] dispatched=1 total=8
  2.03  [AIR][BaseResponse] group=0 target=19801
  2.03  [AIR][BaseResponse] group=1 target=19801
  2.03  [AIR][BaseResponse] group=2 target=19801
  2.04  [AIR][Produce] base.emp corbw plant=15409 projected=2/2
  2.07  [AIR][BaseResponse] contact=false
  2.07  [AIR][BaseResponse] group=0 target=-1
  2.07  [AIR][BaseResponse] group=1 target=-1
  2.07  [AIR][BaseResponse] group=2 target=-1
  2.08  [AIR][Produce] intercept corveng plant=15409 projected=3/8
  2.10  [AIR][Capacity] own=2/9065 usage=8/201 gifts=32 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST M=12 bank=99099 E=9065 bank=1027275 pull=201 plants=1/0 aircraftDemand=40/1550
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  2.10  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.12  [AIR][Screen] fighters=1 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  2.13  [AIR][State] T1_SCALE
  2.14  [AIR][Produce] intercept corveng plant=15409 projected=3/7
  2.18  [AIR][State] T1_CONTEST
  2.21  [AIR][Produce] intercept corveng plant=15409 projected=3/6
  2.27  [AIR][Capacity] own=2/9065 usage=28/1107 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST M=2 bank=98988 E=9065 bank=1027275 pull=1107 plants=1/0 aircraftDemand=53/1755
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
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
  2.27  [AIR][Bay] 12 plant=15409 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  2.27  [AIR][BaseResponse] contact=true
  2.27  [AIR][BaseResponse] group=0 target=19801
  2.27  [AIR][BaseResponse] group=1 target=19801
  2.27  [AIR][BaseResponse] group=2 target=19801
  2.27  [AIR][BaseResponse] dispatched=3 total=4
  2.28  [AIR][BaseResponse] contact=false
  2.28  [AIR][BaseResponse] group=0 target=-1
  2.28  [AIR][BaseResponse] group=1 target=-1
  2.28  [AIR][BaseResponse] group=2 target=-1
  2.30  [AIR][Produce] intercept corveng plant=15409 projected=4/9
  2.36  [AIR][Screen] fighters=1 cells=8 centre=2386,11422 width=600 advance=400 responding=false
  2.38  [AIR][Produce] intercept corveng plant=15409 projected=5/9
  2.42  [AIR][BaseResponse] contact=true
  2.42  [AIR][BaseResponse] group=0 target=19801
  2.42  [AIR][BaseResponse] group=1 target=19801
  2.42  [AIR][BaseResponse] group=2 target=19801
  2.42  [AIR][BaseResponse] dispatched=1 total=4
  2.43  [AIR][Capacity] own=2/9065 usage=23/910 gifts=0 sent=0 excess=0 pressure=true mobile=425 arriving=0 idle=425 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=2 bank=98868 E=9065 bank=1027275 pull=910 plants=1/0 aircraftDemand=40/1550
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=425 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/20 available=yes firstSlot=0
... 638 more
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
