# Playtest report: PASS

- Verdict: **PASS** (reached 20 min)
- Game time reached: 20.0 min (frame 36014); wall 186 s
- DLL: build-theatres\d190-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T11:31:21
- Map: Tundra Continents v2.3.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T143120Z-8f9bbd8f\runs\20261004T143429Z-7353dd69\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.447082][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.6 min | `[t=00:00:49.305418][f=0001089] [SeaWatch] finished frame=1089 id=5644 def=armsy builder=21079` |
| expect `first-ship-exit` | seen at 2.4 min | `[t=00:00:56.419174][f=0004290] [SeaWatch] egress id=2183 yard=5644 seconds=9.7 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T143120Z-8f9bbd8f\runs\20261004T143429Z-7353dd69\screen_2026-10-04_14-32-32-080.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\tundra\20261004T143120Z-8f9bbd8f\runs\20261004T143429Z-7353dd69\screen_2026-10-04_14-33-00-703.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 20.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4100, 2100) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (5400, 800) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (6400, 800) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (7800, 1500) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (1504, 12000) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (1610, 10300) units 1
  0.00  [Playtest] frame 1 team 6 ally 1 side legion ai true dead false start (6700, 10600) units 1
  0.00  [Playtest] frame 1 team 7 ally 1 side armada ai true dead false start (8200, 10900) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (9000, 11400) units 1
  0.00  [Playtest] frame 1 team 9 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 10 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4100, 2100) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (5400, 800) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (6400, 800) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (7800, 1500) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (1504, 12000) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (1610, 10300) units 1
  0.05  [Playtest] frame 90 team 6 ally 1 side legion ai true dead false start (6700, 10600) units 1
  0.05  [Playtest] frame 90 team 7 ally 1 side armada ai true dead false start (8200, 10900) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (9000, 11400) units 1
  0.05  [Playtest] frame 90 team 9 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 10 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=4096,2096 facing=0
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(5326,791) factory=armsy landLocked=no spot=4 known=1/3
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(6399,801) factory=corsy landLocked=no spot=5 known=2/3
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(7823,1501) factory=legsy landLocked=no spot=6 known=3/3
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=4496,2096 facing=0
  0.13  [SEA][Layout] berth sea.berth.2 armasy at=4896,2096 facing=0
  0.15  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [Team][Roster] first mex 7153 at 4016,2016
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4100|2097|0|3|1|4016|2016
  0.17  [Team][Roster] team 2 first mex at 6384,720
  0.22  [Team][Roster] team 3 first mex at 7984,1504
  0.28  [Team][Roster] team 1 first mex at 5136,752
  0.60  [Playtest] finished armsy team 0 at 0.61 min
  0.98  [Playtest] finished armmex team 0 at 0.98 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 619/1200, energy +30.0 bank 23/1100, units 5
  1.45  [Playtest] finished armtide team 0 at 1.45 min
  1.82  [Playtest] finished armmex team 0 at 1.82 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 726/1250, energy +45.0 bank 79/1150, units 8
  2.09  [Playtest] finished armtide team 0 at 2.09 min
  2.26  [Playtest] finished armtide team 0 at 2.26 min
  2.41  [Playtest] finished armtide team 0 at 2.41 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 784/1250, energy +104.0 bank 513/1400, units 14
  3.02  [Playtest] finished armmex team 0 at 3.02 min
  3.16  [Playtest] finished armtide team 0 at 3.16 min
  3.35  [Playtest] finished armmex team 0 at 3.35 min
  3.36  [Playtest] finished armmex team 0 at 3.36 min
  3.54  [Playtest] finished armtide team 0 at 3.54 min
  3.90  [Playtest] finished armtide team 0 at 3.90 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +14.0 bank 721/1400, energy +149.0 bank 47/1550, units 23
  4.05  [Playtest] finished armtl team 0 at 4.05 min
  4.08  [Playtest] finished armmex team 0 at 4.07 min
  4.20  [Playtest] finished armfrad team 0 at 4.20 min
  4.25  [Playtest] finished armtide team 0 at 4.25 min
  4.45  [Playtest] finished armmex team 0 at 4.45 min
  4.56  [Playtest] finished armtide team 0 at 4.56 min
  4.77  [Playtest] finished armmex team 0 at 4.77 min
  4.98  [Playtest] finished armtide team 0 at 4.98 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +20.0 bank 602/1550, energy +186.5 bank 1684/1700, units 28
  5.00  [Playtest] target team 0 at (4100, 2100) from its start position
  5.00  [Playtest] camera requested (4100,2100) height=2200
  5.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
  5.02  [Playtest] screenshot at 5.0 min of team 0 at (4100, 2100)
  5.28  [Playtest] finished armmex team 0 at 5.28 min
  5.29  [Playtest] finished armtl team 0 at 5.29 min
  5.30  [Playtest] finished armtide team 0 at 5.30 min
  5.62  [Playtest] finished armtide team 0 at 5.62 min
  5.78  [Playtest] finished armmex team 0 at 5.78 min
  5.93  [Playtest] finished armtide team 0 at 5.93 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.0 bank 821/1650, energy +246.0 bank 1893/1900, units 37
  6.12  [Playtest] finished armmex team 0 at 6.12 min
  6.34  [Playtest] finished armtide team 0 at 6.34 min
  6.40  [Playtest] finished armtide team 0 at 6.40 min
  6.55  [Playtest] finished armmex team 0 at 6.55 min
  6.65  [Playtest] finished armtide team 0 at 6.65 min
  6.79  [Playtest] finished armtl team 0 at 6.79 min
  6.90  [Playtest] finished armmex team 0 at 6.90 min
  6.97  [Playtest] finished armtide team 0 at 6.97 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +30.0 bank 1000/1800, energy +305.5 bank 2132/2150, units 47
  7.13  [Playtest] finished armtide team 0 at 7.13 min
  7.20  [Playtest] finished armnanotcplat team 0 at 7.20 min
  7.23  [Playtest] finished armmex team 0 at 7.23 min
  7.29  [Playtest] finished armtide team 0 at 7.29 min
  7.50  [Playtest] finished armtide team 0 at 7.50 min
  7.55  [Playtest] finished armtide team 0 at 7.55 min
  7.61  [Playtest] finished armtide team 0 at 7.61 min
  7.72  [Playtest] finished armmex team 0 at 7.72 min
  7.82  [Playtest] finished armtide team 0 at 7.82 min
  7.86  [Playtest] finished armmex team 0 at 7.86 min
  7.87  [Playtest] finished armtide team 0 at 7.87 min
  7.94  [Playtest] finished armtide team 0 at 7.94 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +33.9 bank 438/1900, energy +433.0 bank 2492/2550, units 60
  8.08  [Playtest] finished armtl team 0 at 8.08 min
  8.19  [Playtest] finished armmex team 0 at 8.19 min
  8.21  [Playtest] finished armtide team 0 at 8.21 min
  8.22  [Playtest] finished armtide team 0 at 8.22 min
  8.25  [Playtest] finished armtide team 0 at 8.25 min
  8.51  [Playtest] finished armmex team 0 at 8.51 min
  8.53  [Playtest] finished armtide team 0 at 8.53 min
  8.54  [Playtest] finished armtide team 0 at 8.54 min
  8.64  [Playtest] finished armtide team 0 at 8.64 min
  8.86  [Playtest] finished armtide team 0 at 8.86 min
  8.92  [Playtest] finished armtide team 0 at 8.92 min
  8.95  [Playtest] finished armtide team 0 at 8.95 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +37.9 bank 524/2000, energy +575.0 bank 3031/3050, units 73
  9.07  [Playtest] finished armmex team 0 at 9.07 min
  9.18  [Playtest] finished armtide team 0 at 9.18 min
  9.24  [Playtest] finished armtide team 0 at 9.24 min
  9.27  [Playtest] finished armtl team 0 at 9.27 min
  9.38  [Playtest] finished armtide team 0 at 9.38 min
  9.38  [Playtest] finished armtide team 0 at 9.38 min
  9.38  [Playtest] finished armmex team 0 at 9.38 min
  9.50  [Playtest] finished armtide team 0 at 9.50 min
  9.55  [Playtest] finished armtide team 0 at 9.55 min
  9.69  [Playtest] finished armtide team 0 at 9.69 min
  9.81  [Playtest] finished armtide team 0 at 9.81 min
  9.91  [Playtest] finished armtide team 0 at 9.91 min
  9.94  [Playtest] finished armmex team 0 at 9.94 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +43.9 bank 653/2150, energy +710.0 bank 3475/3500, units 90
 10.00  [Playtest] camera requested (4100,2100) height=2200
 10.02  [Playtest] finished armtide team 0 at 10.02 min
 10.02  [Playtest] camera captured name=ta position=(4100,2100) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4100, 2100)
 10.13  [Playtest] finished armtide team 0 at 10.13 min
 10.15  [Playtest] finished armtide team 0 at 10.15 min
 10.26  [Playtest] finished armtide team 0 at 10.26 min
 10.29  [Playtest] finished armmex team 0 at 10.29 min
 10.30  [Playtest] finished armtl team 0 at 10.30 min
 10.32  [Playtest] finished armtide team 0 at 10.32 min
 10.45  [Playtest] finished armtide team 0 at 10.45 min
 10.53  [Playtest] finished armtide team 0 at 10.53 min
 10.62  [Playtest] finished armmex team 0 at 10.62 min
 10.65  [Playtest] finished armtide team 0 at 10.65 min
 10.70  [Playtest] finished armtide team 0 at 10.70 min
 10.77  [Playtest] finished armtide team 0 at 10.77 min
 10.85  [Playtest] finished armtide team 0 at 10.85 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +47.9 bank 933/2250, energy +875.0 bank 4050/4050, units 101
 11.32  [Playtest] finished armtide team 0 at 11.32 min
 11.34  [Playtest] finished armmex team 0 at 11.34 min
 11.46  [Playtest] finished armtl team 0 at 11.45 min
 11.47  [Playtest] finished armtide team 0 at 11.47 min
 11.61  [Playtest] finished armtide team 0 at 11.61 min
 11.67  [Playtest] finished armmex team 0 at 11.67 min
 11.71  [Playtest] finished armtide team 0 at 11.71 min
 11.77  [Playtest] finished armtl team 0 at 11.77 min
 11.81  [Playtest] finished armtide team 0 at 11.81 min
 11.90  [Playtest] finished armtide team 0 at 11.90 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +51.9 bank 2235/2350, energy +965.0 bank 4340/4350, units 110
 12.22  [Playtest] finished armtide team 0 at 12.22 min
 12.23  [Playtest] finished armtide team 0 at 12.23 min
 12.33  [Playtest] finished armfrad team 0 at 12.33 min
 12.45  [Playtest] finished armtide team 0 at 12.45 min
 12.77  [Playtest] finished armtl team 0 at 12.77 min
 12.99  [Playtest] finished armtide team 0 at 12.99 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +51.9 bank 1671/2350, energy +1010.0 bank 4533/4550, units 116
 13.01  [Playtest] finished armfrad team 0 at 13.01 min
 13.79  [Playtest] finished armasy team 0 at 13.79 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +51.9 bank 965/2550, energy +1025.0 bank 4685/4750, units 122
 14.22  [Playtest] finished armtl team 0 at 14.22 min
 14.24  [Playtest] finished armtide team 0 at 14.24 min
 14.31  [Playtest] finished armtide team 0 at 14.31 min
 14.51  [Playtest] finished armnanotcplat team 0 at 14.51 min
 14.60  [Playtest] finished armtide team 0 at 14.60 min
 14.85  [Playtest] finished armnanotcplat team 0 at 14.85 min
 14.91  [Playtest] finished armtide team 0 at 14.91 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +51.9 bank 90/2550, energy +1115.0 bank 5022/5100, units 130
 15.42  [Playtest] finished armtide team 0 at 15.42 min
 15.42  [Playtest] finished armtide team 0 at 15.42 min
 15.45  [Playtest] finished armuwmme team 0 at 15.45 min
 15.55  [Playtest] finished armtide team 0 at 15.56 min
 15.97  [Playtest] finished armtide team 0 at 15.97 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +57.9 bank 0/3100, energy +1205.0 bank 5435/5450, units 134
 16.43  [Playtest] finished armuwmme team 0 at 16.43 min
 16.64  [Playtest] finished armuwmme team 0 at 16.64 min
 16.66  [Playtest] finished armtide team 0 at 16.66 min
 16.69  [Playtest] finished armbats team 0 at 16.69 min
 16.80  [Playtest] finished armtide team 0 at 16.80 min
 16.94  [Playtest] finished armfrad team 0 at 16.94 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +69.9 bank 30/4200, energy +1235.0 bank 5465/5550, units 140
 17.25  [Playtest] finished armfmkr team 0 at 17.25 min
 17.39  [Playtest] finished armuwmme team 0 at 17.39 min
 17.45  [Playtest] finished armtide team 0 at 17.44 min
 17.48  [Playtest] finished armfmkr team 0 at 17.48 min
 17.64  [Playtest] finished armuwmme team 0 at 17.64 min
 17.67  [Playtest] finished armfmkr team 0 at 17.67 min
 17.95  [Playtest] finished armnanotcplat team 0 at 17.95 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +84.9 bank 950/5300, energy +1550.0 bank 6761/7100, units 151
 18.05  [Playtest] finished armnanotcplat team 0 at 18.05 min
 18.14  [Playtest] finished armnanotcplat team 0 at 18.14 min
 18.46  [Playtest] finished armuwmme team 0 at 18.46 min
 18.53  [Playtest] finished armmex team 0 at 18.53 min
 18.63  [Playtest] finished armfmkr team 0 at 18.63 min
 18.74  [Playtest] finished armuwmme team 0 at 18.74 min
 18.81  [Playtest] finished armfmkr team 0 at 18.81 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +95.8 bank 652/6450, energy +1550.0 bank 4484/7100, units 159
 19.15  [Playtest] finished armtide team 0 at 19.15 min
 19.29  [Playtest] finished armmship team 0 at 19.29 min
 19.30  [Playtest] finished armuwmme team 0 at 19.30 min
 19.37  [Playtest] finished armfmkr team 0 at 19.37 min
 19.43  [Playtest] finished armtide team 0 at 19.43 min
 19.57  [Playtest] finished armtide team 0 at 19.57 min
 19.79  [Playtest] finished armuwmme team 0 at 19.79 min
 19.82  [Playtest] finished armtl team 0 at 19.82 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +113.8 bank 87/7550, energy +1595.0 bank 6388/7250, units 164
 20.00  [Playtest] camera requested (4100,2100) height=2200
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(22971) at (5327, 792) walks to (5269, 780), 136 from the armmex site (5136, 752)
  0.09  EXP: approach: legcom(18714) at (7824, 1502) walks to (7847, 1502), 137 from the legmex site (7984, 1504)
  0.09  EXP: approach: corcom(365) at (9054, 11420) walks to (9370, 11501), 139 from the cormex site (9504, 11536)
  0.10  RESERVE: zone 1 at (4096, 2096) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (4096, 2096) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (4096, 2384) facing 0, 12x30 cells: 356 of 360 held
  0.10  RESERVE: zone 3 at (4072, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4072, 1976) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (4120, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4120, 1976) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (4168, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 1976) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (4216, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4216, 1976) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (4264, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4264, 1976) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (4072, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4072, 2024) facing 0 (id 7)
  0.10  RESERVE: zone 9 at (4120, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4120, 2024) facing 0 (id 8)
  0.10  RESERVE: zone 10 at (4168, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4168, 2024) facing 0 (id 9)
  0.10  RESERVE: zone 11 at (4216, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4216, 2024) facing 0 (id 10)
  0.10  RESERVE: zone 12 at (4264, 2024) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4264, 2024) facing 0 (id 11)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 released
  0.10  RESERVE: zone 11 released
  0.10  RESERVE: zone 12 released
  0.10  RESERVE: zone 13 at (3928, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3928, 1976) facing 0 (id 12)
  0.10  RESERVE: zone 13 released
  0.10  RESERVE: zone 14 at (3864, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3864, 1928) facing 0 (id 13)
  0.10  RESERVE: zone 15 at (3912, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3912, 1928) facing 0 (id 14)
  0.10  RESERVE: zone 16 at (3960, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3960, 1928) facing 0 (id 15)
  0.10  RESERVE: zone 17 at (4008, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4008, 1928) facing 0 (id 16)
  0.10  RESERVE: zone 18 at (4056, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4056, 1928) facing 0 (id 17)
  0.10  RESERVE: zone 19 at (3864, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3864, 1976) facing 0 (id 18)
  0.10  RESERVE: zone 20 at (3912, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3912, 1976) facing 0 (id 19)
  0.10  RESERVE: zone 21 at (3960, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3960, 1976) facing 0 (id 20)
  0.10  RESERVE: zone 14 released
  0.10  RESERVE: zone 15 released
  0.10  RESERVE: zone 16 released
  0.10  RESERVE: zone 17 released
  0.10  RESERVE: zone 18 released
  0.10  RESERVE: zone 19 released
  0.10  RESERVE: zone 20 released
  0.10  RESERVE: zone 21 released
  0.10  RESERVE: zone 22 at (3816, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3816, 1880) facing 0 (id 21)
  0.10  RESERVE: zone 23 at (3864, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3864, 1880) facing 0 (id 22)
  0.10  RESERVE: zone 24 at (3912, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3912, 1880) facing 0 (id 23)
  0.10  RESERVE: zone 25 at (3960, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3960, 1880) facing 0 (id 24)
  0.10  RESERVE: zone 26 at (4008, 1880) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4008, 1880) facing 0 (id 25)
  0.10  RESERVE: zone 27 at (3816, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3816, 1928) facing 0 (id 26)
  0.10  RESERVE: zone 28 at (3864, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3864, 1928) facing 0 (id 27)
  0.10  RESERVE: zone 29 at (3912, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3912, 1928) facing 0 (id 28)
  0.10  RESERVE: zone 30 at (3960, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3960, 1928) facing 0 (id 29)
  0.10  RESERVE: zone 31 at (4008, 1928) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (4008, 1928) facing 0 (id 30)
  0.10  RESERVE: zone 32 at (3816, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3816, 1976) facing 0 (id 31)
  0.10  RESERVE: zone 33 at (3864, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3864, 1976) facing 0 (id 32)
  0.10  RESERVE: zone 34 at (3912, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3912, 1976) facing 0 (id 33)
  0.10  RESERVE: zone 35 at (3960, 1976) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (3960, 1976) facing 0 (id 34)
  0.10  RESERVE: zone 22 released
  0.10  RESERVE: zone 23 released
  0.10  RESERVE: zone 24 released
  0.10  RESERVE: zone 25 released
  0.10  RESERVE: zone 26 released
  0.10  RESERVE: zone 27 released
  0.10  RESERVE: zone 28 released
  0.10  RESERVE: zone 29 released
  0.10  RESERVE: zone 30 released
  0.10  RESERVE: zone 31 released
  0.10  RESERVE: zone 32 released
  0.10  RESERVE: zone 33 released
  0.10  RESERVE: zone 34 released
  0.10  RESERVE: zone 35 released
  0.10  RESERVE: zone 1 at (7824, 1504) facing 0, 6x6 cells: 36 of 36 held
  0.10  RESERVE: legsy at (7824, 1504) facing 0 (id 1)
  0.10  RESERVE: corridor 2 at (7824, 1792) facing 0, 12x30 cells: 348 of 360 held
  0.10  RESERVE: zone 3 at (7800, 1384) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7800, 1384) facing 0 (id 2)
  0.10  RESERVE: zone 4 at (7848, 1384) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7848, 1384) facing 0 (id 3)
  0.10  RESERVE: zone 5 at (7896, 1384) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7896, 1384) facing 0 (id 4)
  0.10  RESERVE: zone 6 at (7944, 1384) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7944, 1384) facing 0 (id 5)
  0.10  RESERVE: zone 7 at (7992, 1384) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7992, 1384) facing 0 (id 6)
  0.10  RESERVE: zone 8 at (7800, 1432) facing 0, 3x3 cells: 9 of 9 held
  0.10  RESERVE: legnanotcplat at (7800, 1432) facing 0 (id 7)
```
