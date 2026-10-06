# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 12.0 min (frame 21640); wall 262 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (2a92618ff453ab13); AI BARbTest/test; staged 2026-10-05T22:19:50
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-capacity-8v8.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-8v8\shore\20261006T011950Z-bc3b3ace\runs\20261006T012422Z-4fec9b21\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:30.844517][f=-000001] [SeaRecoveryTest] loaded teams=16 fixture=false` |
| expect `sub-scaling` | seen at 1.5 min | `[t=00:01:03.862207][f=0002700] [SeaRecoveryTest] PASS sub-scaling` |
| expect `start-count` | seen at 0.1 min | `[Setup] StartSpots length=16` |
| expect `team-0-factory-1` | seen at 1.1 min | `[t=00:00:58.713143][f=0002009] [SeaRecoveryTest] PASS team-0-factory-1` |
| expect `team-0-factory-2` | seen at 1.4 min | `[t=00:01:01.528732][f=0002446] [SeaRecoveryTest] PASS team-0-factory-2` |
| expect `team-0-factory-3` | seen at 1.6 min | `[t=00:01:04.673066][f=0002798] [SeaRecoveryTest] PASS team-0-factory-3` |
| expect `team-1-factory-1` | seen at 1.1 min | `[t=00:00:58.714204][f=0002009] [SeaRecoveryTest] PASS team-1-factory-1` |
| expect `team-1-factory-2` | seen at 1.4 min | `[t=00:01:01.529394][f=0002446] [SeaRecoveryTest] PASS team-1-factory-2` |
| expect `team-1-factory-3` | seen at 1.6 min | `[t=00:01:05.423106][f=0002894] [SeaRecoveryTest] PASS team-1-factory-3` |
| expect `team-2-factory-1` | seen at 1.1 min | `[t=00:00:58.639620][f=0001991] [SeaRecoveryTest] PASS team-2-factory-1` |
| expect `team-2-factory-2` | seen at 1.4 min | `[t=00:01:03.031615][f=0002606] [SeaRecoveryTest] PASS team-2-factory-2` |
| expect `team-2-factory-3` | seen at 1.4 min | `[t=00:01:02.550586][f=0002551] [SeaRecoveryTest] PASS team-2-factory-3` |
| expect `team-3-factory-1` | seen at 1.1 min | `[t=00:00:58.586669][f=0001983] [SeaRecoveryTest] PASS team-3-factory-1` |
| expect `team-3-factory-2` | seen at 1.6 min | `[t=00:01:04.994432][f=0002837] [SeaRecoveryTest] PASS team-3-factory-2` |
| expect `team-3-factory-3` | seen at 1.3 min | `[t=00:01:01.059791][f=0002380] [SeaRecoveryTest] PASS team-3-factory-3` |
| expect `team-4-factory-1` | seen at 1.1 min | `[t=00:00:58.713827][f=0002009] [SeaRecoveryTest] PASS team-4-factory-1` |
| expect `team-4-factory-2` | seen at 1.6 min | `[t=00:01:05.971422][f=0002970] [SeaRecoveryTest] PASS team-4-factory-2` |
| expect `team-4-factory-3` | seen at 1.6 min | `[t=00:01:05.423782][f=0002894] [SeaRecoveryTest] PASS team-4-factory-3` |
| expect `team-5-factory-1` | seen at 1.1 min | `[t=00:00:58.803174][f=0002018] [SeaRecoveryTest] PASS team-5-factory-1` |
| expect `team-5-factory-2` | seen at 1.7 min | `[t=00:01:06.014685][f=0002975] [SeaRecoveryTest] PASS team-5-factory-2` |
| expect `team-5-factory-3` | seen at 1.3 min | `[t=00:01:01.294741][f=0002410] [SeaRecoveryTest] PASS team-5-factory-3` |
| expect `team-6-factory-1` | seen at 1.1 min | `[t=00:00:58.710049][f=0002008] [SeaRecoveryTest] PASS team-6-factory-1` |
| expect `team-6-factory-2` | seen at 1.6 min | `[t=00:01:05.706361][f=0002937] [SeaRecoveryTest] PASS team-6-factory-2` |
| expect `team-6-factory-3` | seen at 1.3 min | `[t=00:01:00.960261][f=0002364] [SeaRecoveryTest] PASS team-6-factory-3` |
| expect `team-7-factory-1` | seen at 1.1 min | `[t=00:00:58.721672][f=0002010] [SeaRecoveryTest] PASS team-7-factory-1` |
| expect `team-7-factory-2` | seen at 1.6 min | `[t=00:01:05.962540][f=0002969] [SeaRecoveryTest] PASS team-7-factory-2` |
| expect `team-7-factory-3` | seen at 1.6 min | `[t=00:01:05.424180][f=0002894] [SeaRecoveryTest] PASS team-7-factory-3` |
| expect `team-8-factory-1` | seen at 1.2 min | `[t=00:00:59.988917][f=0002223] [SeaRecoveryTest] PASS team-8-factory-1` |
| expect `team-8-factory-2` | seen at 1.4 min | `[t=00:01:01.540722][f=0002449] [SeaRecoveryTest] PASS team-8-factory-2` |
| expect `team-8-factory-3` | seen at 1.4 min | `[t=00:01:02.676977][f=0002562] [SeaRecoveryTest] PASS team-8-factory-3` |
| expect `team-9-factory-1` | seen at 1.2 min | `[t=00:00:59.877803][f=0002200] [SeaRecoveryTest] PASS team-9-factory-1` |
| expect `team-9-factory-2` | seen at 1.3 min | `[t=00:01:01.324092][f=0002414] [SeaRecoveryTest] PASS team-9-factory-2` |
| expect `team-9-factory-3` | seen at 1.5 min | `[t=00:01:04.159328][f=0002733] [SeaRecoveryTest] PASS team-9-factory-3` |
| expect `team-10-factory-1` | seen at 1.2 min | `[t=00:00:59.877182][f=0002200] [SeaRecoveryTest] PASS team-10-factory-1` |
| expect `team-10-factory-2` | seen at 1.4 min | `[t=00:01:01.496776][f=0002441] [SeaRecoveryTest] PASS team-10-factory-2` |
| expect `team-10-factory-3` | seen at 1.4 min | `[t=00:01:03.020694][f=0002604] [SeaRecoveryTest] PASS team-10-factory-3` |
| expect `team-11-factory-1` | seen at 1.2 min | `[t=00:00:59.974785][f=0002221] [SeaRecoveryTest] PASS team-11-factory-1` |
| expect `team-11-factory-2` | seen at 1.4 min | `[t=00:01:01.533499][f=0002447] [SeaRecoveryTest] PASS team-11-factory-2` |
| expect `team-11-factory-3` | seen at 1.4 min | `[t=00:01:02.666504][f=0002561] [SeaRecoveryTest] PASS team-11-factory-3` |
| expect `team-12-factory-1` | seen at 1.2 min | `[t=00:00:59.826131][f=0002195] [SeaRecoveryTest] PASS team-12-factory-1` |
| expect `team-12-factory-2` | seen at 1.4 min | `[t=00:01:01.401490][f=0002431] [SeaRecoveryTest] PASS team-12-factory-2` |
| expect `team-12-factory-3` | seen at 1.6 min | `[t=00:01:05.415417][f=0002893] [SeaRecoveryTest] PASS team-12-factory-3` |
| expect `team-13-factory-1` | seen at 1.3 min | `[t=00:01:00.510183][f=0002298] [SeaRecoveryTest] PASS team-13-factory-1` |
| expect `team-13-factory-2` | seen at 1.6 min | `[t=00:01:05.019965][f=0002844] [SeaRecoveryTest] PASS team-13-factory-2` |
| expect `team-13-factory-3` | seen at 1.6 min | `[t=00:01:05.424511][f=0002894] [SeaRecoveryTest] PASS team-13-factory-3` |
| expect `team-14-factory-1` | seen at 1.2 min | `[t=00:00:59.950527][f=0002217] [SeaRecoveryTest] PASS team-14-factory-1` |
| expect `team-14-factory-2` | seen at 1.4 min | `[t=00:01:01.549620][f=0002452] [SeaRecoveryTest] PASS team-14-factory-2` |
| expect `team-14-factory-3` | seen at 1.5 min | `[t=00:01:03.551094][f=0002665] [SeaRecoveryTest] PASS team-14-factory-3` |
| expect `team-15-factory-1` | seen at 1.2 min | `[t=00:00:59.871502][f=0002199] [SeaRecoveryTest] PASS team-15-factory-1` |
| expect `team-15-factory-2` | seen at 1.3 min | `[t=00:01:01.160393][f=0002397] [SeaRecoveryTest] PASS team-15-factory-2` |
| expect `team-15-factory-3` | seen at 1.5 min | `[t=00:01:03.518794][f=0002658] [SeaRecoveryTest] PASS team-15-factory-3` |
| expect `allied-repair` | seen at 1.8 min | `[t=00:01:07.429648][f=0003150] [SeaRecoveryTest] PASS allied-repair` |
| forbid `errors` | **hit** | `[INVARIANT] INV-033 metal over 95% for 60 s while team 8 has 9729 free` |

## Failures

- forbid 'errors' hit at 2.0 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 8 has 9729 free

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-8v8\shore\20261006T011950Z-bc3b3ace\runs\20261006T012422Z-4fec9b21\screen_2026-10-06_01-20-57-955.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-8v8\shore\20261006T011950Z-bc3b3ace\runs\20261006T012422Z-4fec9b21\screen_2026-10-06_01-21-29-218.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-8v8\shore\20261006T011950Z-bc3b3ace\runs\20261006T012422Z-4fec9b21\screen_2026-10-06_01-22-03-737.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-8v8\shore\20261006T011950Z-bc3b3ace\runs\20261006T012422Z-4fec9b21\screen_2026-10-06_01-23-40-323.png

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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1628|638|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(1637,1241) factory=armsy landLocked=no spot=1 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1599,1801) factory=corsy landLocked=no spot=2 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(1595,2415) factory=legsy landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(2802,638) factory=armsy landLocked=no spot=4 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(2779,1237) factory=corsy landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(2763,1795) factory=legsy landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=SEA side=armada start=(2833,2410) factory=armsy landLocked=no spot=7 known=7/7
  0.18  [Team][Roster] team 2 first mex at 1568,1951
  0.19  [Team][Roster] team 3 first mex at 1568,2528
  0.24  [Playtest] finished armmex team 0 at 0.24 min
  0.25  [Team][Roster] first mex 8022 at 1792,832
  0.25  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1628|638|0|0|1|1792|832
  0.27  [Team][Roster] team 6 first mex at 2528,1696
  0.28  [Team][Roster] team 1 first mex at 1888,1488
  0.29  [Team][Roster] team 4 first mex at 2816,944
  0.32  [Team][Roster] team 7 first mex at 3168,2448
  0.35  [Playtest] finished armwin team 0 at 0.35 min
  0.50  [Playtest] finished armuwfus team 0 at 0.50 min
  0.52  [Playtest] finished armuwfus team 0 at 0.52 min
  0.54  [Playtest] finished armuwfus team 0 at 0.54 min
  0.56  [Playtest] finished armuwfus team 0 at 0.56 min
  0.58  [Playtest] finished armuwfus team 0 at 0.58 min
  0.60  [Playtest] finished armuwfus team 0 at 0.60 min
  0.60  [Playtest] finished armmex team 0 at 0.60 min
  0.62  [Playtest] finished armuwfus team 0 at 0.62 min
  0.63  [Playtest] finished armuwfus team 0 at 0.63 min
  0.65  [Playtest] finished armuwmmm team 0 at 0.65 min
  0.67  [Playtest] finished armuwmmm team 0 at 0.67 min
  0.68  [Playtest] finished armuwmmm team 0 at 0.68 min
  0.70  [Playtest] finished armuwmmm team 0 at 0.70 min
  0.72  [Playtest] finished armuwmmm team 0 at 0.72 min
  0.73  [Playtest] finished armwin team 0 at 0.73 min
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
  0.91  [Playtest] finished armuwmmm team 0 at 0.91 min
  0.93  [Playtest] finished armuwmmm team 0 at 0.93 min
  0.95  [Playtest] finished armsy team 0 at 0.95 min
  0.97  [Playtest] finished armasy team 0 at 0.97 min
  0.98  [Playtest] finished armplat team 0 at 0.98 min
  1.00  [Playtest] finished armnanotcplat team 0 at 1.00 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +97.6 bank 1396/1400, energy +9663.4 bank 18424/21501, units 37
  1.00  [Playtest] camera requested (5000,1550) height=6000
  1.02  [Playtest] finished armnanotcplat team 0 at 1.02 min
  1.02  [Playtest] finished armnanotcplat team 0 at 1.02 min
  1.02  [Playtest] camera captured name=ta position=(5000,1550) height=6000
  1.02  [Playtest] screenshot at 1.0 min of team 0 at (5000, 1550)
  1.05  [Playtest] finished armnanotcplat team 0 at 1.05 min
  1.07  [Playtest] finished armepoch team 0 at 1.07 min
  1.10  [SEA][Layout] berth sea.berth.0 armasy at=4672,224 facing=1
  1.20  [Playtest] finished armsy team 0 at 1.20 min
  1.25  [SEA][Layout] berth sea.berth.1 armplat at=5104,496 facing=1
  1.45  [SEA][Layout] replan unused berth sea.berth.0
  1.78  [Playtest] finished armmex team 0 at 1.78 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +92.7 bank 1002/1550, energy +9682.4 bank 18382/21801, units 53
  2.10  [Playtest] finished armuwadves team 0 at 2.10 min
  2.74  [Playtest] finished armmex team 0 at 2.74 min
  2.95  [Playtest] finished armfrad team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +196.3 bank 1585/1600, energy +9702.9 bank 54767/61801, units 60
  3.00  [Playtest] camera requested (6500,1550) height=6000
  3.02  [Playtest] camera captured name=ta position=(6500,1550) height=6000
  3.02  [Playtest] screenshot at 3.0 min of team 0 at (6500, 1550)
  3.51  [Playtest] finished armtl team 0 at 3.51 min
  3.91  [Playtest] finished armtl team 0 at 3.91 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +196.3 bank 1564/1600, energy +9683.8 bank 54275/61801, units 71
  4.48  [Playtest] finished armuwmme team 0 at 4.48 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +202.5 bank 2119/2150, energy +9697.2 bank 54224/61801, units 66
  5.00  [Playtest] camera requested (7500,1550) height=6000
  5.02  [Playtest] camera captured name=ta position=(7500,1550) height=6000
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (7500, 1550)
  5.38  [Playtest] finished armtl team 0 at 5.38 min
  5.81  [Playtest] finished armuwmme team 0 at 5.81 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +208.6 bank 2689/2700, energy +9703.0 bank 55375/61801, units 71
  6.74  [Playtest] finished armtl team 0 at 6.74 min
  7.00  [Playtest] finished armatl team 0 at 6.99 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +208.6 bank 2696/2700, energy +9702.3 bank 55313/61801, units 70
  7.86  [Playtest] finished armrad team 0 at 7.86 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +208.6 bank 2654/2700, energy +9684.6 bank 54018/61800, units 70
  8.04  [Playtest] finished armllt team 0 at 8.04 min
  8.28  [Playtest] finished armrl team 0 at 8.27 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +208.6 bank 2667/2700, energy +9679.6 bank 54577/61800, units 64
  9.92  [Playtest] finished armfmkr team 0 at 9.92 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +23.4 bank 971/2700, energy +9684.8 bank 61163/61800, units 45
 10.00  [Playtest] camera requested (5500,1550) height=6000
 10.02  [Playtest] camera captured name=ta position=(5500,1550) height=6000
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (5500, 1550)
 10.09  [Playtest] finished armfmkr team 0 at 10.09 min
 10.47  [Playtest] finished armfmkr team 0 at 10.48 min
 10.57  [Playtest] finished armason team 0 at 10.57 min
 10.95  [Playtest] finished armfmkr team 0 at 10.95 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +26.4 bank 0/2700, energy +9679.6 bank 61588/61800, units 41
 11.26  [Playtest] finished armmstor team 0 at 11.26 min
 11.35  [Playtest] finished armfmkr team 0 at 11.35 min
 11.74  [Playtest] finished armfmkr team 0 at 11.74 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +28.4 bank 13/5700, energy +9684.9 bank 61484/61800, units 40
```

