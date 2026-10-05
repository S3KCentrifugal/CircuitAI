# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.1 min (frame 54146); wall 236 s
- DLL: build-theatres\d189-build-7\SkirmishAI.dll (a293daae515d9f77); AI BARbTest/test; staged 2026-10-04T08:47:47
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-approach-recovery\glacial\20261004T114747Z-a3de87e8\runs\20261004T115146Z-d255c24a\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:30.330574][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 0.8 min | `[t=00:00:44.167299][f=0001377] [SeaWatch] finished frame=1377 id=9800 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 2.6 min | `[t=00:00:51.667381][f=0004650] [SeaWatch] egress id=26255 yard=9800 seconds=4.9 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-approach-recovery\glacial\20261004T114747Z-a3de87e8\runs\20261004T115146Z-d255c24a\screen_2026-10-04_11-48-53-535.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-approach-recovery\glacial\20261004T114747Z-a3de87e8\runs\20261004T115146Z-d255c24a\screen_2026-10-04_11-49-15-441.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-approach-recovery\glacial\20261004T114747Z-a3de87e8\runs\20261004T115146Z-d255c24a\screen_2026-10-04_11-50-16-440.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\d189-approach-recovery\glacial\20261004T114747Z-a3de87e8\runs\20261004T115146Z-d255c24a\screen_2026-10-04_11-51-34-405.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 15, 4 shots, end at 30.5 min
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
  0.15  [Team][Roster] team 1 first mex at 704,4448
  0.15  [Playtest] finished armmex team 0 at 0.15 min
  0.17  [SEA][Layout] berth sea.berth.2 armasy at=1424,3296 facing=3
  0.17  [Team][Roster] first mex 10685 at 1424,4096
  0.17  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|1430|3997|0|4|1|1424|4096
  0.18  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.77  [Playtest] finished armsy team 0 at 0.76 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 715/1200, energy +30.0 bank 94/1100, units 5
  1.22  [Playtest] finished armtide team 0 at 1.22 min
  1.46  [Playtest] finished armtide team 0 at 1.46 min
  1.66  [Playtest] finished armtide team 0 at 1.66 min
  1.83  [Playtest] finished armtide team 0 at 1.83 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +6.0 bank 380/1200, energy +129.0 bank 266/1350, units 12
  2.08  [Playtest] finished armtide team 0 at 2.08 min
  2.11  [Playtest] finished armmex team 0 at 2.11 min
  2.22  [Playtest] finished armtide team 0 at 2.22 min
  2.53  [Playtest] finished armmex team 0 at 2.53 min
  2.69  [Playtest] finished armtide team 0 at 2.69 min
  2.80  [Playtest] finished armtide team 0 at 2.80 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +10.0 bank 0/1300, energy +228.0 bank 1593/1600, units 20
  3.12  [Playtest] finished armtide team 0 at 3.12 min
  3.29  [Playtest] finished armtide team 0 at 3.29 min
  3.42  [Playtest] finished armmex team 0 at 3.42 min
  3.71  [Playtest] finished armmex team 0 at 3.71 min
  3.88  [Playtest] finished armtide team 0 at 3.88 min
  3.90  [Playtest] finished armtide team 0 at 3.90 min
  3.95  [Playtest] finished armmex team 0 at 3.95 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +16.0 bank 27/1450, energy +320.0 bank 1797/1800, units 25
  4.17  [Playtest] finished armmex team 0 at 4.17 min
  4.47  [Playtest] finished armfmkr team 0 at 4.47 min
  4.47  [Playtest] finished armfmkr team 0 at 4.47 min
  4.62  [Playtest] finished armmex team 0 at 4.63 min
  4.84  [Playtest] finished armmex team 0 at 4.84 min
  4.85  [Playtest] finished armfmkr team 0 at 4.85 min
  4.85  [Playtest] finished armfmkr team 0 at 4.85 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +26.0 bank 273/1600, energy +320.0 bank 1451/1800, units 34
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.04  [Playtest] finished armmex team 0 at 5.04 min
  5.22  [Playtest] finished armmex team 0 at 5.22 min
  5.48  [Playtest] finished armtide team 0 at 5.48 min
  5.78  [Playtest] finished armmex team 0 at 5.78 min
  5.79  [Playtest] finished armtide team 0 at 5.79 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +30.4 bank 1179/1750, energy +366.0 bank 1498/1900, units 42
  6.01  [Playtest] finished armmex team 0 at 6.01 min
  6.09  [Playtest] finished armtide team 0 at 6.09 min
  6.20  [Playtest] finished armmex team 0 at 6.20 min
  6.28  [Playtest] finished armmex team 0 at 6.28 min
  6.37  [Playtest] finished armmex team 0 at 6.37 min
  6.40  [Playtest] finished armtide team 0 at 6.40 min
  6.58  [Playtest] finished armmex team 0 at 6.58 min
  6.71  [Playtest] finished armtide team 0 at 6.71 min
  6.86  [Playtest] finished armmex team 0 at 6.86 min
  6.90  [Playtest] finished armmex team 0 at 6.90 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +44.4 bank 1815/2100, energy +435.0 bank 1621/2050, units 50
  7.20  [Playtest] finished armmex team 0 at 7.20 min
  7.49  [Playtest] finished armnanotcplat team 0 at 7.49 min
  7.72  [Playtest] finished armmex team 0 at 7.72 min
  7.87  [Playtest] finished armtide team 0 at 7.86 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +48.6 bank 1965/2200, energy +465.0 bank 1701/2150, units 55
  8.06  [Playtest] finished armmex team 0 at 8.06 min
  8.31  [Playtest] finished armtide team 0 at 8.31 min
  8.66  [Playtest] finished armtide team 0 at 8.66 min
  8.96  [Playtest] finished armtide team 0 at 8.96 min
  8.98  [Playtest] finished armtide team 0 at 8.98 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +46.7 bank 2027/2150, energy +552.5 bank 2068/2400, units 59
  9.03  [Playtest] finished armtl team 0 at 9.03 min
  9.30  [Playtest] finished armtide team 0 at 9.30 min
  9.30  [Playtest] finished armmex team 0 at 9.31 min
  9.45  [Playtest] finished armtide team 0 at 9.45 min
  9.76  [Playtest] finished armtide team 0 at 9.76 min
  9.82  [Playtest] finished armnanotcplat team 0 at 9.82 min
  9.98  [Playtest] finished armmex team 0 at 9.98 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +50.7 bank 2217/2250, energy +647.0 bank 2087/2650, units 70
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.08  [Playtest] finished armtide team 0 at 10.08 min
 10.24  [Playtest] finished armtide team 0 at 10.24 min
 10.40  [Playtest] finished armtide team 0 at 10.40 min
 10.53  [Playtest] finished armtl team 0 at 10.53 min
 10.56  [Playtest] finished armtide team 0 at 10.56 min
 10.56  [Playtest] finished armtide team 0 at 10.56 min
 10.65  [Playtest] finished armmex team 0 at 10.65 min
 10.99  [Playtest] finished armtide team 0 at 10.99 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +52.6 bank 1679/2300, energy +762.0 bank 2284/2950, units 82
 11.18  [Playtest] finished armtl team 0 at 11.18 min
 11.21  [Playtest] finished armtide team 0 at 11.21 min
 11.24  [Playtest] finished armnanotcplat team 0 at 11.24 min
 11.32  [Playtest] finished armtide team 0 at 11.32 min
 11.53  [Playtest] finished armtide team 0 at 11.53 min
 11.67  [Playtest] finished armtide team 0 at 11.67 min
 11.86  [Playtest] finished armtide team 0 at 11.86 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +54.0 bank 1631/2300, energy +900.0 bank 3002/3200, units 90
 12.09  [Playtest] finished armtide team 0 at 12.09 min
 12.31  [Playtest] finished armtl team 0 at 12.31 min
 12.47  [Playtest] finished armtide team 0 at 12.47 min
 12.53  [Playtest] finished armtide team 0 at 12.53 min
 12.79  [Playtest] finished armtide team 0 at 12.79 min
 12.86  [Playtest] finished armtide team 0 at 12.85 min
 12.94  [Playtest] finished armmex team 0 at 12.94 min
 12.96  [Playtest] finished armasy team 0 at 12.95 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +56.0 bank 71/2550, energy +1008.0 bank 3598/3600, units 98
 13.15  [Playtest] finished armfmkr team 0 at 13.15 min
 13.23  [Playtest] finished armtide team 0 at 13.23 min
 13.29  [Playtest] finished armfmkr team 0 at 13.29 min
 13.52  [Playtest] finished armtide team 0 at 13.52 min
 13.75  [Playtest] finished armtide team 0 at 13.75 min
 13.76  [Playtest] finished armtide team 0 at 13.76 min
 13.92  [Playtest] finished armtide team 0 at 13.92 min
 13.98  [Playtest] finished armllt team 0 at 13.98 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +58.0 bank 1/2550, energy +1153.0 bank 3915/4000, units 114
 14.01  [Playtest] finished armtl team 0 at 14.01 min
 14.25  [Playtest] finished armtide team 0 at 14.25 min
 14.30  [Playtest] finished armuwmme team 0 at 14.30 min
 14.65  [Playtest] finished armtide team 0 at 14.65 min
 14.74  [Playtest] finished armmex team 0 at 14.74 min
 14.97  [Playtest] finished armllt team 0 at 14.98 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +64.0 bank 0/3100, energy +1229.0 bank 4167/4250, units 119
 15.26  [Playtest] finished armuwmme team 0 at 15.26 min
 15.28  [Playtest] finished armtide team 0 at 15.28 min
 15.31  [Playtest] finished armtl team 0 at 15.31 min
 15.32  [Playtest] finished armuwmme team 0 at 15.32 min
 15.74  [Playtest] finished armfmkr team 0 at 15.74 min
 15.92  [Playtest] finished armmex team 0 at 15.92 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +79.0 bank 42/4250, energy +1552.0 bank 4625/5800, units 121
 16.09  [Playtest] finished armfmkr team 0 at 16.09 min
 16.16  [Playtest] finished armfmkr team 0 at 16.16 min
 16.21  [Playtest] finished armmex team 0 at 16.21 min
 16.21  [Playtest] finished armnanotcplat team 0 at 16.21 min
 16.51  [Playtest] finished armfmkr team 0 at 16.51 min
 16.52  [Playtest] finished armmex team 0 at 16.52 min
 16.61  [Playtest] finished armfrad team 0 at 16.61 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +83.7 bank 45/4350, energy +1552.0 bank 4538/5800, units 127
 17.10  [Playtest] finished armfmkr team 0 at 17.10 min
 17.17  [Playtest] finished armmex team 0 at 17.17 min
 17.27  [Playtest] finished armmex team 0 at 17.27 min
 17.55  [Playtest] finished armfrad team 0 at 17.55 min
 17.76  [Playtest] finished armmex team 0 at 17.76 min
 17.98  [Playtest] finished armmex team 0 at 17.98 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +89.8 bank 50/4550, energy +1552.0 bank 4577/5800, units 134
 18.14  [Playtest] finished armfmkr team 0 at 18.14 min
 18.23  [Playtest] finished armuwfus team 0 at 18.23 min
 18.63  [Playtest] finished armnanotcplat team 0 at 18.63 min
 18.64  [Playtest] finished armtl team 0 at 18.64 min
 18.69  [Playtest] finished armmex team 0 at 18.69 min
 18.92  [Playtest] finished armmex team 0 at 18.92 min
 18.93  [Playtest] finished armmex team 0 at 18.93 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +100.0 bank 761/4650, energy +2752.0 bank 8004/8300, units 147
 19.01  [Playtest] finished armfmkr team 0 at 19.01 min
 19.23  [Playtest] finished armfmkr team 0 at 19.23 min
 19.23  [Playtest] finished armmex team 0 at 19.24 min
 19.32  [Playtest] finished armfmkr team 0 at 19.32 min
 19.34  [Playtest] finished armmex team 0 at 19.34 min
 19.53  [Playtest] finished armfmkr team 0 at 19.53 min
 19.55  [Playtest] finished armmex team 0 at 19.55 min
 19.70  [Playtest] finished armfmkr team 0 at 19.70 min
 19.82  [Playtest] finished armnanotcplat team 0 at 19.82 min
 19.94  [Playtest] finished armfmkr team 0 at 19.94 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +104.9 bank 1429/4800, energy +2445.0 bank 5444/6750, units 155
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.25  [Playtest] finished armfrad team 0 at 20.25 min
 20.50  [Playtest] finished armfmkr team 0 at 20.50 min
 20.67  [Playtest] finished armnanotcplat team 0 at 20.67 min
 20.71  [Playtest] finished armuwmmm team 0 at 20.71 min
 20.78  [Playtest] finished armuwmmm team 0 at 20.78 min
 20.87  [Playtest] finished armfmkr team 0 at 20.87 min
 20.94  [Playtest] finished armnanotcplat team 0 at 20.94 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +149.9 bank 2661/4750, energy +2759.0 bank 6568/8350, units 166
 21.02  [Playtest] finished armnanotcplat team 0 at 21.02 min
 21.25  [Playtest] finished armmex team 0 at 21.25 min
 21.26  [Playtest] finished armatl team 0 at 21.26 min
 21.67  [Playtest] finished armmex team 0 at 21.67 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +113.5 bank 58/4700, energy +2752.0 bank 7051/8300, units 174
 22.31  [Playtest] finished armtl team 0 at 22.31 min
 22.47  [Playtest] finished coruwmme team 0 at 22.47 min
 22.72  [Playtest] finished armuwfus team 0 at 22.72 min
 22.85  [Playtest] finished armmex team 0 at 22.85 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +130.8 bank 253/5300, energy +3952.0 bank 9096/10800, units 177
 23.34  [Playtest] finished armfmkr team 0 at 23.34 min
 23.95  [Playtest] finished armtl team 0 at 23.95 min
 23.98  [Playtest] finished coruwmme team 0 at 23.98 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +180.2 bank 190/5850, energy +3959.0 bank 9304/10850, units 183
 24.12  [Playtest] finished armuwmmm team 0 at 24.12 min
 24.43  [Playtest] finished armuwmmm team 0 at 24.43 min
 24.65  [Playtest] finished armmex team 0 at 24.65 min
 24.85  [Playtest] finished armtl team 0 at 24.85 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +135.9 bank 296/5800, energy +3959.0 bank 9146/10850, units 191
 25.07  [Playtest] finished armmex team 0 at 25.07 min
 25.69  [Playtest] finished coruwmme team 0 at 25.69 min
 25.85  [Playtest] finished armtl team 0 at 25.85 min
 25.87  [Playtest] finished armuwmmm team 0 at 25.87 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +132.0 bank 1234/6350, energy +3959.0 bank 8638/10850, units 194
 26.06  [Playtest] finished armtl team 0 at 26.06 min
 26.28  [Playtest] finished armtl team 0 at 26.28 min
 26.61  [Playtest] finished armuwmmm team 0 at 26.61 min
 26.62  [Playtest] finished coruwmme team 0 at 26.62 min
 26.70  [Playtest] finished armfrad team 0 at 26.70 min
 26.82  [Playtest] finished armtl team 0 at 26.82 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +146.0 bank 2788/6900, energy +3989.0 bank 9640/11000, units 202
 27.25  [Playtest] finished armtl team 0 at 27.25 min
 27.41  [Playtest] finished armfmkr team 0 at 27.41 min
 27.90  [Playtest] finished armuwmmm team 0 at 27.90 min
 28.00  [Playtest] finished armfmkr team 0 at 28.00 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +228.5 bank 5709/6900, energy +4049.0 bank 9239/11300, units 204
 28.29  [Playtest] finished armuwmme team 0 at 28.29 min
 28.52  [Playtest] finished armnanotcplat team 0 at 28.52 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +148.4 bank 6671/7450, energy +4049.0 bank 9172/11300, units 208
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.01  [Playtest] finished armnanotcplat team 0 at 29.01 min
 29.01  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.01  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.15  [Playtest] finished armuwmmm team 0 at 29.15 min
 29.22  [Playtest] finished armuwmme team 0 at 29.22 min
 29.37  [Playtest] finished armtide team 0 at 29.37 min
 29.51  [Playtest] finished armmex team 0 at 29.51 min
 29.60  [Playtest] finished armuwmme team 0 at 29.60 min
 29.69  [Playtest] finished armuwmme team 0 at 29.69 min
 29.82  [Playtest] finished armnanotcplat team 0 at 29.82 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +186.1 bank 6765/9100, energy +4095.0 bank 9535/11450, units 213
```

## Native lines (all AIs, first 120)

```
  0.09  EXP: approach: corcom(8444) at (1899, 5801) walks to (1900, 5829), 139 from the cormex site (1904, 5968)
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
