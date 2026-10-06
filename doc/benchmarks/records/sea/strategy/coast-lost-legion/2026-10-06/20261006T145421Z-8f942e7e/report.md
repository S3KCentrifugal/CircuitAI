# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.1 min (frame 45182); wall 337 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T11:48:41
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: coast-checks.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loss` | seen at 2.5 min | `[SEA][Coast] fallback=true body=0` |
| expect `donation` | seen at 2.0 min | `[t=00:00:47.719110][f=0003630] [CoastFixture] frame=3630 donated legck id=20343` |
| expect `lab` | seen at 3.9 min | `[t=00:00:56.751800][f=0007049] [CoastFixture] frame=7049 finished leglab x=1472 z=2256` |
| expect `metal-storage` | seen at 6.0 min | `[t=00:01:09.385278][f=0010819] [CoastFixture] frame=10819 finished legmstor x=1712 z=2128` |
| expect `energy-storage` | seen at 6.1 min | `[t=00:01:09.851417][f=0010998] [CoastFixture] frame=10998 finished legestor x=1360 z=2256` |
| expect `t1-defense` | seen at 6.2 min | `[t=00:01:10.334547][f=0011215] [CoastFixture] frame=11215 finished legmg x=1368 z=2888` |
| expect `t2-defense` | seen at 7.2 min | `[t=00:01:18.203890][f=0012975] [CoastFixture] frame=12975 finished legapopupdef x=1992 z=2920` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-49-37-110.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-49-37-505.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-49-42-547.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-49-47-860.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-49-53-060.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-49-53-713.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-50-01-100.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-50-10-660.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-50-26-788.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-50-43-328.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-50-43-709.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-51-00-478.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-51-20-396.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-51-39-940.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-51-40-313.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-51-58-484.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-52-16-346.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-52-29-150.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-52-42-228.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-52-54-365.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-53-08-496.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-53-21-901.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-53-33-907.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-53-44-730.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-53-55-374.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-54-06-283.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\strategy\coast-lost-legion\glacial\20261006T144840Z-a881b9dd\runs\20261006T145421Z-8f942e7e\screen_2026-10-06_14-54-18-593.png

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
  3.92  [Playtest] finished leglab team 0 at 3.92 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +0.0 bank 589/600, energy +5.0 bank 577/650, units 3
  4.73  [Playtest] finished legrad team 0 at 4.73 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +0.0 bank 562/600, energy +15.0 bank 367/750, units 9
  5.19  [Playtest] finished legmex team 0 at 5.19 min
  5.20  [Team][Roster] first mex 9556 at 1616,2560
  5.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|1430|4000|0|4|1|1616|2560
  6.00  [Playtest] eco team 0 at 6.0 min: metal +2.0 bank 517/650, energy +81.0 bank 111/1250, units 22
  6.00  [Playtest] camera requested (1430,4000) height=2200
  6.00  [Playtest] camera captured name=ta position=(1430,4000) height=2200
  6.00  [Playtest] screenshot at 6.0 min of team 0 at (1430, 4000)
  6.01  [Playtest] finished legmstor team 0 at 6.01 min
  6.11  [Playtest] finished legestor team 0 at 6.11 min
  6.23  [Playtest] finished legmg team 0 at 6.23 min
  6.58  [Playtest] finished legsolar team 0 at 6.58 min
  6.68  [Playtest] finished legctl team 0 at 6.68 min
  6.73  [Playtest] finished legmoho team 0 at 6.73 min
  6.75  [Playtest] finished legmoho team 0 at 6.75 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +18.0 bank 4777/4850, energy +116.0 bank 5221/7450, units 30
  7.08  [Playtest] finished legsolar team 0 at 7.07 min
  7.21  [Playtest] finished legapopupdef team 0 at 7.21 min
  7.27  [Playtest] finished legapopupdef team 0 at 7.27 min
  7.36  [Playtest] finished legjam team 0 at 7.36 min
  7.70  [Playtest] finished legrad team 0 at 7.70 min
  7.94  [Playtest] finished legjam team 0 at 7.94 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +18.0 bank 4731/4850, energy +136.0 bank 5119/7500, units 39
  8.25  [Playtest] finished legctl team 0 at 8.25 min
  8.46  [Playtest] finished legmoho team 0 at 8.46 min
  8.64  [Playtest] finished legapopupdef team 0 at 8.64 min
  8.71  [Playtest] finished legapopupdef team 0 at 8.71 min
  8.91  [Playtest] finished legctl team 0 at 8.91 min
  8.91  [Playtest] finished legctl team 0 at 8.91 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +25.9 bank 5443/5450, energy +136.0 bank 6470/7500, units 44
 10.00  [Playtest] eco team 0 at 10.0 min: metal +25.9 bank 5378/5450, energy +136.0 bank 4972/7500, units 50
 10.00  [Playtest] camera requested (1430,4000) height=2200
 10.01  [Playtest] camera captured name=ta position=(1430,4000) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1430, 4000)
 10.05  [Playtest] finished legrad team 0 at 10.05 min
 10.16  [Playtest] finished legjam team 0 at 10.16 min
 10.20  [Playtest] finished legmg team 0 at 10.20 min
 10.45  [Playtest] finished legapopupdef team 0 at 10.45 min
 10.61  [Playtest] finished legapopupdef team 0 at 10.61 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +25.9 bank 5444/5450, energy +136.0 bank 6303/7500, units 55
 11.71  [Playtest] finished legctl team 0 at 11.71 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +25.9 bank 5438/5450, energy +136.0 bank 5791/7500, units 61
 12.24  [Playtest] finished legapopupdef team 0 at 12.24 min
 12.33  [Playtest] finished legjam team 0 at 12.33 min
 12.50  [Playtest] finished legctl team 0 at 12.50 min
 12.54  [Playtest] finished legalab team 0 at 12.54 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +25.9 bank 5562/5650, energy +136.0 bank 4092/7700, units 69
 13.00  [Playtest] camera requested (1430,4000) height=2200
 13.01  [Playtest] camera captured name=ta position=(1430,4000) height=2200
 13.01  [Playtest] screenshot at 13.0 min of team 0 at (1430, 4000)
 13.39  [Playtest] finished legrad team 0 at 13.39 min
 13.90  [Playtest] finished legctl team 0 at 13.90 min
 13.94  [Playtest] finished legapopupdef team 0 at 13.94 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +25.9 bank 5578/5650, energy +136.0 bank 3548/7700, units 74
 14.18  [Playtest] finished legapopupdef team 0 at 14.18 min
 14.29  [Playtest] finished leginc team 0 at 14.28 min
 14.30  [Playtest] finished legctl team 0 at 14.30 min
 14.67  [Playtest] finished legjam team 0 at 14.67 min
 14.71  [Playtest] finished legrad team 0 at 14.71 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +25.9 bank 5565/5650, energy +136.0 bank 2995/7700, units 85
 15.47  [Playtest] finished legmine2 team 0 at 15.47 min
 15.80  [Playtest] finished legjam team 0 at 15.80 min
 15.81  [Playtest] finished legapopupdef team 0 at 15.81 min
 15.94  [Playtest] finished legctl team 0 at 15.94 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +25.9 bank 5593/5650, energy +136.0 bank 3065/7700, units 91
 16.20  [Playtest] finished legapopupdef team 0 at 16.20 min
 16.22  [Playtest] finished legmine2 team 0 at 16.22 min
 16.37  [Playtest] finished leginc team 0 at 16.37 min
 16.62  [Playtest] finished legctl team 0 at 16.62 min
 16.68  [Playtest] finished legforti team 0 at 16.68 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +25.9 bank 5589/5650, energy +136.0 bank 4315/7700, units 99
 17.04  [Playtest] finished legforti team 0 at 17.04 min
 17.11  [Playtest] finished legjam team 0 at 17.11 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +25.9 bank 5578/5650, energy +136.0 bank 4294/7700, units 99
 18.25  [Playtest] finished legmg team 0 at 18.25 min
 18.25  [Playtest] finished legforti team 0 at 18.25 min
 18.42  [Playtest] finished leginc team 0 at 18.42 min
 18.81  [Playtest] finished legapopupdef team 0 at 18.81 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +25.9 bank 5609/5650, energy +136.0 bank 4848/7700, units 107
 19.76  [Playtest] finished legmg team 0 at 19.76 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +25.9 bank 5571/5650, energy +136.0 bank 3744/7700, units 113
 20.16  [Playtest] finished legrad team 0 at 20.16 min
 20.20  [Playtest] finished legctl team 0 at 20.20 min
 20.46  [Playtest] finished leginc team 0 at 20.46 min
 20.57  [Playtest] finished legapopupdef team 0 at 20.57 min
 20.89  [Playtest] finished legjam team 0 at 20.89 min
 20.98  [Playtest] finished legforti team 0 at 20.98 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +25.9 bank 5577/5650, energy +136.0 bank 3491/7700, units 122
 21.11  [Playtest] finished legforti team 0 at 21.11 min
 21.55  [Playtest] finished legjam team 0 at 21.55 min
 21.80  [Playtest] finished legapopupdef team 0 at 21.80 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +25.9 bank 5606/5650, energy +136.0 bank 4491/7700, units 128
 22.51  [Playtest] finished leginc team 0 at 22.51 min
 22.74  [Playtest] finished legmg team 0 at 22.74 min
 22.99  [Playtest] finished legforti team 0 at 22.99 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +25.9 bank 5582/5650, energy +136.0 bank 4338/7700, units 134
 23.34  [Playtest] finished legmg team 0 at 23.34 min
 23.68  [Playtest] finished legforti team 0 at 23.68 min
 23.96  [Playtest] finished legforti team 0 at 23.96 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +25.9 bank 5616/5650, energy +136.0 bank 4677/7700, units 140
 24.07  [Playtest] finished legforti team 0 at 24.07 min
 24.10  [Playtest] finished legforti team 0 at 24.10 min
 24.20  [Playtest] finished legforti team 0 at 24.20 min
 24.23  [Playtest] finished legforti team 0 at 24.23 min
 24.56  [Playtest] finished leginc team 0 at 24.56 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +25.9 bank 5639/5650, energy +136.0 bank 5065/7700, units 149
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
