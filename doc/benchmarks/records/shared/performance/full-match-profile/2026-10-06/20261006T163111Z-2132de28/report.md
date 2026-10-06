# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 7.6 min (frame 13689); wall 293 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T13:26:14
- Map: Full Metal Plate 1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=SUPPORT/cortex/test, 3=TACTICAL/legion/test, 4=FRONT/armada/test, 5=FRONT/cortex/test, 6=FRONT/legion/test, 7=FRONT/armada/test, 8=TECH/cortex/test, 9=AIR/legion/test, 10=SUPPORT/armada/test, 11=TACTICAL/cortex/test, 12=FRONT/legion/test, 13=FRONT/armada/test, 14=FRONT/cortex/test, 15=FRONT/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: full-match-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\metal-plate\20261006T162613Z-c2a85e34\runs\20261006T163111Z-2132de28\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `competitive-roster` | seen at 0.2 min | `[t=00:00:52.232536][f=0000300] [PerfFixture] spectator_units=0 competing_ai_teams=16` |
| expect `timing` | seen at 4.0 min | `ed=12.000 speed_actual=12.000 ai_n=1800 ai_mean_ms=0.665154 ai_p50_ms=0.541016 ai_p95_ms=1.794922 ai_p99_ms=2.626953 ai_max_ms=9.017578 fps_n=5 fps_p10=29.000 fps_p50=31.000 fps_p90=38.000 profiling=1` |
| expect `commands` | seen at 1.0 min | `[t=00:00:56.408584][f=0001800] [AirOrders] frame=1800 team=0 all_apm=65 air_apm=4 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-033 metal over 95% for 60 s while team 15 has 1367 free` |

## Failures

