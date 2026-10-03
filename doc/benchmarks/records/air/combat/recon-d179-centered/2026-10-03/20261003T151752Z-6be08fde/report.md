# Playtest report: PASS

- Verdict: **PASS** (reached 8 min)
- Game time reached: 8.5 min (frame 15301); wall 1 s
- DLL: build-theatres\d179-build\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T12:14:29
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/armada/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_recon.json; widget loaded: yes
- Log: build-theatres\games\air\combat\recon-d179-centered\glacial\20261003T151316Z-94776a9c\runs\20261003T151752Z-6be08fde\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `formation` | seen at 1.0 min | `[AIR][Recon] formation slots=20 columns=6 spacing=1275 sight=1275` |
| expect `dispatch` | seen at 1.5 min | `[AIR][Recon] synchronized sweep=20 formed=20 spacing=1275` |
| expect `survey` | seen at 2.6 min | `[AirReconProbe] waiting=0 sweeping=20 surveying=20 productionTarget=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- build-theatres\games\air\combat\recon-d179-centered\glacial\20261003T151316Z-94776a9c\runs\20261003T151752Z-6be08fde\screen_2026-10-03_15-15-25-052.png
- build-theatres\games\air\combat\recon-d179-centered\glacial\20261003T151316Z-94776a9c\runs\20261003T151752Z-6be08fde\screen_2026-10-03_15-15-31-160.png
- build-theatres\games\air\combat\recon-d179-centered\glacial\20261003T151316Z-94776a9c\runs\20261003T151752Z-6be08fde\screen_2026-10-03_15-15-38-382.png

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
  1.01  [AIR][Recon] formation slots=20 columns=6 spacing=1275 sight=1275
  1.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.47  [AIR][Recon] synchronized sweep=20 formed=20 spacing=1275
  1.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Recon] nearby bases plane=21301 bases=2
  1.97  [AIR][Recon] nearby bases plane=30498 bases=2
  1.97  [AIR][Recon] nearby bases plane=18609 bases=2
  1.97  [AIR][Recon] nearby bases plane=13830 bases=2
  1.98  [AIR][Recon] nearby bases plane=28617 bases=2
  1.98  [AIR][Recon] nearby bases plane=10880 bases=2
  1.98  [AIR][Recon] nearby bases plane=6434 bases=2
  2.00  [AIR][Recon] nearby bases plane=2885 bases=2
  2.00  [AIR][Recon] nearby bases plane=20589 bases=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
  2.03  [AIR][Recon] nearby bases plane=26411 bases=2
  2.05  [AIR][Recon] nearby bases plane=20876 bases=2
  2.07  [AIR][Recon] nearby bases plane=11603 bases=2
  2.08  [AIR][Recon] nearby bases plane=13073 bases=2
  2.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30 bank=1000 pull=0 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Recon] nearby bases plane=20608 bases=2
  2.10  [AIR][Recon] nearby bases plane=13932 bases=2
  2.10  [AIR][Recon] nearby bases plane=4331 bases=2
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.12  [AIR][Recon] nearby bases plane=14737 bases=2
  2.15  [AIR][Recon] nearby bases plane=18705 bases=2
  2.17  [AIR][Recon] nearby bases plane=19326 bases=2
  2.17  [AIR][Recon] nearby bases plane=17227 bases=2
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
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
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
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
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
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
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
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
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
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
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
  8.00  [Playtest] eco team 0 at 8.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 1000/1000, units 21
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
