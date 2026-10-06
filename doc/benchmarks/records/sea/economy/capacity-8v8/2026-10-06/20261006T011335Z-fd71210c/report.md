# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 2.5 min (frame 4439); wall 82 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (8f86a21003fa1cb7); AI BARbTest/test; staged 2026-10-05T22:12:03
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test, 9=SEA/legion/test, 10=SEA/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea-capacity-8v8.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\capacity-8v8\shore\20261006T011203Z-6d9a94f2\runs\20261006T011335Z-fd71210c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:30.600307][f=-000001] [SeaRecoveryTest] loaded teams=16 fixture=false` |
| expect `sub-scaling` | seen at 1.5 min | `[t=00:01:01.131125][f=0002700] [SeaRecoveryTest] PASS sub-scaling` |
| expect `start-count` | seen at 0.1 min | `[Setup] StartSpots length=16` |
| expect `team-0-factory-1` | seen at 1.8 min | `[t=00:01:03.876753][f=0003242] [SeaRecoveryTest] PASS team-0-factory-1` |
| expect `team-0-factory-2` | **missing** (by 12 min) | |
| expect `team-0-factory-3` | **missing** (by 12 min) | |
| expect `team-1-factory-1` | **missing** (by 12 min) | |
| expect `team-1-factory-2` | **missing** (by 12 min) | |
| expect `team-1-factory-3` | **missing** (by 12 min) | |
| expect `team-2-factory-1` | seen at 1.3 min | `[t=00:00:59.601112][f=0002347] [SeaRecoveryTest] PASS team-2-factory-1` |
| expect `team-2-factory-2` | **missing** (by 12 min) | |
| expect `team-2-factory-3` | **missing** (by 12 min) | |
| expect `team-3-factory-1` | seen at 2.1 min | `[t=00:01:07.070893][f=0003827] [SeaRecoveryTest] PASS team-3-factory-1` |
| expect `team-3-factory-2` | **missing** (by 12 min) | |
| expect `team-3-factory-3` | **missing** (by 12 min) | |
| expect `team-4-factory-1` | seen at 1.1 min | `[t=00:00:58.252225][f=0002027] [SeaRecoveryTest] PASS team-4-factory-1` |
| expect `team-4-factory-2` | seen at 1.5 min | `[t=00:01:01.261182][f=0002731] [SeaRecoveryTest] PASS team-4-factory-2` |
| expect `team-4-factory-3` | seen at 1.6 min | `[t=00:01:01.768245][f=0002832] [SeaRecoveryTest] PASS team-4-factory-3` |
| expect `team-5-factory-1` | seen at 1.3 min | `[t=00:00:59.300251][f=0002276] [SeaRecoveryTest] PASS team-5-factory-1` |
| expect `team-5-factory-2` | seen at 1.7 min | `[t=00:01:02.409813][f=0002972] [SeaRecoveryTest] PASS team-5-factory-2` |
| expect `team-5-factory-3` | seen at 1.5 min | `[t=00:01:01.226391][f=0002721] [SeaRecoveryTest] PASS team-5-factory-3` |
| expect `team-6-factory-1` | seen at 1.1 min | `[t=00:00:58.136351][f=0001993] [SeaRecoveryTest] PASS team-6-factory-1` |
| expect `team-6-factory-2` | seen at 1.4 min | `[t=00:01:00.711551][f=0002600] [SeaRecoveryTest] PASS team-6-factory-2` |
| expect `team-6-factory-3` | seen at 1.5 min | `[t=00:01:01.338573][f=0002746] [SeaRecoveryTest] PASS team-6-factory-3` |
| expect `team-7-factory-1` | seen at 1.2 min | `[t=00:00:58.409453][f=0002074] [SeaRecoveryTest] PASS team-7-factory-1` |
| expect `team-7-factory-2` | seen at 1.6 min | `[t=00:01:02.391287][f=0002967] [SeaRecoveryTest] PASS team-7-factory-2` |
| expect `team-7-factory-3` | seen at 1.6 min | `[t=00:01:02.013647][f=0002887] [SeaRecoveryTest] PASS team-7-factory-3` |
| expect `team-8-factory-1` | **missing** (by 12 min) | |
| expect `team-8-factory-2` | **missing** (by 12 min) | |
| expect `team-8-factory-3` | **missing** (by 12 min) | |
| expect `team-9-factory-1` | seen at 1.9 min | `[t=00:01:05.221220][f=0003496] [SeaRecoveryTest] PASS team-9-factory-1` |
| expect `team-9-factory-2` | **missing** (by 12 min) | |
| expect `team-9-factory-3` | **missing** (by 12 min) | |
| expect `team-10-factory-1` | **missing** (by 12 min) | |
| expect `team-10-factory-2` | **missing** (by 12 min) | |
| expect `team-10-factory-3` | **missing** (by 12 min) | |
| expect `team-11-factory-1` | **missing** (by 12 min) | |
| expect `team-11-factory-2` | **missing** (by 12 min) | |
| expect `team-11-factory-3` | **missing** (by 12 min) | |
| expect `team-12-factory-1` | seen at 1.1 min | `[t=00:00:58.051921][f=0001983] [SeaRecoveryTest] PASS team-12-factory-1` |
| expect `team-12-factory-2` | seen at 1.6 min | `[t=00:01:02.253197][f=0002937] [SeaRecoveryTest] PASS team-12-factory-2` |
| expect `team-12-factory-3` | seen at 1.5 min | `[t=00:01:00.830397][f=0002628] [SeaRecoveryTest] PASS team-12-factory-3` |
| expect `team-13-factory-1` | seen at 1.2 min | `[t=00:00:58.467155][f=0002085] [SeaRecoveryTest] PASS team-13-factory-1` |
| expect `team-13-factory-2` | seen at 1.6 min | `[t=00:01:02.394629][f=0002968] [SeaRecoveryTest] PASS team-13-factory-2` |
| expect `team-13-factory-3` | seen at 1.6 min | `[t=00:01:02.018223][f=0002888] [SeaRecoveryTest] PASS team-13-factory-3` |
| expect `team-14-factory-1` | seen at 1.4 min | `[t=00:01:00.391012][f=0002528] [SeaRecoveryTest] PASS team-14-factory-1` |
| expect `team-14-factory-2` | **missing** (by 12 min) | |
| expect `team-14-factory-3` | seen at 1.5 min | `[t=00:01:01.228536][f=0002722] [SeaRecoveryTest] PASS team-14-factory-3` |
| expect `team-15-factory-1` | seen at 1.2 min | `[t=00:00:58.752203][f=0002140] [SeaRecoveryTest] PASS team-15-factory-1` |
| expect `team-15-factory-2` | **missing** (by 12 min) | |
| expect `team-15-factory-3` | **missing** (by 12 min) | |
| forbid `errors` | **hit** | `[t=00:00:53.559491][f=0001290] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm` |

## Failures

- forbid 'errors' hit at 0.7 min: [t=00:00:53.559491][f=0001290] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.7 min: [t=00:00:53.568083][f=0001290] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.7 min: [t=00:00:53.576431][f=0001290] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.7 min: [t=00:00:53.693291][f=0001320] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.7 min: [t=00:00:53.701722][f=0001320] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.7 min: [t=00:00:53.710088][f=0001320] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:53.827370][f=0001350] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:53.835853][f=0001350] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.8 min: [t=00:00:53.844693][f=0001350] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:53.965680][f=0001380] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:53.974538][f=0001380] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.8 min: [t=00:00:53.984009][f=0001380] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:53.993692][f=0001380] [SeaRecoveryTest] FAIL no capacity site team=11 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.126930][f=0001410] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.136891][f=0001410] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.8 min: [t=00:00:54.146257][f=0001410] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.155539][f=0001410] [SeaRecoveryTest] FAIL no capacity site team=11 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.273810][f=0001440] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.284045][f=0001440] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.8 min: [t=00:00:54.293917][f=0001440] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.304410][f=0001440] [SeaRecoveryTest] FAIL no capacity site team=11 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.402256][f=0001470] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armuwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.443898][f=0001470] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.454392][f=0001470] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.8 min: [t=00:00:54.464439][f=0001470] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.475111][f=0001470] [SeaRecoveryTest] FAIL no capacity site team=11 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.585044][f=0001500] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armuwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.628739][f=0001500] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.639852][f=0001500] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.8 min: [t=00:00:54.650441][f=0001500] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.661409][f=0001500] [SeaRecoveryTest] FAIL no capacity site team=11 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.751941][f=0001530] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armuwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.798456][f=0001530] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.808993][f=0001530] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.8 min: [t=00:00:54.820695][f=0001530] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.8 min: [t=00:00:54.831457][f=0001530] [SeaRecoveryTest] FAIL no capacity site team=11 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:54.928403][f=0001560] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:54.939378][f=0001560] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:54.976724][f=0001560] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:54.988116][f=0001560] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.9 min: [t=00:00:54.999973][f=0001560] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.010825][f=0001560] [SeaRecoveryTest] FAIL no capacity site team=11 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.128117][f=0001590] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.139408][f=0001590] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.150727][f=0001590] [SeaRecoveryTest] FAIL no capacity site team=2 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.179904][f=0001590] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.192131][f=0001590] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.9 min: [t=00:00:55.204247][f=0001590] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.215631][f=0001590] [SeaRecoveryTest] FAIL no capacity site team=11 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.321831][f=0001620] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.334420][f=0001620] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.346271][f=0001620] [SeaRecoveryTest] FAIL no capacity site team=2 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.376835][f=0001620] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.388210][f=0001620] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.9 min: [t=00:00:55.400423][f=0001620] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.412387][f=0001620] [SeaRecoveryTest] FAIL no capacity site team=11 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.513747][f=0001650] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.525385][f=0001650] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.537128][f=0001650] [SeaRecoveryTest] FAIL no capacity site team=2 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.569508][f=0001650] [SeaRecoveryTest] FAIL no capacity site team=8 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.582153][f=0001650] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavaleconv
- forbid 'errors' hit at 0.9 min: [t=00:00:55.594487][f=0001650] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armuwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.606618][f=0001650] [SeaRecoveryTest] FAIL no capacity site team=11 unit=coruwmmm
- forbid 'errors' hit at 0.9 min: [t=00:00:55.734150][f=0001680] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armsy
- forbid 'errors' hit at 0.9 min: [t=00:00:55.746539][f=0001680] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armsy
- forbid 'errors' hit at 0.9 min: [t=00:00:55.758243][f=0001680] [SeaRecoveryTest] FAIL no capacity site team=2 unit=corsy
- forbid 'errors' hit at 0.9 min: [t=00:00:55.769539][f=0001680] [SeaRecoveryTest] FAIL no capacity site team=3 unit=legsy
- forbid 'errors' hit at 0.9 min: [t=00:00:55.792562][f=0001680] [SeaRecoveryTest] FAIL no capacity site team=8 unit=corsy
- forbid 'errors' hit at 0.9 min: [t=00:00:55.804307][f=0001680] [SeaRecoveryTest] FAIL no capacity site team=9 unit=legsy
- forbid 'errors' hit at 0.9 min: [t=00:00:55.817097][f=0001680] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armsy
- forbid 'errors' hit at 0.9 min: [t=00:00:55.829497][f=0001680] [SeaRecoveryTest] FAIL no capacity site team=11 unit=corsy
- forbid 'errors' hit at 0.9 min: [t=00:00:55.935765][f=0001710] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armasy
- forbid 'errors' hit at 0.9 min: [t=00:00:55.946133][f=0001710] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armasy
- forbid 'errors' hit at 0.9 min: [t=00:00:55.956772][f=0001710] [SeaRecoveryTest] FAIL no capacity site team=2 unit=corasy
- forbid 'errors' hit at 0.9 min: [t=00:00:55.967065][f=0001710] [SeaRecoveryTest] FAIL no capacity site team=3 unit=legadvshipyard
- forbid 'errors' hit at 0.9 min: [t=00:00:55.992558][f=0001710] [SeaRecoveryTest] FAIL no capacity site team=8 unit=corasy
- forbid 'errors' hit at 0.9 min: [t=00:00:56.003490][f=0001710] [SeaRecoveryTest] FAIL no capacity site team=9 unit=legadvshipyard
- forbid 'errors' hit at 0.9 min: [t=00:00:56.015647][f=0001710] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armasy
- forbid 'errors' hit at 0.9 min: [t=00:00:56.027059][f=0001710] [SeaRecoveryTest] FAIL no capacity site team=11 unit=corasy
- forbid 'errors' hit at 0.9 min: [t=00:00:56.041300][f=0001710] [SeaRecoveryTest] FAIL no capacity site team=14 unit=corasy
- forbid 'errors' hit at 0.9 min: [t=00:00:56.048836][f=0001710] [SeaRecoveryTest] FAIL no capacity site team=15 unit=legadvshipyard
- forbid 'errors' hit at 1.0 min: [t=00:00:56.200372][f=0001740] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.212246][f=0001740] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.224109][f=0001740] [SeaRecoveryTest] FAIL no capacity site team=2 unit=corplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.236138][f=0001740] [SeaRecoveryTest] FAIL no capacity site team=3 unit=legsplab
- forbid 'errors' hit at 1.0 min: [t=00:00:56.262703][f=0001740] [SeaRecoveryTest] FAIL no capacity site team=8 unit=corplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.275004][f=0001740] [SeaRecoveryTest] FAIL no capacity site team=9 unit=legsplab
- forbid 'errors' hit at 1.0 min: [t=00:00:56.287542][f=0001740] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.300504][f=0001740] [SeaRecoveryTest] FAIL no capacity site team=11 unit=corplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.327663][f=0001740] [SeaRecoveryTest] FAIL no capacity site team=15 unit=legsplab
- forbid 'errors' hit at 1.0 min: [t=00:00:56.435464][f=0001770] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.448554][f=0001770] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.482620][f=0001770] [SeaRecoveryTest] FAIL no capacity site team=9 unit=legnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.495752][f=0001770] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.508526][f=0001770] [SeaRecoveryTest] FAIL no capacity site team=11 unit=cornanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.698800][f=0001800] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.712048][f=0001800] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.740948][f=0001800] [SeaRecoveryTest] FAIL no capacity site team=8 unit=cornanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.755199][f=0001800] [SeaRecoveryTest] FAIL no capacity site team=9 unit=legnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.768805][f=0001800] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.782356][f=0001800] [SeaRecoveryTest] FAIL no capacity site team=11 unit=cornanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.938715][f=0001830] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.952377][f=0001830] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:56.968465][f=0001830] [SeaRecoveryTest] FAIL no capacity site team=3 unit=legnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.000587][f=0001830] [SeaRecoveryTest] FAIL no capacity site team=8 unit=cornanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.016881][f=0001830] [SeaRecoveryTest] FAIL no capacity site team=9 unit=legnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.031270][f=0001830] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.044624][f=0001830] [SeaRecoveryTest] FAIL no capacity site team=11 unit=cornanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.260742][f=0001860] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.273921][f=0001860] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.287369][f=0001860] [SeaRecoveryTest] FAIL no capacity site team=2 unit=cornanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.300048][f=0001860] [SeaRecoveryTest] FAIL no capacity site team=3 unit=legnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.333474][f=0001860] [SeaRecoveryTest] FAIL no capacity site team=8 unit=cornanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.348149][f=0001860] [SeaRecoveryTest] FAIL no capacity site team=9 unit=legnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.363781][f=0001860] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armnanotcplat
- forbid 'errors' hit at 1.0 min: [t=00:00:57.378474][f=0001860] [SeaRecoveryTest] FAIL no capacity site team=11 unit=cornanotcplat
- forbid 'errors' hit at 1.1 min: [t=00:00:57.518438][f=0001890] [SeaRecoveryTest] FAIL no capacity site team=0 unit=armepoch
- forbid 'errors' hit at 1.1 min: [t=00:00:57.532971][f=0001890] [SeaRecoveryTest] FAIL no capacity site team=1 unit=armepoch
- forbid 'errors' hit at 1.1 min: [t=00:00:57.546039][f=0001890] [SeaRecoveryTest] FAIL no capacity site team=2 unit=corblackhy
- forbid 'errors' hit at 1.1 min: [t=00:00:57.559505][f=0001890] [SeaRecoveryTest] FAIL no capacity site team=3 unit=leganavyflagship
- forbid 'errors' hit at 1.1 min: [t=00:00:57.598585][f=0001890] [SeaRecoveryTest] FAIL no capacity site team=8 unit=corblackhy
- forbid 'errors' hit at 1.1 min: [t=00:00:57.612269][f=0001890] [SeaRecoveryTest] FAIL no capacity site team=9 unit=leganavyflagship
- forbid 'errors' hit at 1.1 min: [t=00:00:57.626704][f=0001890] [SeaRecoveryTest] FAIL no capacity site team=10 unit=armepoch
- forbid 'errors' hit at 1.1 min: [t=00:00:57.640619][f=0001890] [SeaRecoveryTest] FAIL no capacity site team=11 unit=corblackhy
- forbid 'errors' hit at 1.1 min: [t=00:00:57.659706][f=0001890] [SeaRecoveryTest] FAIL no capacity site team=14 unit=corblackhy
- forbid 'errors' hit at 2.5 min: [t=00:01:11.607898][f=0004439] Error: Spring 2026.07.04 has crashed.
- forbid 'errors' hit at 2.5 min: [t=00:01:11.679407][f=0004439] Error: Exception: Access violation (0xc0000005)
- forbid 'errors' hit at 2.5 min: [t=00:01:15.646432][f=0004439] Fatal: [ExitSpringProcess] errorMsg="Spring has crashed:

## Screenshots

- none

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
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1627|637|0|0|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(1637,1241) factory=armsy landLocked=no spot=1 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1599,1801) factory=corsy landLocked=no spot=2 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(1595,2417) factory=legsy landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(2802,638) factory=armsy landLocked=no spot=4 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(2779,1236) factory=corsy landLocked=no spot=5 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(2764,1795) factory=legsy landLocked=no spot=6 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=SEA side=armada start=(2832,2410) factory=armsy landLocked=no spot=7 known=7/7
  0.18  [Team][Roster] team 2 first mex at 1568,1951
  0.19  [Team][Roster] team 3 first mex at 1568,2528
  0.24  [Playtest] finished armmex team 0 at 0.24 min
  0.25  [Team][Roster] first mex 8022 at 1792,832
  0.25  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1627|637|0|0|1|1792|832
  0.27  [Team][Roster] team 6 first mex at 2528,1696
  0.28  [Team][Roster] team 1 first mex at 1888,1488
  0.29  [Team][Roster] team 4 first mex at 2816,944
  0.32  [Team][Roster] team 7 first mex at 3168,2448
  0.36  [Playtest] finished armwin team 0 at 0.36 min
  0.50  [Playtest] finished armuwfus team 0 at 0.50 min
  0.52  [Playtest] finished armuwfus team 0 at 0.52 min
  0.54  [Playtest] finished armuwfus team 0 at 0.54 min
  0.56  [Playtest] finished armuwfus team 0 at 0.56 min
  0.58  [Playtest] finished armuwfus team 0 at 0.58 min
  0.60  [Playtest] finished armuwfus team 0 at 0.60 min
  0.61  [Playtest] finished armmex team 0 at 0.61 min
  0.62  [Playtest] finished armuwfus team 0 at 0.62 min
  0.63  [Playtest] finished armuwfus team 0 at 0.63 min
  0.65  [Playtest] finished armuwmmm team 0 at 0.65 min
  0.67  [Playtest] finished armuwmmm team 0 at 0.67 min
  0.68  [Playtest] finished armuwmmm team 0 at 0.68 min
  0.70  [Playtest] finished armuwmmm team 0 at 0.70 min
  0.71  [Playtest] finished armuwmmm team 0 at 0.71 min
  0.73  [Playtest] finished armuwmmm team 0 at 0.73 min
  0.74  [Playtest] finished armwin team 0 at 0.74 min
  0.75  [Playtest] finished armuwmmm team 0 at 0.75 min
  0.77  [Playtest] finished armuwmmm team 0 at 0.77 min
  0.78  [Playtest] finished armuwmmm team 0 at 0.78 min
  0.80  [Playtest] finished armuwmmm team 0 at 0.80 min
  0.82  [Playtest] finished armuwmmm team 0 at 0.82 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +96.7 bank 1100/1100, energy +9666.0 bank 18450/21001, units 24
  1.53  [Playtest] finished armsy team 0 at 1.53 min
  1.90  [SEA][Layout] berth sea.berth.0 armasy at=4592,656 facing=1
  2.00  [Playtest] eco team 0 at 2.0 min: metal +96.3 bank 1194/1200, energy +9658.6 bank 18603/21151, units 28
  2.02  [SEA][Layout] berth sea.berth.1 armplat at=3440,160 facing=1
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
  0.27  RESERVE: zone 6 at (12904, 2376) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12904, 2376) facing 3 (id 6)
  0.27  RESERVE: zone 7 at (12904, 2424) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12904, 2424) facing 3 (id 7)
  0.27  RESERVE: zone 8 at (12904, 2472) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12904, 2472) facing 3 (id 8)
  0.27  RESERVE: zone 9 at (12904, 2520) facing 3, 3x3 cells: 9 of 9 held
  0.27  RESERVE: legtide at (12904, 2520) facing 3 (id 9)
```