- forbid 'invariant' hit at 5.2 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 15 has 1367 free
- forbid 'invariant' hit at 7.5 min: [INVARIANT] INV-052 ferry run for cargo 18555 unloading for 16 s

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\metal-plate\20261006T162613Z-c2a85e34\runs\20261006T163111Z-2132de28\screen_2026-10-06_16-28-30-280.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 12, 11 shots, end at 90.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (3400, 900) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1400, 1200) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (800, 3400) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (2100, 2500) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (4600, 1600) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (3600, 3000) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (2200, 4300) units 1
  0.00  [Playtest] frame 1 team 7 ally 0 side armada ai true dead false start (800, 5100) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (10888, 11088) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (8888, 11388) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (11488, 8888) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (10188, 9788) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (7688, 10688) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (8688, 9288) units 1
  0.00  [Playtest] frame 1 team 14 ally 1 side cortex ai true dead false start (10088, 7988) units 1
  0.00  [Playtest] frame 1 team 15 ally 1 side legion ai true dead false start (11488, 7188) units 1
  0.00  [Playtest] frame 1 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 12
  0.00  [Playtest] speed 12 at 0.00 min
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (3400, 900) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1400, 1200) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (800, 3400) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (2100, 2500) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (4600, 1600) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (3600, 3000) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (2200, 4300) units 1
  0.05  [Playtest] frame 90 team 7 ally 0 side armada ai true dead false start (800, 5100) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (10888, 11088) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (8888, 11388) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (11488, 8888) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (10188, 9788) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (7688, 10688) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (8688, 9288) units 1
  0.05  [Playtest] frame 90 team 14 ally 1 side cortex ai true dead false start (10088, 7988) units 1
  0.05  [Playtest] frame 90 team 15 ally 1 side legion ai true dead false start (11488, 7188) units 1
  0.05  [Playtest] frame 90 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Capacity] own=2/30 usage=7/32 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=990 E=0 bank=989 pull=32 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=23/101
  0.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.10  [AIR][Fusion] target=1200s mexes=0 upgraded=all reactor=pending
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (3384, 1048), 151 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|3400|897|0|1|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(1400,1197) factory=armlab landLocked=no spot=0 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=SUPPORT side=cortex start=(799,3401) factory=corlab landLocked=no spot=2 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=TACTICAL side=legion start=(2100,2500) factory=leghp landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=FRONT side=armada start=(4600,1597) factory=armlab landLocked=no spot=4 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=FRONT side=cortex start=(3599,3001) factory=corlab landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=FRONT side=legion start=(2200,4300) factory=leglab landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=FRONT side=armada start=(800,5097) factory=armlab landLocked=no spot=7 known=7/7
  0.15  [Playtest] finished armwin team 0 at 0.15 min
  0.17  [AIR][Rule] metal.economy builder=2244
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=939 E=18 bank=978 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=1/16
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.27  [Team][Roster] team 1 first mex at 1408,1264
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.28  [Team][Roster] first mex 21550 at 3472,896
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|3400|897|0|1|1|3472|896
  0.39  [Playtest] finished armmex team 0 at 0.38 min
  0.40  [AIR][Wind] cluster=0 slots=6 at=3592,896 local=false builder=2244
  0.43  [AIR][Capacity] own=2/55 usage=6/35 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=919 E=55 bank=996 pull=35 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=26/113
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.49  [Playtest] finished armwin team 0 at 0.49 min
  0.60  [AIR][Capacity] own=6/55 usage=7/38 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=5 bank=942 E=55 bank=997 pull=38 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=22/96
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.65  [Playtest] finished armwin team 0 at 0.65 min
  0.66  [AIR][Starter] nearby distance=160
  0.67  [AIR][Layout] cluster=0 labs=6 at=3424,585
  0.67  [AIR][EcoLayout] reserved air.fieldEco.0 reactor=3024,256 converters=0 support=12 zone=181
  0.67  [AIR][Layout] cluster=1 labs=6 at=3712,969
  0.68  [AIR][EcoLayout] reserved air.fieldEco.1 reactor=2640,640 converters=0 support=12 zone=322
  0.70  [AIR][EcoLayout] reserved air.fieldEco.2 reactor=3024,1024 converters=0 support=12 zone=338
  0.72  [AIR][EcoLayout] reserved air.fieldEco.3 reactor=2256,256 converters=0 support=12 zone=352
  0.77  [AIR][Capacity] own=6/80 usage=35/66 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=804 E=80 bank=999 pull=66 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=438/742
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.77  [AIR][Bay] 12 plant=26064 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Capacity] own=6/105 usage=35/66 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=513 E=105 bank=995 pull=66 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=81/137
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.93  [AIR][Bay] 12 plant=26064 BP=0 nanos=0+0/0 available=yes firstSlot=0
  0.97  [Playtest] finished armap team 0 at 0.97 min
  0.98  [AIR][Produce] opening.scout armpeep plant=26064 projected=1/1
  0.98  [AIR][Rule] opening.commander.guard builder=2244
  0.98  [AIR][Commander] cleared factory guard for metal.economy
  0.98  [AIR][Rule] metal.economy builder=2244
  0.98  [AIR][Claim] cancel unowned native order armnanotc
  0.98  [AIR][Claim] cancel unowned native order armnanotc
  0.98  [AIR][State] T1_CONTEST
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.7 bank 426/1200, energy +105.0 bank 1015/1101, units 8
  1.02  [Team][Roster] team 5 first mex at 3664,3008
  1.02  [Team][Roster] team 7 first mex at 864,5040
  1.03  [Team][Roster] team 2 first mex at 800,3471
  1.07  [Team][Roster] team 6 first mex at 2208,4368
  1.08  [AIR][Rule] opening.commander.guard builder=2244
  1.08  [AIR][Commander] cleared factory guard for metal.economy
  1.08  [AIR][Rule] metal.economy builder=2244
  1.10  [AIR][Capacity] own=6/105 usage=7/244 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T1_CONTEST M=6 bank=418 E=105 bank=1076 pull=244 plants=1/0 aircraftDemand=3/121
  1.10  [AIR][Projects] energyQueued=0 committed=0/0
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  1.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Bay] 12 plant=26064 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.11  [AIR][Produce] constructor.recovery armca plant=26064 projected=1/3
  1.11  [AIR][Scout] opening drone=30899 enemy starts=8
  1.15  [Team][Roster] team 4 first mex at 4672,1600
  1.18  [AIR][Rule] opening.commander.guard builder=2244
  1.18  [AIR][Commander] cleared factory guard for metal.economy
  1.18  [AIR][Rule] metal.economy builder=2244
  1.25  [Team][Roster] team 3 first mex at 2160,2496
  1.27  [AIR][Capacity] own=6/105 usage=0/6 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T1_CONTEST M=6 bank=405 E=105 bank=1034 pull=195 plants=1/0 aircraftDemand=3/121
  1.27  [AIR][Projects] energyQueued=0 committed=0/0
  1.27  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  1.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.27  [AIR][Bay] 12 plant=26064 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.28  [AIR][Rule] opening.commander.guard builder=2244
  1.28  [AIR][Commander] cleared factory guard for metal.economy
  1.28  [AIR][Rule] metal.economy builder=2244
  1.32  [AIR][Produce] constructor.recovery armca plant=26064 projected=2/3
  1.32  [AIR][Rule] metal.economy builder=15483
  1.37  [AIR][Rule] opening.commander.guard builder=2244
  1.37  [AIR][Commander] cleared factory guard for metal.economy
  1.37  [AIR][Rule] metal.economy builder=2244
  1.43  [AIR][Capacity] own=6/105 usage=1/19 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=96 reason=funded workload
  1.43  [AIR][Economy] T1_CONTEST M=6 bank=385 E=105 bank=959 pull=208 plants=1/0 aircraftDemand=3/121
  1.43  [AIR][Projects] energyQueued=0 committed=41/411
  1.43  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=196 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.43  [AIR][Bay] 12 plant=26064 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.47  [AIR][Rule] opening.commander.guard builder=2244
  1.47  [AIR][Commander] cleared factory guard for metal.economy
  1.47  [AIR][Rule] metal.economy builder=2244
  1.54  [AIR][Produce] constructor.recovery armca plant=26064 projected=3/3
  1.55  [AIR][Rule] metal.economy builder=12786
  1.57  [AIR][Rule] opening.commander.guard builder=2244
  1.57  [AIR][Commander] cleared factory guard for metal.economy
  1.57  [AIR][Rule] metal.economy builder=2244
  1.60  [AIR][Capacity] own=6/110 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=50 shortage=161 reason=funded workload
  1.60  [AIR][Economy] T1_CONTEST M=6 bank=360 E=110 bank=1139 pull=166 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=66/443
  1.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=311 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Bay] 12 plant=26064 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.67  [AIR][Rule] opening.commander.guard builder=2244
  1.67  [AIR][Commander] cleared factory guard for metal.economy
  1.67  [AIR][Rule] metal.economy builder=2244
  1.76  [AIR][Produce] opening.screen armfig plant=26064 projected=1/6
  1.76  [AIR][Rule] metal.economy builder=23402
  1.77  [AIR][Capacity] own=6/115 usage=10/184 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST M=6 bank=306 E=115 bank=1164 pull=184 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=1 committed=80/425
  1.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.77  [AIR][Bay] 12 plant=26064 BP=150 nanos=0+0/2 available=yes firstSlot=0
  1.85  [Playtest] finished armwin team 0 at 1.85 min
  1.93  [Playtest] finished armmex team 0 at 1.93 min
  1.93  [AIR][Capacity] own=6/120 usage=13/182 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=350 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST M=6 bank=274 E=116 bank=1165 pull=182 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=2/11
  1.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=3 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  1.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Bay] 12 plant=26064 BP=150 nanos=0+0/2 available=yes firstSlot=0
  1.94  [Playtest] finished armwin team 0 at 1.94 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.1 bank 277/1250, energy +170.0 bank 940/1177, units 17
  2.04  [AIR][Produce] opening.screen armfig plant=26064 projected=2/6
  2.04  [AIR][Screen] fighters=1 cells=8 centre=1667,1494 width=600 advance=400 responding=true
  2.10  [AIR][Capacity] own=7/145 usage=14/190 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=450 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST M=6 bank=268 E=145 bank=1137 pull=190 plants=1/0 aircraftDemand=3/125
  2.10  [AIR][Projects] energyQueued=0 committed=85/607
  2.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Bay] 12 plant=26064 BP=150 nanos=0+0/2 available=yes firstSlot=0
  2.10  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=39
  2.12  [Playtest] finished armwin team 0 at 2.12 min
  2.13  [AIR][Wind] cluster=1 slots=6 at=3496,1264 local=false builder=12786
  2.17  [AIR][BaseResponse] contact=true
  2.17  [AIR][BaseResponse] group=0 target=8009
  2.17  [AIR][BaseResponse] group=2 target=8009
  2.17  [AIR][BaseResponse] group=3 target=8009
  2.17  [AIR][BaseResponse] dispatched=1 total=1
  2.18  [AIR][BaseResponse] contact=false
  2.18  [AIR][BaseResponse] group=0 target=-1
  2.18  [AIR][BaseResponse] group=2 target=-1
  2.18  [AIR][BaseResponse] group=3 target=-1
  2.20  [AIR][BaseResponse] contact=true
  2.20  [AIR][BaseResponse] group=0 target=8009
  2.20  [AIR][BaseResponse] group=2 target=8009
  2.20  [AIR][BaseResponse] group=3 target=8009
  2.22  [AIR][BaseResponse] contact=false
  2.22  [AIR][BaseResponse] group=0 target=-1
  2.22  [AIR][BaseResponse] group=2 target=-1
  2.22  [AIR][BaseResponse] group=3 target=-1
  2.24  [Playtest] finished armwin team 0 at 2.24 min
  2.25  [AIR][BaseResponse] contact=true
  2.25  [AIR][BaseResponse] group=0 target=23795
  2.25  [AIR][BaseResponse] group=2 target=23795
  2.25  [AIR][BaseResponse] group=3 target=23795
  2.27  [AIR][Capacity] own=9/170 usage=9/167 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=100 shortage=18 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST M=9 bank=255 E=170 bank=1162 pull=167 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=1 committed=101/598
  2.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=168 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.27  [AIR][Bay] 12 plant=26064 BP=150 nanos=0+0/2 available=yes firstSlot=0
  2.30  [AIR][BaseResponse] contact=false
  2.30  [AIR][BaseResponse] group=0 target=-1
  2.30  [AIR][BaseResponse] group=2 target=-1
  2.30  [AIR][BaseResponse] group=3 target=-1
  2.32  [AIR][BaseResponse] contact=true
  2.32  [AIR][BaseResponse] group=0 target=23795
  2.32  [AIR][BaseResponse] group=2 target=23795
  2.32  [AIR][BaseResponse] group=3 target=23795
  2.33  [AIR][BaseResponse] group=0 target=8009
  2.33  [AIR][BaseResponse] group=2 target=8009
  2.33  [AIR][BaseResponse] group=3 target=8009
  2.35  [AIR][BaseResponse] group=0 target=23795
  2.35  [AIR][BaseResponse] group=2 target=23795
  2.35  [AIR][BaseResponse] group=3 target=23795
  2.40  [AIR][BaseResponse] contact=false
  2.40  [AIR][BaseResponse] group=0 target=-1
  2.40  [AIR][BaseResponse] group=2 target=-1
  2.40  [AIR][BaseResponse] group=3 target=-1
  2.42  [AIR][BaseResponse] contact=true
  2.42  [AIR][BaseResponse] group=0 target=8009
  2.42  [AIR][BaseResponse] group=2 target=8009
  2.42  [AIR][BaseResponse] group=3 target=8009
  2.43  [AIR][Capacity] own=9/220 usage=7/159 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=449 shortage=106 reason=funded workload
  2.43  [AIR][Economy] T1_CONTEST M=9 bank=280 E=217 bank=1178 pull=159 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=58/332
  2.43  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=256 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Bay] 12 plant=26064 BP=150 nanos=0+0/2 available=yes firstSlot=0
  2.45  [AIR][Produce] opening.screen armfig plant=26064 projected=3/6
  2.46  [Playtest] finished armwin team 0 at 2.46 min
  2.54  [Playtest] finished armwin team 0 at 2.54 min
  2.60  [Playtest] finished armmex team 0 at 2.60 min
  2.60  [AIR][Capacity] own=9/220 usage=13/186 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=400 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=9 bank=258 E=220 bank=1179 pull=186 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=54/237
  2.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 727 more
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.08  RESERVE: zone 7 at (1288, 616) facing 0, 77x63 cells: 4815 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1288, 1112) facing 0: 9 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1288, 1064) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1288, 1016) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (1288, 968) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1208, 1192) facing 0 (id 59)
  0.08  RESERVE: zone 8 at (968, 1592) facing 0, 41x45 cells: 1827 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (968, 1944) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (968, 1896) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (968, 1848) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (968, 1800) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (1296, 2848) facing 0 (id 112)
  0.08  RESERVE: zone 9 at (1296, 2776) facing 0, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1296, 2800) facing 0: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (1392, 2824) facing 0, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 11 at (1296, 2824) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (1296, 3072) facing 0, 10x20 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 3
  0.09  RESERVE: zone 7 at (10861, 11496) facing 3, 63x77 cells: 4375 of 4851 held
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (10365, 11496) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (10413, 11496) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (10461, 11496) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (10509, 11496) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: coralab at (10280, 11256) facing 3 (id 63)
  0.09  RESERVE: zone 8 at (9885, 11816) facing 3, 45x41 cells: 1845 of 1845 held
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (9533, 11816) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (9581, 11816) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (9629, 11816) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (9677, 11816) facing 3: 13 of 13 slots (group 6, held, zone)
  0.09  RESERVE: corlab at (8848, 10992) facing 3 (id 116)
  0.09  RESERVE: zone 9 at (8920, 10992) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of cornanotc 2x1 gap 0 behind (8896, 10992) facing 3: 2 of 2 slots (group 7, zone)
  0.09  RESERVE: corridor 10 at (8872, 10896) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 11 at (8872, 11088) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: zone 12 at (8872, 10992) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 12 at (8624, 10992) facing 3, 20x10 cells: 180 of 200 held
  0.16  EXP: approach: corcom(29543) at (10887, 11089) walks to (10877, 10879), 139 from the cormex site (11008, 10832)
  0.17  RESERVE: zone 1 at (8784, 11360) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (8784, 11360) facing 0 (id 1)
  0.17  RESERVE: zone 2 at (8848, 11360) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (8848, 11360) facing 0 (id 2)
  0.17  RESERVE: zone 3 at (8912, 11360) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (8912, 11360) facing 0 (id 3)
  0.17  RESERVE: zone 4 at (8976, 11360) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (8976, 11360) facing 0 (id 4)
  0.17  RESERVE: zone 5 at (8784, 11296) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (8784, 11296) facing 0 (id 5)
  0.17  RESERVE: zone 6 at (8848, 11296) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (8848, 11296) facing 0 (id 6)
  0.17  RESERVE: zone 7 at (8912, 11296) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (8912, 11296) facing 0 (id 7)
  0.17  RESERVE: zone 8 at (8976, 11296) facing 0, 4x4 cells: 16 of 16 held
  0.17  RESERVE: legmex at (8976, 11296) facing 0 (id 8)
  0.17  RESERVE: zone 9 at (8880, 11328) facing 0, 16x8 cells: 0 of 128 held
  0.17  RESERVE: armlab at (1040, 2848) facing 0 (id 115)
  0.17  RESERVE: zone 12 at (1040, 2776) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (1040, 2800) facing 0: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (1136, 2824) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (1040, 2824) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (1040, 3072) facing 0, 10x20 cells: 190 of 200 held
  0.17  RESERVE: corlab at (8848, 10608) facing 3 (id 119)
  0.17  RESERVE: zone 13 at (8920, 10608) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of cornanotc 2x1 gap 0 behind (8896, 10608) facing 3: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 14 at (8872, 10512) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: corridor 15 at (8872, 10704) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 16 at (8872, 10608) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 16 at (8624, 10608) facing 3, 20x10 cells: 180 of 200 held
  0.25  RESERVE: armalab at (1656, 2840) facing 0 (id 118)
  0.25  RESERVE: zone 15 at (1656, 2720) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (1656, 2768) facing 0: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (1656, 2792) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (1656, 3088) facing 0, 13x20 cells: 260 of 260 held
  0.26  RESERVE: coralab at (8856, 10296) facing 3 (id 122)
  0.26  RESERVE: zone 17 at (8976, 10296) facing 3, 6x7 cells: 42 of 42 held
  0.26  RESERVE: grid of cornanotc 2x2 gap 0 behind (8928, 10296) facing 3: 4 of 4 slots (group 9, zone)
  0.26  RESERVE: zone 18 at (8904, 10296) facing 0, 15x9 cells: 12 of 135 held
  0.26  RESERVE: corridor 19 at (8608, 10296) facing 3, 20x13 cells: 260 of 260 held
  0.28  RESERVE: zone 1 at (3488, 768) facing 0, 4x4 cells: 16 of 16 held
  0.28  RESERVE: armmex at (3488, 768) facing 0 (id 1)
  0.28  RESERVE: zone 2 at (3552, 768) facing 0, 4x4 cells: 16 of 16 held
  0.28  RESERVE: armmex at (3552, 768) facing 0 (id 2)
  0.28  RESERVE: zone 3 at (3616, 768) facing 0, 4x4 cells: 16 of 16 held
  0.28  RESERVE: armmex at (3616, 768) facing 0 (id 3)
  0.28  RESERVE: zone 4 at (3680, 768) facing 0, 4x4 cells: 16 of 16 held
  0.28  RESERVE: armmex at (3680, 768) facing 0 (id 4)
  0.28  RESERVE: zone 5 at (3488, 704) facing 0, 4x4 cells: 16 of 16 held
  0.28  RESERVE: armmex at (3488, 704) facing 0 (id 5)
  0.28  RESERVE: zone 6 at (3552, 704) facing 0, 4x4 cells: 16 of 16 held
  0.28  RESERVE: armmex at (3552, 704) facing 0 (id 6)
  0.28  RESERVE: zone 7 at (3616, 704) facing 0, 4x4 cells: 16 of 16 held
  0.28  RESERVE: armmex at (3616, 704) facing 0 (id 7)
  0.28  RESERVE: zone 8 at (3680, 704) facing 0, 4x4 cells: 16 of 16 held
  0.28  RESERVE: armmex at (3680, 704) facing 0 (id 8)
  0.28  RESERVE: zone 9 at (3584, 736) facing 0, 16x8 cells: 0 of 128 held
  0.29  EXP: approach: legcom(27939) at (8888, 11388) walks to (9022, 11383), 137 from the legmex site (9024, 11520)
  0.33  RESERVE: armalab at (776, 2840) facing 0 (id 123)
  0.33  RESERVE: zone 18 at (776, 2720) facing 0, 7x6 cells: 42 of 42 held
  0.33  RESERVE: grid of armnanotc 2x2 gap 0 behind (776, 2768) facing 0: 4 of 4 slots (group 10, zone)
  0.33  RESERVE: zone 19 at (776, 2792) facing 0, 9x15 cells: 12 of 135 held
  0.33  RESERVE: corridor 20 at (776, 3088) facing 0, 13x20 cells: 260 of 260 held
  0.34  RESERVE: coralab at (8840, 11704) facing 3 (id 127)
  0.34  RESERVE: zone 20 at (8960, 11704) facing 3, 6x7 cells: 42 of 42 held
  0.34  RESERVE: grid of cornanotc 2x2 gap 0 behind (8912, 11704) facing 3: 4 of 4 slots (group 10, zone)
  0.34  RESERVE: zone 21 at (8888, 11704) facing 0, 15x9 cells: 12 of 135 held
  0.34  RESERVE: corridor 22 at (8592, 11704) facing 3, 20x13 cells: 260 of 260 held
  0.35  RESERVE: zone 23 at (10976, 10768) facing 0, 4x4 cells: 16 of 16 held
  0.35  RESERVE: cormex at (10976, 10768) facing 0 (id 132)
  0.35  RESERVE: zone 24 at (11040, 10768) facing 0, 4x4 cells: 16 of 16 held
  0.35  RESERVE: cormex at (11040, 10768) facing 0 (id 133)
  0.35  RESERVE: zone 25 at (11104, 10768) facing 0, 4x4 cells: 16 of 16 held
  0.35  RESERVE: cormex at (11104, 10768) facing 0 (id 134)
  0.35  RESERVE: zone 26 at (11168, 10768) facing 0, 4x4 cells: 16 of 16 held
  0.35  RESERVE: cormex at (11168, 10768) facing 0 (id 135)
  0.35  RESERVE: zone 27 at (10976, 10704) facing 0, 4x4 cells: 16 of 16 held
  0.35  RESERVE: cormex at (10976, 10704) facing 0 (id 136)
  0.35  RESERVE: zone 28 at (11040, 10704) facing 0, 4x4 cells: 16 of 16 held
  0.35  RESERVE: cormex at (11040, 10704) facing 0 (id 137)
  0.35  RESERVE: zone 29 at (11104, 10704) facing 0, 4x4 cells: 16 of 16 held
  0.35  RESERVE: cormex at (11104, 10704) facing 0 (id 138)
```