## Native lines (all AIs, first 120)

```
  0.09  RESERVE: zone 1 at (2232, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2232, 1448) facing 1 (id 1)
  0.09  RESERVE: zone 2 at (2232, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2232, 1400) facing 1 (id 2)
  0.09  RESERVE: zone 3 at (2232, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2232, 1352) facing 1 (id 3)
  0.09  RESERVE: zone 4 at (2232, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2232, 1304) facing 1 (id 4)
  0.09  RESERVE: zone 5 at (2232, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2232, 1256) facing 1 (id 5)
  0.09  RESERVE: zone 6 at (2232, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2232, 1208) facing 1 (id 6)
  0.09  RESERVE: zone 7 at (2280, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2280, 1448) facing 1 (id 7)
  0.09  RESERVE: zone 8 at (2280, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2280, 1400) facing 1 (id 8)
  0.09  RESERVE: zone 9 at (2280, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2280, 1352) facing 1 (id 9)
  0.09  RESERVE: zone 10 at (2280, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2280, 1304) facing 1 (id 10)
  0.09  RESERVE: zone 11 at (2280, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2280, 1256) facing 1 (id 11)
  0.09  RESERVE: zone 12 at (2280, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2280, 1208) facing 1 (id 12)
  0.09  RESERVE: zone 13 at (2328, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2328, 1448) facing 1 (id 13)
  0.09  RESERVE: zone 14 at (2328, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2328, 1400) facing 1 (id 14)
  0.09  RESERVE: zone 15 at (2328, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2328, 1352) facing 1 (id 15)
  0.09  RESERVE: zone 16 at (2328, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2328, 1304) facing 1 (id 16)
  0.09  RESERVE: zone 17 at (2328, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2328, 1256) facing 1 (id 17)
  0.09  RESERVE: zone 18 at (2328, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2328, 1208) facing 1 (id 18)
  0.09  RESERVE: zone 19 at (2376, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2376, 1448) facing 1 (id 19)
  0.09  RESERVE: zone 20 at (2376, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2376, 1400) facing 1 (id 20)
  0.09  RESERVE: zone 21 at (2376, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2376, 1352) facing 1 (id 21)
  0.09  RESERVE: zone 22 at (2376, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2376, 1304) facing 1 (id 22)
  0.09  RESERVE: zone 23 at (2376, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2376, 1256) facing 1 (id 23)
  0.09  RESERVE: zone 24 at (2376, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2376, 1208) facing 1 (id 24)
  0.09  RESERVE: zone 25 at (2424, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2424, 1448) facing 1 (id 25)
  0.09  RESERVE: zone 26 at (2424, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2424, 1400) facing 1 (id 26)
  0.09  RESERVE: zone 27 at (2424, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2424, 1352) facing 1 (id 27)
  0.09  RESERVE: zone 28 at (2424, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2424, 1304) facing 1 (id 28)
  0.09  RESERVE: zone 29 at (2424, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2424, 1256) facing 1 (id 29)
  0.09  RESERVE: zone 30 at (2424, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2424, 1208) facing 1 (id 30)
  0.09  RESERVE: zone 31 at (2472, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2472, 1448) facing 1 (id 31)
  0.09  RESERVE: zone 32 at (2472, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2472, 1400) facing 1 (id 32)
  0.09  RESERVE: zone 33 at (2472, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2472, 1352) facing 1 (id 33)
  0.09  RESERVE: zone 34 at (2472, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2472, 1304) facing 1 (id 34)
  0.09  RESERVE: zone 35 at (2472, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2472, 1256) facing 1 (id 35)
  0.09  RESERVE: zone 36 at (2472, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2472, 1208) facing 1 (id 36)
  0.09  RESERVE: zone 37 at (2520, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2520, 1448) facing 1 (id 37)
  0.09  RESERVE: zone 38 at (2520, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2520, 1400) facing 1 (id 38)
  0.09  RESERVE: zone 39 at (2520, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2520, 1352) facing 1 (id 39)
  0.09  RESERVE: zone 40 at (2520, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2520, 1304) facing 1 (id 40)
  0.09  RESERVE: zone 41 at (2520, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2520, 1256) facing 1 (id 41)
  0.09  RESERVE: zone 42 at (2520, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2520, 1208) facing 1 (id 42)
  0.09  RESERVE: zone 43 at (2568, 1448) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2568, 1448) facing 1 (id 43)
  0.09  RESERVE: zone 44 at (2568, 1400) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2568, 1400) facing 1 (id 44)
  0.09  RESERVE: zone 45 at (2568, 1352) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2568, 1352) facing 1 (id 45)
  0.09  RESERVE: zone 46 at (2568, 1304) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2568, 1304) facing 1 (id 46)
  0.09  RESERVE: zone 47 at (2568, 1256) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2568, 1256) facing 1 (id 47)
  0.09  RESERVE: zone 48 at (2568, 1208) facing 1, 3x3 cells: 9 of 9 held
  0.09  RESERVE: cortide at (2568, 1208) facing 1 (id 48)
  0.09  RESERVE: served cortide at (2232, 1448) facing 1 (id 1, 47 of this def still held)
  0.27  RESERVE: zone 1 at (12952, 2424) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2424) facing 3 (id 1)
  0.27  RESERVE: zone 2 at (12952, 2472) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2472) facing 3 (id 2)
  0.27  RESERVE: zone 3 at (12952, 2520) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2520) facing 3 (id 3)
  0.27  RESERVE: zone 4 at (12952, 2568) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2568) facing 3 (id 4)
  0.27  RESERVE: zone 5 at (12952, 2616) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12952, 2616) facing 3 (id 5)
  0.27  RESERVE: zone 1 released
  0.27  RESERVE: zone 2 released
  0.27  RESERVE: zone 3 released
  0.27  RESERVE: zone 4 released
  0.27  RESERVE: zone 5 released
  0.27  RESERVE: zone 6 at (12920, 2376) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2376) facing 3 (id 6)
  0.27  RESERVE: zone 7 at (12920, 2424) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2424) facing 3 (id 7)
  0.27  RESERVE: zone 8 at (12920, 2472) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2472) facing 3 (id 8)
  0.27  RESERVE: zone 9 at (12920, 2520) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12920, 2520) facing 3 (id 9)
```
