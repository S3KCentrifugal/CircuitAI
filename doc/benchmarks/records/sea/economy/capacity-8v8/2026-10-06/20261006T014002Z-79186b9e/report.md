# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 12.0 min (frame 21675); wall 243 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (3a6cae6daa1b3852); AI BARbTest/test; staged 2026-10-05T22:35:50
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-capacity-8v8.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-8v8\shore\20261006T013550Z-55fff867\runs\20261006T014002Z-79186b9e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:27.624205][f=-000001] [SeaRecoveryTest] loaded teams=16 fixture=false` |
| expect `sub-scaling` | seen at 1.5 min | `[t=00:00:59.472789][f=0002700] [SeaRecoveryTest] PASS sub-scaling` |
| expect `start-count` | seen at 0.1 min | `[Setup] StartSpots length=16` |
| expect `team-0-factory-1` | seen at 1.1 min | `[t=00:00:54.137114][f=0002009] [SeaRecoveryTest] PASS team-0-factory-1` |
| expect `team-0-factory-2` | seen at 1.4 min | `[t=00:00:57.371176][f=0002446] [SeaRecoveryTest] PASS team-0-factory-2` |
| expect `team-0-factory-3` | seen at 1.5 min | `[t=00:01:00.164649][f=0002778] [SeaRecoveryTest] PASS team-0-factory-3` |
| expect `team-1-factory-1` | seen at 1.1 min | `[t=00:00:54.137623][f=0002009] [SeaRecoveryTest] PASS team-1-factory-1` |
| expect `team-1-factory-2` | seen at 1.4 min | `[t=00:00:57.372220][f=0002446] [SeaRecoveryTest] PASS team-1-factory-2` |
| expect `team-1-factory-3` | seen at 1.6 min | `[t=00:01:01.126650][f=0002894] [SeaRecoveryTest] PASS team-1-factory-3` |
| expect `team-2-factory-1` | seen at 1.1 min | `[t=00:00:54.164548][f=0002013] [SeaRecoveryTest] PASS team-2-factory-1` |
| expect `team-2-factory-2` | seen at 1.5 min | `[t=00:00:59.284440][f=0002674] [SeaRecoveryTest] PASS team-2-factory-2` |
| expect `team-2-factory-3` | seen at 1.4 min | `[t=00:00:58.230465][f=0002556] [SeaRecoveryTest] PASS team-2-factory-3` |
| expect `team-3-factory-1` | seen at 1.1 min | `[t=00:00:54.109612][f=0001999] [SeaRecoveryTest] PASS team-3-factory-1` |
| expect `team-3-factory-2` | seen at 1.6 min | `[t=00:01:00.673319][f=0002834] [SeaRecoveryTest] PASS team-3-factory-2` |
| expect `team-3-factory-3` | seen at 1.2 min | `[t=00:00:55.372716][f=0002192] [SeaRecoveryTest] PASS team-3-factory-3` |
| expect `team-4-factory-1` | seen at 1.1 min | `[t=00:00:54.139106][f=0002009] [SeaRecoveryTest] PASS team-4-factory-1` |
| expect `team-4-factory-2` | seen at 1.6 min | `[t=00:01:01.679143][f=0002970] [SeaRecoveryTest] PASS team-4-factory-2` |
| expect `team-4-factory-3` | seen at 1.6 min | `[t=00:01:01.127232][f=0002894] [SeaRecoveryTest] PASS team-4-factory-3` |
| expect `team-5-factory-1` | seen at 1.1 min | `[t=00:00:54.193464][f=0002018] [SeaRecoveryTest] PASS team-5-factory-1` |
| expect `team-5-factory-2` | seen at 1.7 min | `[t=00:01:01.735339][f=0002975] [SeaRecoveryTest] PASS team-5-factory-2` |
| expect `team-5-factory-3` | seen at 1.3 min | `[t=00:00:56.895630][f=0002395] [SeaRecoveryTest] PASS team-5-factory-3` |
| expect `team-6-factory-1` | seen at 1.1 min | `[t=00:00:54.132578][f=0002008] [SeaRecoveryTest] PASS team-6-factory-1` |
| expect `team-6-factory-2` | seen at 1.6 min | `[t=00:01:01.450915][f=0002937] [SeaRecoveryTest] PASS team-6-factory-2` |
| expect `team-6-factory-3` | seen at 1.2 min | `[t=00:00:55.363662][f=0002191] [SeaRecoveryTest] PASS team-6-factory-3` |
| expect `team-7-factory-1` | seen at 1.1 min | `[t=00:00:54.133018][f=0002008] [SeaRecoveryTest] PASS team-7-factory-1` |
| expect `team-7-factory-2` | seen at 1.6 min | `[t=00:01:01.669067][f=0002969] [SeaRecoveryTest] PASS team-7-factory-2` |
| expect `team-7-factory-3` | **missing** (by 12 min) | |
| expect `team-8-factory-1` | seen at 1.2 min | `[t=00:00:55.552566][f=0002211] [SeaRecoveryTest] PASS team-8-factory-1` |
| expect `team-8-factory-2` | seen at 1.4 min | `[t=00:00:57.388857][f=0002448] [SeaRecoveryTest] PASS team-8-factory-2` |
| expect `team-8-factory-3` | seen at 1.4 min | `[t=00:00:58.301298][f=0002562] [SeaRecoveryTest] PASS team-8-factory-3` |
| expect `team-9-factory-1` | seen at 1.2 min | `[t=00:00:55.493228][f=0002202] [SeaRecoveryTest] PASS team-9-factory-1` |
| expect `team-9-factory-2` | seen at 1.4 min | `[t=00:00:57.243791][f=0002437] [SeaRecoveryTest] PASS team-9-factory-2` |
| expect `team-9-factory-3` | seen at 1.4 min | `[t=00:00:58.635614][f=0002607] [SeaRecoveryTest] PASS team-9-factory-3` |
| expect `team-10-factory-1` | seen at 1.2 min | `[t=00:00:55.463524][f=0002199] [SeaRecoveryTest] PASS team-10-factory-1` |
| expect `team-10-factory-2` | seen at 1.4 min | `[t=00:00:57.416181][f=0002449] [SeaRecoveryTest] PASS team-10-factory-2` |
| expect `team-10-factory-3` | seen at 1.5 min | `[t=00:00:58.736591][f=0002618] [SeaRecoveryTest] PASS team-10-factory-3` |
| expect `team-11-factory-1` | seen at 1.2 min | `[t=00:00:55.640052][f=0002222] [SeaRecoveryTest] PASS team-11-factory-1` |
| expect `team-11-factory-2` | seen at 1.4 min | `[t=00:00:57.377312][f=0002447] [SeaRecoveryTest] PASS team-11-factory-2` |
| expect `team-11-factory-3` | seen at 1.4 min | `[t=00:00:58.320988][f=0002565] [SeaRecoveryTest] PASS team-11-factory-3` |
| expect `team-12-factory-1` | seen at 1.2 min | `[t=00:00:55.395647][f=0002194] [SeaRecoveryTest] PASS team-12-factory-1` |
| expect `team-12-factory-2` | seen at 1.3 min | `[t=00:00:57.056272][f=0002412] [SeaRecoveryTest] PASS team-12-factory-2` |
| expect `team-12-factory-3` | seen at 1.6 min | `[t=00:01:00.342442][f=0002797] [SeaRecoveryTest] PASS team-12-factory-3` |
| expect `team-13-factory-1` | seen at 1.2 min | `[t=00:00:55.382044][f=0002193] [SeaRecoveryTest] PASS team-13-factory-1` |
| expect `team-13-factory-2` | seen at 1.4 min | `[t=00:00:58.349243][f=0002566] [SeaRecoveryTest] PASS team-13-factory-2` |
| expect `team-13-factory-3` | seen at 1.6 min | `[t=00:01:01.022040][f=0002884] [SeaRecoveryTest] PASS team-13-factory-3` |
| expect `team-14-factory-1` | seen at 1.2 min | `[t=00:00:55.609651][f=0002219] [SeaRecoveryTest] PASS team-14-factory-1` |
| expect `team-14-factory-2` | seen at 1.4 min | `[t=00:00:57.429301][f=0002452] [SeaRecoveryTest] PASS team-14-factory-2` |
| expect `team-14-factory-3` | seen at 1.5 min | `[t=00:00:59.692962][f=0002724] [SeaRecoveryTest] PASS team-14-factory-3` |
| expect `team-15-factory-1` | seen at 1.2 min | `[t=00:00:55.482019][f=0002201] [SeaRecoveryTest] PASS team-15-factory-1` |
| expect `team-15-factory-2` | seen at 1.3 min | `[t=00:00:57.102843][f=0002416] [SeaRecoveryTest] PASS team-15-factory-2` |
| expect `team-15-factory-3` | seen at 1.5 min | `[t=00:00:59.285068][f=0002674] [SeaRecoveryTest] PASS team-15-factory-3` |
| expect `allied-repair` | seen at 2.3 min | `[t=00:01:11.328376][f=0004170] [SeaRecoveryTest] PASS allied-repair` |
| forbid `errors` | **hit** | `[INVARIANT] INV-033 metal over 95% for 60 s while team 8 has 1542 free` |

## Failures

- forbid 'errors' hit at 5.7 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 8 has 1542 free
- forbid 'errors' hit at 10.6 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 12 has 1023 free
- 'team-7-factory-3' not seen by 12.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-8v8\shore\20261006T013550Z-55fff867\runs\20261006T014002Z-79186b9e\screen_2026-10-06_01-36-52-651.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-8v8\shore\20261006T013550Z-55fff867\runs\20261006T014002Z-79186b9e\screen_2026-10-06_01-37-22-711.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-8v8\shore\20261006T013550Z-55fff867\runs\20261006T014002Z-79186b9e\screen_2026-10-06_01-37-55-638.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-8v8\shore\20261006T013550Z-55fff867\runs\20261006T014002Z-79186b9e\screen_2026-10-06_01-39-24-836.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 12.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1600, 600) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (1600, 1200) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1600, 1800) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (1600, 2400) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (2800, 600) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (2800, 1200) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (2800, 1800) units 1
  0.00  [Playtest] frame 1 team 7 ally 0 side armada ai true dead false start (2800, 2400) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (13750, 600) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (13750, 1200) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (13750, 1800) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (13750, 2400) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (12550, 600) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (12550, 1200) units 1
  0.00  [Playtest] frame 1 team 14 ally 1 side cortex ai true dead false start (12550, 1800) units 1
  0.00  [Playtest] frame 1 team 15 ally 1 side legion ai true dead false start (12550, 2400) units 1
  0.00  [Playtest] frame 1 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1600, 600) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (1600, 1200) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1600, 1800) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (1600, 2400) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (2800, 600) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (2800, 1200) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (2800, 1800) units 1
  0.05  [Playtest] frame 90 team 7 ally 0 side armada ai true dead false start (2800, 2400) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (13750, 600) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (13750, 1200) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (13750, 1800) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (13750, 2400) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (12550, 600) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (12550, 1200) units 1
  0.05  [Playtest] frame 90 team 14 ally 1 side cortex ai true dead false start (12550, 1800) units 1
  0.05  [Playtest] frame 90 team 15 ally 1 side legion ai true dead false start (12550, 2400) units 1
  0.05  [Playtest] frame 90 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1631|642|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(1641,1244) factory=armsy landLocked=no spot=1 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1599,1801) factory=corsy landLocked=no spot=2 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(1596,2412) factory=legsy landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(2802,642) factory=armsy landLocked=no spot=4 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(2777,1240) factory=corsy landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(2760,1793) factory=legsy landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=SEA side=armada start=(2836,2411) factory=armsy landLocked=no spot=7 known=7/7
  0.17  [Team][Roster] team 2 first mex at 1568,1951
  0.19  [Team][Roster] team 3 first mex at 1568,2528
  0.24  [Playtest] finished armmex team 0 at 0.24 min
  0.25  [Team][Roster] first mex 8022 at 1792,832
  0.25  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1631|642|0|0|1|1792|832
  0.27  [Team][Roster] team 6 first mex at 2528,1696
  0.28  [Team][Roster] team 1 first mex at 1888,1488
  0.29  [Team][Roster] team 4 first mex at 2816,944
  0.32  [Team][Roster] team 7 first mex at 3168,2448
  0.49  [Playtest] finished armmex team 0 at 0.49 min
  0.50  [Playtest] finished armuwfus team 0 at 0.50 min
  0.52  [Playtest] finished armuwfus team 0 at 0.52 min
  0.54  [Playtest] finished armuwfus team 0 at 0.54 min
  0.55  [Playtest] finished armuwfus team 0 at 0.55 min
  0.57  [Playtest] finished armuwfus team 0 at 0.57 min
  0.59  [Playtest] finished armuwfus team 0 at 0.59 min
  0.61  [Playtest] finished armwin team 0 at 0.61 min
  0.61  [Playtest] finished armuwfus team 0 at 0.61 min
  0.63  [Playtest] finished armuwfus team 0 at 0.63 min
  0.65  [Playtest] finished armuwmmm team 0 at 0.65 min
  0.67  [Playtest] finished armuwmmm team 0 at 0.67 min
  0.68  [Playtest] finished armuwmmm team 0 at 0.68 min
  0.70  [Playtest] finished armuwmmm team 0 at 0.70 min
  0.71  [Playtest] finished armuwmmm team 0 at 0.71 min
  0.73  [Playtest] finished armuwmmm team 0 at 0.73 min
  0.75  [Playtest] finished armuwmmm team 0 at 0.75 min
  0.77  [Playtest] finished armuwmmm team 0 at 0.77 min
  0.78  [Playtest] finished armuwmmm team 0 at 0.78 min
  0.80  [Playtest] finished armuwmmm team 0 at 0.80 min
  0.82  [Playtest] finished armuwmmm team 0 at 0.82 min
  0.83  [Playtest] finished armuwmmm team 0 at 0.83 min
  0.85  [Playtest] finished armuwmmm team 0 at 0.85 min
  0.87  [Playtest] finished armuwmmm team 0 at 0.87 min
  0.88  [Playtest] finished armuwmmm team 0 at 0.88 min
  0.90  [Playtest] finished armuwmmm team 0 at 0.90 min
  0.92  [Playtest] finished armuwmmm team 0 at 0.92 min
  0.93  [Playtest] finished armuwmmm team 0 at 0.93 min
  0.95  [Playtest] finished armsy team 0 at 0.95 min
  0.97  [Playtest] finished armasy team 0 at 0.97 min
  0.98  [Playtest] finished armplat team 0 at 0.98 min
  1.00  [Playtest] finished armnanotcplat team 0 at 1.00 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +97.5 bank 1346/1400, energy +9644.3 bank 18496/21500, units 36
  1.00  [Playtest] camera requested (5000,1550) height=6000
  1.02  [Playtest] finished armnanotcplat team 0 at 1.02 min
  1.02  [Playtest] finished armnanotcplat team 0 at 1.02 min
  1.02  [Playtest] camera captured name=ta position=(5000,1550) height=6000
  1.02  [Playtest] screenshot at 1.0 min of team 0 at (5000, 1550)
  1.05  [Playtest] finished armnanotcplat team 0 at 1.05 min
  1.07  [Playtest] finished armepoch team 0 at 1.07 min
  1.08  [Playtest] finished armsy team 0 at 1.08 min
  1.50  [SEA][Layout] berth sea.berth.0 armasy at=4608,2112 facing=1
  1.55  [SEA][Layout] berth sea.berth.1 armplat at=5168,384 facing=1
  1.64  [Playtest] finished armmex team 0 at 1.64 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +93.4 bank 1204/1550, energy +9722.0 bank 18679/22000, units 52
  2.12  [Playtest] finished armuwadves team 0 at 2.12 min
  2.56  [Playtest] finished armmex team 0 at 2.56 min
  2.84  [Team][Roster] team 5 first mex at 3648,879
  2.98  [Playtest] finished armtl team 0 at 2.98 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +196.3 bank 1573/1600, energy +9706.1 bank 54642/62000, units 60
  3.00  [Playtest] camera requested (6500,1550) height=6000
  3.02  [Playtest] camera captured name=ta position=(6500,1550) height=6000
  3.02  [Playtest] screenshot at 3.0 min of team 0 at (6500, 1550)
  3.22  [Playtest] finished armfrad team 0 at 3.22 min
  3.28  [Playtest] finished armason team 0 at 3.28 min
  3.45  [Playtest] finished armfrad team 0 at 3.45 min
  3.81  [Playtest] finished armfrad team 0 at 3.81 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +196.3 bank 1563/1600, energy +9717.1 bank 54456/62000, units 71
  4.60  [Playtest] finished armtl team 0 at 4.60 min
  4.65  [Playtest] finished armtl team 0 at 4.65 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +196.3 bank 1565/1600, energy +9721.5 bank 54676/62000, units 78
  5.00  [Playtest] camera requested (7500,1550) height=6000
  5.00  [Playtest] finished armtl team 0 at 5.01 min
  5.02  [Playtest] camera captured name=ta position=(7500,1550) height=6000
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (7500, 1550)
  5.11  [Playtest] finished armtl team 0 at 5.11 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +199.4 bank 1566/1600, energy +9716.0 bank 54931/62000, units 76
  6.67  [Playtest] finished armasy team 0 at 6.67 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +196.3 bank 1750/1800, energy +9714.2 bank 54229/62200, units 73
  7.24  [Playtest] finished armuwmme team 0 at 7.24 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +202.5 bank 2281/2350, energy +9704.0 bank 54380/62200, units 76
  8.53  [Playtest] finished armuwmme team 0 at 8.53 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +208.6 bank 2830/2900, energy +9697.0 bank 54444/62150, units 82
  9.26  [Playtest] finished armatl team 0 at 9.26 min
  9.65  [Playtest] finished armllt team 0 at 9.65 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +208.6 bank 2829/2900, energy +9697.0 bank 54509/62150, units 86
 10.00  [Playtest] camera requested (5500,1550) height=6000
 10.02  [Playtest] camera captured name=ta position=(5500,1550) height=6000
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (5500, 1550)
 10.76  [Playtest] finished armtl team 0 at 10.76 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +208.6 bank 2824/2900, energy +9697.0 bank 54017/62150, units 81
 11.06  [Playtest] finished armatl team 0 at 11.06 min
 11.56  [Playtest] finished armatl team 0 at 11.56 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +208.6 bank 2825/2900, energy +9697.0 bank 54882/62150, units 82
```

