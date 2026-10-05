# Playtest report: PASS

- Verdict: **PASS** (reached 7 min)
- Game time reached: 7.0 min (frame 12630); wall 97 s
- DLL: build-theatres\d193-build\SkirmishAI.dll (df4b5dd21490b768); AI BARbTest/test; staged 2026-10-04T16:34:09
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/legion/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: response-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-t1-legion\supreme\20261004T193409Z-1ff8a5be\runs\20261004T193550Z-757186c3\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:39.693988][f=-000001] [AirResponseWatch] loaded case=t1` |
| expect `production` | seen at 1.6 min | `[AIR][Produce] base.defence legmos plant=581 projected=10/10` |
| expect `damage` | seen at 1.9 min | `[t=00:01:03.549140][f=0003391] [AirResponseWatch] damage frame=3391 attacker=legmos victim=armmar amount=45.35186 emp=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-t1-legion\supreme\20261004T193409Z-1ff8a5be\runs\20261004T193550Z-757186c3\screen_2026-10-04_19-35-13-113.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-t1-legion\supreme\20261004T193409Z-1ff8a5be\runs\20261004T193550Z-757186c3\screen_2026-10-04_19-35-16-175.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\resp-t1-legion\supreme\20261004T193409Z-1ff8a5be\runs\20261004T193550Z-757186c3\screen_2026-10-04_19-35-18-680.png

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
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 24
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 24
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
  0.17  [Playtest] finished legap team 0 at 0.17 min
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
  0.18  [AIR][State] T1_CONTEST
  0.18  [AIR][Share] metal 100003 of 100100 (99%): no teammate with room (1 teammates); the engine counts 0 metal sent in the last update (D-106)
  0.18  [AIR][Produce] opening.scout legfig plant=581 projected=1/1
  0.19  [Playtest] finished armarad team 0 at 0.19 min
  0.20  [AIR][EcoLayout] reserved air.eco.1 reactor=3056,11616 converters=8 support=12 zone=283
  0.22  [AIR][EcoLayout] reserved air.eco.2 reactor=3184,11104 converters=8 support=12 zone=307
  0.23  [AIR][EcoLayout] reserved air.eco.3 reactor=3824,11360 converters=8 support=12 zone=341
  0.24  [AIR][Produce] opening.screen legfig plant=581 projected=2/6
  0.24  [AIR][Scout] opening drone=12218 enemy starts=2
  0.27  [AIR][Capacity] own=2/30 usage=3/172 gifts=0 sent=0 excess=0 pressure=false mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] T1_CONTEST M=1 bank=99967 E=18 bank=1027275 pull=172 plants=1/0 aircraftDemand=31/1245
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
  0.27  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  0.28  [AIR][Produce] opening.screen legfig plant=581 projected=3/7
  0.28  [AIR][Screen] fighters=1 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  0.31  [AIR][Produce] opening.screen legfig plant=581 projected=4/7
  0.35  [AIR][Produce] opening.screen legfig plant=581 projected=5/7
  0.38  [AIR][Produce] opening.screen legfig plant=581 projected=6/7
  0.41  [AIR][Produce] opening.screen legfig plant=581 projected=7/7
  0.43  [AIR][Capacity] own=2/9065 usage=6/300 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] T1_CONTEST M=2 bank=99790 E=9065 bank=1027275 pull=300 plants=1/0 aircraftDemand=46/1048
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
  0.43  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  0.45  [AIR][Produce] intercept legfig plant=581 projected=8/8
  0.45  [AIR][Screen] fighters=6 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  0.48  [AIR][Raid] opening size drawn=9
  0.48  [AIR][Produce] opening.raid legmos plant=581 projected=1/1
  0.54  [AIR][Produce] opening.raid legmos plant=581 projected=2/2
  0.60  [AIR][Capacity] own=2/9065 usage=52/987 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] T1_CONTEST M=2 bank=99548 E=9065 bank=1027275 pull=987 plants=1/0 aircraftDemand=46/1048
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
  0.60  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  0.60  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.62  [AIR][Screen] fighters=7 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  0.62  [AIR][Produce] opening.raid legmos plant=581 projected=3/3
  0.70  [AIR][Produce] opening.raid legmos plant=581 projected=4/4
  0.77  [AIR][Capacity] own=2/9065 usage=55/1037 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] T1_CONTEST M=2 bank=99354 E=9065 bank=1027275 pull=1037 plants=1/0 aircraftDemand=46/1048
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
  0.77  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  0.78  [AIR][Screen] fighters=7 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  0.79  [AIR][Produce] opening.raid legmos plant=581 projected=5/5
  0.87  [AIR][Produce] opening.raid legmos plant=581 projected=6/6
  0.93  [AIR][Capacity] own=2/9065 usage=49/934 gifts=0 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] T1_CONTEST M=2 bank=99166 E=9065 bank=1027275 pull=934 plants=1/0 aircraftDemand=46/1048
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
  0.93  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  0.95  [AIR][Screen] fighters=7 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  0.96  [AIR][Produce] opening.raid legmos plant=581 projected=7/7
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 99072/100100, energy +9065.0 bank 1027028/1027275, units 40
  1.02  [AIR][Share] metal 99099 of 100100 (99%): sent 69 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.04  [AIR][Produce] opening.raid legmos plant=581 projected=8/8
  1.05  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99934) (D-106)
  1.10  [AIR][Capacity] own=2/9065 usage=44/830 gifts=4 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T1_CONTEST M=2 bank=99099 E=9065 bank=1027275 pull=830 plants=1/0 aircraftDemand=46/1048
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
  1.10  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  1.10  [AIR][Attack] home=7 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.10  [AIR][Share] metal 99099 of 100100 (99%): sent 158 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.12  [AIR][Screen] fighters=7 cells=8 centre=2386,11421 width=600 advance=400 responding=false
  1.13  [AIR][Produce] opening.raid legmos plant=581 projected=9/9
  1.13  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99845) (D-106)
  1.18  [AIR][Share] metal 99099 of 100100 (99%): sent 229 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.20  [AIR][State] T1_SCALE
  1.21  [AIR][Produce] air.control legfig plant=581 projected=9/9
  1.22  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99758) (D-106)
  1.26  [AIR][Produce] front.support legkam plant=581 projected=1/3
  1.27  [AIR][Capacity] own=2/9065 usage=25/1038 gifts=10 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T1_SCALE M=15 bank=99099 E=9065 bank=1027275 pull=1038 plants=1/0 aircraftDemand=46/1048
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
  1.27  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  1.27  [AIR][Share] metal 99099 of 100100 (99%): sent 287 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.29  [AIR][Produce] front.support legkam plant=581 projected=2/3
  1.30  [AIR][Screen] fighters=8 cells=8 centre=2765,10889 width=1200 advance=1052 responding=false
  1.30  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99668) (D-106)
  1.33  [AIR][Produce] air.control legfig plant=581 projected=10/10
  1.35  [AIR][Scout] opening drone=25054 enemy starts=2
  1.35  [AIR][Scout] replacement drone=25054
  1.35  [AIR][Share] metal 99099 of 100100 (99%): sent 415 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.36  [AIR][Produce] front.support legkam plant=581 projected=3/3
  1.38  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99527) (D-106)
  1.39  [AIR][Produce] air.control legfig plant=581 projected=10/10
  1.42  [AIR][Produce] air.control legfig plant=581 projected=11/11
  1.43  [AIR][Capacity] own=2/9065 usage=24/1020 gifts=13 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T1_SCALE M=15 bank=99099 E=9065 bank=1027275 pull=1020 plants=1/0 aircraftDemand=46/1048
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
  1.43  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  1.43  [AIR][Share] metal 99099 of 100100 (99%): sent 520 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.45  [AIR][Produce] air.control legfig plant=581 projected=12/12
  1.47  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99429) (D-106)
  1.48  [AIR][Produce] air.control legfig plant=581 projected=13/13
  1.48  [AIR][Screen] fighters=11 cells=8 centre=2765,10889 width=1200 advance=1052 responding=false
  1.52  [AIR][BaseResponse] contact=true
  1.52  [AIR][BaseResponse] group=0 target=10269
  1.52  [AIR][BaseResponse] group=1 target=10269
  1.52  [AIR][BaseResponse] group=2 target=10269
  1.52  [AIR][BaseResponse] dispatched=25 total=25
  1.52  [AIR][Share] metal 99101 of 100100 (99%): sent 601 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.55  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99402) (D-106)
  1.56  [AIR][Produce] base.defence legmos plant=581 projected=10/10
  1.58  [AIR][State] T1_CONTEST
  1.60  [AIR][Capacity] own=2/9065 usage=70/1291 gifts=16 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T1_CONTEST M=9 bank=99099 E=9065 bank=1027275 pull=1291 plants=1/0 aircraftDemand=31/1245
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
  1.60  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/2 available=yes firstSlot=-1
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.60  [AIR][Share] metal 99099 of 100100 (99%): sent 687 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.61  [AIR][Produce] base.defence legmos plant=581 projected=11/11
  1.63  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99304) (D-106)
  1.67  [AIR][BaseResponse] dispatched=1 total=23
  1.67  [Playtest] finished legvision team 0 at 1.67 min
  1.67  [AIR][Produce] base.defence legmos plant=581 projected=12/12
  1.68  [AIR][Share] metal 99099 of 100100 (99%): sent 782 to team 1 (99% full); the engine counts 0 metal sent in the last update (D-106)
  1.72  [AIR][Share] after the donation: we sent 0; team 1 received 0 (bank 99145) (D-106)
  1.73  [AIR][BaseResponse] dispatched=1 total=22
  1.73  [AIR][Produce] base.defence legmos plant=581 projected=13/13
  1.77  [AIR][Capacity] own=2/9065 usage=1/25 gifts=20 sent=0 excess=0 pressure=true mobile=320 arriving=0 idle=320 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][State] T1_SCALE
  1.77  [AIR][Economy] T1_SCALE M=18 bank=99099 E=9065 bank=1027250 pull=25 plants=1/0 aircraftDemand=31/1245
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=2/3 t2=2/2 targetBP=320 floating=true savingLab=false
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
  1.77  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/3 available=yes firstSlot=-1
  1.80  [AIR][BaseResponse] contact=false
  1.80  [AIR][BaseResponse] group=0 target=-1
  1.80  [AIR][BaseResponse] group=1 target=-1
  1.80  [AIR][BaseResponse] group=2 target=-1
  1.82  [AIR][BaseResponse] contact=true
  1.82  [AIR][BaseResponse] group=0 target=10269
  1.82  [AIR][BaseResponse] group=1 target=10269
  1.82  [AIR][BaseResponse] group=2 target=10269
  1.82  [AIR][BaseResponse] dispatched=1 total=16
  1.82  [AIR][Produce] constructor.recovery legca plant=581 projected=3/3
  1.83  [AIR][BaseResponse] group=0 target=24245
  1.83  [AIR][BaseResponse] group=1 target=24245
  1.83  [AIR][BaseResponse] group=2 target=24245
  1.89  [AIR][Produce] base.defence legmos plant=581 projected=12/12
  1.93  [AIR][Capacity] own=2/9060 usage=26/481 gifts=4 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_SCALE M=18 bank=99099 E=9060 bank=1027275 pull=481 plants=1/0 aircraftDemand=31/1245
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
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
  1.93  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/3 available=yes firstSlot=-1
  1.93  [AIR][BaseResponse] group=0 target=347
  1.93  [AIR][BaseResponse] group=1 target=347
  1.93  [AIR][BaseResponse] group=2 target=347
  1.95  [AIR][BaseResponse] dispatched=1 total=11
  1.96  [AIR][Produce] base.defence legmos plant=581 projected=11/11
  2.00  [AIR][BaseResponse] contact=false
  2.00  [AIR][BaseResponse] group=0 target=-1
  2.00  [AIR][BaseResponse] group=1 target=-1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 99052/100100, energy +9065.0 bank 1027043/1027275, units 31
  2.03  [AIR][BaseResponse] contact=true
  2.03  [AIR][BaseResponse] group=0 target=19348
  2.03  [AIR][BaseResponse] group=1 target=19348
  2.03  [AIR][BaseResponse] group=2 target=19348
  2.03  [AIR][BaseResponse] dispatched=1 total=8
  2.03  [AIR][Produce] base.defence legmos plant=581 projected=9/9
  2.05  [AIR][BaseResponse] contact=false
  2.05  [AIR][BaseResponse] group=0 target=-1
  2.05  [AIR][BaseResponse] group=1 target=-1
  2.05  [AIR][BaseResponse] group=2 target=-1
  2.07  [AIR][BaseResponse] contact=true
  2.07  [AIR][BaseResponse] group=0 target=19348
  2.07  [AIR][BaseResponse] group=1 target=19348
  2.07  [AIR][BaseResponse] group=2 target=19348
  2.08  [AIR][BaseResponse] group=0 target=2158
  2.08  [AIR][BaseResponse] group=1 target=2158
  2.08  [AIR][BaseResponse] group=2 target=2158
  2.10  [AIR][Capacity] own=2/9065 usage=63/1161 gifts=25 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_SCALE M=22 bank=99099 E=9064 bank=1027275 pull=1161 plants=1/0 aircraftDemand=31/1245
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=3/3 t2=2/2 targetBP=365 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/4 available=yes firstSlot=0
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
  2.10  [AIR][Bay] 12 plant=581 BP=2550 nanos=12+0/4 available=yes firstSlot=-1
  2.10  [AIR][BaseResponse] group=0 target=19348
  2.10  [AIR][BaseResponse] group=1 target=19348
  2.10  [AIR][BaseResponse] group=2 target=19348
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.11  [AIR][Produce] base.defence legmos plant=581 projected=8/8
  2.20  [AIR][Produce] base.defence legmos plant=581 projected=5/5
  2.23  [AIR][BaseResponse] group=0 target=2158
  2.23  [AIR][BaseResponse] group=1 target=2158
  2.23  [AIR][BaseResponse] group=2 target=2158
  2.25  [AIR][BaseResponse] contact=false
  2.25  [AIR][BaseResponse] group=0 target=-1
  2.25  [AIR][BaseResponse] group=1 target=-1
  2.25  [AIR][BaseResponse] group=2 target=-1
  2.27  [AIR][Capacity] own=2/9065 usage=64/1174 gifts=25 sent=0 excess=0 pressure=true mobile=365 arriving=0 idle=365 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_SCALE M=19 bank=99045 E=9065 bank=1027275 pull=1174 plants=1/0 aircraftDemand=31/1245
... 1179 more
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
