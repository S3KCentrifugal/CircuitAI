# Playtest report: PASS

- Verdict: **PASS** (reached 35 min)
- Game time reached: 35.1 min (frame 63097); wall 349 s
- DLL: build-theatres\d188-build-4\SkirmishAI.dll (4269e12be49092f4); AI BARbTest/test; staged 2026-10-04T01:06:16
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-support\glacial\20261004T040616Z-271010e4\runs\20261004T041208Z-7cc7f7dd\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:35.590989][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:54.070735][f=0001405] [SeaWatch] finished frame=1405 id=20718 def=armsy builder=12936` |
| expect `first-ship-exit` | seen at 2.5 min | `[t=00:01:01.080985][f=0004560] [SeaWatch] egress id=10555 yard=20718 seconds=14.4 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-support\glacial\20261004T040616Z-271010e4\runs\20261004T041208Z-7cc7f7dd\screen_2026-10-04_04-07-34-453.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-support\glacial\20261004T040616Z-271010e4\runs\20261004T041208Z-7cc7f7dd\screen_2026-10-04_04-08-02-156.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-support\glacial\20261004T040616Z-271010e4\runs\20261004T041208Z-7cc7f7dd\screen_2026-10-04_04-09-26-949.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\migration-support\glacial\20261004T040616Z-271010e4\runs\20261004T041208Z-7cc7f7dd\screen_2026-10-04_04-11-06-004.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 35.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.00  [Playtest] frame 1 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.00  [Playtest] frame 1 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.00  [Playtest] frame 1 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.00  [Playtest] frame 1 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (1430, 4000) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (700, 4600) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (1900, 5800) units 1
  0.05  [Playtest] frame 90 team 3 ally 1 side legion ai true dead false start (12925, 4000) units 1
  0.05  [Playtest] frame 90 team 4 ally 1 side armada ai true dead false start (13700, 4600) units 1
  0.05  [Playtest] frame 90 team 5 ally 1 side cortex ai true dead false start (12618, 5800) units 1
  0.05  [Playtest] frame 90 team 6 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 7 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.10  [SEA][Layout] berth sea.berth.0 armsy at=1424,4000 facing=1
  0.10  [Team][Roster] Announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=SEA side=armada start=(700,4597) factory=armsy landLocked=no spot=5 known=1/2
  0.10  [Team][Roster] Team 2 (AI 2): role=SEA side=cortex start=(1899,5801) factory=corsy landLocked=no spot=6 known=2/2
  0.12  [SEA][Layout] berth sea.berth.1 armasy at=1424,3600 facing=1
  0.16  [Playtest] finished armmex team 0 at 0.16 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 22562 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.17  [Team][Roster] team 1 first mex at 704,4448
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.78  [Playtest] finished armsy team 0 at 0.78 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 709/1200, energy +30.0 bank 1/1100, units 6
  1.07  [Playtest] finished armmex team 0 at 1.07 min
  1.50  [Playtest] finished armtide team 0 at 1.50 min
  1.68  [Playtest] finished armtide team 0 at 1.68 min
  1.83  [Playtest] finished armtide team 0 at 1.83 min
  1.97  [Playtest] finished armtide team 0 at 1.97 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 767/1250, energy +129.0 bank 288/1350, units 11
  2.25  [Playtest] finished armmex team 0 at 2.25 min
  2.64  [Playtest] finished armtide team 0 at 2.64 min
  2.91  [Playtest] finished armfrad team 0 at 2.91 min
  2.94  [Playtest] finished armtide team 0 at 2.94 min
  2.98  [Playtest] finished armmex team 0 at 2.98 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 369/1350, energy +196.0 bank 740/1600, units 19
  3.18  [Playtest] finished armmex team 0 at 3.18 min
  3.38  [Playtest] finished armmex team 0 at 3.38 min
  3.38  [Playtest] finished armtide team 0 at 3.38 min
  3.39  [Playtest] finished armtide team 0 at 3.39 min
  3.46  [Playtest] finished armtide team 0 at 3.46 min
  3.56  [Playtest] finished armmex team 0 at 3.56 min
  3.69  [Playtest] finished armtide team 0 at 3.69 min
  3.77  [Playtest] finished armtide team 0 at 3.77 min
  3.90  [Playtest] finished armtide team 0 at 3.90 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +18.0 bank 15/1500, energy +348.0 bank 1985/2000, units 34
  4.00  [Playtest] finished armtide team 0 at 4.00 min
  4.06  [Playtest] finished armmex team 0 at 4.06 min
  4.25  [Playtest] finished armtide team 0 at 4.25 min
  4.28  [Playtest] finished armmex team 0 at 4.28 min
  4.39  [Playtest] finished armtide team 0 at 4.39 min
  4.42  [Playtest] finished armtide team 0 at 4.42 min
  4.46  [Playtest] finished armtide team 0 at 4.46 min
  4.47  [Playtest] finished armmex team 0 at 4.47 min
  4.50  [Playtest] finished armtide team 0 at 4.50 min
  4.66  [Playtest] finished armmex team 0 at 4.66 min
  4.92  [Playtest] finished armtide team 0 at 4.92 min
  4.94  [Playtest] finished armtide team 0 at 4.94 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +26.0 bank 111/1700, energy +532.0 bank 2384/2400, units 49
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.06  [Playtest] finished armfmkr team 0 at 5.06 min
  5.07  [Playtest] finished armtide team 0 at 5.07 min
  5.10  [Playtest] finished armtide team 0 at 5.10 min
  5.24  [Playtest] finished armmex team 0 at 5.24 min
  5.27  [Playtest] finished armtide team 0 at 5.27 min
  5.29  [Playtest] finished armfmkr team 0 at 5.29 min
  5.44  [Playtest] finished armfmkr team 0 at 5.44 min
  5.47  [Playtest] finished armmex team 0 at 5.47 min
  5.49  [Playtest] finished armtide team 0 at 5.49 min
  5.53  [Playtest] finished armfmkr team 0 at 5.53 min
  5.59  [Playtest] finished armtide team 0 at 5.59 min
  5.61  [Playtest] finished armtide team 0 at 5.61 min
  5.66  [Playtest] finished armfmkr team 0 at 5.66 min
  5.68  [Playtest] finished armmex team 0 at 5.68 min
  5.83  [Playtest] finished armtide team 0 at 5.83 min
  5.87  [Playtest] finished armtide team 0 at 5.87 min
  5.88  [Playtest] finished armmex team 0 at 5.88 min
  5.95  [Playtest] finished armtide team 0 at 5.95 min
  5.98  [Playtest] finished armtide team 0 at 5.98 min
  5.99  [Playtest] finished armfmkr team 0 at 5.99 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +39.0 bank 323/1900, energy +739.0 bank 2815/2900, units 67
  6.13  [Playtest] finished armtide team 0 at 6.13 min
  6.29  [Playtest] finished armtide team 0 at 6.30 min
  6.36  [Playtest] finished armtide team 0 at 6.36 min
  6.38  [Playtest] finished armmex team 0 at 6.38 min
  6.45  [Playtest] finished armtide team 0 at 6.45 min
  6.47  [Playtest] finished armtide team 0 at 6.47 min
  6.61  [Playtest] finished armmex team 0 at 6.61 min
  6.73  [Playtest] finished armnanotcplat team 0 at 6.73 min
  6.74  [Playtest] finished armtide team 0 at 6.74 min
  6.80  [Playtest] finished armllt team 0 at 6.80 min
  6.92  [Playtest] finished armnanotcplat team 0 at 6.92 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +44.0 bank 725/2000, energy +900.0 bank 3063/3200, units 81
  7.14  [Playtest] finished armtide team 0 at 7.14 min
  7.24  [Playtest] finished armtide team 0 at 7.24 min
  7.34  [Playtest] finished armfmkr team 0 at 7.34 min
  7.34  [Playtest] finished armllt team 0 at 7.34 min
  7.45  [Playtest] finished armtide team 0 at 7.45 min
  7.55  [Playtest] finished armtide team 0 at 7.55 min
  7.56  [Playtest] finished armtide team 0 at 7.56 min
  7.57  [Playtest] finished armfmkr team 0 at 7.57 min
  7.67  [Playtest] finished armfmkr team 0 at 7.67 min
  7.70  [Playtest] finished armtide team 0 at 7.70 min
  7.82  [Playtest] finished armfmkr team 0 at 7.82 min
  7.83  [Playtest] finished armmex team 0 at 7.83 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +50.0 bank 534/2050, energy +1038.0 bank 2816/3500, units 98
  8.07  [Playtest] finished armfmkr team 0 at 8.07 min
  8.07  [Playtest] finished armmex team 0 at 8.07 min
  8.23  [Playtest] finished armfmkr team 0 at 8.23 min
  8.27  [Playtest] finished armtide team 0 at 8.27 min
  8.34  [Playtest] finished armtide team 0 at 8.34 min
  8.68  [Playtest] finished armtide team 0 at 8.68 min
  8.69  [Playtest] finished armrad team 0 at 8.69 min
  8.70  [Playtest] finished armtide team 0 at 8.70 min
  8.77  [Playtest] finished armtide team 0 at 8.77 min
  8.99  [Playtest] finished armmex team 0 at 8.99 min
  9.00  [Playtest] finished armtide team 0 at 9.00 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +53.0 bank 832/2150, energy +1153.0 bank 3230/3800, units 111
  9.38  [Playtest] finished armtide team 0 at 9.38 min
  9.51  [Playtest] finished armtide team 0 at 9.51 min
  9.55  [Playtest] finished armtl team 0 at 9.55 min
  9.58  [Playtest] finished armrad team 0 at 9.58 min
  9.71  [Playtest] finished armtide team 0 at 9.71 min
  9.83  [Playtest] finished armllt team 0 at 9.83 min
  9.83  [Playtest] finished armmex team 0 at 9.83 min
  9.96  [Playtest] finished armfrad team 0 at 9.96 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +58.0 bank 104/2200, energy +1245.0 bank 3530/3950, units 118
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.02  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.46  [Playtest] finished armasy team 0 at 10.46 min
 10.70  [Playtest] finished armmex team 0 at 10.70 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +56.4 bank 23/2450, energy +1245.0 bank 3450/4150, units 119
 11.33  [Playtest] finished armfrad team 0 at 11.33 min
 11.36  [Playtest] finished armllt team 0 at 11.36 min
 11.90  [Playtest] finished armuwmme team 0 at 11.90 min
 11.97  [Playtest] finished armmex team 0 at 11.97 min
 11.99  [Playtest] finished armmex team 0 at 11.99 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +61.4 bank 230/3100, energy +1305.0 bank 3604/4450, units 128
 12.04  [Playtest] finished armmex team 0 at 12.04 min
 12.40  [Playtest] finished armmex team 0 at 12.40 min
 12.51  [Playtest] finished armnanotcplat team 0 at 12.51 min
 12.65  [Playtest] finished armuwmme team 0 at 12.65 min
 12.72  [Playtest] finished armuwmme team 0 at 12.72 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +80.8 bank 421/4250, energy +1298.0 bank 3420/4400, units 124
 13.35  [Playtest] finished armtide team 0 at 13.35 min
 13.87  [Playtest] finished armnanotcplat team 0 at 13.87 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +72.0 bank 464/4250, energy +1328.0 bank 3219/4450, units 126
 14.09  [Playtest] finished armmex team 0 at 14.09 min
 14.71  [Playtest] finished armnanotcplat team 0 at 14.72 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +82.4 bank 40/4300, energy +1328.0 bank 3653/4500, units 132
 15.52  [Playtest] finished armuwfus team 0 at 15.52 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +84.0 bank 227/4250, energy +2528.0 bank 6926/7000, units 132
 16.12  [Playtest] finished armfmkr team 0 at 16.12 min
 16.28  [Playtest] finished armfmkr team 0 at 16.28 min
 16.37  [Playtest] finished armnanotcplat team 0 at 16.37 min
 16.64  [Playtest] finished armfmkr team 0 at 16.64 min
 16.89  [Playtest] finished armnanotcplat team 0 at 16.89 min
 16.94  [Playtest] finished armfmkr team 0 at 16.94 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +88.0 bank 846/4250, energy +2528.0 bank 6686/7000, units 138
 17.45  [Playtest] finished armtide team 0 at 17.44 min
 17.95  [Playtest] finished armfmkr team 0 at 17.95 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +89.0 bank 42/4250, energy +2544.0 bank 6637/7000, units 144
 18.20  [Playtest] finished armfmkr team 0 at 18.20 min
 18.55  [Playtest] finished armmex team 0 at 18.55 min
 18.70  [Playtest] finished armmex team 0 at 18.70 min
 18.86  [Playtest] finished armfmkr team 0 at 18.86 min
 18.91  [Playtest] finished armfmkr team 0 at 18.91 min
 18.92  [Playtest] finished armmex team 0 at 18.92 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +98.0 bank 45/4400, energy +2532.5 bank 6548/7000, units 149
 19.52  [Playtest] finished armuwfus team 0 at 19.51 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +98.0 bank 182/4400, energy +3751.0 bank 9335/9550, units 149
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.11  [Playtest] finished armfmkr team 0 at 20.11 min
 20.44  [Playtest] finished armmex team 0 at 20.44 min
 20.91  [Playtest] finished armfmkr team 0 at 20.91 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +96.0 bank 135/4300, energy +3751.0 bank 9071/9550, units 153
 21.04  [Playtest] finished armfmkr team 0 at 21.03 min
 21.28  [Playtest] finished armuwmmm team 0 at 21.28 min
 21.34  [Playtest] finished armfmkr team 0 at 21.34 min
 21.38  [Playtest] finished armuwmme team 0 at 21.38 min
 21.77  [Playtest] finished armnanotcplat team 0 at 21.77 min
 21.93  [Playtest] finished armfmkr team 0 at 21.93 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +115.3 bank 850/4850, energy +3744.0 bank 8680/9500, units 158
 22.10  [Playtest] finished armuwmme team 0 at 22.10 min
 22.14  [Playtest] finished armfmkr team 0 at 22.14 min
 22.64  [Playtest] finished armatl team 0 at 22.64 min
 22.67  [Playtest] finished armmship team 0 at 22.67 min
 22.67  [Playtest] finished armmex team 0 at 22.67 min
 22.75  [Playtest] finished armnanotcplat team 0 at 22.75 min
 22.84  [Playtest] finished armnanotcplat team 0 at 22.84 min
 22.98  [Playtest] finished armmex team 0 at 22.98 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +120.4 bank 54/5400, energy +3744.0 bank 8623/9500, units 167
 23.13  [Playtest] finished armmship team 0 at 23.13 min
 23.17  [Playtest] finished armfmkr team 0 at 23.17 min
 23.35  [Playtest] finished armfmkr team 0 at 23.35 min
 23.43  [Playtest] finished armfmkr team 0 at 23.43 min
 23.54  [Playtest] finished armmship team 0 at 23.54 min
 23.71  [Playtest] finished armtl team 0 at 23.71 min
 23.82  [Playtest] finished armmex team 0 at 23.82 min
 23.94  [Playtest] finished armmship team 0 at 23.94 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +127.4 bank 160/5450, energy +3751.0 bank 8037/9550, units 176
 24.15  [Playtest] finished armmex team 0 at 24.15 min
 24.28  [Playtest] finished armmship team 0 at 24.28 min
 24.42  [Playtest] finished armfrad team 0 at 24.42 min
 24.44  [Playtest] finished armuwmmm team 0 at 24.44 min
 24.68  [Playtest] finished armuwmme team 0 at 24.68 min
 24.69  [Playtest] finished armfmkr team 0 at 24.69 min
 24.96  [Playtest] finished armmex team 0 at 24.96 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +136.9 bank 65/6100, energy +4051.0 bank 9455/11050, units 187
 25.30  [Playtest] finished armmex team 0 at 25.30 min
 25.36  [Playtest] finished armfrad team 0 at 25.36 min
 25.49  [Playtest] finished armmex team 0 at 25.49 min
 25.65  [Playtest] finished armuwmme team 0 at 25.65 min
 25.95  [Playtest] finished armmex team 0 at 25.95 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +145.1 bank 79/6750, energy +4051.0 bank 9431/11050, units 191
 26.33  [Playtest] finished armtl team 0 at 26.33 min
 26.49  [Playtest] finished armtl team 0 at 26.49 min
 26.78  [Playtest] finished armtl team 0 at 26.78 min
 26.86  [Playtest] finished armtl team 0 at 26.86 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +177.3 bank 165/6750, energy +4051.0 bank 9035/11050, units 198
 27.02  [Playtest] finished armtl team 0 at 27.02 min
 27.12  [Playtest] finished armfrad team 0 at 27.12 min
 27.13  [Playtest] finished armuwmme team 0 at 27.13 min
 27.80  [Playtest] finished armepoch team 0 at 27.80 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +212.1 bank 2091/7300, energy +4051.0 bank 9373/11050, units 193
 28.61  [Playtest] finished armmex team 0 at 28.60 min
 28.94  [Playtest] finished armnanotcplat team 0 at 28.94 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +150.9 bank 6023/7350, energy +4051.0 bank 9298/11050, units 199
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.02  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.40  [Playtest] finished armmex team 0 at 29.40 min
 29.67  [Playtest] finished armmex team 0 at 29.67 min
 29.78  [Playtest] finished armmex team 0 at 29.78 min
 29.97  [Playtest] finished armfrad team 0 at 29.97 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +160.3 bank 6661/7500, energy +4081.0 bank 9509/11200, units 213
 30.08  [Playtest] finished armtl team 0 at 30.08 min
 30.22  [Playtest] finished armuwfus team 0 at 30.22 min
 30.25  [Playtest] finished armtl team 0 at 30.25 min
 30.48  [Playtest] finished armbats team 0 at 30.48 min
 31.00  [Playtest] eco team 0 at 31.0 min: metal +170.7 bank 5981/7450, energy +5311.0 bank 13095/13850, units 221
 31.25  [Playtest] finished armfmkr team 0 at 31.25 min
 31.29  [Playtest] finished armbats team 0 at 31.29 min
 32.00  [Playtest] eco team 0 at 32.0 min: metal +171.7 bank 7428/7450, energy +5341.0 bank 13130/14000, units 230
 32.24  [Playtest] finished armuwfus team 0 at 32.24 min
 32.95  [Playtest] finished armuwmmm team 0 at 32.95 min
 32.99  [Playtest] finished armuwmme team 0 at 32.99 min
 33.00  [Playtest] eco team 0 at 33.0 min: metal +182.1 bank 7484/8000, energy +6661.0 bank 15738/17100, units 245
 33.18  [Playtest] finished armfmkr team 0 at 33.18 min
 33.49  [Playtest] finished armuwmmm team 0 at 33.49 min
 33.52  [Playtest] finished armfmkr team 0 at 33.52 min
 33.68  [Playtest] finished armuwmmm team 0 at 33.68 min
 33.71  [Playtest] finished armuwmmm team 0 at 33.71 min
 33.84  [Playtest] finished armuwmme team 0 at 33.84 min
 33.96  [Playtest] finished armnanotcplat team 0 at 33.96 min
 33.99  [Playtest] finished armuwmmm team 0 at 33.99 min
 34.00  [Playtest] eco team 0 at 34.0 min: metal +194.5 bank 8485/8550, energy +6691.0 bank 15006/17250, units 258
 34.11  [Playtest] finished armnanotcplat team 0 at 34.11 min
 34.48  [Playtest] finished armuwmmm team 0 at 34.48 min
 34.58  [Playtest] finished armnanotcplat team 0 at 34.58 min
 34.65  [Playtest] finished armtide team 0 at 34.65 min
 34.75  [Playtest] finished armbats team 0 at 34.75 min
 34.81  [Playtest] finished armnanotcplat team 0 at 34.81 min
 34.85  [Playtest] finished armnanotcplat team 0 at 34.85 min
 34.91  [Playtest] finished armnanotcplat team 0 at 34.91 min
 34.95  [Playtest] finished armuwmmm team 0 at 34.95 min
 35.00  [Playtest] eco team 0 at 35.0 min: metal +212.6 bank 8365/8550, energy +6714.0 bank 14634/17300, units 280
 35.02  [Playtest] finished armnanotcplat team 0 at 35.02 min
 35.02  [Playtest] finished armuwmme team 0 at 35.02 min
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(27855) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
  0.10  RESERVE: zone 1 at (1424, 4000) facing 1, 6x6 cells: 36 of 36 held
  0.10  RESERVE: armsy at (1424, 4000) facing 1 (id 1)
  0.10  RESERVE: corridor 2 at (1712, 4000) facing 1, 30x12 cells: 344 of 360 held
  0.10  RESERVE: zone 3 at (1208, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4072) facing 1 (id 2)
  0.10  RESERVE: zone 4 at (1208, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 4008) facing 1 (id 3)
  0.10  RESERVE: zone 5 at (1208, 3944) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1208, 3944) facing 1 (id 4)
  0.10  RESERVE: zone 6 at (1272, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4072) facing 1 (id 5)
  0.10  RESERVE: zone 7 at (1272, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1272, 4008) facing 1 (id 6)
  0.10  RESERVE: zone 3 released
  0.10  RESERVE: zone 4 released
  0.10  RESERVE: zone 5 released
  0.10  RESERVE: zone 6 released
  0.10  RESERVE: zone 7 released
  0.10  RESERVE: zone 8 at (1304, 4072) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4072) facing 1 (id 7)
  0.10  RESERVE: zone 9 at (1304, 4008) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1304, 4008) facing 1 (id 8)
  0.10  RESERVE: zone 8 released
  0.10  RESERVE: zone 9 released
  0.10  RESERVE: zone 10 at (1288, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4104) facing 1 (id 9)
  0.10  RESERVE: zone 11 at (1288, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 4040) facing 1 (id 10)
  0.10  RESERVE: zone 12 at (1288, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1288, 3976) facing 1 (id 11)
  0.10  RESERVE: zone 13 at (1352, 4104) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4104) facing 1 (id 12)
  0.10  RESERVE: zone 14 at (1352, 4040) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 4040) facing 1 (id 13)
  0.10  RESERVE: zone 15 at (1352, 3976) facing 1, 3x3 cells: 9 of 9 held
  0.10  RESERVE: armnanotcplat at (1352, 3976) facing 1 (id 14)
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
