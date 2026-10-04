# Playtest report: PASS

- Verdict: **PASS** (reached 8 min)
- Game time reached: 8.5 min (frame 15302); wall 1 s
- DLL: build-theatres\d179-build\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T12:14:35
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_recon.json; widget loaded: yes
- Log: build-theatres\games\air\combat\recon-d179-centered\supreme\20261003T151316Z-5948569b\runs\20261003T151753Z-093b24ce\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `formation` | seen at 1.0 min | `[AIR][Recon] formation slots=20 columns=11 spacing=1125 sight=1250` |
| expect `dispatch` | seen at 1.5 min | `[AIR][Recon] synchronized sweep=20 formed=20 spacing=1125` |
| expect `survey` | seen at 2.6 min | `[AirReconProbe] waiting=0 sweeping=20 surveying=20 productionTarget=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- build-theatres\games\air\combat\recon-d179-centered\supreme\20261003T151316Z-5948569b\runs\20261003T151753Z-093b24ce\screen_2026-10-03_15-15-32-558.png
- build-theatres\games\air\combat\recon-d179-centered\supreme\20261003T151316Z-5948569b\runs\20261003T151753Z-093b24ce\screen_2026-10-03_15-15-37-782.png
- build-theatres\games\air\combat\recon-d179-centered\supreme\20261003T151316Z-5948569b\runs\20261003T151753Z-093b24ce\screen_2026-10-03_15-15-45-755.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 8, 0 shots, end at 8.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order corap
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=314 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 19 from the start
  0.27  [AIR][Layout] cluster=0 labs=6 at=2130,11676
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=1000 E=21 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=350 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.27  [Playtest] finished coraap team 0 at 0.27 min
  0.28  [AIR][State] T2_SUSTAIN
  0.29  [Playtest] finished cornanotc team 0 at 0.29 min
  0.29  [Playtest] finished cornanotc team 0 at 0.29 min
  0.29  [Playtest] finished cornanotc team 0 at 0.29 min
  0.30  [AIR][EcoLayout] reserved air.eco.0 reactor=2800,11888 converters=8 zone=137
  0.30  [AIR][Layout] cluster=1 labs=6 at=2610,11484
  0.30  [Playtest] finished cornanotc team 0 at 0.30 min
  0.31  [Playtest] finished cornanotc team 0 at 0.31 min
  0.32  [AIR][EcoLayout] reserved air.eco.1 reactor=1520,11888 converters=8 zone=259
  0.32  [Playtest] finished cornanotc team 0 at 0.32 min
  0.33  [Playtest] finished cornanotc team 0 at 0.32 min
  0.33  [AIR][EcoLayout] reserved air.eco.2 reactor=3184,11504 converters=8 zone=270
  0.33  [Playtest] finished cornanotc team 0 at 0.33 min
  0.34  [Playtest] finished cornanotc team 0 at 0.34 min
  0.35  [AIR][EcoLayout] reserved air.eco.3 reactor=3696,11120 converters=8 zone=280
  0.35  [Playtest] finished cornanotc team 0 at 0.35 min
  0.36  [Playtest] finished cornanotc team 0 at 0.36 min
  0.37  [Playtest] finished cornanotc team 0 at 0.37 min
  0.38  [Playtest] finished cornanotc team 0 at 0.38 min
  0.38  [Playtest] finished cornanotc team 0 at 0.38 min
  0.39  [Playtest] finished cornanotc team 0 at 0.39 min
  0.40  [Playtest] finished cornanotc team 0 at 0.40 min
  0.41  [Playtest] finished cornanotc team 0 at 0.41 min
  0.42  [Playtest] finished cornanotc team 0 at 0.42 min
  0.42  [Playtest] finished cornanotc team 0 at 0.43 min
  0.43  [AIR][Economy] T2_SUSTAIN M=2 bank=1018 E=30 bank=1200 pull=0 plants=0/1 aircraftDemand=50/1766
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=322 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.43  [AIR][Bay] 0 plant=14974 BP=4400 nanos=19+0/0 available=yes firstSlot=0
  0.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.43  [Playtest] finished cornanotc team 0 at 0.43 min
  0.44  [Playtest] finished coraap team 0 at 0.44 min
  0.45  [AIR][State] MULTIPLANT
  0.45  [Playtest] finished cornanotc team 0 at 0.45 min
  0.46  [Playtest] finished cornanotc team 0 at 0.46 min
  0.47  [Playtest] finished cornanotc team 0 at 0.47 min
  0.47  [Playtest] finished cornanotc team 0 at 0.47 min
  0.48  [Playtest] finished cornanotc team 0 at 0.48 min
  0.49  [Playtest] finished cornanotc team 0 at 0.49 min
  0.50  [Playtest] finished cornanotc team 0 at 0.50 min
  0.51  [Playtest] finished cornanotc team 0 at 0.51 min
  0.52  [Playtest] finished cornanotc team 0 at 0.52 min
  0.53  [Playtest] finished cornanotc team 0 at 0.52 min
  0.53  [Playtest] finished cornanotc team 0 at 0.53 min
  0.54  [Playtest] finished cornanotc team 0 at 0.54 min
  0.55  [Playtest] finished cornanotc team 0 at 0.55 min
  0.56  [Playtest] finished cornanotc team 0 at 0.56 min
  0.57  [Playtest] finished cornanotc team 0 at 0.57 min
  0.58  [Playtest] finished cornanotc team 0 at 0.58 min
  0.58  [Playtest] finished cornanotc team 0 at 0.58 min
  0.59  [Playtest] finished cornanotc team 0 at 0.59 min
  0.60  [AIR][Economy] MULTIPLANT M=2 bank=1038 E=30 bank=1400 pull=0 plants=0/2 aircraftDemand=100/3532
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 1 plant=1605 BP=4200 nanos=18+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.60  [Playtest] finished cornanotc team 0 at 0.60 min
  0.61  [Playtest] finished cornanotc team 0 at 0.61 min
  0.62  [Playtest] finished coraap team 0 at 0.62 min
  0.63  [Playtest] finished cornanotc team 0 at 0.63 min
  0.63  [Playtest] finished cornanotc team 0 at 0.63 min
  0.64  [Playtest] finished cornanotc team 0 at 0.64 min
  0.65  [Playtest] finished cornanotc team 0 at 0.65 min
  0.66  [Playtest] finished cornanotc team 0 at 0.66 min
  0.67  [Playtest] finished cornanotc team 0 at 0.67 min
  0.68  [Playtest] finished cornanotc team 0 at 0.68 min
  0.68  [Playtest] finished cornanotc team 0 at 0.68 min
  0.69  [Playtest] finished cornanotc team 0 at 0.69 min
  0.70  [Playtest] finished cornanotc team 0 at 0.70 min
  0.71  [Playtest] finished cornanotc team 0 at 0.71 min
  0.72  [Playtest] finished cornanotc team 0 at 0.72 min
  0.73  [Playtest] finished cornanotc team 0 at 0.73 min
  0.73  [Playtest] finished cornanotc team 0 at 0.73 min
  0.74  [Playtest] finished cornanotc team 0 at 0.74 min
  0.75  [Playtest] finished cornanotc team 0 at 0.75 min
  0.76  [Playtest] finished cornanotc team 0 at 0.76 min
  0.77  [AIR][Economy] MULTIPLANT M=2 bank=1058 E=30 bank=1600 pull=0 plants=0/3 aircraftDemand=150/5297
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.77  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 1 plant=1605 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 2 plant=17635 BP=4000 nanos=17+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [Playtest] finished cornanotc team 0 at 0.77 min
  0.78  [Playtest] finished cornanotc team 0 at 0.78 min
  0.78  [Playtest] finished cornanotc team 0 at 0.78 min
  0.79  [Playtest] finished coraap team 0 at 0.79 min
  0.80  [Playtest] finished cornanotc team 0 at 0.80 min
  0.81  [Playtest] finished cornanotc team 0 at 0.81 min
  0.82  [Playtest] finished cornanotc team 0 at 0.82 min
  0.83  [Playtest] finished cornanotc team 0 at 0.83 min
  0.84  [Playtest] finished cornanotc team 0 at 0.84 min
  0.84  [Playtest] finished cornanotc team 0 at 0.84 min
  0.85  [Playtest] finished cornanotc team 0 at 0.85 min
  0.86  [Playtest] finished cornanotc team 0 at 0.86 min
  0.87  [Playtest] finished cornanotc team 0 at 0.87 min
  0.88  [Playtest] finished cornanotc team 0 at 0.88 min
  0.88  [Playtest] finished cornanotc team 0 at 0.88 min
  0.89  [Playtest] finished cornanotc team 0 at 0.89 min
  0.90  [Playtest] finished cornanotc team 0 at 0.90 min
  0.91  [Playtest] finished cornanotc team 0 at 0.91 min
  0.92  [Playtest] finished cornanotc team 0 at 0.92 min
  0.93  [Playtest] finished cornanotc team 0 at 0.93 min
  0.93  [AIR][Economy] MULTIPLANT M=2 bank=1078 E=30 bank=1800 pull=0 plants=0/4 aircraftDemand=200/7061
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.93  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 1 plant=1605 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 2 plant=17635 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 3 plant=5103 BP=3800 nanos=16+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.94  [Playtest] finished cornanotc team 0 at 0.94 min
  0.94  [Playtest] finished cornanotc team 0 at 0.94 min
  0.95  [Playtest] finished cornanotc team 0 at 0.95 min
  0.96  [Playtest] finished cornanotc team 0 at 0.96 min
  0.97  [Playtest] finished coraap team 0 at 0.97 min
  0.98  [Playtest] finished cornanotc team 0 at 0.98 min
  0.98  [Playtest] finished cornanotc team 0 at 0.98 min
  0.99  [Playtest] finished cornanotc team 0 at 0.99 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1087/2000, energy +30.0 bank 1845/2000, units 89
  1.00  [Playtest] finished cornanotc team 0 at 1.00 min
  1.01  [Playtest] finished cornanotc team 0 at 1.01 min
  1.01  [AIR][Recon] formation slots=20 columns=11 spacing=1125 sight=1250
  1.02  [Playtest] finished cornanotc team 0 at 1.02 min
  1.03  [Playtest] finished cornanotc team 0 at 1.03 min
  1.03  [Playtest] finished cornanotc team 0 at 1.03 min
  1.04  [Playtest] finished cornanotc team 0 at 1.04 min
  1.05  [Playtest] finished cornanotc team 0 at 1.05 min
  1.06  [Playtest] finished cornanotc team 0 at 1.06 min
  1.07  [Playtest] finished cornanotc team 0 at 1.07 min
  1.08  [Playtest] finished cornanotc team 0 at 1.08 min
  1.08  [Playtest] finished cornanotc team 0 at 1.09 min
  1.09  [Playtest] finished cornanotc team 0 at 1.09 min
  1.10  [AIR][Economy] MULTIPLANT M=2 bank=1098 E=30 bank=2000 pull=0 plants=0/5 aircraftDemand=250/8823
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.10  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 1 plant=1605 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 2 plant=17635 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 3 plant=5103 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 4 plant=31224 BP=3600 nanos=15+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.10  [Playtest] finished cornanotc team 0 at 1.10 min
  1.11  [Playtest] finished cornanotc team 0 at 1.11 min
  1.12  [Playtest] finished cornanotc team 0 at 1.12 min
  1.12  [Playtest] finished cornanotc team 0 at 1.13 min
  1.13  [Playtest] finished cornanotc team 0 at 1.13 min
  1.14  [Playtest] finished coraap team 0 at 1.14 min
  1.15  [Playtest] finished cornanotc team 0 at 1.15 min
  1.16  [Playtest] finished cornanotc team 0 at 1.16 min
  1.17  [Playtest] finished cornanotc team 0 at 1.17 min
  1.18  [Playtest] finished cornanotc team 0 at 1.18 min
  1.18  [Playtest] finished cornanotc team 0 at 1.18 min
  1.19  [Playtest] finished cornanotc team 0 at 1.19 min
  1.20  [Playtest] finished cornanotc team 0 at 1.20 min
  1.21  [Playtest] finished cornanotc team 0 at 1.21 min
  1.22  [Playtest] finished cornanotc team 0 at 1.22 min
  1.23  [Playtest] finished cornanotc team 0 at 1.23 min
  1.23  [Playtest] finished cornanotc team 0 at 1.23 min
  1.24  [Playtest] finished cornanotc team 0 at 1.24 min
  1.25  [Playtest] finished cornanotc team 0 at 1.25 min
  1.26  [Playtest] finished cornanotc team 0 at 1.26 min
  1.27  [AIR][Economy] MULTIPLANT M=2 bank=1118 E=30 bank=2200 pull=0 plants=0/6 aircraftDemand=300/10585
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.27  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=1605 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 2 plant=17635 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 3 plant=5103 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 4 plant=31224 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 5 plant=5575 BP=3400 nanos=14+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [Playtest] finished cornanotc team 0 at 1.27 min
  1.28  [Playtest] finished cornanotc team 0 at 1.28 min
  1.28  [Playtest] finished cornanotc team 0 at 1.28 min
  1.29  [Playtest] finished cornanotc team 0 at 1.29 min
  1.30  [Playtest] finished cornanotc team 0 at 1.30 min
  1.31  [Playtest] finished cornanotc team 0 at 1.31 min
  1.43  [AIR][Economy] MULTIPLANT M=2 bank=1138 E=30 bank=2200 pull=0 plants=0/6 aircraftDemand=312/10996
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.43  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=1605 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=17635 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=5103 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=31224 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=5575 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.48  [AIR][Recon] synchronized sweep=20 formed=20 spacing=1125
  1.60  [AIR][Economy] MULTIPLANT M=2 bank=1158 E=30 bank=2200 pull=0 plants=0/6 aircraftDemand=312/10996
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=1605 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=17635 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=5103 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=31224 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=5575 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.70  [AIR][Recon] nearby bases plane=7342 bases=2
  1.73  [AIR][Recon] nearby bases plane=17680 bases=2
  1.77  [AIR][Economy] MULTIPLANT M=2 bank=1178 E=30 bank=2200 pull=0 plants=0/6 aircraftDemand=312/10996
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.77  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=1605 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=17635 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=5103 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=31224 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=5575 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.80  [AIR][Recon] nearby bases plane=24953 bases=2
  1.82  [AIR][Recon] nearby bases plane=13403 bases=2
  1.83  [AIR][Recon] nearby bases plane=27167 bases=2
  1.88  [AIR][Recon] nearby bases plane=13325 bases=2
  1.88  [AIR][Recon] nearby bases plane=12142 bases=2
  1.90  [AIR][Recon] nearby bases plane=29608 bases=2
  1.90  [AIR][Recon] nearby bases plane=30000 bases=2
  1.90  [AIR][Recon] nearby bases plane=8466 bases=2
  1.92  [AIR][Recon] nearby bases plane=18002 bases=2
  1.93  [AIR][Economy] MULTIPLANT M=2 bank=1198 E=30 bank=2200 pull=0 plants=0/6 aircraftDemand=312/10996
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=1605 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=17635 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=5103 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=31224 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=5575 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Recon] nearby bases plane=20707 bases=2
  1.93  [AIR][Recon] nearby bases plane=22937 bases=2
  1.95  [AIR][Recon] nearby bases plane=24393 bases=2
  2.00  [AIR][Recon] nearby bases plane=12325 bases=2
  2.00  [AIR][Recon] nearby bases plane=9691 bases=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1207/2200, energy +30.0 bank 2200/2200, units 147
  2.02  [AIR][Recon] nearby bases plane=10397 bases=2
  2.05  [AIR][Recon] nearby bases plane=16032 bases=2
  2.08  [AIR][Recon] nearby bases plane=14115 bases=2
  2.10  [AIR][Economy] MULTIPLANT M=2 bank=1218 E=30 bank=2200 pull=0 plants=0/6 aircraftDemand=312/10996
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=1605 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=17635 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=5103 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=31224 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=5575 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Recon] nearby bases plane=25673 bases=2
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Economy] MULTIPLANT M=2 bank=1238 E=30 bank=2200 pull=0 plants=0/6 aircraftDemand=312/10996
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.27  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=1605 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=17635 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=5103 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=31224 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=5575 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Economy] MULTIPLANT M=2 bank=1258 E=30 bank=2200 pull=0 plants=0/6 aircraftDemand=312/10996
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=48 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Bay] 0 plant=14974 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=1605 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=17635 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=5103 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=31224 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=5575 BP=4600 nanos=20+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 596 more
```

