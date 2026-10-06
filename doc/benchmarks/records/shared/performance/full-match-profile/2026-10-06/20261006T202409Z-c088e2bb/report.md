# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 30.0 min (frame 54004); wall 1263 s
- DLL: build-theatres\d221\candidate1\SkirmishAI.dll (eca9d0229482cc8e); AI BARbTest/test; staged 2026-10-06T17:03:03
- Map: Full Metal Plate 1.7; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=SUPPORT/cortex/test, 3=TACTICAL/legion/test, 4=FRONT/armada/test, 5=FRONT/cortex/test, 6=FRONT/legion/test, 7=FRONT/armada/test, 8=TECH/cortex/test, 9=AIR/legion/test, 10=SUPPORT/armada/test, 11=TACTICAL/cortex/test, 12=FRONT/legion/test, 13=FRONT/armada/test, 14=FRONT/cortex/test, 15=FRONT/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: full-match-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\metal-plate\20261006T200302Z-fb4b67d2\runs\20261006T202409Z-c088e2bb\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `competitive-roster` | seen at 0.2 min | `[t=00:00:49.002121][f=0000300] [PerfFixture] spectator_units=0 competing_ai_teams=16` |
| expect `timing` | seen at 4.0 min | `ed=12.000 speed_actual=12.000 ai_n=1800 ai_mean_ms=0.667967 ai_p50_ms=0.541016 ai_p95_ms=1.738281 ai_p99_ms=2.603516 ai_max_ms=9.664063 fps_n=5 fps_p10=28.000 fps_p50=31.000 fps_p90=36.000 profiling=1` |
| expect `commands` | seen at 1.0 min | `[t=00:00:53.192666][f=0001800] [AirOrders] frame=1800 team=0 all_apm=64 air_apm=4 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-033 metal over 95% for 60 s while team 14 has 3077 free` |

## Failures

