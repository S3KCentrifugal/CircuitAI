# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.2 min (frame 45281); wall 241 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T11:28:20
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: coast-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loss` | seen at 2.5 min | `[SEA][Coast] fallback=true body=0` |
| expect `donation` | seen at 2.0 min | `[t=00:00:48.170674][f=0003631] [CoastFixture] frame=3631 donated legck id=6491` |
| expect `lab` | seen at 3.9 min | `[t=00:00:56.869199][f=0007034] [CoastFixture] frame=7034 finished leglab x=1472 z=2256` |
| expect `metal-storage` | seen at 5.9 min | `[t=00:01:05.809426][f=0010622] [CoastFixture] frame=10622 finished legmstor x=1808 z=2336` |
| expect `energy-storage` | seen at 6.4 min | `[t=00:01:09.033305][f=0011574] [CoastFixture] frame=11574 finished legestor x=1232 z=2256` |
| expect `t1-defense` | seen at 8.1 min | `[t=00:01:19.860153][f=0014581] [CoastFixture] frame=14581 finished legmg x=2472 z=3144` |
| expect `t2-defense` | seen at 7.2 min | `[t=00:01:13.953500][f=0012993] [CoastFixture] frame=12993 finished legapopupdef x=1992 z=2920` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-29-16-051.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-29-17-052.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-29-21-161.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-29-25-702.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-29-30-007.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-29-31-009.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-29-36-113.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-29-43-199.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-29-48-822.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-29-57-911.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-29-58-912.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-30-06-996.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-30-17-111.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-30-24-896.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-30-25-897.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-30-36-052.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-30-46-147.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-30-55-751.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-31-05-746.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-31-16-110.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-31-25-598.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-31-34-692.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-31-43-417.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-31-53-357.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-32-03-541.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-32-13-014.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T142820Z-18fc63b4\runs\20261006T143224Z-fabf58bd\screen_2026-10-06_14-32-21-928.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|legion|legsy|1430|4000|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.33  [Playtest] finished legsy team 0 at 0.33 min
  0.38  [SEA][Layout] berth sea.berth.0 legadvshipyard at=2192,4192 facing=1
  0.40  [SEA][Layout] berth sea.berth.1 legsplab at=2192,3600 facing=1
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1100/1100, energy +35.0 bank 1150/1150, units 3
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1100/1100, energy +35.0 bank 1150/1150, units 3
  2.10  [SEA][Layout] berth sea.berth.2 legsy at=2192,4384 facing=1
  3.00  [Playtest] eco team 0 at 3.0 min: metal +0.0 bank 488/500, energy +5.0 bank 534/550, units 2
  3.00  [Playtest] target team 0 at (1430, 4000) from its start position
  3.00  [Playtest] camera requested (1430,4000) height=2200
  3.00  [Playtest] camera captured name=ta position=(1430,4000) height=2200
  3.00  [Playtest] screenshot at 3.0 min of team 0 at (1430, 4000)
  3.91  [Playtest] finished leglab team 0 at 3.91 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +0.0 bank 589/600, energy +5.0 bank 577/650, units 3
  4.73  [Playtest] finished legsolar team 0 at 4.73 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +0.0 bank 551/600, energy +35.0 bank 736/800, units 10
  5.08  [Playtest] finished legsolar team 0 at 5.08 min
  5.19  [Playtest] finished legmex team 0 at 5.19 min
  5.20  [Team][Roster] first mex 7785 at 1776,2720
  5.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|1430|4000|0|4|1|1776|2720
  5.47  [Playtest] finished legsolar team 0 at 5.47 min
  5.90  [Playtest] finished legmstor team 0 at 5.90 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 3523/3650, energy +131.0 bank 75/1300, units 23
  6.00  [Playtest] camera requested (1430,4000) height=2200
  6.00  [Playtest] camera captured name=ta position=(1430,4000) height=2200
  6.00  [Playtest] screenshot at 6.0 min of team 0 at (1430, 4000)
  6.18  [Playtest] finished legsolar team 0 at 6.18 min
  6.43  [Playtest] finished legestor team 0 at 6.43 min
  6.75  [Playtest] finished legmoho team 0 at 6.74 min
  6.75  [Playtest] finished legmoho team 0 at 6.75 min
  6.84  [Playtest] finished legsolar team 0 at 6.84 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +18.0 bank 4812/4850, energy +171.0 bank 6185/7400, units 28
  7.22  [Playtest] finished legapopupdef team 0 at 7.22 min
  7.26  [Playtest] finished legapopupdef team 0 at 7.26 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +18.0 bank 4750/4850, energy +171.0 bank 4828/7400, units 35
  8.10  [Playtest] finished legmg team 0 at 8.10 min
  8.70  [Playtest] finished legsolar team 0 at 8.70 min
  8.78  [Playtest] finished legapopupdef team 0 at 8.78 min
  8.95  [Playtest] finished legapopupdef team 0 at 8.95 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +18.0 bank 4803/4850, energy +191.0 bank 6355/7450, units 40
  9.25  [Playtest] finished legapopupdef team 0 at 9.25 min
  9.35  [Playtest] finished legsolar team 0 at 9.35 min
  9.39  [Playtest] finished legapopupdef team 0 at 9.39 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +18.0 bank 4846/4850, energy +211.0 bank 7415/7500, units 45
 10.00  [Playtest] camera requested (1430,4000) height=2200
 10.01  [Playtest] camera captured name=ta position=(1430,4000) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1430, 4000)
 10.73  [Playtest] finished legsolar team 0 at 10.73 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +18.0 bank 4785/4850, energy +231.0 bank 6095/7550, units 51
 11.46  [Playtest] finished legapopupdef team 0 at 11.46 min
 11.63  [Playtest] finished legapopupdef team 0 at 11.63 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +18.0 bank 4797/4850, energy +231.0 bank 6204/7550, units 56
 12.20  [Playtest] finished legapopupdef team 0 at 12.20 min
 12.90  [Playtest] finished legsolar team 0 at 12.90 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +18.0 bank 4785/4850, energy +251.0 bank 6229/7600, units 61
 13.00  [Playtest] camera requested (1430,4000) height=2200
 13.01  [Playtest] camera captured name=ta position=(1430,4000) height=2200
 13.01  [Playtest] screenshot at 13.0 min of team 0 at (1430, 4000)
 13.14  [Playtest] finished legapopupdef team 0 at 13.14 min
 13.44  [Playtest] finished legapopupdef team 0 at 13.44 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +18.0 bank 4831/4850, energy +251.0 bank 7059/7600, units 66
 14.11  [Playtest] finished legapopupdef team 0 at 14.11 min
 14.60  [Playtest] finished legapopupdef team 0 at 14.60 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +18.0 bank 4825/4850, energy +251.0 bank 6895/7600, units 71
 15.51  [Playtest] finished legapopupdef team 0 at 15.51 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +18.0 bank 4842/4850, energy +251.0 bank 7454/7600, units 74
 16.26  [Playtest] finished legapopupdef team 0 at 16.26 min
 16.47  [Playtest] finished legforti team 0 at 16.47 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +18.0 bank 4846/4850, energy +251.0 bank 7583/7600, units 79
 17.07  [Playtest] finished legforti team 0 at 17.07 min
 17.19  [Playtest] finished legforti team 0 at 17.19 min
 17.45  [Playtest] finished legforti team 0 at 17.44 min
 17.55  [Playtest] finished legforti team 0 at 17.55 min
 17.99  [Playtest] finished legforti team 0 at 17.99 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +18.0 bank 4846/4850, energy +251.0 bank 7572/7600, units 87
 18.24  [Playtest] finished legforti team 0 at 18.24 min
 18.60  [Playtest] finished legforti team 0 at 18.60 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +18.0 bank 4828/4850, energy +251.0 bank 7425/7600, units 94
 19.03  [Playtest] finished legforti team 0 at 19.03 min
 19.04  [Playtest] finished legforti team 0 at 19.04 min
 19.12  [Playtest] finished legforti team 0 at 19.12 min
 19.28  [Playtest] finished legforti team 0 at 19.28 min
 19.78  [Playtest] finished legforti team 0 at 19.78 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +18.0 bank 4846/4850, energy +251.0 bank 7568/7600, units 100
 20.30  [Playtest] finished legforti team 0 at 20.30 min
 20.56  [Playtest] finished legforti team 0 at 20.56 min
 20.94  [Playtest] finished legforti team 0 at 20.94 min
 20.96  [Playtest] finished legforti team 0 at 20.96 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +18.0 bank 4846/4850, energy +251.0 bank 7568/7600, units 108
 21.39  [Playtest] finished legforti team 0 at 21.39 min
 21.66  [Playtest] finished legforti team 0 at 21.66 min
 21.74  [Playtest] finished legforti team 0 at 21.74 min
 21.84  [Playtest] finished legforti team 0 at 21.84 min
 21.86  [Playtest] finished legforti team 0 at 21.86 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +18.0 bank 4845/4850, energy +251.0 bank 7568/7600, units 116
 22.09  [Playtest] finished legforti team 0 at 22.09 min
 22.37  [Playtest] finished legforti team 0 at 22.37 min
 22.76  [Playtest] finished legforti team 0 at 22.76 min
 22.77  [Playtest] finished legforti team 0 at 22.77 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +18.0 bank 4843/4850, energy +251.0 bank 7534/7600, units 124
 23.03  [Playtest] finished legforti team 0 at 23.03 min
 23.56  [Playtest] finished legforti team 0 at 23.56 min
 23.84  [Playtest] finished legforti team 0 at 23.84 min
 23.85  [Playtest] finished legforti team 0 at 23.85 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +18.0 bank 4845/4850, energy +251.0 bank 7564/7600, units 130
 24.23  [Playtest] finished legforti team 0 at 24.23 min
 24.71  [Playtest] finished legforti team 0 at 24.71 min
 24.86  [Playtest] finished legforti team 0 at 24.86 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +18.0 bank 4850/4850, energy +251.0 bank 7600/7600, units 136
 25.14  [Playtest] finished legforti team 0 at 25.14 min
```

