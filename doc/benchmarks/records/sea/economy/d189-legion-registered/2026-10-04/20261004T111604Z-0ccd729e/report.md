# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54042); wall 261 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:11:40
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/legion/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-legion-registered\glacial\20261004T111140Z-93a49113\runs\20261004T111604Z-0ccd729e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.405941][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.7 min | `[t=00:00:49.702877][f=0001337] [SeaWatch] finished frame=1337 id=9800 def=legsy builder=27123` |
| expect `first-ship-exit` | seen at 2.4 min | `[t=00:00:56.468717][f=0004380] [SeaWatch] egress id=19532 yard=9800 seconds=16.4 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-legion-registered\glacial\20261004T111140Z-93a49113\runs\20261004T111604Z-0ccd729e\screen_2026-10-04_11-12-51-832.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-legion-registered\glacial\20261004T111140Z-93a49113\runs\20261004T111604Z-0ccd729e\screen_2026-10-04_11-13-12-832.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-legion-registered\glacial\20261004T111140Z-93a49113\runs\20261004T111604Z-0ccd729e\screen_2026-10-04_11-14-18-833.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-legion-registered\glacial\20261004T111140Z-93a49113\runs\20261004T111604Z-0ccd729e\screen_2026-10-04_11-15-55-232.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
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
  0.10  [SEA][Layout] berth sea.berth.0 legsy at=1424,4000 facing=1
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|legion|legsy|1430|4000|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.12  [SEA][Layout] berth sea.berth.1 legadvshipyard at=1424,3600 facing=1
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.16  [Playtest] finished legmex team 0 at 0.16 min
  0.17  [SEA][Layout] berth sea.berth.2 legadvshipyard at=1472,3296 facing=3
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|legion|legsy|1430|4000|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.29  [Playtest] finished legmex team 0 at 0.29 min
  0.74  [Playtest] finished legsy team 0 at 0.74 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 714/1200, energy +30.0 bank 76/1100, units 5
  1.19  [Playtest] finished legtide team 0 at 1.19 min
  1.38  [Playtest] finished legtide team 0 at 1.38 min
  1.53  [Playtest] finished legtide team 0 at 1.53 min
  1.77  [Playtest] finished legtide team 0 at 1.77 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 371/1200, energy +127.0 bank 221/1350, units 12
  2.00  [Playtest] finished legtide team 0 at 2.00 min
  2.12  [Playtest] finished legmex team 0 at 2.12 min
  2.14  [Playtest] finished legtide team 0 at 2.14 min
  2.73  [Playtest] finished legtide team 0 at 2.73 min
  2.77  [Playtest] finished legmex team 0 at 2.77 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 221/1300, energy +201.0 bank 1518/1550, units 20
  3.05  [Playtest] finished legtide team 0 at 3.05 min
  3.39  [Playtest] finished legtl team 0 at 3.39 min
  3.74  [Playtest] finished legmex team 0 at 3.74 min
  3.98  [Playtest] finished legmex team 0 at 3.98 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +12.0 bank 2/1400, energy +224.0 bank 1572/1600, units 24
  4.18  [Playtest] finished legmex team 0 at 4.18 min
  4.35  [Playtest] finished legmex team 0 at 4.35 min
  4.40  [Playtest] finished legtide team 0 at 4.40 min
  4.43  [Playtest] finished legfeconv team 0 at 4.43 min
  4.75  [Playtest] finished legtide team 0 at 4.75 min
  4.86  [Playtest] finished legmex team 0 at 4.86 min
  4.91  [Playtest] finished legtide team 0 at 4.91 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +21.0 bank 72/1550, energy +293.0 bank 1677/1750, units 33
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.00  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.08  [Playtest] finished legmex team 0 at 5.08 min
  5.08  [Playtest] finished legtide team 0 at 5.08 min
  5.28  [Playtest] finished legmex team 0 at 5.28 min
  5.32  [Playtest] finished legfeconv team 0 at 5.32 min
  5.44  [Playtest] finished legmex team 0 at 5.44 min
  5.63  [Playtest] finished legtide team 0 at 5.63 min
  5.64  [Playtest] finished legtide team 0 at 5.64 min
  5.95  [Playtest] finished legtide team 0 at 5.95 min
  6.00  [Playtest] finished legmex team 0 at 6.00 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +28.0 bank 722/1750, energy +390.0 bank 1865/2000, units 45
  6.22  [Playtest] finished legmex team 0 at 6.22 min
  6.27  [Playtest] finished legfeconv team 0 at 6.27 min
  6.29  [Playtest] finished legtide team 0 at 6.29 min
  6.30  [Playtest] finished legtide team 0 at 6.30 min
  6.41  [Playtest] finished legmex team 0 at 6.41 min
  6.58  [Playtest] finished legmex team 0 at 6.58 min
  6.59  [Playtest] finished legtide team 0 at 6.59 min
  6.81  [Playtest] finished legtide team 0 at 6.81 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +37.0 bank 1543/1900, energy +482.0 bank 1980/2200, units 55
  7.07  [Playtest] finished legmex team 0 at 7.07 min
  7.15  [Playtest] finished legtide team 0 at 7.15 min
  7.30  [Playtest] finished legmex team 0 at 7.30 min
  7.38  [Playtest] finished legnanotcplat team 0 at 7.38 min
  7.57  [Playtest] finished legnanotcplat team 0 at 7.57 min
  7.57  [Playtest] finished legtide team 0 at 7.57 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +38.0 bank 1420/2000, energy +528.0 bank 1288/2300, units 65
  8.07  [Playtest] finished legtide team 0 at 8.07 min
  8.19  [Playtest] finished legtide team 0 at 8.19 min
  8.21  [Playtest] finished legtide team 0 at 8.21 min
  8.68  [Playtest] finished legtide team 0 at 8.68 min
  8.73  [Playtest] finished legtide team 0 at 8.73 min
  8.93  [Playtest] finished legtide team 0 at 8.93 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +41.0 bank 1386/2000, energy +671.0 bank 2367/2650, units 73
  9.04  [Playtest] finished legfeconv team 0 at 9.04 min
  9.13  [Playtest] finished legfeconv team 0 at 9.13 min
  9.26  [Playtest] finished legtide team 0 at 9.26 min
  9.34  [Playtest] finished legtide team 0 at 9.34 min
  9.47  [Playtest] finished legtide team 0 at 9.47 min
  9.58  [Playtest] finished legfeconv team 0 at 9.58 min
  9.96  [Playtest] finished legtide team 0 at 9.96 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +43.8 bank 1863/2000, energy +768.0 bank 2284/2900, units 85
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.02  [Playtest] finished legtide team 0 at 10.02 min
 10.16  [Playtest] finished legtide team 0 at 10.16 min
 10.28  [Playtest] finished legtide team 0 at 10.28 min
 10.33  [Playtest] finished legtide team 0 at 10.33 min
 10.39  [Playtest] finished legtide team 0 at 10.39 min
 10.69  [Playtest] finished legtide team 0 at 10.69 min
 10.71  [Playtest] finished legtide team 0 at 10.70 min
 10.77  [Playtest] finished legtide team 0 at 10.77 min
 10.81  [Playtest] finished legmex team 0 at 10.81 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +46.0 bank 978/2050, energy +957.0 bank 3292/3350, units 97
 11.03  [Playtest] finished legtide team 0 at 11.03 min
 11.05  [Playtest] finished legtide team 0 at 11.05 min
 11.09  [Playtest] finished legtide team 0 at 11.09 min
 11.59  [Playtest] finished legmex team 0 at 11.59 min
 11.89  [Playtest] finished legtide team 0 at 11.89 min
 11.91  [Playtest] finished legadvshipyard team 0 at 11.91 min
 11.98  [Playtest] finished legtide team 0 at 11.98 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +48.0 bank 20/2300, energy +1060.5 bank 3608/3800, units 105
 12.17  [Playtest] finished legmex team 0 at 12.17 min
 12.23  [Playtest] finished legtide team 0 at 12.23 min
 12.50  [Playtest] finished legmex team 0 at 12.50 min
 12.62  [Playtest] finished legtide team 0 at 12.62 min
 12.64  [Playtest] finished legtide team 0 at 12.64 min
 12.76  [Playtest] finished leglht team 0 at 12.76 min
 12.85  [Playtest] finished legmex team 0 at 12.85 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +54.0 bank 26/2450, energy +1171.0 bank 4028/4100, units 114
 13.17  [Playtest] finished legmex team 0 at 13.17 min
 13.37  [Playtest] finished leganavalmex team 0 at 13.36 min
 13.43  [Playtest] finished legtide team 0 at 13.43 min
 13.58  [Playtest] finished legtide team 0 at 13.58 min
 13.78  [Playtest] finished legrad team 0 at 13.78 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +60.0 bank 0/3000, energy +1242.0 bank 3791/4300, units 114
 14.16  [Playtest] finished leganavalmex team 0 at 14.16 min
 14.34  [Playtest] finished leganavalmex team 0 at 14.34 min
 14.37  [Playtest] finished legtide team 0 at 14.37 min
 14.60  [Playtest] finished legnanotcplat team 0 at 14.60 min
 14.74  [Playtest] finished legmex team 0 at 14.74 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +74.0 bank 155/4150, energy +1565.0 bank 4712/5850, units 122
 15.11  [Playtest] finished legtl team 0 at 15.11 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +72.0 bank 671/4100, energy +1560.0 bank 4472/5800, units 133
 16.47  [Playtest] finished legmex team 0 at 16.47 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +70.0 bank 1915/4150, energy +1565.0 bank 4411/5850, units 140
 17.60  [Playtest] finished leganavalmex team 0 at 17.60 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +77.7 bank 2912/4700, energy +1565.0 bank 4753/5850, units 138
 18.42  [Playtest] finished legmex team 0 at 18.42 min
 18.45  [Playtest] finished legmex team 0 at 18.45 min
 18.60  [Playtest] finished legnanotcplat team 0 at 18.60 min
 18.62  [Playtest] finished legmex team 0 at 18.62 min
 18.69  [Playtest] finished leganavalmex team 0 at 18.69 min
 18.80  [Playtest] finished leganavalfusion team 0 at 18.80 min
 18.84  [Playtest] finished legfrad team 0 at 18.84 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +92.0 bank 921/5400, energy +2790.0 bank 8203/8400, units 146
 19.04  [Playtest] finished legtl team 0 at 19.04 min
 19.11  [Playtest] finished legtide team 0 at 19.11 min
 19.72  [Playtest] finished legmex team 0 at 19.72 min
 19.72  [Playtest] finished leganavalmex team 0 at 19.72 min
 19.97  [Playtest] finished legmex team 0 at 19.97 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +100.0 bank 195/6000, energy +2813.0 bank 8187/8450, units 154
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.00  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.00  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.40  [Playtest] finished legtl team 0 at 20.40 min
 20.47  [Playtest] finished leganavalmex team 0 at 20.47 min
 20.91  [Playtest] finished legfrad team 0 at 20.91 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +106.0 bank 469/6550, energy +2813.0 bank 8121/8450, units 156
 21.24  [Playtest] finished leganavalmex team 0 at 21.24 min
 21.26  [Playtest] finished legmex team 0 at 21.26 min
 21.57  [Playtest] finished leglht team 0 at 21.57 min
 21.97  [Playtest] finished leganavalmex team 0 at 21.97 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +169.9 bank 1040/7700, energy +2813.0 bank 8079/8450, units 179
 22.34  [Playtest] finished legtl team 0 at 22.34 min
 22.48  [Playtest] finished leganavalmex team 0 at 22.48 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +125.9 bank 1899/8250, energy +2813.0 bank 8047/8450, units 194
 23.15  [Playtest] finished legmex team 0 at 23.15 min
 23.21  [Playtest] finished leganavalmex team 0 at 23.21 min
 23.27  [Playtest] finished leganavalmex team 0 at 23.27 min
 23.52  [Playtest] finished legmex team 0 at 23.52 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +141.9 bank 4720/9450, energy +2813.0 bank 8076/8450, units 187
 24.26  [Playtest] finished legtl team 0 at 24.26 min
 24.30  [Playtest] finished leganavalmex team 0 at 24.30 min
 24.37  [Playtest] finished leganavalmex team 0 at 24.37 min
 24.63  [Playtest] finished legtl team 0 at 24.63 min
 24.66  [Playtest] finished legtl team 0 at 24.66 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +151.9 bank 7248/10500, energy +2873.0 bank 8236/8750, units 197
 25.37  [Playtest] finished leganavalmex team 0 at 25.37 min
 25.38  [Playtest] finished legtl team 0 at 25.38 min
 25.55  [Playtest] finished leganavalmex team 0 at 25.55 min
 25.71  [Playtest] finished legtl team 0 at 25.71 min
 25.79  [Playtest] finished legtl team 0 at 25.79 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +164.0 bank 8139/11600, energy +2873.0 bank 8332/8750, units 204
 26.30  [Playtest] finished leganavalfusion team 0 at 26.30 min
 26.35  [Playtest] finished legfrad team 0 at 26.35 min
 26.35  [Playtest] finished legnanotcplat team 0 at 26.35 min
 26.95  [Playtest] finished legnanotcplat team 0 at 26.95 min
 26.99  [Playtest] finished legfrad team 0 at 26.99 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +164.0 bank 8914/11600, energy +4153.0 bank 11385/11550, units 219
 27.13  [Playtest] finished legmex team 0 at 27.13 min
 27.18  [Playtest] finished legnanotcplat team 0 at 27.18 min
 27.23  [Playtest] finished legnanotcplat team 0 at 27.23 min
 27.46  [Playtest] finished legnanotcplat team 0 at 27.46 min
 27.56  [Playtest] finished legnanotcplat team 0 at 27.56 min
 27.62  [Playtest] finished legnanotcplat team 0 at 27.62 min
 27.68  [Playtest] finished legfrad team 0 at 27.68 min
 27.85  [Playtest] finished legnanotcplat team 0 at 27.85 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +164.0 bank 10287/11600, energy +4183.0 bank 11644/11850, units 245
 28.00  [Playtest] finished legfeconv team 0 at 28.00 min
 28.17  [Playtest] finished legtide team 0 at 28.17 min
 28.19  [Playtest] finished legfeconv team 0 at 28.19 min
 28.36  [Playtest] finished legfeconv team 0 at 28.36 min
 28.58  [Playtest] finished legfeconv team 0 at 28.58 min
 28.59  [Playtest] finished legfeconv team 0 at 28.59 min
 28.67  [Playtest] finished legfeconv team 0 at 28.67 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +170.0 bank 9937/11600, energy +4236.0 bank 10425/11900, units 273
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.01  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.33  [Playtest] finished legfeconv team 0 at 29.33 min
 29.43  [Playtest] finished leganavaleconv team 0 at 29.43 min
 29.50  [Playtest] finished legfeconv team 0 at 29.50 min
 29.87  [Playtest] finished legfeconv team 0 at 29.87 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +183.3 bank 10117/11600, energy +4296.0 bank 11041/12200, units 297
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(8444) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1208, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1208, 4072) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1208, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1208, 4008) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1208, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1208, 3944) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1272, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1272, 4072) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1272, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1272, 4008) facing 1 (id 6)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (1304, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1304, 4072) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1304, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1304, 4008) facing 1 (id 8)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 at (1288, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1288, 4104) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1288, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1288, 4040) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1288, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1288, 3976) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1352, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1352, 4104) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1352, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1352, 4040) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1352, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (1352, 3976) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (1321, 4037) facing 1, 9x13 cells: 54 of 117 held
  0.10  RESERVE: zone 1 at (704, 4592) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (704, 4592) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (992, 4592) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (488, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4664) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (488, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4600) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (488, 4536) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4536) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 5)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 at (584, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (584, 4664) facing 1 (id 6)
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (568, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (568, 4696) facing 1 (id 7)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 at (552, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4728) facing 1 (id 8)
  0.10  RESERVE: zone 10 at (552, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4664) facing 1 (id 9)
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 at (520, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4744) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (520, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (520, 4680) facing 1 (id 11)
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 at (488, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4760) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (488, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4696) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (488, 4632) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (488, 4632) facing 1 (id 14)
  0.10  RESERVE: zone 16 at (552, 4760) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4760) facing 1 (id 15)
  0.10  RESERVE: zone 17 at (552, 4696) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (552, 4696) facing 1 (id 16)
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 at (440, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4744) facing 1 (id 17)
  0.10  RESERVE: zone 19 at (440, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4680) facing 1 (id 18)
  0.10  RESERVE: zone 20 at (440, 4616) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (440, 4616) facing 1 (id 19)
  0.10  RESERVE: zone 21 at (504, 4744) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4744) facing 1 (id 20)
  0.10  RESERVE: zone 22 at (504, 4680) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (504, 4680) facing 1 (id 21)
  0.10  RESERVE: zone 18 released
  0.10  RESERVE: zone 19 released
  0.10  RESERVE: zone 20 released
  0.10  RESERVE: zone 21 released
  0.10  RESERVE: zone 22 released
  0.10  RESERVE: zone 23 at (408, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4728) facing 1 (id 22)
  0.10  RESERVE: zone 24 at (408, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4664) facing 1 (id 23)
  0.10  RESERVE: zone 25 at (408, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (408, 4600) facing 1 (id 24)
  0.10  RESERVE: zone 26 at (472, 4728) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4728) facing 1 (id 25)
  0.10  RESERVE: zone 27 at (472, 4664) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4664) facing 1 (id 26)
  0.10  RESERVE: zone 28 at (472, 4600) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (472, 4600) facing 1 (id 27)
  0.10  RESERVE: zone 29 at (444, 4660) facing 1, 9x13 cells: 63 of 117 held
  0.10  RESERVE: zone 1 at (12928, 4000) facing 3, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (12928, 4000) facing 3 (id 1)
  0.10  RESERVE: corridor 2 at (12640, 4000) facing 3, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (13160, 3944) facing 3, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (13160, 3944) facing 3 (id 2)
  0.10  RESERVE: zone 4 at (13160, 4008) facing 3, 3x3 cells: 9 of 9 held
```
