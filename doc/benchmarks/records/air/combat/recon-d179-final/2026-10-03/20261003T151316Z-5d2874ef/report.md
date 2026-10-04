# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 8.5 min (frame 15301); wall 1 s
- DLL: build-theatres\d179-build\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T12:09:47
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_recon.json; widget loaded: yes
- Log: build-theatres\games\air\combat\recon-d179-final\glacial\20261003T150905Z-1a4d5f72\runs\20261003T151316Z-5d2874ef\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `formation` | seen at 1.0 min | `[AIR][Recon] formation slots=20 columns=3 spacing=836 sight=1275` |
| expect `dispatch` | seen at 1.4 min | `[AIR][Recon] synchronized sweep=20 formed=20 spacing=836` |
| expect `survey` | **missing** (by 8 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Failures

- 'survey' not seen by 8.0 min

## Screenshots

- build-theatres\games\air\combat\recon-d179-final\glacial\20261003T150905Z-1a4d5f72\runs\20261003T151316Z-5d2874ef\screen_2026-10-03_15-10-40-322.png
- build-theatres\games\air\combat\recon-d179-final\glacial\20261003T150905Z-1a4d5f72\runs\20261003T151316Z-5d2874ef\screen_2026-10-03_15-10-41-546.png
- build-theatres\games\air\combat\recon-d179-final\glacial\20261003T150905Z-1a4d5f72\runs\20261003T151316Z-5d2874ef\screen_2026-10-03_15-10-47-889.png
- build-theatres\games\air\combat\recon-d179-final\glacial\20261003T150905Z-1a4d5f72\runs\20261003T151316Z-5d2874ef\screen_2026-10-03_15-10-55-798.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 8, 0 shots, end at 8.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (12572, 1400) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (12572, 1400) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=307 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (442, 1128), 48 from the start
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=1000 E=18 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=343 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 1
  1.01  [AIR][Recon] formation slots=20 columns=3 spacing=836 sight=1275
  1.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.35  [AIR][Recon] synchronized sweep=20 formed=20 spacing=836
  1.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.77  [AIR][Recon] nearby bases plane=5777 bases=2
  1.78  [AIR][Recon] nearby bases plane=11785 bases=2
  1.80  [AIR][Recon] nearby bases plane=23992 bases=2
  1.82  [AIR][Recon] nearby bases plane=16224 bases=2
  1.88  [AIR][Recon] nearby bases plane=1182 bases=2
  1.90  [AIR][Recon] nearby bases plane=17769 bases=2
  1.92  [AIR][Recon] nearby bases plane=6426 bases=2
  1.92  [AIR][Recon] nearby bases plane=22066 bases=2
  1.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.95  [AIR][Recon] nearby bases plane=18286 bases=2
  1.95  [AIR][Recon] nearby bases plane=24297 bases=2
  1.95  [AIR][Recon] nearby bases plane=29786 bases=2
  1.95  [AIR][Recon] nearby bases plane=18030 bases=2
  2.00  [AIR][Recon] nearby bases plane=17561 bases=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
  2.02  [AIR][Recon] nearby bases plane=30967 bases=2
  2.03  [AIR][Recon] nearby bases plane=27832 bases=2
  2.05  [AIR][Recon] nearby bases plane=9254 bases=2
  2.07  [AIR][Recon] nearby bases plane=27733 bases=2
  2.07  [AIR][Recon] nearby bases plane=3427 bases=2
  2.08  [AIR][Recon] nearby bases plane=11739 bases=2
  2.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.17  [AIR][Recon] nearby bases plane=14145 bases=2
  2.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 19
  3.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  3.10  [AIR][Projects] energyQueued=0 committed=0/0
  3.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  3.27  [AIR][Projects] energyQueued=0 committed=0/0
  3.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  3.43  [AIR][Projects] energyQueued=0 committed=0/0
  3.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  3.60  [AIR][Projects] energyQueued=0 committed=0/0
  3.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  3.77  [AIR][Projects] energyQueued=0 committed=0/0
  3.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  3.93  [AIR][Projects] energyQueued=0 committed=0/0
  3.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 11
  4.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  4.43  [AIR][Projects] energyQueued=0 committed=0/0
  4.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  4.60  [AIR][Projects] energyQueued=0 committed=0/0
  4.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  4.77  [AIR][Projects] energyQueued=0 committed=0/0
  4.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  4.93  [AIR][Projects] energyQueued=0 committed=0/0
  4.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 3
  5.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  5.10  [AIR][Projects] energyQueued=0 committed=0/0
  5.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  5.27  [AIR][Projects] energyQueued=0 committed=0/0
  5.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  5.43  [AIR][Projects] energyQueued=0 committed=0/0
  5.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  5.60  [AIR][Projects] energyQueued=0 committed=0/0
  5.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  5.77  [AIR][Projects] energyQueued=0 committed=0/0
  5.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  5.93  [AIR][Projects] energyQueued=0 committed=0/0
  5.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 1
  6.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  6.10  [AIR][Projects] energyQueued=0 committed=0/0
  6.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  6.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  6.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  6.27  [AIR][Projects] energyQueued=0 committed=0/0
  6.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  6.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  6.43  [AIR][Projects] energyQueued=0 committed=0/0
  6.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  6.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  6.60  [AIR][Projects] energyQueued=0 committed=0/0
  6.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  6.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  6.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  6.77  [AIR][Projects] energyQueued=0 committed=0/0
  6.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  6.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  6.93  [AIR][Projects] energyQueued=0 committed=0/0
  6.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  6.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 1
  7.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  7.10  [AIR][Projects] energyQueued=0 committed=0/0
  7.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  7.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  7.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  7.27  [AIR][Projects] energyQueued=0 committed=0/0
  7.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  7.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  7.43  [AIR][Projects] energyQueued=0 committed=0/0
  7.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  7.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  7.60  [AIR][Projects] energyQueued=0 committed=0/0
  7.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  7.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  7.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  7.77  [AIR][Projects] energyQueued=0 committed=0/0
  7.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  7.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  7.93  [AIR][Projects] energyQueued=0 committed=0/0
  7.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  7.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 1
  8.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  8.10  [AIR][Projects] energyQueued=0 committed=0/0
  8.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  8.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  8.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  8.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  8.27  [AIR][Projects] energyQueued=0 committed=0/0
  8.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  8.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  8.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  8.43  [AIR][Projects] energyQueued=0 committed=0/0
  8.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  8.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  8.50  [Playtest] end at 8.5 min: quitting
```

## Native lines (all AIs, first 120)

```
```
