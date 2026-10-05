# Playtest report: PASS

- Verdict: **PASS** (reached 30 min)
- Game time reached: 30.0 min (frame 54051); wall 227 s
- DLL: build-theatres\d189-baseline\SkirmishAI.dll (ac71826721992d84); AI BARbTest/test; staged 2026-10-04T07:14:50
- Map: Glacial Gap v1.1; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test, 2=SEA/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T101450Z-fd0796b8\runs\20261004T101839Z-7420ce20\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.364609][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.0 min | `[t=00:00:45.736992][f=0001781] [SeaWatch] finished frame=1781 id=3076 def=armsy builder=27123` |
| expect `first-ship-exit` | seen at 3.0 min | `[t=00:00:53.913870][f=0005460] [SeaWatch] egress id=2035 yard=3076 seconds=5.0 worker=false` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T101450Z-fd0796b8\runs\20261004T101839Z-7420ce20\screen_2026-10-04_10-15-56-581.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T101450Z-fd0796b8\runs\20261004T101839Z-7420ce20\screen_2026-10-04_10-16-19-335.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T101450Z-fd0796b8\runs\20261004T101839Z-7420ce20\screen_2026-10-04_10-17-30-330.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\economy\cohort-baseline\glacial\20261004T101450Z-fd0796b8\runs\20261004T101839Z-7420ce20\screen_2026-10-04_10-18-29-921.png

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
  0.17  [Team][Roster] team 2 first mex at 1904,5967
  0.28  [Playtest] finished armmex team 0 at 0.28 min
  0.99  [Playtest] finished armsy team 0 at 0.99 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.0 bank 747/1200, energy +30.0 bank 432/1100, units 4
  1.40  [Playtest] finished armmex team 0 at 1.40 min
  1.82  [Playtest] finished armtide team 0 at 1.82 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +8.0 bank 856/1250, energy +53.0 bank 66/1150, units 8
  2.02  [Playtest] finished armtide team 0 at 2.02 min
  2.26  [Playtest] finished armtide team 0 at 2.26 min
  2.51  [Playtest] finished armtide team 0 at 2.51 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +8.0 bank 613/1250, energy +136.0 bank 1388/1400, units 14
  3.07  [Playtest] finished armtide team 0 at 3.07 min
  3.12  [Playtest] finished armmex team 0 at 3.12 min
  3.37  [Playtest] finished armtide team 0 at 3.37 min
  3.58  [Playtest] finished armtl team 0 at 3.58 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +10.0 bank 246/1300, energy +182.0 bank 1434/1500, units 22
  4.01  [Playtest] finished armtide team 0 at 4.01 min
  4.03  [Playtest] finished armmex team 0 at 4.03 min
  4.23  [Playtest] finished armmex team 0 at 4.23 min
  4.32  [Playtest] finished armtide team 0 at 4.32 min
  4.43  [Playtest] finished armmex team 0 at 4.43 min
  4.60  [Playtest] finished armmex team 0 at 4.60 min
  4.62  [Playtest] finished armtide team 0 at 4.62 min
  4.93  [Playtest] finished armtide team 0 at 4.93 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +18.0 bank 43/1500, energy +274.0 bank 1693/1700, units 31
  5.00  [Playtest] camera requested (1450,4350) height=2800
  5.01  [Playtest] camera captured name=ta position=(1450,4350) height=2800
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (1450, 4350)
  5.12  [Playtest] finished armmex team 0 at 5.12 min
  5.24  [Playtest] finished armtide team 0 at 5.24 min
  5.37  [Playtest] finished armmex team 0 at 5.37 min
  5.53  [Playtest] finished armmex team 0 at 5.53 min
  5.56  [Playtest] finished armllt team 0 at 5.56 min
  5.67  [Playtest] finished armtide team 0 at 5.68 min
  5.91  [Playtest] finished armmex team 0 at 5.91 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +26.0 bank 307/1700, energy +327.0 bank 1814/1850, units 40
  6.02  [Playtest] finished armrad team 0 at 6.02 min
  6.53  [Playtest] finished armmex team 0 at 6.53 min
  6.53  [Playtest] finished armfrad team 0 at 6.53 min
  6.75  [Playtest] finished armmex team 0 at 6.74 min
  6.76  [Playtest] finished armmex team 0 at 6.76 min
  6.84  [Playtest] finished armfmkr team 0 at 6.84 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +33.0 bank 898/1850, energy +334.0 bank 1842/1900, units 45
  7.01  [Playtest] finished armtl team 0 at 7.01 min
  7.31  [Playtest] finished armmex team 0 at 7.31 min
  7.34  [Playtest] finished armtide team 0 at 7.34 min
  7.53  [Playtest] finished armmex team 0 at 7.53 min
  7.66  [Playtest] finished armtide team 0 at 7.66 min
  7.68  [Playtest] finished armtide team 0 at 7.68 min
  7.72  [Playtest] finished armmex team 0 at 7.72 min
  7.98  [Playtest] finished armtide team 0 at 7.98 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +39.0 bank 1797/2000, energy +410.0 bank 2135/2150, units 53
  8.05  [Playtest] finished armtide team 0 at 8.05 min
  8.16  [Playtest] finished armmex team 0 at 8.16 min
  8.45  [Playtest] finished armtide team 0 at 8.45 min
  8.55  [Playtest] finished armtide team 0 at 8.56 min
  8.86  [Playtest] finished armmex team 0 at 8.86 min
  8.87  [Playtest] finished armtide team 0 at 8.87 min
  8.91  [Playtest] finished armtide team 0 at 8.91 min
  8.96  [Playtest] finished armmex team 0 at 8.96 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +45.0 bank 1897/2150, energy +555.0 bank 2434/2450, units 64
  9.09  [Playtest] finished armmex team 0 at 9.09 min
  9.26  [Playtest] finished armmex team 0 at 9.26 min
  9.27  [Playtest] finished armtide team 0 at 9.27 min
  9.39  [Playtest] finished armtide team 0 at 9.39 min
  9.48  [Playtest] finished armfmkr team 0 at 9.48 min
  9.52  [Playtest] finished armmex team 0 at 9.52 min
  9.64  [Playtest] finished armtide team 0 at 9.64 min
  9.68  [Playtest] finished armmex team 0 at 9.68 min
  9.70  [Playtest] finished armtide team 0 at 9.70 min
  9.79  [Playtest] finished armtide team 0 at 9.79 min
  9.85  [Playtest] finished armllt team 0 at 9.85 min
  9.97  [Playtest] finished armtide team 0 at 9.97 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +54.0 bank 2348/2350, energy +693.0 bank 2744/2750, units 77
 10.00  [Playtest] camera requested (1450,4350) height=3200
 10.01  [Playtest] camera captured name=ta position=(1450,4350) height=3200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (1450, 4350)
 10.04  [Playtest] finished armtide team 0 at 10.04 min
 10.06  [Playtest] finished armtide team 0 at 10.06 min
 10.18  [Playtest] finished armtide team 0 at 10.18 min
 10.33  [Playtest] finished armmex team 0 at 10.33 min
 10.45  [Playtest] finished armllt team 0 at 10.45 min
 10.46  [Playtest] finished armtide team 0 at 10.46 min
 10.47  [Playtest] finished armtide team 0 at 10.47 min
 10.56  [Playtest] finished armtide team 0 at 10.56 min
 10.61  [Playtest] finished armrad team 0 at 10.60 min
 10.84  [Playtest] finished armtide team 0 at 10.84 min
 10.85  [Playtest] finished armtide team 0 at 10.85 min
 10.88  [Playtest] finished armtide team 0 at 10.88 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +56.0 bank 2398/2400, energy +893.0 bank 3143/3150, units 86
 11.58  [Playtest] finished armtide team 0 at 11.58 min
 11.59  [Playtest] finished armllt team 0 at 11.59 min
 11.61  [Playtest] finished armtide team 0 at 11.61 min
 11.88  [Playtest] finished armnanotcplat team 0 at 11.88 min
 11.93  [Playtest] finished armtide team 0 at 11.93 min
 11.95  [Playtest] finished armtide team 0 at 11.95 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +56.0 bank 1818/2400, energy +985.0 bank 3340/3350, units 95
 12.25  [Playtest] finished armtide team 0 at 12.25 min
 12.29  [Playtest] finished armtide team 0 at 12.28 min
 12.78  [Playtest] finished armasy team 0 at 12.78 min
 12.81  [Playtest] finished armtide team 0 at 12.81 min
 13.00  [Playtest] finished armtide team 0 at 13.00 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +54.0 bank 757/2550, energy +1061.0 bank 3728/3800, units 100
 13.13  [Playtest] finished armtide team 0 at 13.13 min
 13.18  [Playtest] finished armfmkr team 0 at 13.18 min
 13.33  [Playtest] finished armtide team 0 at 13.33 min
 13.39  [Playtest] finished armfmkr team 0 at 13.39 min
 13.39  [Playtest] finished armtide team 0 at 13.39 min
 13.51  [Playtest] finished armtide team 0 at 13.51 min
 13.57  [Playtest] finished armfmkr team 0 at 13.57 min
 13.71  [Playtest] finished armtide team 0 at 13.71 min
 13.74  [Playtest] finished armfmkr team 0 at 13.74 min
 13.84  [Playtest] finished armtide team 0 at 13.84 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +58.0 bank 481/2550, energy +1252.0 bank 3747/4250, units 114
 14.08  [Playtest] finished armnanotcplat team 0 at 14.08 min
 14.08  [Playtest] finished armuwmme team 0 at 14.08 min
 14.25  [Playtest] finished armnanotcplat team 0 at 14.25 min
 14.28  [Playtest] finished armmex team 0 at 14.28 min
 14.51  [Playtest] finished armtide team 0 at 14.51 min
 14.64  [Playtest] finished armuwmme team 0 at 14.64 min
 14.73  [Playtest] finished armmex team 0 at 14.73 min
 14.73  [Playtest] finished armnanotcplat team 0 at 14.73 min
 14.93  [Playtest] finished armmex team 0 at 14.93 min
 14.96  [Playtest] finished armuwmme team 0 at 14.96 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +78.1 bank 48/4300, energy +1305.0 bank 3564/4450, units 124
 15.16  [Playtest] finished armtide team 0 at 15.16 min
 15.23  [Playtest] finished armmex team 0 at 15.23 min
 15.48  [Playtest] finished armmex team 0 at 15.48 min
 15.49  [Playtest] finished armtide team 0 at 15.49 min
 15.75  [Playtest] finished armmex team 0 at 15.75 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +86.0 bank 39/4450, energy +1351.0 bank 4289/4550, units 129
 16.05  [Playtest] finished armtl team 0 at 16.05 min
 16.29  [Playtest] finished armmex team 0 at 16.29 min
 16.65  [Playtest] finished armmex team 0 at 16.65 min
 16.84  [Playtest] finished armuwfus team 0 at 16.84 min
 16.95  [Playtest] finished armtl team 0 at 16.95 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +86.0 bank 73/4450, energy +2551.0 bank 6967/7050, units 132
 17.33  [Playtest] finished armtide team 0 at 17.33 min
 17.43  [Playtest] finished armfmkr team 0 at 17.43 min
 17.46  [Playtest] finished armmex team 0 at 17.46 min
 17.74  [Playtest] finished armfmkr team 0 at 17.74 min
 17.81  [Playtest] finished armfmkr team 0 at 17.81 min
 17.91  [Playtest] finished armfmkr team 0 at 17.91 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +90.0 bank 1313/4450, energy +2574.0 bank 6827/7100, units 145
 18.19  [Playtest] finished armfmkr team 0 at 18.19 min
 18.32  [Playtest] finished armmship team 0 at 18.32 min
 18.34  [Playtest] finished armfmkr team 0 at 18.34 min
 18.61  [Playtest] finished armmex team 0 at 18.61 min
 18.68  [Playtest] finished armfmkr team 0 at 18.68 min
 18.68  [Playtest] finished armfmkr team 0 at 18.68 min
 18.84  [Playtest] finished armfmkr team 0 at 18.84 min
 18.90  [Playtest] finished armfmkr team 0 at 18.90 min
 19.00  [Playtest] eco team 0 at 19.0 min: metal +98.0 bank 46/4500, energy +2567.0 bank 6556/7050, units 153
 19.04  [Playtest] finished armfmkr team 0 at 19.04 min
 19.14  [Playtest] finished armfmkr team 0 at 19.14 min
 19.54  [Playtest] finished armmship team 0 at 19.54 min
 19.56  [Playtest] finished armuwfus team 0 at 19.56 min
 19.69  [Playtest] finished armuwmmm team 0 at 19.69 min
 19.85  [Playtest] finished armfmkr team 0 at 19.85 min
 19.91  [Playtest] finished armfmkr team 0 at 19.91 min
 19.99  [Playtest] finished armmship team 0 at 19.99 min
 20.00  [Playtest] eco team 0 at 20.0 min: metal +110.3 bank 106/4450, energy +3762.5 bank 8845/9600, units 158
 20.00  [Playtest] camera requested (1700,4550) height=3800
 20.02  [Playtest] camera captured name=ta position=(1700,4550) height=3800
 20.02  [Playtest] screenshot at 20.0 min of team 0 at (1700, 4550)
 20.03  [Playtest] finished armfmkr team 0 at 20.03 min
 20.09  [Playtest] finished armfmkr team 0 at 20.09 min
 20.17  [Playtest] finished armfmkr team 0 at 20.17 min
 20.24  [Playtest] finished armfmkr team 0 at 20.24 min
 20.46  [Playtest] finished armmship team 0 at 20.46 min
 20.92  [Playtest] finished armmship team 0 at 20.92 min
 21.00  [Playtest] eco team 0 at 21.0 min: metal +114.3 bank 120/4450, energy +3774.0 bank 8222/9600, units 165
 21.08  [Playtest] finished armuwmmm team 0 at 21.08 min
 21.29  [Playtest] finished armuwmmm team 0 at 21.29 min
 21.48  [Playtest] finished armmex team 0 at 21.48 min
 21.50  [Playtest] finished armnanotcplat team 0 at 21.50 min
 21.66  [Playtest] finished armnanotcplat team 0 at 21.66 min
 22.00  [Playtest] eco team 0 at 22.0 min: metal +114.4 bank 1003/4500, energy +4074.0 bank 9272/11100, units 170
 22.04  [Playtest] finished armuwmmm team 0 at 22.04 min
 23.00  [Playtest] eco team 0 at 23.0 min: metal +125.8 bank 1374/4450, energy +4074.0 bank 9680/11100, units 168
 23.61  [Playtest] finished armtl team 0 at 23.61 min
 24.00  [Playtest] eco team 0 at 24.0 min: metal +124.5 bank 2041/4450, energy +4074.0 bank 9589/11100, units 172
 24.14  [Playtest] finished armtl team 0 at 24.14 min
 24.24  [Playtest] finished armtl team 0 at 24.24 min
 24.48  [Playtest] finished armtl team 0 at 24.48 min
 24.53  [Playtest] finished armtl team 0 at 24.53 min
 24.58  [Playtest] finished armepoch team 0 at 24.58 min
 24.82  [Playtest] finished armtl team 0 at 24.82 min
 24.95  [Playtest] finished armmex team 0 at 24.95 min
 25.00  [Playtest] eco team 0 at 25.0 min: metal +133.2 bank 3866/4500, energy +4104.0 bank 9957/11250, units 181
 25.04  [Playtest] finished coruwmme team 0 at 25.04 min
 25.15  [Playtest] finished armtl team 0 at 25.15 min
 25.31  [Playtest] finished armtl team 0 at 25.31 min
 25.99  [Playtest] finished armuwmmm team 0 at 25.99 min
 26.00  [Playtest] eco team 0 at 26.0 min: metal +126.1 bank 4784/5000, energy +4164.0 bank 10016/11550, units 186
 26.10  [Playtest] finished armtl team 0 at 26.10 min
 26.25  [SEA][Layout] berth sea.berth.3 armsy at=3360,4272 facing=1
 26.27  [Playtest] finished armnanotcplat team 0 at 26.27 min
 26.31  [Playtest] finished armuwmmm team 0 at 26.31 min
 26.68  [Playtest] finished armuwmme team 0 at 26.68 min
 26.74  [Playtest] finished armbats team 0 at 26.74 min
 26.97  [Playtest] finished armuwmme team 0 at 26.97 min
 27.00  [Playtest] eco team 0 at 27.0 min: metal +195.8 bank 4734/6100, energy +4224.0 bank 10351/11850, units 191
 27.23  [Playtest] finished armrl team 0 at 27.23 min
 27.27  [Playtest] finished armsy team 0 at 27.27 min
 27.50  [Playtest] finished armtl team 0 at 27.50 min
 27.52  [SEA][Layout] berth sea.berth.4 corsy at=2320,3632 facing=1
 27.55  [Playtest] finished armuwmme team 0 at 27.55 min
 27.77  [Playtest] finished armbats team 0 at 27.77 min
 27.79  [Playtest] finished armnanotcplat team 0 at 27.79 min
 28.00  [Playtest] eco team 0 at 28.0 min: metal +145.9 bank 5589/6750, energy +4254.0 bank 10100/12100, units 204
 28.08  [Playtest] finished armuwmme team 0 at 28.08 min
 28.30  [Playtest] finished armnanotcplat team 0 at 28.30 min
 28.49  [Playtest] finished corsy team 0 at 28.49 min
 28.51  [Playtest] finished armnanotcplat team 0 at 28.51 min
 28.62  [Playtest] finished armnanotcplat team 0 at 28.62 min
 28.73  [Playtest] finished armbats team 0 at 28.73 min
 28.74  [Playtest] finished armnanotcplat team 0 at 28.74 min
 28.80  [Playtest] finished armnanotcplat team 0 at 28.80 min
 28.91  [Playtest] finished armnanotcplat team 0 at 28.91 min
 29.00  [Playtest] eco team 0 at 29.0 min: metal +163.8 bank 6053/7400, energy +4321.0 bank 10856/12550, units 215
 29.00  [Playtest] camera requested (1700,4550) height=4000
 29.02  [Playtest] camera captured name=ta position=(1700,4550) height=4000
 29.02  [Playtest] screenshot at 29.0 min of team 0 at (1700, 4550)
 29.60  [Playtest] finished armnanotcplat team 0 at 29.60 min
 29.67  [Playtest] finished armbats team 0 at 29.67 min
 30.00  [Playtest] eco team 0 at 30.0 min: metal +138.9 bank 5378/7400, energy +4372.0 bank 10479/12900, units 228
 30.02  [Playtest] finished armuwmme team 0 at 30.02 min
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
