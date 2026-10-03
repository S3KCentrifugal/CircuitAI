# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54003); wall 218 s
- DLL: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\workforce-paired\cohort\20261003T172751Z-47454589\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T14:36:39
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=AIR/cortex/test, 3=TECH/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\glitters\runs\20261003T174021Z-d68b26be\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `layout` | seen at 0.1 min | `[AIR][Layout] enabled; adopted 0 bays, 0 wind clusters` |
| expect `economy` | seen at 0.1 min | `[AIR][Economy] BOOTSTRAP M=0 bank=995 E=0 bank=958 pull=69 plants=0/0 aircraftDemand=0/0` |
| forbid `script` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-028 metal bank over 50% for 60 s, 4 T2 constructors, none added` |
| forbid `crash` | clean |  |

## Failures

- forbid 'invariant' hit at 11.1 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 4 T2 constructors, none added
- forbid 'invariant' hit at 13.8 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 6 T2 constructors, none added
- forbid 'invariant' hit at 17.5 min: [INVARIANT] INV-021 a fusion frame started with a T1 mex at (1888, 9760) not upgraded
- forbid 'invariant' hit at 18.9 min: [INVARIANT] INV-010 combat unit legstr 7923 produced at +133 metal under the gate 200
- forbid 'invariant' hit at 24.4 min: [INVARIANT] INV-010 combat unit legstr 27776 produced at +192 metal under the gate 200
- forbid 'invariant' hit at 26.2 min: [INVARIANT] INV-010 combat unit legstr 4960 produced at +199 metal under the gate 200
- forbid 'invariant' hit at 28.1 min: [INVARIANT] INV-010 combat unit armfast 29075 produced at +121 metal under the gate 200
- forbid 'invariant' hit at 28.3 min: [t=00:03:11.644486][f=0050891] [INVARIANT] INV-090 AIR observer: expansion before twenty completed turrets per existing T2 lab
- forbid 'invariant' hit at 29.2 min: [INVARIANT] INV-010 combat unit legstr 25530 produced at +186 metal under the gate 200

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\glitters\runs\20261003T174021Z-d68b26be\screen_2026-10-03_17-37-40-530.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\glitters\runs\20261003T174021Z-d68b26be\screen_2026-10-03_17-38-14-528.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\economy\wf-baseline-1811001\cohort\20261003T172752Z-12902c78\glitters\runs\20261003T174021Z-d68b26be\screen_2026-10-03_17-38-36-802.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 30, 5 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2801, 775) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.00  [Playtest] frame 1 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.00  [Playtest] frame 1 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 30
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2801, 775) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (4211, 609) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (1943, 9622) units 1
  0.05  [Playtest] frame 90 team 4 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 5 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=995 E=0 bank=958 pull=69 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=304 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2832, 746), 53 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|2792|783|0|1|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(4228,591) factory=armlab landLocked=no spot=2 known=1/1
  0.17  [Playtest] finished armmex team 0 at 0.17 min
  0.18  [AIR][Rule] opening.mex builder=2274
  0.18  [Team][Roster] first mex 18764 at 2688,704
  0.18  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|2792|783|0|1|1|2688|704
  0.22  [Team][Roster] team 1 first mex at 4256,480
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=961 E=18 bank=633 pull=86 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=13/138
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=304 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.43  [AIR][Economy] BOOTSTRAP M=3 bank=950 E=30 bank=250 pull=89 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=1/13
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=378 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.44  [Playtest] finished armmex team 0 at 0.44 min
  0.45  [AIR][Wind] cluster=0 slots=6 at=2808,768 local=true builder=2274
  0.45  [AIR][Rule] opening.energy builder=2274
  0.59  [Playtest] finished armwin team 0 at 0.59 min
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=5 bank=977 E=30 bank=252 pull=41 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=445 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.60  [AIR][Rule] recovery.energy builder=2274
  0.75  [Playtest] finished armsolar team 0 at 0.75 min
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=7 bank=898 E=37 bank=656 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=1 committed=155/0
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=464 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.91  [Playtest] finished armsolar team 0 at 0.91 min
  0.93  [AIR][Rule] opening.energy builder=2274
  0.93  [AIR][Economy] BOOTSTRAP M=7 bank=814 E=65 bank=1095 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=180 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +7.5 bank 823/1150, energy +86.0 bank 1090/1100, units 8
  1.02  [Playtest] finished armwin team 0 at 1.02 min
  1.10  [AIR][Economy] BOOTSTRAP M=7 bank=831 E=83 bank=1095 pull=41 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=14/63
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.13  [Playtest] finished armwin team 0 at 1.13 min
  1.14  [AIR][Starter] nearby distance=192
  1.14  [AIR][Rule] opening.plant builder=2274
  1.15  [AIR][EcoLayout] reserved air.eco.0 reactor=3568,400 converters=8 zone=1032
  1.17  [AIR][EcoLayout] reserved air.eco.1 reactor=1904,400 converters=8 zone=1054
  1.18  [AIR][EcoLayout] reserved air.eco.2 reactor=3696,912 converters=8 zone=1069
  1.20  [AIR][EcoLayout] reserved air.eco.3 reactor=1648,912 converters=8 zone=1080
  1.27  [AIR][Economy] BOOTSTRAP M=7 bank=671 E=100 bank=1070 pull=69 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=401/680
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.27  [AIR][Bay] 0 plant=14169 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Economy] BOOTSTRAP M=7 bank=388 E=109 bank=1087 pull=69 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=44/74
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=14169 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.45  [Playtest] finished armap team 0 at 1.45 min
  1.47  [AIR][Produce] opening.scout armpeep plant=14169 projected=1/1
  1.47  [AIR][Claim] cancel unowned native order armnanotc
  1.47  [AIR][Claim] cancel unowned native order armnanotc
  1.47  [AIR][State] T1_CONTEST
  1.47  [AIR][Rule] opening.commander.guard builder=2274
  1.60  [AIR][Economy] T1_CONTEST M=7 bank=346 E=99 bank=511 pull=158 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.62  [AIR][Produce] constructor.recovery armca plant=14169 projected=1/3
  1.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=371 E=96 bank=406 pull=71 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=391 E=97 bank=263 pull=197 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/1 t2=0/1 targetBP=180 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.96  [AIR][Produce] constructor.recovery armca plant=14169 projected=2/3
  1.96  [AIR][Rule] recovery.energy builder=16353
  2.00  [Playtest] eco team 0 at 2.0 min: metal +7.5 bank 395/1250, energy +117.8 bank 131/1226, units 13
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=382 E=106 bank=15 pull=164 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=138/0
  2.10  [AIR][Workforce] t1=2/1 t2=0/1 targetBP=175 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.26  [AIR][Produce] constructor.recovery armca plant=14169 projected=3/3
  2.26  [AIR][Rule] recovery.energy builder=15131
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=366 E=118 bank=109 pull=109 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=1 committed=264/0
  2.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=167 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=328 E=123 bank=901 pull=176 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=211/0
  2.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=175 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.51  [AIR][Produce] opening.screen armfig plant=14169 projected=1/6
  2.51  [AIR][Rule] mex.expand builder=519
  2.54  [AIR][Rule] commander.factory.guard builder=2274
  2.60  [AIR][Economy] T1_CONTEST M=7 bank=266 E=127 bank=788 pull=383 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=200/485
  2.60  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.68  [AIR][Produce] opening.screen armfig plant=14169 projected=2/6
  2.68  [AIR][Screen] fighters=1 cells=8 centre=4194,989 width=600 advance=400 responding=false
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=201 E=132 bank=173 pull=275 plants=1/0 aircraftDemand=3/127
  2.77  [AIR][Projects] energyQueued=0 committed=126/346
  2.77  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.85  [AIR][Screen] fighters=1 cells=8 centre=4194,989 width=600 advance=400 responding=false
  2.88  [Playtest] finished armsolar team 0 at 2.88 min
  2.89  [AIR][Rule] recovery.assist builder=16353
  2.90  [AIR][Produce] opening.screen armfig plant=14169 projected=3/6
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=156 E=132 bank=554 pull=68 plants=1/0 aircraftDemand=3/127
  2.93  [AIR][Projects] energyQueued=0 committed=58/211
  2.93  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=171 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +7.5 bank 114/1250, energy +152.9 bank 49/1326, units 19
  3.03  [AIR][Screen] fighters=2 cells=8 centre=4194,989 width=600 advance=400 responding=false
  3.04  [Playtest] finished armsolar team 0 at 3.04 min
  3.05  [AIR][Rule] intel.radar builder=15131
  3.05  [AIR][Rule] wait builder=16353
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=110 E=150 bank=6 pull=271 plants=1/0 aircraftDemand=3/127
  3.10  [AIR][Projects] energyQueued=0 committed=67/708
  3.10  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=180 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=2 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.12  [AIR][Rule] project.assist builder=16353
  3.13  [AIR][Produce] opening.screen armfig plant=14169 projected=4/6
  3.13  [AIR][Commander] cleared factory guard for commander.idle.wait
  3.13  [AIR][Rule] commander.idle.wait builder=2274
  3.16  [AIR][Rule] commander.factory.guard builder=2274
  3.20  [AIR][Screen] fighters=3 cells=8 centre=4194,989 width=600 advance=400 responding=false
  3.21  [Playtest] finished armmex team 0 at 3.21 min
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=110 E=164 bank=31 pull=336 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=81/826
  3.27  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=153 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.32  [AIR][Layout] cluster=0 labs=3 at=1376,1047
  3.33  [AIR][Layout] cluster=1 labs=1 at=3392,1431
  3.35  [AIR][Layout] cluster=2 labs=1 at=3008,1431
  3.37  [AIR][Layout] cluster=3 labs=1 at=1664,567
  3.37  [AIR][Screen] fighters=3 cells=8 centre=4194,989 width=600 advance=400 responding=false
  3.38  [AIR][Layout] cluster=4 labs=1 at=2528,759
  3.41  [Playtest] finished armrad team 0 at 3.41 min
  3.43  [AIR][Rule] project.assist builder=15131
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=134 E=163 bank=6 pull=315 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=44/447
  3.43  [AIR][Workforce] t1=3/1 t2=0/1 targetBP=153 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.52  [AIR][Produce] opening.screen armfig plant=14169 projected=5/6
  3.57  [AIR][Screen] fighters=4 cells=8 centre=4194,989 width=600 advance=400 responding=false
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=169 E=168 bank=5 pull=302 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=22/229
  3.60  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=211 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=4 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.73  [Playtest] finished armmex team 0 at 3.72 min
  3.73  [AIR][Screen] fighters=4 cells=8 centre=4194,989 width=600 advance=400 responding=false
  3.74  [AIR][Rule] wait builder=15131
  3.75  [AIR][Rule] wait builder=16353
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=207 E=172 bank=25 pull=263 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=50/500
  3.77  [AIR][Workforce] t1=3/5 t2=0/2 targetBP=211 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=5 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.87  [AIR][Produce] opening.screen armfig plant=14169 projected=6/6
  3.92  [AIR][Screen] fighters=5 cells=8 centre=4194,989 width=600 advance=400 responding=false
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=565 E=172 bank=9 pull=287 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=48/487
  3.93  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=259 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Rule] project.assist builder=15131
  3.94  [AIR][Rule] project.assist builder=16353
  4.00  [Playtest] eco team 0 at 4.0 min: metal +11.2 bank 600/1350, energy +172.9 bank 6/1376, units 25
  4.08  [AIR][Screen] fighters=5 cells=8 centre=4194,989 width=600 advance=400 responding=false
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=632 E=172 bank=4 pull=277 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=44/445
  4.10  [AIR][Workforce] t1=3/6 t2=0/3 targetBP=250 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=5 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.24  [AIR][Commander] cleared factory guard for commander.idle.wait
  4.24  [AIR][Rule] commander.idle.wait builder=2274
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=10 bank=689 E=167 bank=495 pull=56 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=0 committed=11/116
  4.27  [AIR][Workforce] t1=3/5 t2=0/3 targetBP=241 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Screen] fighters=6 cells=8 centre=4194,989 width=600 advance=400 responding=false
  4.31  [Playtest] finished armmex team 0 at 4.31 min
  4.33  [AIR][Rule] wait builder=519
  4.33  [AIR][Rule] wait builder=15131
  4.33  [AIR][Rule] wait builder=16353
  4.38  [AIR][Produce] constructor.expand armca plant=14169 projected=4/5
  4.40  [AIR][Rule] commander.factory.guard builder=2274
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=11 bank=786 E=167 bank=1307 pull=148 plants=1/0 aircraftDemand=3/127
  4.43  [AIR][Projects] energyQueued=0 committed=0/0
  4.43  [AIR][Workforce] t1=4/6 t2=0/3 targetBP=268 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Screen] fighters=6 cells=8 centre=4194,989 width=600 advance=400 responding=false
  4.45  [AIR][Rule] energy.grow builder=519
  4.46  [AIR][Rule] energy.grow builder=15131
  4.46  [AIR][Rule] energy.grow builder=16353
  4.60  [AIR][Layout] repaired support air.bay.0 viable=5/5 slot=16515 at=3096,936
  4.60  [AIR][Wind] cluster=1 slots=6 at=3064,512 local=false builder=31012
  4.60  [AIR][Rule] energy.grow builder=31012
  4.60  [AIR][Economy] T1_CONTEST M=13 bank=807 E=170 bank=917 pull=223 plants=1/0 aircraftDemand=3/127
  4.60  [AIR][Projects] energyQueued=1 committed=145/638
  4.60  [AIR][Workforce] t1=4/7 t2=0/3 targetBP=312 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Screen] fighters=6 cells=8 centre=4194,989 width=600 advance=400 responding=false
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.60  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.60  [AIR][Rule] commander.idle.assist builder=2274
  4.67  [Playtest] finished armwin team 0 at 4.67 min
  4.77  [AIR][Economy] T1_CONTEST M=13 bank=869 E=173 bank=1399 pull=34 plants=1/0 aircraftDemand=3/127
  4.77  [AIR][Projects] energyQueued=0 committed=117/512
  4.77  [AIR][Workforce] t1=4/7 t2=0/3 targetBP=312 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Screen] fighters=6 cells=8 centre=4194,989 width=600 advance=400 responding=false
  4.83  [Playtest] finished armwin team 0 at 4.83 min
  4.93  [AIR][Economy] T1_CONTEST M=13 bank=932 E=193 bank=1401 pull=34 plants=1/0 aircraftDemand=3/127
  4.93  [AIR][Projects] energyQueued=0 committed=90/394
  4.93  [AIR][Workforce] t1=4/7 t2=0/3 targetBP=312 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Screen] fighters=6 cells=8 centre=4194,989 width=600 advance=400 responding=false
  5.00  [Playtest] eco team 0 at 5.0 min: metal +13.0 bank 971/1400, energy +209.7 bank 1401/1402, units 32
  5.00  [Playtest] target team 0 at (2801, 775) from its start position
  5.00  [Playtest] camera requested (3024,808) height=2200
  5.01  [Playtest] finished armwin team 0 at 5.01 min
  5.02  [Playtest] camera captured name=ta position=(3024,808) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (3024, 808)
  5.10  [AIR][Economy] T1_CONTEST M=13 bank=1017 E=208 bank=1332 pull=37 plants=1/0 aircraftDemand=3/127
  5.10  [AIR][Projects] energyQueued=0 committed=84/370
  5.10  [AIR][Workforce] t1=4/7 t2=0/3 targetBP=312 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Screen] fighters=6 cells=8 centre=4194,989 width=600 advance=400 responding=false
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.18  [Playtest] finished armwin team 0 at 5.18 min
  5.26  [Playtest] finished armwin team 0 at 5.26 min
  5.27  [AIR][Economy] T1_CONTEST M=13 bank=1081 E=225 bank=1392 pull=72 plants=1/0 aircraftDemand=3/127
  5.27  [AIR][Projects] energyQueued=0 committed=51/224
  5.27  [AIR][Workforce] t1=4/14 t2=0/6 targetBP=697 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  5.27  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.27  [AIR][Screen] fighters=6 cells=8 centre=4194,989 width=600 advance=400 responding=false
  5.28  [AIR][Rule] commander.energy.assist builder=2274
  5.29  [Playtest] finished armwin team 0 at 5.29 min
  5.30  [AIR][Wind] cluster=2 slots=6 at=2664,1248 local=false builder=16353
  5.36  [Playtest] finished armwin team 0 at 5.36 min
  5.43  [AIR][Economy] T1_CONTEST M=13 bank=1130 E=249 bank=1401 pull=62 plants=1/0 aircraftDemand=3/127
  5.43  [AIR][Projects] energyQueued=1 committed=89/393
  5.43  [AIR][Workforce] t1=4/15 t2=0/7 targetBP=726 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  5.43  [AIR][Bay] 0 plant=14169 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  5.43  [AIR][Screen] fighters=6 cells=8 centre=4194,989 width=600 advance=400 responding=false
  5.45  [Playtest] finished armwin team 0 at 5.45 min
  5.45  [Playtest] finished armwin team 0 at 5.45 min
  5.46  [AIR][Rule] storage.buffer builder=519
  5.47  [AIR][Rule] commander.idle.assist builder=2274
... 4284 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.08  RESERVE: zone 7 at (4683, 469) facing 0, 77x61 cells: 4089 of 4697 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4683, 965) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4683, 917) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4683, 869) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4683, 821) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (4568, 1048) facing 0 (id 63)
  0.08  RESERVE: zone 8 at (5003, 1445) facing 0, 41x45 cells: 1845 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (5003, 1797) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (5003, 1749) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (5003, 1701) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (5003, 1653) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (3920, 1504) facing 0 (id 116)
  0.08  RESERVE: zone 9 at (3920, 1432) facing 0, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (3920, 1456) facing 0: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (4016, 1480) facing 0, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 11 at (3920, 1480) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (3920, 1728) facing 0, 10x20 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (1461, 9771) facing 2, 77x61 cells: 4076 of 4697 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9275) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9323) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9371) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 9419) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (1704, 9192) facing 2 (id 63)
  0.09  RESERVE: zone 8 at (1461, 8795) facing 2, 41x45 cells: 1811 of 1845 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8443) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8491) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8539) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (1461, 8587) facing 2: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: leglab at (1968, 8720) facing 2 (id 116)
  0.09  RESERVE: zone 9 at (1968, 8792) facing 2, 6x3 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (1968, 8768) facing 2: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (2064, 8744) facing 2, 6x21 cells: 126 of 126 held
  0.09  RESERVE: corridor 11 at (1872, 8744) facing 2, 6x21 cells: 126 of 126 held
  0.09  RESERVE: zone 12 at (1968, 8744) facing 0, 6x9 cells: 0 of 54 held
  0.09  RESERVE: corridor 12 at (1968, 8496) facing 2, 10x20 cells: 164 of 200 held
  0.17  RESERVE: armlab at (3664, 1680) facing 0 (id 119)
  0.17  RESERVE: zone 12 at (3664, 1608) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3664, 1632) facing 0: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (3760, 1656) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (3664, 1656) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (3664, 1904) facing 0, 10x20 cells: 174 of 200 held
  0.17  RESERVE: leglab at (2352, 8736) facing 2 (id 119)
  0.17  RESERVE: zone 13 at (2352, 8808) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (2352, 8784) facing 2: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 14 at (2448, 8760) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: corridor 15 at (2256, 8760) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (2352, 8760) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (2352, 8512) facing 2, 10x20 cells: 180 of 200 held
  0.18  EXP: approach: corcom(24492) at (3450, 9702) walks to (3423, 9683), 139 from the cormex site (3312, 9600)
  0.25  RESERVE: armalab at (3128, 1496) facing 0 (id 122)
  0.25  RESERVE: zone 15 at (3128, 1376) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3128, 1424) facing 0: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (3128, 1448) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (3128, 1744) facing 0, 13x20 cells: 252 of 260 held
  0.25  RESERVE: zone 18 at (4704, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4704, 1888) facing 0 (id 127)
  0.25  RESERVE: zone 19 at (4672, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4672, 1888) facing 0 (id 128)
  0.25  RESERVE: zone 20 at (4640, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4640, 1888) facing 0 (id 129)
  0.25  RESERVE: zone 21 at (4608, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4608, 1888) facing 0 (id 130)
  0.25  RESERVE: zone 22 at (4576, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4576, 1888) facing 0 (id 131)
  0.25  RESERVE: zone 23 at (4544, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4544, 1888) facing 0 (id 132)
  0.25  RESERVE: zone 24 at (4512, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4512, 1888) facing 0 (id 133)
  0.25  RESERVE: zone 25 at (4480, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4480, 1888) facing 0 (id 134)
  0.25  RESERVE: zone 26 at (4448, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4448, 1888) facing 0 (id 135)
  0.25  RESERVE: zone 27 at (4416, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4416, 1888) facing 0 (id 136)
  0.25  RESERVE: zone 28 at (4384, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4384, 1888) facing 0 (id 137)
  0.25  RESERVE: zone 29 at (4064, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4064, 1888) facing 0 (id 138)
  0.25  RESERVE: zone 30 at (4032, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4032, 1888) facing 0 (id 139)
  0.25  RESERVE: zone 31 at (3808, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3808, 1888) facing 0 (id 140)
  0.25  RESERVE: zone 32 at (3776, 1888) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3776, 1888) facing 0 (id 141)
  0.25  RESERVE: zone 33 at (4480, 1776) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (4480, 1776) facing 0 (id 142)
  0.25  RESERVE: legalab at (3016, 8744) facing 2 (id 122)
  0.25  RESERVE: zone 17 at (3016, 8864) facing 2, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of legnanotc 2x2 gap 0 behind (3016, 8816) facing 2: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 18 at (3016, 8792) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 19 at (3016, 8496) facing 2, 13x20 cells: 252 of 260 held
  0.25  RESERVE: zone 20 at (1456, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1456, 8336) facing 0 (id 127)
  0.25  RESERVE: zone 21 at (1488, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1488, 8336) facing 0 (id 128)
  0.25  RESERVE: zone 22 at (1520, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1520, 8336) facing 0 (id 129)
  0.25  RESERVE: zone 23 at (1552, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1552, 8336) facing 0 (id 130)
  0.25  RESERVE: zone 24 at (1584, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1584, 8336) facing 0 (id 131)
  0.25  RESERVE: zone 25 at (1616, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1616, 8336) facing 0 (id 132)
  0.25  RESERVE: zone 26 at (1648, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1648, 8336) facing 0 (id 133)
  0.25  RESERVE: zone 27 at (1744, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1744, 8336) facing 0 (id 134)
  0.25  RESERVE: zone 28 at (1776, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (1776, 8336) facing 0 (id 135)
  0.25  RESERVE: zone 29 at (2096, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2096, 8336) facing 0 (id 136)
  0.25  RESERVE: zone 30 at (2128, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2128, 8336) facing 0 (id 137)
  0.25  RESERVE: zone 31 at (2160, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2160, 8336) facing 0 (id 138)
  0.25  RESERVE: zone 32 at (2192, 8336) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: legdrag at (2192, 8336) facing 0 (id 139)
  0.25  RESERVE: zone 33 at (2224, 8336) facing 0, 2x2 cells: 4 of 4 held
```
