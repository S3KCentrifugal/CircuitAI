# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 12.1 min (frame 21699); wall 205 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T15:02:49
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=FRONT/cortex/test, 3=FRONT/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=TACTICAL/armada/test, 8=FRONT/cortex/test, 9=TECH/legion/test, 10=FRONT/armada/test, 11=AIR/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=TACTICAL/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: full-match-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T180249Z-6b21e4bb\runs\20261006T180619Z-a4813114\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `competitive-roster` | seen at 0.2 min | `[t=00:00:48.243911][f=0000300] [PerfFixture] spectator_units=0 competing_ai_teams=16` |
| expect `timing` | seen at 4.0 min | `d=12.000 speed_actual=10.747 ai_n=1800 ai_mean_ms=1.222957 ai_p50_ms=0.775391 ai_p95_ms=3.478516 ai_p99_ms=7.560547 ai_max_ms=11.281250 fps_n=7 fps_p10=17.000 fps_p50=24.000 fps_p90=26.000 profiling=1` |
| expect `commands` | seen at 1.0 min | `[t=00:00:52.484324][f=0001800] [AirOrders] frame=1800 team=0 all_apm=50 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 6.2 min: [INVARIANT] INV-029 legalab 16229 stands 3 cells from the turrets, not tight

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T180249Z-6b21e4bb\runs\20261006T180619Z-a4813114\screen_2026-10-06_18-05-04-499.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\glacial\20261006T180249Z-6b21e4bb\runs\20261006T180619Z-a4813114\screen_2026-10-06_18-05-56-173.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 12, 11 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (430, 2300) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1800, 1400) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (1800, 2550) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 7 ally 0 side armada ai true dead false start (880, 6850) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (12572, 1400) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (14000, 1100) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (12640, 2500) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (13890, 2246) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 14 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 15 ally 1 side legion ai true dead false start (13454, 6850) units 1
  0.00  [Playtest] frame 1 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 12
  0.00  [Playtest] speed 12 at 0.00 min
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (430, 2300) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (490, 1140) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1800, 1400) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (1800, 2550) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 7 ally 0 side armada ai true dead false start (880, 6850) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (12572, 1400) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (14000, 1100) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (12640, 2500) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (13890, 2246) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 14 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 15 ally 1 side legion ai true dead false start (13454, 6850) units 1
  0.05  [Playtest] frame 90 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=989 E=0 bank=866 pull=83 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=27/274
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (450, 2298), 20 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|430|2297|0|2|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(490,1137) factory=armlab landLocked=no spot=0 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=FRONT side=cortex start=(1799,1401) factory=corvp landLocked=no spot=1 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=FRONT side=legion start=(1800,2550) factory=legvp landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(1430,3997) factory=armsy landLocked=no spot=4 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(699,4601) factory=corsy landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(1900,5800) factory=legsy landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=TACTICAL side=armada start=(880,6847) factory=armhp landLocked=no spot=7 known=7/7
  0.15  [Team][Roster] team 1 first mex at 496,1296
  0.15  [Team][Roster] team 4 first mex at 1424,4096
  0.15  [Team][Roster] team 7 first mex at 880,6720
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [Team][Roster] first mex 29028 at 448,2416
  0.17  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|430|2297|0|2|1|448|2416
  0.17  [Team][Roster] team 2 first mex at 1952,1407
  0.17  [Team][Roster] team 3 first mex at 1952,2576
  0.17  [AIR][Rule] opening.mex builder=2244
  0.17  [Team][Roster] team 5 first mex at 704,4447
  0.17  [Team][Roster] team 6 first mex at 1904,5968
  0.27  [AIR][Capacity] own=2/30 usage=8/86 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=953 E=18 bank=483 pull=86 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=9/99
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.29  [Playtest] finished armmex team 0 at 0.29 min
  0.43  [AIR][Capacity] own=4/30 usage=8/89 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=4 bank=954 E=30 bank=202 pull=89 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=5/52
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.44  [Playtest] finished armmex team 0 at 0.44 min
  0.46  [AIR][Rule] recovery.energy builder=2244
  0.60  [AIR][Capacity] own=6/30 usage=17/9 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP RECOVERY M=6 bank=899 E=30 bank=375 pull=9 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=14/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.61  [Playtest] finished armsolar team 0 at 0.61 min
  0.77  [AIR][Capacity] own=8/30 usage=17/9 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP RECOVERY M=8 bank=828 E=30 bank=876 pull=9 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=14/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  0.78  [Playtest] finished armsolar team 0 at 0.78 min
  0.79  [AIR][Wind] cluster=0 slots=6 at=672,2712 local=false builder=2244
  0.79  [AIR][Rule] opening.energy builder=2244
  0.93  [AIR][Capacity] own=8/50 usage=0/9 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=8 bank=889 E=50 bank=1100 pull=9 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=1 committed=40/175
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +8.0 bank 915/1150, energy +70.0 bank 1094/1100, units 7
  1.05  [Playtest] finished armwin team 0 at 1.05 min
  1.10  [AIR][Capacity] own=8/70 usage=6/38 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=8 bank=927 E=70 bank=1096 pull=38 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=26/113
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.16  [Playtest] finished armwin team 0 at 1.16 min
  1.26  [Playtest] finished armwin team 0 at 1.26 min
  1.27  [AIR][Capacity] own=8/71 usage=7/41 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=8 bank=942 E=71 bank=1096 pull=41 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.37  [Playtest] finished armwin team 0 at 1.37 min
  1.39  [AIR][Starter] nearby distance=127
  1.39  [AIR][Rule] opening.plant builder=2244
  1.40  [AIR][EcoLayout] reserved air.eco.0 reactor=816,2432 converters=8 support=12 zone=28
  1.42  [AIR][EcoLayout] reserved air.eco.1 reactor=1200,2816 converters=8 support=12 zone=52
  1.43  [AIR][EcoLayout] reserved air.eco.2 reactor=1200,1280 converters=8 support=12 zone=74
  1.43  [AIR][Capacity] own=8/88 usage=35/69 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] BOOTSTRAP M=8 bank=938 E=90 bank=1093 pull=69 plants=0/0 aircraftDemand=0/0
  1.43  [AIR][Projects] energyQueued=0 committed=576/974
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=5045 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.45  [AIR][EcoLayout] reserved air.eco.3 reactor=1200,768 converters=8 support=12 zone=96
  1.60  [AIR][Capacity] own=8/95 usage=35/69 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] BOOTSTRAP M=8 bank=664 E=97 bank=1054 pull=69 plants=0/0 aircraftDemand=0/0
  1.60  [AIR][Projects] energyQueued=0 committed=218/369
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=5045 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.70  [Playtest] finished armap team 0 at 1.70 min
  1.71  [AIR][Produce] opening.scout armpeep plant=5045 projected=1/1
  1.72  [AIR][Rule] opening.commander.guard builder=2244
  1.72  [AIR][Claim] cancel unowned native order armnanotc
  1.72  [AIR][Claim] cancel unowned native order armnanotc
  1.72  [AIR][State] T1_CONTEST
  1.77  [AIR][Capacity] own=8/79 usage=8/258 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST M=8 bank=481 E=80 bank=877 pull=258 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.84  [AIR][Produce] constructor.recovery armca plant=5045 projected=1/3
  1.84  [AIR][Scout] opening drone=31620 enemy starts=8
  1.93  [AIR][Capacity] own=7/72 usage=0/4 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=499 E=75 bank=1 pull=134 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 517/1250, energy +91.9 bank 4/1202, units 13
  2.10  [AIR][Capacity] own=7/84 usage=0/7 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=528 E=77 bank=13 pull=134 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.20  [AIR][Produce] constructor.recovery armca plant=5045 projected=2/3
  2.20  [AIR][Rule] recovery.energy builder=4133
  2.27  [AIR][Capacity] own=8/107 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=0 shortage=137 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=544 E=100 bank=169 pull=197 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=154/0
  2.27  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=237 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Produce] constructor.recovery armca plant=5045 projected=3/3
  2.43  [AIR][Rule] recovery.energy builder=729
  2.43  [AIR][Capacity] own=8/145 usage=9/134 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=50 shortage=0 reason=available or arriving power
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=516 E=146 bank=86 pull=162 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=1 committed=279/0
  2.43  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Capacity] own=8/145 usage=5/6 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=99 shortage=31 reason=funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=488 E=146 bank=326 pull=149 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=232/0
  2.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=181 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][BaseResponse] contact=true
  2.60  [AIR][BaseResponse] group=0 target=8127
  2.60  [AIR][BaseResponse] group=2 target=8127
  2.60  [AIR][BaseResponse] group=3 target=8127
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.63  [AIR][BaseResponse] contact=false
  2.63  [AIR][BaseResponse] group=0 target=-1
  2.63  [AIR][BaseResponse] group=2 target=-1
  2.63  [AIR][BaseResponse] group=3 target=-1
  2.69  [AIR][Commander] cleared factory guard for commander.idle.assist
  2.69  [AIR][Rule] commander.idle.assist builder=2244
  2.70  [AIR][Produce] opening.screen armfig plant=5045 projected=1/6
  2.70  [AIR][Rule] recovery.assist builder=30539
  2.72  [AIR][Rule] commander.factory.guard builder=2244
  2.77  [AIR][Capacity] own=8/143 usage=12/265 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=450 E=143 bank=461 pull=265 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=172/0
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][BaseResponse] contact=true
  2.77  [AIR][BaseResponse] group=0 target=16614
  2.77  [AIR][BaseResponse] group=2 target=16614
  2.77  [AIR][BaseResponse] group=3 target=16614
  2.80  [AIR][BaseResponse] contact=false
  2.80  [AIR][BaseResponse] group=0 target=-1
  2.80  [AIR][BaseResponse] group=2 target=-1
  2.80  [AIR][BaseResponse] group=3 target=-1
  2.93  [AIR][Produce] opening.screen armfig plant=5045 projected=2/6
  2.93  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  2.93  [AIR][Capacity] own=6/141 usage=13/191 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=380 E=143 bank=86 pull=257 plants=1/0 aircraftDemand=3/127
  2.93  [AIR][Projects] energyQueued=0 committed=84/0
  2.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.95  [Playtest] finished armsolar team 0 at 2.95 min
  2.97  [AIR][Rule] mex.expand builder=4133
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 373/1250, energy +158.9 bank 144/1327, units 18
  3.07  [AIR][BaseResponse] contact=true
  3.07  [AIR][BaseResponse] group=0 target=13134
  3.07  [AIR][BaseResponse] group=2 target=13134
  3.07  [AIR][BaseResponse] group=3 target=13134
  3.07  [AIR][BaseResponse] dispatched=1 total=1
  3.07  [AIR][Rule] recovery.assist builder=4133
  3.10  [AIR][Capacity] own=5/140 usage=10/170 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=7 bank=355 E=141 bank=7 pull=340 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=27/0
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.12  [AIR][BaseResponse] contact=false
  3.12  [AIR][BaseResponse] group=0 target=-1
  3.12  [AIR][BaseResponse] group=2 target=-1
  3.12  [AIR][BaseResponse] group=3 target=-1
  3.15  [Playtest] finished armsolar team 0 at 3.15 min
  3.17  [AIR][Rule] mex.expand builder=30539
  3.17  [AIR][Rule] intel.radar builder=4133
  3.17  [AIR][Rule] wait builder=729
  3.20  [AIR][Produce] opening.screen armfig plant=5045 projected=3/6
  3.20  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.21  [AIR][Rule] project.assist builder=30539
  3.21  [AIR][Commander] cleared factory guard for commander.idle.energy
  3.21  [AIR][Rule] commander.idle.energy builder=2244
  3.22  [AIR][Rule] commander.factory.guard builder=2244
  3.24  [AIR][Rule] project.assist builder=729
  3.27  [AIR][Capacity] own=6/164 usage=5/133 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=345 E=161 bank=663 pull=133 plants=1/0 aircraftDemand=3/127
  3.27  [AIR][Projects] energyQueued=0 committed=93/958
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.37  [Playtest] finished armrad team 0 at 3.37 min
  3.37  [AIR][Screen] fighters=1 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.38  [AIR][Rule] wait builder=30539
  3.38  [AIR][Rule] wait builder=4133
  3.39  [AIR][Rule] wait builder=729
  3.40  [AIR][Layout] cluster=0 labs=1 at=1654,2177
  3.40  [AIR][Produce] opening.screen armfig plant=5045 projected=4/6
  3.42  [AIR][Layout] cluster=1 labs=1 at=2038,2753
  3.42  [AIR][Commander] cleared factory guard for commander.idle.energy
  3.42  [AIR][Rule] commander.idle.energy builder=2244
  3.43  [AIR][Rule] commander.factory.guard builder=2244
  3.43  [AIR][Layout] cluster=2 labs=1 at=2134,2177
  3.43  [AIR][Capacity] own=8/200 usage=0/9 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=310 E=199 bank=841 pull=9 plants=1/0 aircraftDemand=3/127
  3.43  [AIR][Projects] energyQueued=0 committed=50/500
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.45  [AIR][Layout] cluster=3 labs=1 at=2134,2945
  3.55  [AIR][Screen] fighters=3 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.60  [AIR][Capacity] own=8/197 usage=7/319 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST M=8 bank=329 E=199 bank=1331 pull=319 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=50/500
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.62  [AIR][Produce] opening.screen armfig plant=5045 projected=5/6
  3.63  [AIR][Commander] cleared factory guard for commander.idle.energy
  3.63  [AIR][Rule] commander.idle.energy builder=2244
  3.64  [AIR][Layout] repaired support air.bay.0 viable=3/5 slot=269 at=536,2616
  3.64  [AIR][Rule] opening.support builder=30539
  3.64  [AIR][Rule] energy.grow builder=4133
  3.65  [AIR][Rule] energy.grow builder=729
  3.65  [AIR][Rule] commander.factory.guard builder=2244
  3.72  [AIR][Screen] fighters=4 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.75  [AIR][Commander] cleared factory guard for commander.energy.assist
  3.75  [AIR][Rule] commander.energy.assist builder=2244
  3.77  [AIR][Capacity] own=8/181 usage=11/392 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=209 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST M=8 bank=338 E=183 bank=560 pull=422 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=348/3947
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+1/2 available=yes firstSlot=2
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.83  [Playtest] finished armwin team 0 at 3.83 min
  3.84  [AIR][Produce] opening.screen armfig plant=5045 projected=6/6
  3.85  [AIR][Rule] opening.support.assist builder=4133
  3.85  [AIR][Rule] commander.idle.assist builder=2244
  3.88  [AIR][Screen] fighters=5 cells=8 centre=889,1145 width=600 advance=400 responding=false
  3.93  [Playtest] finished armwin team 0 at 3.93 min
  3.93  [AIR][Capacity] own=8/181 usage=10/147 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=90 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST M=8 bank=295 E=182 bank=850 pull=201 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=251/3300
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+1/2 available=yes firstSlot=2
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.94  [AIR][Rule] opening.support.assist builder=729
  3.95  [AIR][Rule] commander.factory.guard builder=2244
  3.97  [AIR][Layout] cluster=4 labs=1 at=118,2177
  4.00  [Playtest] eco team 0 at 4.0 min: metal +8.0 bank 275/1250, energy +237.3 bank 555/1378, units 26
  4.00  [Playtest] speed 1 at 4.00 min
  4.05  [AIR][Screen] fighters=5 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.10  [AIR][Capacity] own=8/221 usage=0/8 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=38 reason=funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=252 E=217 bank=238 pull=99 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=193/2494
  4.10  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=188 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+1/0 available=yes firstSlot=2
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.14  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.14  [AIR][Rule] commander.idle.energy builder=2244
  4.22  [AIR][Screen] fighters=6 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.27  [AIR][Capacity] own=8/238 usage=0/8 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=268 E=238 bank=1309 pull=99 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=0 committed=128/1588
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=5045 BP=150 nanos=0+1/0 available=yes firstSlot=2
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.30  [AIR][Rule] commander.idle.assist builder=2244
  4.33  [AIR][Produce] recon.replace armpeep plant=5045 projected=1/1
  4.38  [AIR][Screen] fighters=6 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.42  [Playtest] finished armnanotc team 0 at 4.42 min
  4.43  [AIR][Capacity] own=8/206 usage=15/271 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=150 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST M=8 bank=254 E=216 bank=1152 pull=363 plants=1/0 aircraftDemand=9/290
  4.43  [AIR][Projects] energyQueued=0 committed=50/500
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=5045 BP=350 nanos=1+0/2 available=yes firstSlot=3
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.44  [AIR][Wind] cluster=1 slots=6 at=704,2376 local=false builder=30539
  4.44  [AIR][Rule] energy.grow builder=30539
  4.44  [AIR][Rule] energy.grow builder=4133
  4.45  [AIR][Rule] energy.grow builder=729
  4.45  [AIR][Rule] commander.factory.guard builder=2244
  4.48  [AIR][Layout] cluster=5 labs=1 at=2134,1313
  4.50  [AIR][Produce] air.control armfig plant=5045 projected=7/7
  4.50  [AIR][Scout] opening drone=7891 enemy starts=8
  4.55  [AIR][Screen] fighters=6 cells=8 centre=889,1145 width=600 advance=400 responding=false
  4.60  [AIR][Capacity] own=8/179 usage=7/189 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=141 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST RECOVERY M=8 bank=232 E=185 bank=13 pull=273 plants=1/0 aircraftDemand=9/290
  4.60  [AIR][Projects] energyQueued=0 committed=150/938
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=5045 BP=350 nanos=1+0/0 available=yes firstSlot=3
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 808 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (427, 1512) facing 1, 58x77 cells: 3799 of 4466 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (923, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (875, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (827, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (779, 1512) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1000, 1272) facing 1 (id 63)
  0.08  RESERVE: zone 8 at (1403, 1832) facing 1, 45x41 cells: 1841 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1755, 1832) facing 1: 11 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1707, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1659, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1611, 1832) facing 1: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (1792, 1088) facing 1 (id 114)
  0.08  RESERVE: zone 9 at (1720, 1088) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1744, 1088) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (1768, 1184) facing 1, 21x6 cells: 122 of 126 held
  0.08  RESERVE: zone 11 at (1768, 1088) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (2016, 1088) facing 1, 20x10 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 2
  0.09  RESERVE: zone 7 at (13509, 1272) facing 2, 77x63 cells: 4538 of 4851 held
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 776) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 824) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 872) facing 2: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of legnanotc 13x1 gap 0 behind (13509, 920) facing 2: 12 of 13 slots (group 5, held, zone)
  0.09  RESERVE: legalab at (13496, 1096) facing 3 (id 62)
  0.09  RESERVE: packed legalab at (13496, 1096) facing 3 in zone 7 where 8 slots of group 5 reach (id 62)
  0.09  RESERVE: leglab at (12544, 1088) facing 3 (id 63)
  0.09  RESERVE: zone 8 at (12616, 1088) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of legnanotc 2x1 gap 0 behind (12592, 1088) facing 3: 2 of 2 slots (group 6, zone)
  0.09  RESERVE: corridor 9 at (12568, 992) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 10 at (12568, 1184) facing 3, 21x6 cells: 122 of 126 held
  0.09  RESERVE: zone 11 at (12568, 1088) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 11 at (12320, 1088) facing 3, 20x10 cells: 180 of 200 held
  0.09  EXP: approach: corcom(22427) at (13889, 2247) walks to (13909, 2246), 139 from the cormex site (14048, 2240)
  0.12  EXP: idle: corcom(22427) on cormex at (13906, 2252), site (14048, 2240), target yes, fails 1 (arrived at the approach point)
  0.17  RESERVE: armlab at (1776, 960) facing 1 (id 117)
  0.17  RESERVE: zone 12 at (1704, 960) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1728, 960) facing 1: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: armlab at (1776, 832) facing 1 (id 120)
  0.17  RESERVE: zone 13 at (1704, 832) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1728, 832) facing 1: 2 of 2 slots (group 9, zone)
  0.17  RESERVE: armlab at (1776, 704) facing 1 (id 123)
  0.17  RESERVE: zone 14 at (1704, 704) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1728, 704) facing 1: 2 of 2 slots (group 10, zone)
  0.17  RESERVE: armlab at (2048, 816) facing 1 (id 126)
  0.17  RESERVE: zone 15 at (1976, 816) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (2000, 816) facing 1: 2 of 2 slots (group 11, zone)
  0.17  RESERVE: corridor 16 at (2024, 912) facing 1, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 17 at (2024, 816) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 17 at (2272, 816) facing 1, 20x10 cells: 190 of 200 held
  0.17  EXP: approach: armcom(2244) at (430, 2297) walks to (414, 2291), 136 from the armmex site (288, 2240)
  0.17  RESERVE: leglab at (12560, 832) facing 3 (id 66)
  0.17  RESERVE: zone 12 at (12632, 832) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of legnanotc 2x1 gap 0 behind (12608, 832) facing 3: 2 of 2 slots (group 7, zone)
  0.17  RESERVE: corridor 13 at (12584, 736) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (12584, 832) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (12336, 832) facing 3, 20x10 cells: 190 of 200 held
  0.21  EXP: approach: corcom(22427) at (13906, 2252) walks to (13903, 2278), 139 from the cormex site (13888, 2416)
  0.25  RESERVE: armalab at (2072, 1608) facing 1 (id 129)
  0.25  RESERVE: zone 18 at (1952, 1608) facing 1, 6x7 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (2000, 1608) facing 1: 4 of 4 slots (group 12, zone)
  0.25  RESERVE: zone 19 at (2024, 1608) facing 0, 15x9 cells: 12 of 135 held
  0.25  RESERVE: corridor 20 at (2320, 1608) facing 1, 20x13 cells: 260 of 260 held
  0.26  RESERVE: legalab at (12520, 1784) facing 3 (id 69)
  0.26  RESERVE: zone 15 at (12640, 1784) facing 3, 6x7 cells: 42 of 42 held
  0.26  RESERVE: grid of legnanotc 2x2 gap 0 behind (12592, 1784) facing 3: 4 of 4 slots (group 8, zone)
  0.26  RESERVE: zone 16 at (12568, 1784) facing 0, 15x9 cells: 12 of 135 held
  0.26  RESERVE: corridor 17 at (12272, 1784) facing 3, 20x13 cells: 260 of 260 held
  0.28  RESERVE: zone 1 at (872, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4200) facing 1 (id 1)
  0.28  RESERVE: zone 2 at (872, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4152) facing 1 (id 2)
  0.28  RESERVE: zone 3 at (872, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4104) facing 1 (id 3)
  0.28  RESERVE: zone 4 at (872, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4056) facing 1 (id 4)
  0.28  RESERVE: zone 5 at (872, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 4008) facing 1 (id 5)
  0.28  RESERVE: zone 6 at (872, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (872, 3960) facing 1 (id 6)
  0.28  RESERVE: zone 7 at (920, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4200) facing 1 (id 7)
  0.28  RESERVE: zone 8 at (920, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4152) facing 1 (id 8)
  0.28  RESERVE: zone 9 at (920, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4104) facing 1 (id 9)
  0.28  RESERVE: zone 10 at (920, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4056) facing 1 (id 10)
  0.28  RESERVE: zone 11 at (920, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 4008) facing 1 (id 11)
  0.28  RESERVE: zone 12 at (920, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (920, 3960) facing 1 (id 12)
  0.28  RESERVE: zone 13 at (968, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4200) facing 1 (id 13)
  0.28  RESERVE: zone 14 at (968, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4152) facing 1 (id 14)
  0.28  RESERVE: zone 15 at (968, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4104) facing 1 (id 15)
  0.28  RESERVE: zone 16 at (968, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4056) facing 1 (id 16)
  0.28  RESERVE: zone 17 at (968, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 4008) facing 1 (id 17)
  0.28  RESERVE: zone 18 at (968, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (968, 3960) facing 1 (id 18)
  0.28  RESERVE: zone 19 at (1016, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4200) facing 1 (id 19)
  0.28  RESERVE: zone 20 at (1016, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4152) facing 1 (id 20)
  0.28  RESERVE: zone 21 at (1016, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4104) facing 1 (id 21)
  0.28  RESERVE: zone 22 at (1016, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4056) facing 1 (id 22)
  0.28  RESERVE: zone 23 at (1016, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 4008) facing 1 (id 23)
  0.28  RESERVE: zone 24 at (1016, 3960) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1016, 3960) facing 1 (id 24)
  0.28  RESERVE: zone 25 at (1064, 4200) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4200) facing 1 (id 25)
  0.28  RESERVE: zone 26 at (1064, 4152) facing 1, 3x3 cells: 9 of 9 held
  0.28  RESERVE: armtide at (1064, 4152) facing 1 (id 26)
```