## Native lines (all AIs, first 120)

```
  0.27  RESERVE: zone 1 at (2056, 11272) facing 2, 9x9 cells: 81 of 81 held
  0.27  RESERVE: coraap at (2056, 11272) facing 2 (id 1)
  0.27  RESERVE: zone 2 at (2104, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2104, 11368) facing 2 (id 2)
  0.27  RESERVE: zone 3 at (2056, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2056, 11368) facing 2 (id 3)
  0.27  RESERVE: zone 4 at (2008, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2008, 11368) facing 2 (id 4)
  0.27  RESERVE: zone 5 at (2104, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2104, 11416) facing 2 (id 5)
  0.27  RESERVE: zone 6 at (2056, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2056, 11416) facing 2 (id 6)
  0.27  RESERVE: zone 7 at (2008, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2008, 11416) facing 2 (id 7)
  0.27  RESERVE: zone 8 at (2104, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2104, 11464) facing 2 (id 8)
  0.27  RESERVE: zone 9 at (2056, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2056, 11464) facing 2 (id 9)
  0.27  RESERVE: zone 10 at (2008, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2008, 11464) facing 2 (id 10)
  0.27  RESERVE: zone 11 at (2104, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2104, 11512) facing 2 (id 11)
  0.27  RESERVE: zone 12 at (2056, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2056, 11512) facing 2 (id 12)
  0.27  RESERVE: zone 13 at (2008, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2008, 11512) facing 2 (id 13)
  0.27  RESERVE: zone 14 at (2104, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2104, 11560) facing 2 (id 14)
  0.27  RESERVE: zone 15 at (2056, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2056, 11560) facing 2 (id 15)
  0.27  RESERVE: zone 16 at (2008, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2008, 11560) facing 2 (id 16)
  0.27  RESERVE: zone 17 at (2104, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2104, 11608) facing 2 (id 17)
  0.27  RESERVE: zone 18 at (2056, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2056, 11608) facing 2 (id 18)
  0.27  RESERVE: zone 19 at (2008, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2008, 11608) facing 2 (id 19)
  0.27  RESERVE: zone 20 at (2104, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2104, 11656) facing 2 (id 20)
  0.27  RESERVE: zone 21 at (2056, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (2056, 11656) facing 2 (id 21)
  0.27  RESERVE: zone 22 at (1912, 11272) facing 2, 9x9 cells: 81 of 81 held
  0.27  RESERVE: coraap at (1912, 11272) facing 2 (id 22)
  0.27  RESERVE: zone 23 at (1960, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1960, 11368) facing 2 (id 23)
  0.27  RESERVE: zone 24 at (1912, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1912, 11368) facing 2 (id 24)
  0.27  RESERVE: zone 25 at (1864, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1864, 11368) facing 2 (id 25)
  0.27  RESERVE: zone 26 at (1960, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1960, 11416) facing 2 (id 26)
  0.27  RESERVE: zone 27 at (1912, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1912, 11416) facing 2 (id 27)
  0.27  RESERVE: zone 28 at (1864, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1864, 11416) facing 2 (id 28)
  0.27  RESERVE: zone 29 at (1960, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1960, 11464) facing 2 (id 29)
  0.27  RESERVE: zone 30 at (1912, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1912, 11464) facing 2 (id 30)
  0.27  RESERVE: zone 31 at (1864, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1864, 11464) facing 2 (id 31)
  0.27  RESERVE: zone 32 at (1960, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1960, 11512) facing 2 (id 32)
  0.27  RESERVE: zone 33 at (1912, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1912, 11512) facing 2 (id 33)
  0.27  RESERVE: zone 34 at (1864, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1864, 11512) facing 2 (id 34)
  0.27  RESERVE: zone 35 at (1960, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1960, 11560) facing 2 (id 35)
  0.27  RESERVE: zone 36 at (1912, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1912, 11560) facing 2 (id 36)
  0.27  RESERVE: zone 37 at (1864, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1864, 11560) facing 2 (id 37)
  0.27  RESERVE: zone 38 at (1960, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1960, 11608) facing 2 (id 38)
  0.27  RESERVE: zone 39 at (1912, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1912, 11608) facing 2 (id 39)
  0.27  RESERVE: zone 40 at (1864, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1864, 11608) facing 2 (id 40)
  0.27  RESERVE: zone 41 at (1960, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1960, 11656) facing 2 (id 41)
  0.27  RESERVE: zone 42 at (1912, 11656) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1912, 11656) facing 2 (id 42)
  0.27  RESERVE: zone 43 at (1768, 11272) facing 2, 9x9 cells: 81 of 81 held
  0.27  RESERVE: coraap at (1768, 11272) facing 2 (id 43)
  0.27  RESERVE: zone 44 at (1816, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1816, 11368) facing 2 (id 44)
  0.27  RESERVE: zone 45 at (1768, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1768, 11368) facing 2 (id 45)
  0.27  RESERVE: zone 46 at (1720, 11368) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1720, 11368) facing 2 (id 46)
  0.27  RESERVE: zone 47 at (1816, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1816, 11416) facing 2 (id 47)
  0.27  RESERVE: zone 48 at (1768, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1768, 11416) facing 2 (id 48)
  0.27  RESERVE: zone 49 at (1720, 11416) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1720, 11416) facing 2 (id 49)
  0.27  RESERVE: zone 50 at (1816, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1816, 11464) facing 2 (id 50)
  0.27  RESERVE: zone 51 at (1768, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1768, 11464) facing 2 (id 51)
  0.27  RESERVE: zone 52 at (1720, 11464) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1720, 11464) facing 2 (id 52)
  0.27  RESERVE: zone 53 at (1816, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1816, 11512) facing 2 (id 53)
  0.27  RESERVE: zone 54 at (1768, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1768, 11512) facing 2 (id 54)
  0.27  RESERVE: zone 55 at (1720, 11512) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1720, 11512) facing 2 (id 55)
  0.27  RESERVE: zone 56 at (1816, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1816, 11560) facing 2 (id 56)
  0.27  RESERVE: zone 57 at (1768, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1768, 11560) facing 2 (id 57)
  0.27  RESERVE: zone 58 at (1720, 11560) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1720, 11560) facing 2 (id 58)
  0.27  RESERVE: zone 59 at (1816, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1816, 11608) facing 2 (id 59)
  0.27  RESERVE: zone 60 at (1768, 11608) facing 2, 3x3 cells: 9 of 9 held
  0.27  RESERVE: cornanotc at (1768, 11608) facing 2 (id 60)
```