## Native lines (all AIs, first 120)

```
  0.21  RESERVE: zone 1 at (2216, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2216, 1448) facing 1 (id 1)
  0.21  RESERVE: zone 2 at (2216, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2216, 1400) facing 1 (id 2)
  0.21  RESERVE: zone 3 at (2216, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2216, 1352) facing 1 (id 3)
  0.21  RESERVE: zone 4 at (2216, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2216, 1304) facing 1 (id 4)
  0.21  RESERVE: zone 5 at (2216, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2216, 1256) facing 1 (id 5)
  0.21  RESERVE: zone 6 at (2216, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2216, 1208) facing 1 (id 6)
  0.21  RESERVE: zone 7 at (2264, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2264, 1448) facing 1 (id 7)
  0.21  RESERVE: zone 8 at (2264, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2264, 1400) facing 1 (id 8)
  0.21  RESERVE: zone 9 at (2264, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2264, 1352) facing 1 (id 9)
  0.21  RESERVE: zone 10 at (2264, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2264, 1304) facing 1 (id 10)
  0.21  RESERVE: zone 11 at (2264, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2264, 1256) facing 1 (id 11)
  0.21  RESERVE: zone 12 at (2264, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2264, 1208) facing 1 (id 12)
  0.21  RESERVE: zone 13 at (2312, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2312, 1448) facing 1 (id 13)
  0.21  RESERVE: zone 14 at (2312, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2312, 1400) facing 1 (id 14)
  0.21  RESERVE: zone 15 at (2312, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2312, 1352) facing 1 (id 15)
  0.21  RESERVE: zone 16 at (2312, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2312, 1304) facing 1 (id 16)
  0.21  RESERVE: zone 17 at (2312, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2312, 1256) facing 1 (id 17)
  0.21  RESERVE: zone 18 at (2312, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2312, 1208) facing 1 (id 18)
  0.21  RESERVE: zone 19 at (2360, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2360, 1448) facing 1 (id 19)
  0.21  RESERVE: zone 20 at (2360, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2360, 1400) facing 1 (id 20)
  0.21  RESERVE: zone 21 at (2360, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2360, 1352) facing 1 (id 21)
  0.21  RESERVE: zone 22 at (2360, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2360, 1304) facing 1 (id 22)
  0.21  RESERVE: zone 23 at (2360, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2360, 1256) facing 1 (id 23)
  0.21  RESERVE: zone 24 at (2360, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2360, 1208) facing 1 (id 24)
  0.21  RESERVE: zone 25 at (2408, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2408, 1448) facing 1 (id 25)
  0.21  RESERVE: zone 26 at (2408, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2408, 1400) facing 1 (id 26)
  0.21  RESERVE: zone 27 at (2408, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2408, 1352) facing 1 (id 27)
  0.21  RESERVE: zone 28 at (2408, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2408, 1304) facing 1 (id 28)
  0.21  RESERVE: zone 29 at (2408, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2408, 1256) facing 1 (id 29)
  0.21  RESERVE: zone 30 at (2408, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2408, 1208) facing 1 (id 30)
  0.21  RESERVE: zone 31 at (2456, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2456, 1448) facing 1 (id 31)
  0.21  RESERVE: zone 32 at (2456, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2456, 1400) facing 1 (id 32)
  0.21  RESERVE: zone 33 at (2456, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2456, 1352) facing 1 (id 33)
  0.21  RESERVE: zone 34 at (2456, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2456, 1304) facing 1 (id 34)
  0.21  RESERVE: zone 35 at (2456, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2456, 1256) facing 1 (id 35)
  0.21  RESERVE: zone 36 at (2456, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2456, 1208) facing 1 (id 36)
  0.21  RESERVE: zone 37 at (2504, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2504, 1448) facing 1 (id 37)
  0.21  RESERVE: zone 38 at (2504, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2504, 1400) facing 1 (id 38)
  0.21  RESERVE: zone 39 at (2504, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2504, 1352) facing 1 (id 39)
  0.21  RESERVE: zone 40 at (2504, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2504, 1304) facing 1 (id 40)
  0.21  RESERVE: zone 41 at (2504, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2504, 1256) facing 1 (id 41)
  0.21  RESERVE: zone 42 at (2504, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2504, 1208) facing 1 (id 42)
  0.21  RESERVE: zone 43 at (2552, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2552, 1448) facing 1 (id 43)
  0.21  RESERVE: zone 44 at (2552, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2552, 1400) facing 1 (id 44)
  0.21  RESERVE: zone 45 at (2552, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2552, 1352) facing 1 (id 45)
  0.21  RESERVE: zone 46 at (2552, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2552, 1304) facing 1 (id 46)
  0.21  RESERVE: zone 47 at (2552, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2552, 1256) facing 1 (id 47)
  0.21  RESERVE: zone 48 at (2552, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.21  RESERVE: cortide at (2552, 1208) facing 1 (id 48)
  0.21  RESERVE: served cortide at (2216, 1448) facing 1 (id 1, 47 of this def still held)
  0.27  RESERVE: zone 1 at (12952, 2440) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2440) facing 3 (id 1)
  0.27  RESERVE: zone 2 at (12952, 2488) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2488) facing 3 (id 2)
  0.27  RESERVE: zone 3 at (12952, 2536) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2536) facing 3 (id 3)
  0.27  RESERVE: zone 4 at (12952, 2584) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2584) facing 3 (id 4)
  0.27  RESERVE: zone 1 released
  0.27  RESERVE: zone 2 released
  0.27  RESERVE: zone 3 released
  0.27  RESERVE: zone 4 released
  0.27  RESERVE: zone 5 at (12920, 2376) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2376) facing 3 (id 5)
  0.27  RESERVE: zone 6 at (12920, 2424) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2424) facing 3 (id 6)
  0.27  RESERVE: zone 7 at (12920, 2472) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2472) facing 3 (id 7)
  0.27  RESERVE: zone 8 at (12920, 2520) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2520) facing 3 (id 8)
  0.27  RESERVE: zone 9 at (12920, 2568) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2568) facing 3 (id 9)
  0.27  RESERVE: zone 10 at (12920, 2616) facing 3, 3x3 cells: 9 of 9 held
```
