# Playtest report: PASS

- Verdict: **PASS** (reached 25 min)
- Game time reached: 25.0 min (frame 45001); wall 230 s
- DLL: build-theatres\d192-baseline\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T15:45:26
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-preplan\supreme\20261004T184526Z-9d7331a8\runs\20261004T184919Z-d208282c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:42.204029][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.4 min | `[t=00:01:00.979483][f=0002585] [SeaWatch] finished frame=2585 id=26482 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 2.0 min | `[t=00:01:03.332768][f=0003570] [SeaWatch] egress id=19532 yard=26482 seconds=13.3 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-preplan\supreme\20261004T184526Z-9d7331a8\runs\20261004T184919Z-d208282c\screen_2026-10-04_18-46-47-372.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-preplan\supreme\20261004T184526Z-9d7331a8\runs\20261004T184919Z-d208282c\screen_2026-10-04_18-47-19-107.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d192-preplan\supreme\20261004T184526Z-9d7331a8\runs\20261004T184919Z-d208282c\screen_2026-10-04_18-48-28-953.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 25.5 min
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
  0.19  [Playtest] finished armmex team 0 at 0.19 min
  0.20  [Team][Roster] first mex 6887 at 4608,11072
  0.20  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4775|11078|0|7|1|4608|11072
  0.38  [Playtest] finished armmex team 0 at 0.38 min
  0.50  [Playtest] finished armwin team 0 at 0.50 min
  0.61  [Playtest] finished armwin team 0 at 0.61 min
  0.71  [Playtest] finished armwin team 0 at 0.71 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1085/1100, energy +65.9 bank 1001/1001, units 6
  1.44  [Playtest] finished armsy team 0 at 1.44 min
  1.52  [SEA][Layout] berth sea.berth.0 armasy at=6112,10080 facing=2
  1.67  [SEA][Layout] berth sea.berth.1 armasy at=6400,9968 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.3 bank 654/1200, energy +73.3 bank 14/1151, units 10
  2.52  [Playtest] finished armtide team 0 at 2.52 min
  2.82  [Playtest] finished armtide team 0 at 2.82 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +6.6 bank 211/1200, energy +123.7 bank 232/1301, units 13
  3.05  [Playtest] finished armtide team 0 at 3.05 min
  3.45  [Playtest] finished armmex team 0 at 3.45 min
  3.86  [Playtest] finished armmex team 0 at 3.86 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.9 bank 14/1300, energy +164.0 bank 1340/1351, units 18
  4.16  [Playtest] finished armmex team 0 at 4.16 min
  4.53  [Playtest] finished armmex team 0 at 4.53 min
  4.64  [Playtest] finished armtide team 0 at 4.64 min
  4.95  [Playtest] finished armmex team 0 at 4.95 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +17.3 bank 16/1450, energy +184.5 bank 1381/1401, units 23
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.35  [Playtest] finished armmex team 0 at 5.35 min
  5.38  [Playtest] finished armtide team 0 at 5.38 min
  5.42  [Playtest] finished armtide team 0 at 5.42 min
  5.66  [Playtest] finished armmex team 0 at 5.66 min
  5.68  [Playtest] finished armtide team 0 at 5.68 min
  5.89  [Playtest] finished armtide team 0 at 5.89 min
  5.92  [Playtest] finished armmex team 0 at 5.93 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +24.2 bank 155/1600, energy +260.0 bank 1638/1651, units 31
  6.11  [Playtest] finished armllt team 0 at 6.11 min
  6.20  [Playtest] finished armrad team 0 at 6.20 min
  6.33  [Playtest] finished armfmkr team 0 at 6.33 min
  6.65  [Playtest] finished armtide team 0 at 6.65 min
  6.66  [Playtest] finished armmex team 0 at 6.66 min
  6.84  [Playtest] finished armllt team 0 at 6.84 min
  6.96  [Playtest] finished armtide team 0 at 6.96 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +27.0 bank 494/1650, energy +303.9 bank 1432/1801, units 42
  7.17  [Playtest] finished armtide team 0 at 7.17 min
  7.21  [Playtest] finished armtide team 0 at 7.21 min
  7.27  [Playtest] finished armnanotcplat team 0 at 7.27 min
  7.64  [Playtest] finished armfmkr team 0 at 7.64 min
  7.93  [Playtest] finished armmex team 0 at 7.93 min
  7.96  [Playtest] finished armtide team 0 at 7.96 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +30.0 bank 637/1700, energy +394.5 bank 1567/2001, units 50
  8.08  [Playtest] finished armtide team 0 at 8.08 min
  8.19  [Playtest] finished armtide team 0 at 8.19 min
  8.58  [Playtest] finished armmex team 0 at 8.58 min
  8.67  [Playtest] finished armfmkr team 0 at 8.67 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +33.4 bank 587/1750, energy +436.8 bank 1650/2101, units 57
  9.04  [Playtest] finished armtide team 0 at 9.04 min
  9.15  [Playtest] finished armtide team 0 at 9.15 min
  9.24  [Playtest] finished armtide team 0 at 9.24 min
  9.31  [Playtest] finished armmex team 0 at 9.31 min
  9.45  [Playtest] finished armtide team 0 at 9.45 min
  9.60  [Playtest] finished armtide team 0 at 9.60 min
  9.81  [Playtest] finished armtide team 0 at 9.81 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +36.4 bank 665/1800, energy +535.1 bank 2420/2451, units 70
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.02  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.02  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.12  [Playtest] finished armmex team 0 at 10.13 min
 10.40  [Playtest] finished armtl team 0 at 10.40 min
 10.45  [Playtest] finished armfmkr team 0 at 10.45 min
 10.47  [Playtest] finished armfmkr team 0 at 10.47 min
 10.68  [Playtest] finished armfrad team 0 at 10.68 min
 10.73  [Playtest] finished armtide team 0 at 10.73 min
 10.97  [Playtest] finished armtide team 0 at 10.97 min
 10.99  [Playtest] finished armfmkr team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +40.7 bank 1536/1850, energy +581.6 bank 2193/2551, units 79
 11.06  [Playtest] finished armmex team 0 at 11.06 min
 11.09  [Playtest] finished armfmkr team 0 at 11.09 min
 11.22  [Playtest] finished armfmkr team 0 at 11.22 min
 11.23  [Playtest] finished armtide team 0 at 11.23 min
 11.31  [Playtest] finished armtl team 0 at 11.31 min
 11.65  [Playtest] finished armnanotcplat team 0 at 11.65 min
 11.68  [Playtest] finished armtide team 0 at 11.68 min
 11.79  [Playtest] finished armfmkr team 0 at 11.79 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +40.3 bank 1806/1900, energy +636.6 bank 2067/2651, units 90
 12.04  [Playtest] finished armtide team 0 at 12.03 min
 12.14  [Playtest] finished armestor team 0 at 12.14 min
 12.28  [Playtest] finished armtide team 0 at 12.28 min
 12.36  [Playtest] finished armmstor team 0 at 12.36 min
 12.42  [Playtest] finished armfmkr team 0 at 12.42 min
 12.43  [Playtest] finished armnanotcplat team 0 at 12.43 min
 12.49  [Playtest] finished armtide team 0 at 12.49 min
 12.70  [Playtest] finished armtide team 0 at 12.70 min
 12.81  [Playtest] finished armtide team 0 at 12.81 min
 12.81  [Playtest] finished armllt team 0 at 12.81 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +45.0 bank 2312/4900, energy +740.4 bank 6915/8901, units 101
 13.02  [Playtest] finished armtl team 0 at 13.02 min
 13.11  [Playtest] finished armtl team 0 at 13.11 min
 13.23  [Playtest] finished armtide team 0 at 13.23 min
 13.56  [Playtest] finished armtide team 0 at 13.56 min
 13.90  [Playtest] finished armtide team 0 at 13.90 min
 13.92  [Playtest] finished armmex team 0 at 13.92 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +50.3 bank 3794/4950, energy +809.4 bank 7150/9051, units 108
 14.13  [Playtest] finished armllt team 0 at 14.13 min
 14.14  [Playtest] finished armmex team 0 at 14.14 min
 14.24  [Playtest] finished armtide team 0 at 14.24 min
 14.30  [Playtest] finished armrad team 0 at 14.30 min
 14.49  [Playtest] finished armnanotcplat team 0 at 14.49 min
 14.57  [Playtest] finished armtide team 0 at 14.57 min
 14.69  [Playtest] finished armtl team 0 at 14.69 min
 14.73  [Playtest] finished armtide team 0 at 14.73 min
 14.86  [Playtest] finished armnanotcplat team 0 at 14.86 min
 15.00  [Playtest] finished armnanotcplat team 0 at 15.00 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +42.7 bank 4126/5000, energy +884.9 bank 7072/9201, units 124
 15.06  [Playtest] finished armtide team 0 at 15.06 min
 15.12  [Playtest] finished armnanotcplat team 0 at 15.12 min
 15.20  [Playtest] finished armrad team 0 at 15.20 min
 15.23  [Playtest] finished armnanotcplat team 0 at 15.23 min
 15.26  [Playtest] finished armfrad team 0 at 15.26 min
 15.38  [Playtest] finished armtide team 0 at 15.39 min
 15.57  [Playtest] finished armmex team 0 at 15.57 min
 15.73  [Playtest] finished armtide team 0 at 15.73 min
 15.75  [Playtest] finished armrad team 0 at 15.75 min
 15.86  [Playtest] finished armfrad team 0 at 15.86 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +51.7 bank 4002/5050, energy +945.3 bank 7504/9351, units 141
 16.02  [Playtest] finished armllt team 0 at 16.02 min
 16.07  [Playtest] finished armtide team 0 at 16.07 min
 16.29  [Playtest] finished armtide team 0 at 16.29 min
 16.39  [Playtest] finished armtide team 0 at 16.40 min
 16.48  [Playtest] finished armtl team 0 at 16.48 min
 16.88  [Playtest] finished armtide team 0 at 16.88 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +48.0 bank 4179/5050, energy +1006.4 bank 7609/9551, units 154
 17.08  [Playtest] finished armllt team 0 at 17.08 min
 17.21  [Playtest] finished armtide team 0 at 17.21 min
 17.53  [Playtest] finished armfmkr team 0 at 17.53 min
 17.54  [Playtest] finished armtide team 0 at 17.54 min
 17.70  [Playtest] finished armfmkr team 0 at 17.70 min
 17.77  [Playtest] finished armnanotcplat team 0 at 17.77 min
 17.92  [Playtest] finished armtide team 0 at 17.92 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +46.3 bank 4106/5050, energy +1049.6 bank 7848/9701, units 173
 18.30  [Playtest] finished armtide team 0 at 18.30 min
 18.64  [Playtest] finished armtide team 0 at 18.64 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +44.9 bank 3719/5050, energy +1124.7 bank 6521/9801, units 185
 19.41  [Playtest] finished armfmkr team 0 at 19.41 min
 19.74  [Playtest] finished armtide team 0 at 19.74 min
 19.77  [Playtest] finished armfmkr team 0 at 19.77 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +58.9 bank 4061/5050, energy +1153.7 bank 8875/9851, units 191
 20.00  [Playtest] camera requested (4814,11077) height=2200
 20.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 20.01  [Playtest] screenshot at 20.0 min of team 0 at (4814, 11077)
 20.03  [Playtest] finished armtide team 0 at 20.03 min
 20.40  [Playtest] finished armtide team 0 at 20.40 min
 20.63  [Playtest] finished armfmkr team 0 at 20.63 min
 20.73  [Playtest] finished armtide team 0 at 20.73 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +58.3 bank 4204/5050, energy +1220.5 bank 8029/10001, units 201
 21.38  [Playtest] finished armfmkr team 0 at 21.38 min
 21.45  [Playtest] finished armnanotcplat team 0 at 21.45 min
 21.61  [Playtest] finished armfmkr team 0 at 21.61 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +56.1 bank 4349/5050, energy +1207.0 bank 8071/10001, units 215
 22.15  [Playtest] finished armtide team 0 at 22.15 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +61.8 bank 4390/5050, energy +1242.0 bank 8131/10051, units 223
 23.33  [Playtest] finished armnanotcplat team 0 at 23.33 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +61.5 bank 4213/5050, energy +1238.3 bank 7704/10051, units 237
 25.00  [Playtest] eco team 0 at 25.0 min: metal +48.4 bank 4055/5050, energy +1240.7 bank 7184/10051, units 245
```

## Native lines (all AIs, first 120)

```
  1.45  RESERVE: zone 1 at (5800, 10904) facing 2, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (5800, 10904) facing 2 (id 1)
  1.45  RESERVE: zone 1 released
  1.45  RESERVE: corridor 2 at (5840, 10448) facing 2, 12x30 cells: 210 of 360 held
  1.45  RESERVE: zone 3 at (5968, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: zone 3 released
  1.45  RESERVE: zone 4 at (6096, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6096, 11424) facing 2: 2 of 16 slots (group 2, held, zone)
  1.45  RESERVE: zone 4 released
  1.45  RESERVE: zone 5 at (6224, 11520) facing 2, 40x40 cells: 1600 of 1600 held
  1.45  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6224, 11424) facing 2: 10 of 16 slots (group 3, held, zone)
  1.45  RESERVE: zone 5 released
  1.45  RESERVE: zone 1 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 1)
  1.45  RESERVE: zone 2 at (6520, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6520, 1496) facing 0 (id 2)
  1.45  RESERVE: zone 1 released
  1.45  RESERVE: zone 2 released
  1.45  RESERVE: zone 3 at (6408, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1512) facing 0 (id 3)
  1.45  RESERVE: zone 4 at (6456, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6456, 1512) facing 0 (id 4)
  1.45  RESERVE: zone 5 at (6504, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6504, 1512) facing 0 (id 5)
  1.45  RESERVE: zone 3 released
  1.45  RESERVE: zone 4 released
  1.45  RESERVE: zone 5 released
  1.45  RESERVE: zone 6 at (6328, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6328, 1496) facing 0 (id 6)
  1.45  RESERVE: zone 7 at (6376, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6376, 1496) facing 0 (id 7)
  1.45  RESERVE: zone 8 at (6424, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6424, 1496) facing 0 (id 8)
  1.45  RESERVE: zone 9 at (6472, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6472, 1496) facing 0 (id 9)
  1.45  RESERVE: zone 10 at (6520, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6520, 1496) facing 0 (id 10)
  1.45  RESERVE: zone 11 at (6328, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6328, 1544) facing 0 (id 11)
  1.45  RESERVE: zone 6 released
  1.45  RESERVE: zone 7 released
  1.45  RESERVE: zone 8 released
  1.45  RESERVE: zone 9 released
  1.45  RESERVE: zone 10 released
  1.45  RESERVE: zone 11 released
  1.45  RESERVE: zone 12 at (6264, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1448) facing 0 (id 12)
  1.45  RESERVE: zone 13 at (6312, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1448) facing 0 (id 13)
  1.45  RESERVE: zone 14 at (6360, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1448) facing 0 (id 14)
  1.45  RESERVE: zone 15 at (6408, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1448) facing 0 (id 15)
  1.45  RESERVE: zone 16 at (6456, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6456, 1448) facing 0 (id 16)
  1.45  RESERVE: zone 17 at (6264, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1496) facing 0 (id 17)
  1.45  RESERVE: zone 18 at (6312, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1496) facing 0 (id 18)
  1.45  RESERVE: zone 19 at (6360, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1496) facing 0 (id 19)
  1.45  RESERVE: zone 20 at (6408, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1496) facing 0 (id 20)
  1.45  RESERVE: zone 21 at (6456, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6456, 1496) facing 0 (id 21)
  1.45  RESERVE: zone 22 at (6264, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1544) facing 0 (id 22)
  1.45  RESERVE: zone 23 at (6312, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1544) facing 0 (id 23)
  1.45  RESERVE: zone 12 released
  1.45  RESERVE: zone 13 released
  1.45  RESERVE: zone 14 released
  1.45  RESERVE: zone 15 released
  1.45  RESERVE: zone 16 released
  1.45  RESERVE: zone 17 released
  1.45  RESERVE: zone 18 released
  1.45  RESERVE: zone 19 released
  1.45  RESERVE: zone 20 released
  1.45  RESERVE: zone 21 released
  1.45  RESERVE: zone 22 released
  1.45  RESERVE: zone 23 released
  1.45  RESERVE: zone 24 at (6216, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1400) facing 0 (id 24)
  1.45  RESERVE: zone 25 at (6264, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1400) facing 0 (id 25)
  1.45  RESERVE: zone 26 at (6312, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1400) facing 0 (id 26)
  1.45  RESERVE: zone 27 at (6360, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1400) facing 0 (id 27)
  1.45  RESERVE: zone 28 at (6408, 1400) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1400) facing 0 (id 28)
  1.45  RESERVE: zone 29 at (6216, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1448) facing 0 (id 29)
  1.45  RESERVE: zone 30 at (6264, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1448) facing 0 (id 30)
  1.45  RESERVE: zone 31 at (6312, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1448) facing 0 (id 31)
  1.45  RESERVE: zone 32 at (6360, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1448) facing 0 (id 32)
  1.45  RESERVE: zone 33 at (6408, 1448) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1448) facing 0 (id 33)
  1.45  RESERVE: zone 34 at (6216, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1496) facing 0 (id 34)
  1.45  RESERVE: zone 35 at (6264, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1496) facing 0 (id 35)
  1.45  RESERVE: zone 36 at (6312, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1496) facing 0 (id 36)
  1.45  RESERVE: zone 37 at (6360, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6360, 1496) facing 0 (id 37)
  1.45  RESERVE: zone 38 at (6408, 1496) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6408, 1496) facing 0 (id 38)
  1.45  RESERVE: zone 39 at (6216, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6216, 1544) facing 0 (id 39)
  1.45  RESERVE: zone 40 at (6264, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6264, 1544) facing 0 (id 40)
  1.45  RESERVE: zone 41 at (6312, 1544) facing 0, 3x3 cells: 9 of 9 held
  1.45  RESERVE: armnanotcplat at (6312, 1544) facing 0 (id 41)
  1.45  RESERVE: zone 24 released
  1.45  RESERVE: zone 25 released
  1.45  RESERVE: zone 26 released
```
