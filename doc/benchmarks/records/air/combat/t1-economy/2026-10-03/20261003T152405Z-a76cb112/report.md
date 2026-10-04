# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.0 min (frame 10806); wall 93 s
- DLL: build-theatres\d179-build\SkirmishAI.dll (7be8085c281c3a0f); AI BARbTest/test; staged 2026-10-03T12:22:30
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=AIR/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\t1-economy\supreme-isthmus-v1-7\20261003T152230Z-18aa07e3\runs\20261003T152405Z-a76cb112\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:29.871929][f=-000001] [AirArena] event=loaded frame=0 case=t1-economy endless=0 visibility=global` |
| expect `ready` | seen at 0.1 min | `[t=00:00:37.441476][f=0000150] [AirArena] event=ready frame=150 visibility=global` |
| expect `refill` | seen at 0.2 min | `[t=00:00:38.075652][f=0000300] [AirArena] event=refill frame=300 groups=23 queued=36` |
| expect `combat` | seen at 0.4 min | `[t=00:00:39.826947][f=0000674] [AirArena] event=damage frame=674 adef=armrl amount=115.18 attacker=13327 attackerTeam=1 emp=0 team=0 vdef=armpeep victim=25997 wave=0` |
| expect `screenshot` | seen at 1.0 min | `[t=00:00:45.477441][f=0001719] [AirArena] event=screenshot frame=1719 key=wave1-launch x=4189 z=8137` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\t1-economy\supreme-isthmus-v1-7\20261003T152230Z-18aa07e3\runs\20261003T152405Z-a76cb112\screen_2026-10-03_15-23-18-959.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\t1-economy\supreme-isthmus-v1-7\20261003T152230Z-18aa07e3\runs\20261003T152405Z-a76cb112\screen_2026-10-03_15-23-20-461.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\t1-economy\supreme-isthmus-v1-7\20261003T152230Z-18aa07e3\runs\20261003T152405Z-a76cb112\screen_2026-10-03_15-23-28-415.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\t1-economy\supreme-isthmus-v1-7\20261003T152230Z-18aa07e3\runs\20261003T152405Z-a76cb112\screen_2026-10-03_15-23-29-474.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\t1-economy\supreme-isthmus-v1-7\20261003T152230Z-18aa07e3\runs\20261003T152405Z-a76cb112\screen_2026-10-03_15-23-41-956.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\t1-economy\supreme-isthmus-v1-7\20261003T152230Z-18aa07e3\runs\20261003T152405Z-a76cb112\screen_2026-10-03_15-23-48-322.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\t1-economy\supreme-isthmus-v1-7\20261003T152230Z-18aa07e3\runs\20261003T152405Z-a76cb112\screen_2026-10-03_15-23-49-367.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\t1-economy\supreme-isthmus-v1-7\20261003T152230Z-18aa07e3\runs\20261003T152405Z-a76cb112\screen_2026-10-03_15-23-50-474.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\t1-economy\supreme-isthmus-v1-7\20261003T152230Z-18aa07e3\runs\20261003T152405Z-a76cb112\screen_2026-10-03_15-24-00-845.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 8, 0 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000000/1000000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 32
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 32
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=314 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2162, 11730), 15 from the start
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.20  [Playtest] finished armrad team 0 at 0.19 min
  0.20  [Playtest] finished armrad team 0 at 0.20 min
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=1000 E=21000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=350 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Attack] home=0 target=10 heldBombers=0 escorts=0 wave=0 enemyAir=584
  0.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.93  [AIR][Raid] launched bombers=18 escorts=0 target=5955
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 29
  1.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.10  [AIR][Attack] home=0 target=10 heldBombers=0 escorts=0 wave=0 enemyAir=584
  1.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Attack] home=0 target=10 heldBombers=0 escorts=0 wave=0 enemyAir=584
  1.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 27
  2.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Attack] home=0 target=10 heldBombers=0 escorts=0 wave=0 enemyAir=584
  2.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Attack] home=0 target=10 heldBombers=0 escorts=0 wave=0 enemyAir=584
  2.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 27
  3.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.10  [AIR][Projects] energyQueued=0 committed=0/0
  3.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.10  [AIR][Attack] home=0 target=10 heldBombers=0 escorts=0 wave=0 enemyAir=584
  3.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.27  [AIR][Projects] energyQueued=0 committed=0/0
  3.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.43  [AIR][Projects] energyQueued=0 committed=0/0
  3.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.43  [AIR][Raid] exhausted cohort=18 survivors=0
  3.43  [AIR][Raid] launched bombers=11 escorts=0 target=28292
  3.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.60  [AIR][Projects] energyQueued=0 committed=0/0
  3.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.60  [AIR][Attack] home=0 target=10 heldBombers=0 escorts=0 wave=0 enemyAir=584
  3.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.77  [AIR][Projects] energyQueued=0 committed=0/0
  3.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.93  [AIR][Projects] energyQueued=0 committed=0/0
  3.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 29
  4.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.10  [AIR][Attack] home=0 target=10 heldBombers=0 escorts=0 wave=0 enemyAir=584
  4.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.43  [AIR][Projects] energyQueued=0 committed=0/0
  4.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.60  [AIR][Projects] energyQueued=0 committed=0/0
  4.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.60  [AIR][Attack] home=0 target=10 heldBombers=0 escorts=0 wave=0 enemyAir=584
  4.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.77  [AIR][Projects] energyQueued=0 committed=0/0
  4.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.93  [AIR][Projects] energyQueued=0 committed=0/0
  4.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 26
  5.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.10  [AIR][Projects] energyQueued=0 committed=0/0
  5.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.10  [AIR][Attack] home=0 target=10 heldBombers=0 escorts=0 wave=0 enemyAir=584
  5.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.27  [AIR][Projects] energyQueued=0 committed=0/0
  5.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.43  [AIR][Projects] energyQueued=0 committed=0/0
  5.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.43  [AIR][Raid] exhausted cohort=11 survivors=0
  5.43  [AIR][Raid] launched bombers=15 escorts=0 target=19007
  5.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.60  [AIR][Projects] energyQueued=0 committed=0/0
  5.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.60  [AIR][Attack] home=0 target=10 heldBombers=0 escorts=0 wave=0 enemyAir=584
  5.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.77  [AIR][Projects] energyQueued=0 committed=0/0
  5.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.93  [AIR][Projects] energyQueued=0 committed=0/0
  5.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 25
```

## Native lines (all AIs, first 120)

```
```