- forbid 'invariant' hit at 5.4 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 14 has 3077 free
- forbid 'invariant' hit at 6.5 min: [INVARIANT] INV-025 a T1 lab frame started with 3 T1 constructors at +28 metal, advanced lab down
- forbid 'invariant' hit at 9.7 min: [INVARIANT] INV-052 ferry run for cargo 11765 unloading for 16 s
- forbid 'invariant' hit at 9.8 min: [INVARIANT] INV-028 metal bank over 50% for 60 s, 4 T2 constructors, none added
- forbid 'invariant' hit at 10.3 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 244 elmos away, not flush (160)
- forbid 'invariant' hit at 10.4 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 0 (0 by power), bank 2096 + 70/s (0 by metal))
- forbid 'invariant' hit at 10.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 1381 elmos away, not flush (160)
- forbid 'invariant' hit at 10.7 min: [INVARIANT] INV-025 a T1 lab frame started with 3 T1 constructors at +70 metal, advanced lab up
- forbid 'invariant' hit at 10.8 min: [INVARIANT] INV-025 a T1 lab frame started with 5 T1 constructors at +75 metal, advanced lab up
- forbid 'invariant' hit at 11.0 min: [INVARIANT] INV-008 2 turret(s) in range of the reclaim of armalab 14104 are not on it
- forbid 'invariant' hit at 11.1 min: [INVARIANT] INV-010 combat unit armpw 18627 produced at +80 metal under the gate 200
- forbid 'invariant' hit at 11.3 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 244 elmos away, not flush (160)
- forbid 'invariant' hit at 11.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 1381 elmos away, not flush (160)
- forbid 'invariant' hit at 11.7 min: [INVARIANT] INV-005 T1 lab 20838 is retiring but the throwaway is 10430
- forbid 'invariant' hit at 12.3 min: [INVARIANT] INV-043 1 spam unit(s) left their lane (armpw 19564 now on task type 2)
- forbid 'invariant' hit at 12.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 1381 elmos away, not flush (160)
- forbid 'invariant' hit at 13.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 1381 elmos away, not flush (160)
- forbid 'invariant' hit at 14.2 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 240 elmos away, not flush (160)
- forbid 'invariant' hit at 14.6 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 1381 elmos away, not flush (160)
- forbid 'invariant' hit at 15.2 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 197 elmos away, not flush (160)
- forbid 'invariant' hit at 15.7 min: [INVARIANT] INV-043 9 spam unit(s) left their lane (leghades 27958 now on task type 7)
- forbid 'invariant' hit at 16.2 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 197 elmos away, not flush (160)
- forbid 'invariant' hit at 17.2 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 192 elmos away, not flush (160)
- forbid 'invariant' hit at 18.2 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 192 elmos away, not flush (160)
- forbid 'invariant' hit at 18.4 min: [INVARIANT] INV-010 combat unit armpw 19650 produced at +137 metal under the gate 200
- forbid 'invariant' hit at 19.2 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 192 elmos away, not flush (160)
- forbid 'invariant' hit at 19.5 min: [INVARIANT] INV-010 combat unit armfast 5218 produced at +157 metal under the gate 200
- forbid 'invariant' hit at 20.0 min: [INVARIANT] INV-004 metal floating at 7478 of 7550 for 60 s while armflak is under construction and static build power 1920 is under 2741
- forbid 'invariant' hit at 20.2 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 192 elmos away, not flush (160)
- forbid 'invariant' hit at 20.5 min: [INVARIANT] INV-043 14 spam unit(s) left their lane (armpw 31303 now on task type 7)
- forbid 'invariant' hit at 20.9 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 5 has 3826 free
- forbid 'invariant' hit at 21.0 min: [INVARIANT] INV-008 7 turret(s) in range of the reclaim of armalab 14040 are not on it
- forbid 'invariant' hit at 21.3 min: [INVARIANT] INV-010 combat unit armpw 14899 produced at +137 metal under the gate 200
- forbid 'invariant' hit at 21.7 min: [INVARIANT] INV-043 28 spam unit(s) left their lane (leghades 27205 now on task type 7)
- forbid 'invariant' hit at 22.3 min: [INVARIANT] INV-010 combat unit armpw 25553 produced at +137 metal under the gate 200
- forbid 'invariant' hit at 22.6 min: [INVARIANT] INV-004 metal floating at 8246 of 8250 for 60 s while cornanotc is under construction and static build power 1680 is under 2646
- forbid 'invariant' hit at 22.9 min: [INVARIANT] INV-008 5 turret(s) in range of the reclaim of coralab 15134 are not on it
- forbid 'invariant' hit at 23.6 min: [INVARIANT] INV-004 metal floating at 8099 of 8150 for 60 s while corflak is under construction and static build power 1680 is under 2646
- forbid 'invariant' hit at 23.7 min: [INVARIANT] INV-043 6 spam unit(s) left their lane (corak 24845 now on task type 7)
- forbid 'invariant' hit at 24.2 min: [INVARIANT] INV-010 combat unit armpw 19112 produced at +137 metal under the gate 200
- forbid 'invariant' hit at 24.6 min: [INVARIANT] INV-004 metal floating at 8066 of 8150 for 60 s while corfus is under construction and static build power 1680 is under 2787
- forbid 'invariant' hit at 25.2 min: [INVARIANT] INV-010 combat unit armpw 25446 produced at +137 metal under the gate 200
- forbid 'invariant' hit at 26.6 min: [INVARIANT] INV-010 combat unit armpw 6815 produced at +141 metal under the gate 200
- forbid 'invariant' hit at 26.9 min: [INVARIANT] INV-045 front cluster 3 (armalab) started its factory with 3 of its 4 turrets finished (4 wanted first)
- forbid 'invariant' hit at 27.6 min: [INVARIANT] INV-010 combat unit armpw 7579 produced at +141 metal under the gate 200
- forbid 'invariant' hit at 27.7 min: [INVARIANT] INV-010 combat unit corak 21343 produced at +132 metal under the gate 200
- forbid 'invariant' hit at 28.6 min: [INVARIANT] INV-010 combat unit armpw 5334 produced at +141 metal under the gate 200
- forbid 'invariant' hit at 29.6 min: [INVARIANT] INV-010 combat unit corak 523 produced at +132 metal under the gate 200
- forbid 'invariant' hit at 29.7 min: [INVARIANT] INV-010 combat unit armpw 12860 produced at +141 metal under the gate 200

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\metal-plate\20261006T200302Z-fb4b67d2\runs\20261006T202409Z-c088e2bb\screen_2026-10-06_20-05-15-703.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\metal-plate\20261006T200302Z-fb4b67d2\runs\20261006T202409Z-c088e2bb\screen_2026-10-06_20-06-15-749.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\metal-plate\20261006T200302Z-fb4b67d2\runs\20261006T202409Z-c088e2bb\screen_2026-10-06_20-08-22-795.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\metal-plate\20261006T200302Z-fb4b67d2\runs\20261006T202409Z-c088e2bb\screen_2026-10-06_20-13-02-033.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\full-match-profile\metal-plate\20261006T200302Z-fb4b67d2\runs\20261006T202409Z-c088e2bb\screen_2026-10-06_20-24-08-717.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 12, 11 shots, end at 30.5 min
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
  0.10  [AIR][Economy] BOOTSTRAP M=0 bank=990 E=0 bank=992 pull=32 plants=0/0 aircraftDemand=0/0
  0.10  [AIR][Projects] energyQueued=0 committed=19/86
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
  0.14  [Playtest] finished armwin team 0 at 0.14 min
  0.16  [AIR][Rule] metal.economy builder=2244
  0.26  [Playtest] finished armmex team 0 at 0.26 min
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=938 E=18 bank=976 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.27  [Team][Roster] first mex 18423 at 3472,896
  0.27  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|3400|897|0|1|1|3472|896
  0.27  [Team][Roster] team 1 first mex at 1408,1264
  0.39  [Playtest] finished armmex team 0 at 0.38 min
  0.40  [AIR][Wind] cluster=0 slots=6 at=3592,896 local=false builder=2244
  0.43  [AIR][Capacity] own=3/55 usage=6/35 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=923 E=55 bank=992 pull=35 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=26/113
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=2 upgraded=pending reactor=pending
  0.49  [Playtest] finished armwin team 0 at 0.49 min
  0.60  [AIR][Capacity] own=6/55 usage=7/38 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=299 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=5 bank=946 E=55 bank=999 pull=38 plants=0/0 aircraftDemand=0/0
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
  0.77  [AIR][Economy] BOOTSTRAP M=6 bank=808 E=80 bank=993 pull=66 plants=0/0 aircraftDemand=0/0
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
  0.93  [AIR][Economy] BOOTSTRAP M=6 bank=518 E=105 bank=988 pull=66 plants=0/0 aircraftDemand=0/0
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.7 bank 430/1200, energy +105.0 bank 1015/1101, units 8
  1.02  [Team][Roster] team 5 first mex at 3664,3008
  1.02  [Team][Roster] team 7 first mex at 864,5040
  1.03  [Team][Roster] team 2 first mex at 800,3471
  1.07  [Team][Roster] team 6 first mex at 2208,4368
  1.08  [AIR][Rule] opening.commander.guard builder=2244
  1.08  [AIR][Commander] cleared factory guard for metal.economy
  1.08  [AIR][Rule] metal.economy builder=2244
  1.10  [AIR][Capacity] own=6/105 usage=8/255 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] T1_CONTEST M=6 bank=422 E=105 bank=1024 pull=255 plants=1/0 aircraftDemand=3/121
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
  1.11  [AIR][Scout] opening drone=24727 enemy starts=8
  1.12  [Team][Roster] team 4 first mex at 4672,1600
  1.18  [AIR][Rule] opening.commander.guard builder=2244
  1.18  [AIR][Commander] cleared factory guard for metal.economy
  1.18  [AIR][Rule] metal.economy builder=2244
  1.25  [Team][Roster] team 3 first mex at 2160,2496
  1.27  [AIR][Capacity] own=6/105 usage=0/6 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] T1_CONTEST M=6 bank=410 E=105 bank=1035 pull=195 plants=1/0 aircraftDemand=3/121
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
  1.43  [AIR][Economy] T1_CONTEST M=6 bank=387 E=105 bank=1047 pull=208 plants=1/0 aircraftDemand=3/121
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
  1.54  [AIR][Rule] metal.economy builder=12786
  1.57  [AIR][Rule] opening.commander.guard builder=2244
  1.57  [AIR][Commander] cleared factory guard for metal.economy
  1.57  [AIR][Rule] metal.economy builder=2244
  1.60  [AIR][Capacity] own=6/110 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=100 shortage=107 reason=funded workload
  1.60  [AIR][Economy] T1_CONTEST M=6 bank=359 E=110 bank=1139 pull=171 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=65/441
  1.60  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=257 floating=false savingLab=false
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
  1.75  [AIR][Produce] opening.screen armfig plant=26064 projected=1/6
  1.75  [AIR][Rule] metal.economy builder=27738
  1.77  [AIR][Capacity] own=6/115 usage=5/84 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=99 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST M=6 bank=310 E=115 bank=1164 pull=84 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=1 committed=79/423
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
  1.93  [Playtest] finished armwin team 0 at 1.93 min
  1.93  [AIR][Capacity] own=6/120 usage=14/187 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=49 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST M=6 bank=269 E=117 bank=1165 pull=187 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=36/157
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
  2.00  [Playtest] eco team 0 at 2.0 min: metal +9.1 bank 261/1250, energy +170.0 bank 1142/1177, units 16
  2.02  [Playtest] finished armwin team 0 at 2.02 min
  2.03  [AIR][Wind] cluster=1 slots=6 at=3496,1264 local=false builder=12786
  2.10  [AIR][Capacity] own=7/157 usage=13/185 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=400 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST M=6 bank=259 E=167 bank=1178 pull=185 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=96/672
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
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=39
  2.12  [Playtest] finished armwin team 0 at 2.12 min
  2.15  [AIR][Produce] opening.screen armfig plant=26064 projected=2/6
  2.15  [AIR][Screen] fighters=1 cells=8 centre=1667,1494 width=600 advance=400 responding=false
  2.27  [AIR][Capacity] own=9/195 usage=7/158 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=127 reason=funded workload
  2.27  [AIR][Economy] T1_CONTEST M=9 bank=271 E=195 bank=1178 pull=158 plants=1/0 aircraftDemand=3/125
  2.27  [AIR][Projects] energyQueued=0 committed=92/577
  2.27  [AIR][Workforce] t1=3/4 t2=0/2 targetBP=277 floating=false savingLab=false
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
  2.33  [AIR][Screen] fighters=1 cells=8 centre=1667,1494 width=600 advance=400 responding=false
  2.35  [AIR][BaseResponse] contact=true
  2.35  [AIR][BaseResponse] group=0 target=10482
  2.35  [AIR][BaseResponse] group=2 target=10482
  2.35  [AIR][BaseResponse] group=3 target=10482
  2.35  [AIR][BaseResponse] dispatched=1 total=1
  2.38  [Playtest] finished armwin team 0 at 2.38 min
  2.40  [AIR][BaseResponse] contact=false
  2.40  [AIR][BaseResponse] group=0 target=-1
  2.40  [AIR][BaseResponse] group=2 target=-1
  2.40  [AIR][BaseResponse] group=3 target=-1
  2.42  [AIR][BaseResponse] contact=true
  2.42  [AIR][BaseResponse] group=0 target=19421
  2.42  [AIR][BaseResponse] group=2 target=19421
  2.42  [AIR][BaseResponse] group=3 target=19421
  2.43  [AIR][Capacity] own=9/220 usage=11/176 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=449 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST M=9 bank=264 E=220 bank=1179 pull=176 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=57/347
  2.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
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
  2.44  [Playtest] finished armwin team 0 at 2.44 min
  2.52  [Playtest] finished armwin team 0 at 2.52 min
  2.55  [AIR][BaseResponse] dispatched=1 total=2
  2.56  [AIR][Produce] opening.screen armfig plant=26064 projected=3/6
  2.60  [AIR][Capacity] own=9/245 usage=14/190 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=449 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST M=9 bank=239 E=242 bank=1167 pull=190 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=8/55
  2.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=4 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 8 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 9 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 10 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 11 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Bay] 12 plant=26064 BP=150 nanos=0+0/2 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=35
  2.61  [Playtest] finished armwin team 0 at 2.61 min
  2.64  [Playtest] finished armmex team 0 at 2.64 min
  2.70  [Playtest] finished armrad team 0 at 2.70 min
  2.77  [AIR][Capacity] own=9/295 usage=25/169 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=450 shortage=0 reason=no funded workload
  2.77  [AIR][Economy] T1_CONTEST M=9 bank=184 E=295 bank=1180 pull=169 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=222/1011
  2.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=6 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=-1 BP=0 nanos=0+0/2 available=yes firstSlot=0
  2.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 6 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  2.77  [AIR][Bay] 7 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
... 6221 more
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
