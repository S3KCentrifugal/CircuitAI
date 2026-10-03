# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.0 min (frame 7231); wall 104 s
- DLL: build-theatres\d176-build-2\SkirmishAI.dll (0b8b08be87bbadef); AI BARbTest/test; staged 2026-10-03T10:02:40
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/cortex/test, 1=AIR/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: air_direct.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\direct-glitters\all-that-glitters-v2-2-3\20261003T130239Z-c95e4160\runs\20261003T130427Z-8c8bf821\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:28.636968][f=-000001] [AirArena] event=loaded frame=0 case=direct-glitters endless=0 visibility=global` |
| expect `launch` | seen at 1.3 min | `[t=00:00:55.805870][f=0002310] [AirArena] event=launch frame=2310 count=14 ids=12983,16736,18188,19007,21438,24166,24300,25441,27824,27839,29703,5557,6711,8796 risk=1 target=14488 wave=1` |
| expect `direct-plan` | seen at 1.1 min | `[t=00:00:53.079248][f=0001980] Skirmish AI <BARb playtest-test>: WAVE: mission target=14488 required=2 available=7 route=direct unknown=0.25 army=5400 localAA=0 risk=0.0 synchronized=0` |
| expect `direct-flown` | seen at 2.1 min | `[t=00:01:08.496842][f=0003720] [AirArena] event=route_crossing frame=3720 alive=14 flank=0 wave=1 x=3744 z=5326` |
| expect `target-damage` | seen at 2.1 min | `[t=00:01:09.694453][f=0003751] [AirArena] event=damage frame=3751 adef=corhurc amount=190.46 attacker=8796 attackerTeam=0 emp=0 team=1 vdef=armmmkr victim=14488 wave=1` |
| expect `afus-dead` | seen at 2.2 min | `[t=00:01:14.826459][f=0004028] [AirArena] event=death frame=4028 attacker=27839 attackerTeam=0 cost=9700 id=29515 kind=target team=1 unit=armafus wave=0` |
| expect `flank-screenshot` | seen at 2.1 min | `[t=00:01:09.501166][f=0003727] [AirArena] event=screenshot frame=3727 key=wave1-flank-crossing x=3744 z=5326` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\direct-glitters\all-that-glitters-v2-2-3\20261003T130239Z-c95e4160\runs\20261003T130427Z-8c8bf821\screen_2026-10-03_13-03-35-565.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\direct-glitters\all-that-glitters-v2-2-3\20261003T130239Z-c95e4160\runs\20261003T130427Z-8c8bf821\screen_2026-10-03_13-03-40-756.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\direct-glitters\all-that-glitters-v2-2-3\20261003T130239Z-c95e4160\runs\20261003T130427Z-8c8bf821\screen_2026-10-03_13-03-53-447.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\direct-glitters\all-that-glitters-v2-2-3\20261003T130239Z-c95e4160\runs\20261003T130427Z-8c8bf821\screen_2026-10-03_13-03-54-642.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\direct-glitters\all-that-glitters-v2-2-3\20261003T130239Z-c95e4160\runs\20261003T130427Z-8c8bf821\screen_2026-10-03_13-03-55-699.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\direct-glitters\all-that-glitters-v2-2-3\20261003T130239Z-c95e4160\runs\20261003T130427Z-8c8bf821\screen_2026-10-03_13-03-58-325.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 4, 0 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished corcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000000/1000000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side cortex ai true dead false start (2801, 775) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 4
  0.05  [Playtest] frame 90 team 0 ally 0 side cortex ai true dead false start (2801, 775) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side cortex ai true dead false start (3452, 9689) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order corap
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=1000 E=0 bank=1000000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=0/0
  0.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=307 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (2832, 746), 43 from the start
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armeyes team 0 at 0.17 min
  0.17  [Playtest] finished armrad team 0 at 0.17 min
  0.18  [Playtest] finished armrad team 0 at 0.18 min
  0.18  [Playtest] finished armrad team 0 at 0.18 min
  0.18  [Playtest] finished armrad team 0 at 0.18 min
  0.18  [Playtest] finished armrad team 0 at 0.18 min
  0.18  [Playtest] finished armrad team 0 at 0.18 min
  0.18  [Playtest] finished armrad team 0 at 0.19 min
  0.19  [Playtest] finished armrad team 0 at 0.19 min
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=1000 E=18000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=343 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 14
  1.01  [AIR][Screen] fighters=1 cells=8 centre=2829,1174 width=600 advance=400 responding=false
  1.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=45 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.10  [AIR][Attack] home=33 target=6 heldBombers=7 escorts=0 wave=0 enemyAir=0
  1.10  [AIR][Waves] opening size drawn=14
  1.20  [AIR][Screen] fighters=40 cells=8 centre=3082,4634 width=6000 advance=3868 responding=false
  1.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.27  [AIR][Waves] planned strike target=14488 bombers=14 required=2 aim=3872,6372 mission=economy
  1.27  [AIR][Waves] Wave 1 launched (target and route budget): bombers=14 fighters=40 holdTasksAborted=0 provisionalNext=21
  1.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=34 escorts=0 wave=1 enemyAir=0
  1.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 102
  2.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Attack] home=0 target=6 heldBombers=34 escorts=0 wave=1 enemyAir=0
  2.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Attack] home=0 target=6 heldBombers=34 escorts=0 wave=1 enemyAir=0
  2.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 95
  3.10  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  3.10  [AIR][Projects] energyQueued=0 committed=0/0
  3.10  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.10  [AIR][Attack] home=0 target=6 heldBombers=34 escorts=0 wave=1 enemyAir=0
  3.27  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  3.27  [AIR][Projects] energyQueued=0 committed=0/0
  3.27  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.43  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  3.43  [AIR][Projects] energyQueued=0 committed=0/0
  3.43  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.60  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  3.60  [AIR][Projects] energyQueued=0 committed=0/0
  3.60  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.60  [AIR][Attack] home=0 target=6 heldBombers=34 escorts=0 wave=1 enemyAir=0
  3.77  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  3.77  [AIR][Projects] energyQueued=0 committed=0/0
  3.77  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.93  [AIR][Economy] BOOTSTRAP M=2 bank=1000 E=30000 bank=1000000000 pull=39 plants=0/0 aircraftDemand=0/0
  3.93  [AIR][Projects] energyQueued=0 committed=0/0
  3.93  [AIR][Workforce] t1=0/1 t2=0/1 targetBP=372 floating=true savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30000.0 bank 1000000000/1000000000, units 95
```

## Native lines (all AIs, first 120)

```
```
