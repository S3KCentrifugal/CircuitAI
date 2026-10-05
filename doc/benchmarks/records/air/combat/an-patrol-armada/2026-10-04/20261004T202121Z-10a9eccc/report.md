# Playtest report: PASS

- Verdict: **PASS** (reached 7 min)
- Game time reached: 7.1 min (frame 12782); wall 97 s
- DLL: build-theatres\d194-build\SkirmishAI.dll (f2ac10b0200fc41a); AI BARbTest/test; staged 2026-10-04T17:19:40
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=FRONT/armada/test, 2=FRONT/cortex/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: naval-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\an-patrol-armada\supreme\20261004T201939Z-44af9da8\runs\20261004T202121Z-10a9eccc\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `fixture` | seen at -0.0 min | `[t=00:00:37.650857][f=-000001] [AirNavalWatch] loaded case=patrol` |
| expect `patrol` | seen at 1.0 min | `[AIR][Recon] patrol plane=3197 x=5724 z=6563 knownThreat=0` |
| expect `launch` | seen at 4.0 min | `[AIR][Recon] synchronized sweep=7 formed=7 spacing=1275 reason=deadline` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |
| forbid `widget` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\an-patrol-armada\supreme\20261004T201939Z-44af9da8\runs\20261004T202121Z-10a9eccc\screen_2026-10-04_20-20-46-285.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\air\combat\an-patrol-armada\supreme\20261004T201939Z-44af9da8\runs\20261004T202121Z-10a9eccc\screen_2026-10-04_20-20-51-514.png

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
  0.00  [Playtest] frame 1 team 4 ally 3 side  ai false dead false start (0, 0) units 35
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (2155, 11747) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (837, 10407) units 1
  0.05  [Playtest] frame 90 team 2 ally 1 side cortex ai true dead false start (10129, 541) units 1
  0.05  [Playtest] frame 90 team 3 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 4 ally 3 side  ai false dead false start (0, 0) units 35
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
  0.27  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=100000 E=18 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.43  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.93  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
  1.02  [AIR][Recon] formation slots=20 columns=11 spacing=1275 sight=1275
  1.03  [AIR][Recon] patrol plane=3197 x=5724 z=6563 knownThreat=0
  1.03  [AIR][Recon] patrol plane=5696 x=2372 z=3210 knownThreat=0
  1.03  [AIR][Recon] patrol plane=14872 x=9077 z=9077 knownThreat=0
  1.03  [AIR][Recon] patrol plane=19641 x=1534 z=7401 knownThreat=0
  1.03  [AIR][Recon] patrol plane=30271 x=4886 z=10753 knownThreat=0
  1.03  [AIR][Recon] patrol plane=31558 x=696 z=11592 knownThreat=0
  1.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.12  [AIR][Recon] patrol unavailable plane=14067 candidates=98
  1.12  [AIR][Recon] patrol unavailable plane=31288 candidates=98
  1.20  [AIR][Recon] patrol plane=14067 x=11592 z=11592 knownThreat=0
  1.20  [AIR][Recon] patrol plane=31288 x=4048 z=4886 knownThreat=0
  1.27  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.43  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  1.87  [AIR][Recon] patrol unavailable plane=3197 candidates=89
  1.93  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 8
  2.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.43  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.77  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.77  [AIR][Projects] energyQueued=0 committed=0/0
  2.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  2.93  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  2.93  [AIR][Projects] energyQueued=0 committed=0/0
  2.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 8
  3.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.10  [AIR][Projects] energyQueued=0 committed=0/0
  3.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.27  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.27  [AIR][Projects] energyQueued=0 committed=0/0
  3.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.43  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.43  [AIR][Projects] energyQueued=0 committed=0/0
  3.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.60  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.60  [AIR][Projects] energyQueued=0 committed=0/0
  3.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.77  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.77  [AIR][Projects] energyQueued=0 committed=0/0
  3.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  3.93  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  3.93  [AIR][Projects] energyQueued=0 committed=0/0
  3.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 8
  4.03  [AIR][Recon] synchronized sweep=7 formed=7 spacing=1275 reason=deadline
  4.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.20  [AIR][Recon] nearby bases plane=5696 bases=2
  4.27  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.27  [AIR][Projects] energyQueued=0 committed=0/0
  4.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.43  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.43  [AIR][Projects] energyQueued=0 committed=0/0
  4.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.45  [AIR][Recon] nearby bases plane=19641 bases=2
  4.48  [AIR][Recon] nearby bases plane=31288 bases=2
  4.52  [AIR][Recon] nearby bases plane=14067 bases=2
  4.55  [AIR][Recon] nearby bases plane=14872 bases=2
  4.60  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.60  [AIR][Projects] energyQueued=0 committed=0/0
  4.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.77  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.77  [AIR][Projects] energyQueued=0 committed=0/0
  4.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  4.93  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  4.93  [AIR][Projects] energyQueued=0 committed=0/0
  4.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 6
  5.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.10  [AIR][Projects] energyQueued=0 committed=0/0
  5.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.27  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.27  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.27  [AIR][Projects] energyQueued=0 committed=0/0
  5.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.43  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.43  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.43  [AIR][Projects] energyQueued=0 committed=0/0
  5.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.60  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.60  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.60  [AIR][Projects] energyQueued=0 committed=0/0
  5.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.77  [AIR][Capacity] own=1/15 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.77  [AIR][Economy] BOOTSTRAP M=1 bank=100000 E=27 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.77  [AIR][Projects] energyQueued=0 committed=0/0
  5.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  5.93  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.93  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  5.93  [AIR][Projects] energyQueued=0 committed=0/0
  5.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  5.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 3
  6.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.10  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.10  [AIR][Projects] energyQueued=0 committed=0/0
  6.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  6.27  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.27  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.27  [AIR][Projects] energyQueued=0 committed=0/0
  6.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.27  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.43  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.43  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.43  [AIR][Projects] energyQueued=0 committed=0/0
  6.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.43  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.60  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.60  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.60  [AIR][Projects] energyQueued=0 committed=0/0
  6.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.60  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  6.77  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.77  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.77  [AIR][Projects] energyQueued=0 committed=0/0
  6.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.77  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  6.93  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  6.93  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  6.93  [AIR][Projects] energyQueued=0 committed=0/0
  6.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  6.93  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.00  [Playtest] eco team 0 at 7.0 min: metal +2.0 bank 100000/100000, energy +30.0 bank 1000000/1000000, units 1
  7.10  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=2 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  7.10  [AIR][Economy] BOOTSTRAP M=2 bank=100000 E=30 bank=1000000 pull=0 plants=0/0 aircraftDemand=0/0
  7.10  [AIR][Projects] energyQueued=0 committed=0/0
  7.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  7.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  7.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
```

## Native lines (all AIs, first 120)

```
```