## Native lines (all AIs, first 120)

```
  0.35  RESERVE: zone 1 at (1288, 4056) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1288, 4056) facing 1 (id 1)
  0.35  RESERVE: zone 2 at (1288, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1288, 4008) facing 1 (id 2)
  0.35  RESERVE: zone 1 released
  0.35  RESERVE: zone 2 released
  0.35  RESERVE: zone 3 at (1224, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1224, 4008) facing 1 (id 3)
  0.35  RESERVE: zone 3 released
  0.35  RESERVE: zone 4 at (1176, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1176, 3944) facing 1 (id 4)
  0.35  RESERVE: zone 5 at (1176, 3896) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1176, 3896) facing 1 (id 5)
  0.35  RESERVE: zone 6 at (1176, 3848) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1176, 3848) facing 1 (id 6)
  0.35  RESERVE: zone 7 at (1176, 3800) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1176, 3800) facing 1 (id 7)
  0.35  RESERVE: zone 8 at (1176, 3752) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1176, 3752) facing 1 (id 8)
  0.35  RESERVE: zone 4 released
  0.35  RESERVE: zone 5 released
  0.35  RESERVE: zone 6 released
  0.35  RESERVE: zone 7 released
  0.35  RESERVE: zone 8 released
  0.35  RESERVE: zone 9 at (1160, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1160, 3880) facing 1 (id 9)
  0.35  RESERVE: zone 10 at (1160, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1160, 3832) facing 1 (id 10)
  0.35  RESERVE: zone 11 at (1160, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1160, 3784) facing 1 (id 11)
  0.35  RESERVE: zone 12 at (1160, 3736) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1160, 3736) facing 1 (id 12)
  0.35  RESERVE: zone 9 released
  0.35  RESERVE: zone 10 released
  0.35  RESERVE: zone 11 released
  0.35  RESERVE: zone 12 released
  0.35  RESERVE: zone 13 at (1176, 3800) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1176, 3800) facing 1 (id 13)
  0.35  RESERVE: zone 14 at (1176, 3752) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1176, 3752) facing 1 (id 14)
  0.35  RESERVE: zone 15 at (1176, 3704) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1176, 3704) facing 1 (id 15)
  0.35  RESERVE: zone 13 released
  0.35  RESERVE: zone 14 released
  0.35  RESERVE: zone 15 released
  0.35  RESERVE: zone 16 at (1224, 3736) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1224, 3736) facing 1 (id 16)
  0.35  RESERVE: zone 17 at (1224, 3688) facing 1, 3x3 cells: 9 of 9 held
  0.35  RESERVE: legnanotcplat at (1224, 3688) facing 1 (id 17)
  0.35  RESERVE: zone 16 released
  0.35  RESERVE: zone 17 released
  0.35  RESERVE: corridor 18 at (1430, 4288) facing 0, 13x30 cells: 343 of 390 held
  0.35  RESERVE: zone 19 at (646, 4000) facing 1, 41x40 cells: 1640 of 1640 held
  0.35  RESERVE: grid of legnanotcplat 4x4 gap 0 behind (742, 4000) facing 1: 16 of 16 slots (group 1, held, zone)
  0.35  RESERVE: leganavalfusion at (504, 4016) facing 1 (id 34)
  0.35  RESERVE: packed leganavalfusion at (504, 4016) facing 1 in zone 19, 320 from a turret (id 34, group 0, 1023 candidates)
  0.37  RESERVE: zone 20 at (1288, 3688) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1288, 3688) facing 1 (id 35)
  0.37  RESERVE: zone 21 at (1288, 3640) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1288, 3640) facing 1 (id 36)
  0.37  RESERVE: zone 20 released
  0.37  RESERVE: zone 21 released
  0.37  RESERVE: zone 22 at (1352, 3688) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1352, 3688) facing 1 (id 37)
  0.37  RESERVE: zone 23 at (1352, 3640) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1352, 3640) facing 1 (id 38)
  0.37  RESERVE: zone 22 released
  0.37  RESERVE: zone 23 released
  0.37  RESERVE: zone 24 at (1432, 3688) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1432, 3688) facing 1 (id 39)
  0.37  RESERVE: zone 25 at (1432, 3640) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1432, 3640) facing 1 (id 40)
  0.37  RESERVE: zone 24 released
  0.37  RESERVE: zone 25 released
  0.37  RESERVE: zone 26 at (1496, 3736) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1496, 3736) facing 1 (id 41)
  0.37  RESERVE: zone 27 at (1496, 3688) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1496, 3688) facing 1 (id 42)
  0.37  RESERVE: zone 28 at (1496, 3640) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1496, 3640) facing 1 (id 43)
  0.37  RESERVE: zone 26 released
  0.37  RESERVE: zone 27 released
  0.37  RESERVE: zone 28 released
  0.37  RESERVE: zone 29 at (1528, 3800) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1528, 3800) facing 1 (id 44)
  0.37  RESERVE: zone 30 at (1528, 3752) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1528, 3752) facing 1 (id 45)
  0.37  RESERVE: zone 31 at (1528, 3704) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1528, 3704) facing 1 (id 46)
  0.37  RESERVE: zone 32 at (1528, 3656) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1528, 3656) facing 1 (id 47)
  0.37  RESERVE: zone 29 released
  0.37  RESERVE: zone 30 released
  0.37  RESERVE: zone 31 released
  0.37  RESERVE: zone 32 released
  0.37  RESERVE: zone 33 at (1640, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1640, 3880) facing 1 (id 48)
  0.37  RESERVE: zone 34 at (1640, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1640, 3832) facing 1 (id 49)
  0.37  RESERVE: zone 35 at (1640, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1640, 3784) facing 1 (id 50)
  0.37  RESERVE: zone 36 at (1640, 3736) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1640, 3736) facing 1 (id 51)
  0.37  RESERVE: zone 37 at (1640, 3688) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1640, 3688) facing 1 (id 52)
  0.37  RESERVE: zone 38 at (1688, 3880) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1688, 3880) facing 1 (id 53)
  0.37  RESERVE: zone 39 at (1688, 3832) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1688, 3832) facing 1 (id 54)
  0.37  RESERVE: zone 40 at (1688, 3784) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1688, 3784) facing 1 (id 55)
  0.37  RESERVE: zone 41 at (1688, 3736) facing 1, 3x3 cells: 9 of 9 held
  0.37  RESERVE: legnanotcplat at (1688, 3736) facing 1 (id 56)
  0.37  RESERVE: zone 33 released
  0.37  RESERVE: zone 34 released
  0.37  RESERVE: zone 35 released
  0.37  RESERVE: zone 36 released
  0.37  RESERVE: zone 37 released
  0.37  RESERVE: zone 38 released
  0.37  RESERVE: zone 39 released
```
