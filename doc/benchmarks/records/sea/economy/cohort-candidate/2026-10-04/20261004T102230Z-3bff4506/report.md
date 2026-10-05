# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54137); wall 227 s
- DLL: build-theatres\d189-build-5\SkirmishAI.dll (1b875078bc2aa763); AI BARbTest/test; staged 2026-10-04T07:18:40
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T101840Z-7f158cb6\runs\20261004T102230Z-3bff4506\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:34.211153][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.3 min | `[t=00:00:48.174035][f=0002255] [SeaWatch] finished frame=2255 id=13026 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 5.2 min | `[t=00:01:05.312593][f=0009390] [SeaWatch] egress id=23873 yard=13026 seconds=44.5 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T101840Z-7f158cb6\runs\20261004T102230Z-3bff4506\screen_2026-10-04_10-19-48-823.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T101840Z-7f158cb6\runs\20261004T102230Z-3bff4506\screen_2026-10-04_10-20-13-768.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T101840Z-7f158cb6\runs\20261004T102230Z-3bff4506\screen_2026-10-04_10-21-13-244.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-candidate\supreme\20261004T101840Z-7f158cb6\runs\20261004T102230Z-3bff4506\screen_2026-10-04_10-22-21-148.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 15
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.23  [SEA][Layout] berth sea.berth.0 armsy at=5840,10640 facing=2
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.28  [Team][Roster] first mex 6887 at 4608,11072
  0.28  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4774|11078|0|7|1|4608|11072
  0.49  [Playtest] finished armmex team 0 at 0.49 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1060/1100, energy +30.0 bank 924/1000, units 4
  1.25  [Playtest] finished armsy team 0 at 1.25 min
  1.85  [Playtest] finished armmex team 0 at 1.85 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.9 bank 889/1250, energy +30.0 bank 99/1100, units 6
  2.78  [Playtest] finished armmex team 0 at 2.78 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +11.2 bank 1241/1300, energy +30.0 bank 52/1100, units 7
  3.97  [Playtest] finished armllt team 0 at 3.97 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +3.2 bank 1276/1300, energy +37.0 bank 1/1150, units 9
  4.86  [Playtest] finished armtide team 0 at 4.86 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +11.2 bank 1282/1300, energy +65.0 bank 1/1250, units 13
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.11  [Playtest] finished armmex team 0 at 5.11 min
  5.15  [Playtest] finished armtide team 0 at 5.15 min
  5.62  [Playtest] finished armtide team 0 at 5.62 min
  5.68  [Playtest] finished armrad team 0 at 5.68 min
  5.78  [Playtest] finished armmex team 0 at 5.78 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +15.5 bank 1280/1400, energy +107.0 bank 142/1350, units 20
  6.10  [Playtest] finished armtide team 0 at 6.10 min
  6.30  [Playtest] finished armtl team 0 at 6.30 min
  6.40  [Playtest] finished armtide team 0 at 6.40 min
  6.65  [Playtest] finished armmex team 0 at 6.65 min
  6.71  [Playtest] finished armtide team 0 at 6.71 min
  6.80  [Playtest] finished armmex team 0 at 6.80 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +19.9 bank 1190/1500, energy +170.0 bank 89/1500, units 26
  7.31  [Playtest] finished armwin team 0 at 7.31 min
  7.31  [Playtest] finished armtl team 0 at 7.31 min
  7.39  [Playtest] finished armtl team 0 at 7.39 min
  7.69  [Playtest] finished armfrad team 0 at 7.69 min
  7.84  [Playtest] finished armllt team 0 at 7.84 min
  7.99  [Playtest] finished armmex team 0 at 7.99 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +19.9 bank 1336/1550, energy +177.9 bank 953/1500, units 31
  8.19  [Playtest] finished armwin team 0 at 8.19 min
  8.59  [Playtest] finished armtl team 0 at 8.59 min
  8.64  [Playtest] finished armrad team 0 at 8.64 min
  8.84  [Playtest] finished armtide team 0 at 8.84 min
  8.98  [Playtest] finished armmex team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +22.2 bank 1557/1600, energy +235.6 bank 1565/1601, units 39
  9.16  [Playtest] finished armtide team 0 at 9.16 min
  9.47  [Playtest] finished armtide team 0 at 9.47 min
  9.77  [Playtest] finished armtide team 0 at 9.77 min
  9.87  [Playtest] finished armtl team 0 at 9.87 min
  9.88  [Playtest] finished armmex team 0 at 9.88 min
  9.90  [Playtest] finished armtide team 0 at 9.90 min
  9.96  [Playtest] finished armrad team 0 at 9.96 min
  9.98  [Playtest] finished armtide team 0 at 9.98 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +26.8 bank 1453/1650, energy +330.4 bank 1893/1901, units 48
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.34  [Playtest] finished armtide team 0 at 10.34 min
 10.38  [Playtest] finished armmex team 0 at 10.38 min
 10.39  [Playtest] finished armtide team 0 at 10.39 min
 10.71  [Playtest] finished armtide team 0 at 10.71 min
 10.78  [Playtest] finished armmex team 0 at 10.78 min
 10.84  [Playtest] finished armnanotcplat team 0 at 10.84 min
 10.85  [Playtest] finished armmex team 0 at 10.85 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +33.4 bank 1508/1800, energy +418.0 bank 2034/2101, units 61
 11.03  [Playtest] finished armnanotcplat team 0 at 11.03 min
 11.11  [Playtest] finished armllt team 0 at 11.11 min
 11.14  [Playtest] finished armtide team 0 at 11.14 min
 11.22  [Playtest] finished armtide team 0 at 11.22 min
 11.23  [Playtest] finished armtide team 0 at 11.23 min
 11.36  [Playtest] finished armtl team 0 at 11.36 min
 11.50  [Playtest] finished armmex team 0 at 11.50 min
 11.54  [Playtest] finished armtide team 0 at 11.54 min
 11.57  [Playtest] finished armtide team 0 at 11.57 min
 11.60  [Playtest] finished armtide team 0 at 11.60 min
 11.73  [Playtest] finished armtide team 0 at 11.73 min
 11.77  [Playtest] finished armtide team 0 at 11.77 min
 11.80  [Playtest] finished armmex team 0 at 11.80 min
 11.82  [Playtest] finished armtide team 0 at 11.82 min
 11.96  [Playtest] finished armllt team 0 at 11.96 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +38.0 bank 480/1900, energy +603.5 bank 2569/2601, units 78
 12.05  [Playtest] finished armtide team 0 at 12.06 min
 12.10  [Playtest] finished armrad team 0 at 12.10 min
 12.21  [Playtest] finished armmex team 0 at 12.21 min
 12.27  [Playtest] finished armfrad team 0 at 12.27 min
 12.31  [Playtest] finished armtide team 0 at 12.31 min
 12.34  [Playtest] finished armfmkr team 0 at 12.34 min
 12.37  [Playtest] finished armtide team 0 at 12.37 min
 12.48  [Playtest] finished armtide team 0 at 12.48 min
 12.58  [Playtest] finished armmex team 0 at 12.58 min
 12.69  [Playtest] finished armtide team 0 at 12.69 min
 12.72  [Playtest] finished armfmkr team 0 at 12.72 min
 12.75  [Playtest] finished armfrad team 0 at 12.75 min
 12.79  [Playtest] finished armtide team 0 at 12.79 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +44.6 bank 21/2000, energy +723.3 bank 2830/2901, units 97
 13.00  [Playtest] finished armtide team 0 at 13.00 min
 13.10  [Playtest] finished armfmkr team 0 at 13.10 min
 13.16  [Playtest] finished armllt team 0 at 13.16 min
 13.24  [Playtest] finished armtl team 0 at 13.24 min
 13.29  [Playtest] finished armtide team 0 at 13.29 min
 13.31  [Playtest] finished armtide team 0 at 13.31 min
 13.32  [Playtest] finished armfmkr team 0 at 13.32 min
 13.61  [Playtest] finished armtide team 0 at 13.61 min
 13.69  [Playtest] finished armfmkr team 0 at 13.69 min
 13.78  [Playtest] finished armllt team 0 at 13.78 min
 13.81  [Playtest] finished armtide team 0 at 13.81 min
 13.93  [Playtest] finished armtide team 0 at 13.93 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +47.6 bank 739/2000, energy +864.2 bank 3121/3201, units 108
 14.07  [Playtest] finished armfmkr team 0 at 14.07 min
 14.08  [Playtest] finished armfmkr team 0 at 14.08 min
 14.24  [Playtest] finished armfmkr team 0 at 14.24 min
 14.35  [Playtest] finished armfmkr team 0 at 14.35 min
 14.36  [Playtest] finished armtide team 0 at 14.36 min
 14.58  [Playtest] finished armtide team 0 at 14.58 min
 14.68  [Playtest] finished armtide team 0 at 14.68 min
 14.72  [Playtest] finished armfmkr team 0 at 14.72 min
 14.73  [Playtest] finished armllt team 0 at 14.73 min
 14.79  [Playtest] finished armfmkr team 0 at 14.79 min
 14.89  [Playtest] finished armtide team 0 at 14.89 min
 14.92  [Playtest] finished armrad team 0 at 14.92 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +53.6 bank 1999/2000, energy +938.6 bank 3154/3401, units 120
 15.00  [Playtest] finished armtide team 0 at 15.00 min
 15.18  [Playtest] finished armfmkr team 0 at 15.18 min
 15.41  [Playtest] finished armtide team 0 at 15.41 min
 15.53  [Playtest] finished armfrad team 0 at 15.53 min
 15.72  [Playtest] finished armtide team 0 at 15.72 min
 15.75  [Playtest] finished armtl team 0 at 15.75 min
 15.82  [Playtest] finished armfmkr team 0 at 15.82 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +54.8 bank 1999/2000, energy +984.9 bank 3089/3551, units 128
 16.04  [Playtest] finished armtide team 0 at 16.04 min
 16.15  [Playtest] finished armfmkr team 0 at 16.15 min
 16.21  [Playtest] finished armfmkr team 0 at 16.21 min
 16.24  [Playtest] finished armtide team 0 at 16.24 min
 16.33  [Playtest] finished armtide team 0 at 16.33 min
 16.36  [Playtest] finished armtide team 0 at 16.36 min
 16.68  [Playtest] finished armtide team 0 at 16.68 min
 16.84  [Playtest] finished armtide team 0 at 16.84 min
 16.88  [Playtest] finished armfmkr team 0 at 16.88 min
 16.97  [Playtest] finished armfmkr team 0 at 16.97 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +56.7 bank 1998/2000, energy +1136.8 bank 3397/3851, units 139
 17.05  [Playtest] finished armtide team 0 at 17.05 min
 17.08  [Playtest] finished armtide team 0 at 17.08 min
 17.14  [Playtest] finished armtide team 0 at 17.14 min
 17.23  [Playtest] finished armtide team 0 at 17.23 min
 17.28  [Playtest] finished armtide team 0 at 17.28 min
 17.40  [Playtest] finished armfmkr team 0 at 17.40 min
 17.42  [Playtest] finished armtide team 0 at 17.42 min
 17.77  [Playtest] finished armtide team 0 at 17.77 min
 17.78  [Playtest] finished armtide team 0 at 17.78 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +60.1 bank 1999/2000, energy +1288.6 bank 3800/4251, units 145
 18.19  [Playtest] finished armtide team 0 at 18.19 min
 18.22  [Playtest] finished armtide team 0 at 18.22 min
 18.32  [Playtest] finished armtide team 0 at 18.32 min
 18.37  [Playtest] finished armfmkr team 0 at 18.37 min
 18.40  [Playtest] finished armfmkr team 0 at 18.40 min
 18.54  [Playtest] finished armfmkr team 0 at 18.54 min
 18.81  [Playtest] finished armtide team 0 at 18.81 min
 18.84  [Playtest] finished armfmkr team 0 at 18.84 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +60.3 bank 1999/2000, energy +1382.3 bank 3951/4451, units 155
 19.06  [Playtest] finished armfmkr team 0 at 19.06 min
 19.08  [Playtest] finished armtide team 0 at 19.08 min
 19.08  [Playtest] finished armtide team 0 at 19.08 min
 19.38  [Playtest] finished armtide team 0 at 19.38 min
 19.40  [Playtest] finished armtide team 0 at 19.40 min
 19.48  [Playtest] finished armtide team 0 at 19.48 min
 19.62  [Playtest] finished armfmkr team 0 at 19.62 min
 19.77  [Playtest] finished armfmkr team 0 at 19.77 min
 19.97  [Playtest] finished armfmkr team 0 at 19.97 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +61.8 bank 1999/2000, energy +1485.7 bank 4193/4701, units 163
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.12  [Playtest] finished armtide team 0 at 20.12 min
 20.17  [Playtest] finished armfmkr team 0 at 20.17 min
 20.23  [Playtest] finished armtide team 0 at 20.24 min
 20.39  [Playtest] finished armtide team 0 at 20.39 min
 20.41  [Playtest] finished armfmkr team 0 at 20.41 min
 20.87  [Playtest] finished armfmkr team 0 at 20.87 min
 20.93  [Playtest] finished armfmkr team 0 at 20.93 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +63.8 bank 1999/2000, energy +1550.3 bank 4381/4851, units 169
 21.17  [Playtest] finished armtide team 0 at 21.17 min
 21.37  [Playtest] finished armtide team 0 at 21.37 min
 21.71  [Playtest] finished armfmkr team 0 at 21.71 min
 21.72  [Playtest] finished armtide team 0 at 21.72 min
 21.73  [Playtest] finished armfmkr team 0 at 21.73 min
 21.94  [Playtest] finished armfmkr team 0 at 21.94 min
 21.98  [Playtest] finished armfmkr team 0 at 21.98 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +60.0 bank 1999/2000, energy +1621.4 bank 4372/5001, units 177
 22.04  [Playtest] finished armfmkr team 0 at 22.04 min
 22.06  [Playtest] finished armfmkr team 0 at 22.06 min
 22.53  [Playtest] finished armfmkr team 0 at 22.53 min
 22.79  [Playtest] finished armfmkr team 0 at 22.79 min
 22.98  [Playtest] finished armfmkr team 0 at 22.98 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +61.9 bank 2000/2000, energy +1615.0 bank 4530/5001, units 180
 23.13  [Playtest] finished armfmkr team 0 at 23.13 min
 23.22  [Playtest] finished armfmkr team 0 at 23.22 min
 23.55  [Playtest] finished armfmkr team 0 at 23.55 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +64.7 bank 2000/2000, energy +1596.5 bank 4521/5001, units 183
 25.00  [Playtest] eco team 0 at 25.0 min: metal +64.8 bank 2000/2000, energy +1603.6 bank 4524/5001, units 183
 26.00  [Playtest] eco team 0 at 26.0 min: metal +65.0 bank 2000/2000, energy +1621.7 bank 4534/5001, units 183
 26.36  [Playtest] finished armtl team 0 at 26.36 min
 26.40  [Playtest] finished armrad team 0 at 26.40 min
 26.43  [Playtest] finished armtl team 0 at 26.43 min
 26.65  [Playtest] finished armfrad team 0 at 26.65 min
 26.72  [Playtest] finished armtl team 0 at 26.72 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +65.0 bank 2000/2000, energy +1621.6 bank 4534/5001, units 188
 28.00  [Playtest] eco team 0 at 28.0 min: metal +64.9 bank 2000/2000, energy +1611.6 bank 4528/5001, units 188
 29.00  [Playtest] eco team 0 at 29.0 min: metal +64.8 bank 2000/2000, energy +1608.0 bank 4528/5001, units 188
 29.00  [Playtest] camera requested (4814,11077) height=2200
 29.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (4814, 11077)
 30.00  [Playtest] eco team 0 at 30.0 min: metal +64.9 bank 2000/2000, energy +1617.4 bank 4533/5001, units 188
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(28578) at (4774, 11079) walks to (4744, 11077), 136 from the armmex site (4608, 11072)
  0.08  EXP: approach: armcom(891) at (7537, 1223) walks to (7560, 1224), 136 from the armmex site (7696, 1232)
  0.21  EXP: approach: armcom(891) at (7548, 1223) walks to (7475, 1094), 136 from the armmex site (7408, 976)
  0.22  RESERVE: zone 1 at (6480, 1664) facing 0, 6x6 cells: 36 of 36 held
  0.22  RESERVE: armsy at (6480, 1664) facing 0 (id 1)
  0.22  RESERVE: corridor 2 at (6480, 1952) facing 0, 12x30 cells: 360 of 360 held
  0.22  RESERVE: zone 3 at (6424, 1448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6424, 1448) facing 0 (id 2)
  0.22  RESERVE: zone 4 at (6488, 1448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1448) facing 0 (id 3)
  0.22  RESERVE: zone 3 released
  0.22  RESERVE: zone 4 released
  0.22  RESERVE: zone 5 at (6520, 1448) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6520, 1448) facing 0 (id 4)
  0.22  RESERVE: zone 5 released
  0.22  RESERVE: zone 6 at (6504, 1480) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1480) facing 0 (id 5)
  0.22  RESERVE: zone 6 released
  0.22  RESERVE: zone 7 at (6488, 1512) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1512) facing 0 (id 6)
  0.22  RESERVE: zone 7 released
  0.22  RESERVE: zone 8 at (6456, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6456, 1528) facing 0 (id 7)
  0.22  RESERVE: zone 9 at (6520, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6520, 1528) facing 0 (id 8)
  0.22  RESERVE: zone 8 released
  0.22  RESERVE: zone 9 released
  0.22  RESERVE: zone 10 at (6424, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6424, 1544) facing 0 (id 9)
  0.22  RESERVE: zone 11 at (6488, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6488, 1544) facing 0 (id 10)
  0.22  RESERVE: zone 12 at (6552, 1544) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6552, 1544) facing 0 (id 11)
  0.22  RESERVE: zone 10 released
  0.22  RESERVE: zone 11 released
  0.22  RESERVE: zone 12 released
  0.22  RESERVE: zone 13 at (6376, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 1528) facing 0 (id 12)
  0.22  RESERVE: zone 14 at (6440, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1528) facing 0 (id 13)
  0.22  RESERVE: zone 15 at (6504, 1528) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1528) facing 0 (id 14)
  0.22  RESERVE: zone 16 at (6376, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6376, 1592) facing 0 (id 15)
  0.22  RESERVE: zone 17 at (6440, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6440, 1592) facing 0 (id 16)
  0.22  RESERVE: zone 18 at (6504, 1592) facing 0, 3x3 cells: 9 of 9 held
  0.22  RESERVE: armnanotcplat at (6504, 1592) facing 0 (id 17)
  0.22  RESERVE: zone 19 at (6443, 1561) facing 0, 13x9 cells: 57 of 117 held
  0.23  RESERVE: zone 1 at (5840, 10640) facing 2, 6x6 cells: 36 of 36 held
  0.23  RESERVE: armsy at (5840, 10640) facing 2 (id 1)
  0.23  RESERVE: corridor 2 at (5840, 10352) facing 2, 12x30 cells: 360 of 360 held
  0.23  RESERVE: zone 3 at (5912, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5912, 10872) facing 2 (id 2)
  0.23  RESERVE: zone 4 at (5848, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5848, 10872) facing 2 (id 3)
  0.23  RESERVE: zone 5 at (5784, 10872) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5784, 10872) facing 2 (id 4)
  0.23  RESERVE: zone 6 at (5912, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5912, 10808) facing 2 (id 5)
  0.23  RESERVE: zone 7 at (5848, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5848, 10808) facing 2 (id 6)
  0.23  RESERVE: zone 8 at (5784, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.23  RESERVE: armnanotcplat at (5784, 10808) facing 2 (id 7)
  0.23  RESERVE: zone 9 at (5840, 10832) facing 2, 12x8 cells: 42 of 96 held
  0.29  EXP: approach: armcom(28578) at (4673, 11075) walks to (4806, 11226), 136 from the armmex site (4896, 11328)
  0.41  EXP: approach: armcom(891) at (7494, 1111) walks to (6628, 1583), 168 from the armsy site (6480, 1664)
  0.41  RESERVE: served armsy at (6480, 1664) facing 0 (id 1, 0 of this def still held)
  0.50  EXP: approach: armcom(28578) at (4783, 11201) walks to (5691, 10719), 169 from the armsy site (5840, 10640)
  0.50  RESERVE: served armsy at (5840, 10640) facing 2 (id 1, 0 of this def still held)
  1.15  EXP: approach: armcom(891) at (6661, 1563) walks to (7272, 1515), 136 from the armmex site (7408, 1504)
  1.27  EXP: approach: armcom(28578) at (5663, 10739) walks to (5032, 10789), 136 from the armmex site (4896, 10800)
  1.74  RESERVE: zone 20 at (6424, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.74  RESERVE: armtide at (6424, 1416) facing 0 (id 18)
  1.74  RESERVE: zone 21 at (6488, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.74  RESERVE: armtide at (6488, 1416) facing 0 (id 19)
  1.74  RESERVE: zone 20 released
  1.74  RESERVE: zone 21 released
  1.74  RESERVE: zone 22 at (6376, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.74  RESERVE: armtide at (6376, 1400) facing 0 (id 20)
  1.74  RESERVE: zone 22 released
  1.74  RESERVE: zone 23 at (6344, 1384) facing 0, 3x3 cells: 9 of 9 held
  1.74  RESERVE: armtide at (6344, 1384) facing 0 (id 21)
  1.74  RESERVE: zone 23 released
  1.77  RESERVE: zone 24 at (6328, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6328, 1352) facing 0 (id 22)
  1.77  RESERVE: zone 25 at (6392, 1352) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6392, 1352) facing 0 (id 23)
  1.77  RESERVE: zone 24 released
  1.77  RESERVE: zone 25 released
  1.77  RESERVE: zone 26 at (6328, 1320) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6328, 1320) facing 0 (id 24)
  1.77  RESERVE: zone 27 at (6392, 1320) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6392, 1320) facing 0 (id 25)
  1.77  RESERVE: zone 26 released
  1.77  RESERVE: zone 27 released
  1.77  RESERVE: zone 28 at (6328, 1272) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6328, 1272) facing 0 (id 26)
  1.77  RESERVE: zone 29 at (6392, 1272) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6392, 1272) facing 0 (id 27)
  1.77  RESERVE: zone 28 released
  1.77  RESERVE: zone 29 released
  1.77  RESERVE: zone 30 at (6344, 1240) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6344, 1240) facing 0 (id 28)
  1.77  RESERVE: zone 30 released
  1.77  RESERVE: zone 31 at (6376, 1224) facing 0, 3x3 cells: 9 of 9 held
  1.77  RESERVE: armtide at (6376, 1224) facing 0 (id 29)
  1.77  RESERVE: zone 31 released
  1.80  RESERVE: zone 32 at (6280, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.80  RESERVE: armtide at (6280, 1448) facing 0 (id 30)
  1.80  RESERVE: zone 33 at (6344, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.80  RESERVE: armtide at (6344, 1448) facing 0 (id 31)
  1.80  RESERVE: zone 34 at (6408, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.80  RESERVE: armtide at (6408, 1448) facing 0 (id 32)
  1.80  RESERVE: zone 35 at (6280, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.80  RESERVE: armtide at (6280, 1512) facing 0 (id 33)
  1.80  RESERVE: zone 32 released
  1.80  RESERVE: zone 33 released
  1.80  RESERVE: zone 34 released
  1.80  RESERVE: zone 35 released
```
