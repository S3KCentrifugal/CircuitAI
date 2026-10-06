# Playtest report: PASS

- Verdict: **PASS** (reached 18 min)
- Game time reached: 18.0 min (frame 32400); wall 300 s
- DLL: build-theatres\d212-build2\SkirmishAI.dll (5879283eb5224a12); AI BARbTest/test; staged 2026-10-05T23:34:13
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: amphibious-transition.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T023413Z-faeead2f\runs\20261006T023922Z-dbfc2e50\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `partial-survey` | seen at 1.8 min | `[t=00:00:48.954943][f=0003300] [SeaInvasionTest] PASS partial-survey-blocked` |
| expect `complex` | seen at 6.0 min | `[t=00:01:47.178950][f=0010874] [SeaInvasionTest] PASS complex-finished` |
| expect `gantry` | seen at 11.9 min | `[t=00:03:06.217091][f=0021427] [SeaInvasionTest] PASS gantry-finished` |
| expect `complex-production` | seen at 7.3 min | `[t=00:02:03.210845][f=0013056] [SeaInvasionTest] PASS complex-produced` |
| expect `gantry-production` | seen at 12.2 min | `[t=00:03:09.744891][f=0021948] [SeaInvasionTest] PASS gantry-produced` |
| expect `landfall` | seen at 9.0 min | `[t=00:02:27.085583][f=0016200] [SeaInvasionTest] PASS landfall` |
| expect `backline` | seen at 10.0 min | `[t=00:02:40.684576][f=0018000] [SeaInvasionTest] PASS backline-reached` |
| forbid `errors` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T023413Z-faeead2f\runs\20261006T023922Z-dbfc2e50\screen_2026-10-06_02-35-14-069.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T023413Z-faeead2f\runs\20261006T023922Z-dbfc2e50\screen_2026-10-06_02-35-47-556.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T023413Z-faeead2f\runs\20261006T023922Z-dbfc2e50\screen_2026-10-06_02-35-57-402.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T023413Z-faeead2f\runs\20261006T023922Z-dbfc2e50\screen_2026-10-06_02-36-50-729.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T023413Z-faeead2f\runs\20261006T023922Z-dbfc2e50\screen_2026-10-06_02-36-58-610.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T023413Z-faeead2f\runs\20261006T023922Z-dbfc2e50\screen_2026-10-06_02-37-05-218.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\amphib-transition-armada\supreme\20261006T023413Z-faeead2f\runs\20261006T023922Z-dbfc2e50\screen_2026-10-06_02-38-41-549.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 20, 4 shots, end at 18.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 20000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 37
  0.00  [Playtest] speed 20
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (5800, 10500) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (11456, 1901) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 37
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.18  [Playtest] finished armsy team 0 at 0.18 min
  0.18  [Playtest] finished armasy team 0 at 0.18 min
  0.18  [Playtest] finished armplat team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwfus team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [Playtest] finished armuwmmm team 0 at 0.18 min
  0.18  [SEA][Layout] berth sea.berth.0 armasy at=7456,10032 facing=2
  0.20  [SEA][Layout] berth sea.berth.1 armplat at=7056,10032 facing=2
  0.40  [SEA][Layout] berth sea.berth.2 armsy at=7648,10032 facing=2
  0.53  [Playtest] finished armtide team 0 at 0.53 min
  0.92  [Playtest] finished armmex team 0 at 0.92 min
  0.93  [Team][Roster] first mex 227 at 6848,9664
  0.93  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|5826|10504|0|7|1|6848|9664
  0.96  [Playtest] finished armuwmme team 0 at 0.96 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +480.4 bank 41910/100950, energy +29027.0 bank 1048047/1061550, units 115
  1.21  [Playtest] finished armnanotcplat team 0 at 1.21 min
  1.28  [Playtest] finished armnanotcplat team 0 at 1.28 min
  1.37  [Playtest] finished armason team 0 at 1.37 min
  1.54  [Playtest] finished armmex team 0 at 1.54 min
  1.57  [Playtest] finished armuwmme team 0 at 1.57 min
  1.92  [Playtest] finished armtl team 0 at 1.92 min
  2.00  [Playtest] eco team 0 at 2.0 min: metal +486.6 bank 69019/101500, energy +29027.0 bank 1047968/1061550, units 121
  2.00  [Playtest] camera requested (8500,6500) height=8500
  2.01  [Playtest] camera captured name=ta position=(8500,6500) height=8500
  2.01  [Playtest] screenshot at 2.0 min of team 0 at (8500, 6500)
  2.04  [Playtest] finished armmex team 0 at 2.04 min
  2.19  [Playtest] finished armtl team 0 at 2.19 min
  2.27  [Playtest] finished armuwmme team 0 at 2.27 min
  2.36  [Playtest] finished armfrad team 0 at 2.36 min
  2.55  [Playtest] finished armason team 0 at 2.55 min
  2.95  [Playtest] finished armuwmme team 0 at 2.95 min
  3.00  [Playtest] eco team 0 at 3.0 min: metal +505.0 bank 96854/102700, energy +29027.0 bank 1047940/1061550, units 348
  3.00  [Playtest] finished armtl team 0 at 3.00 min
  3.30  [Playtest] finished armtl team 0 at 3.30 min
  3.56  [Playtest] finished armfrad team 0 at 3.56 min
  3.82  [Playtest] finished armmex team 0 at 3.82 min
  3.88  [Playtest] finished armuwmmm team 0 at 3.88 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +517.7 bank 102749/102750, energy +29027.0 bank 1047651/1061550, units 352
  4.41  [Playtest] finished armmex team 0 at 4.41 min
  4.72  [Playtest] finished armmex team 0 at 4.72 min
  4.97  [Playtest] finished armmex team 0 at 4.97 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +523.4 bank 102899/102900, energy +29027.0 bank 1047587/1061550, units 357
  5.00  [Playtest] camera requested (10800,4000) height=6500
  5.01  [Playtest] camera captured name=ta position=(10800,4000) height=6500
  5.01  [Playtest] screenshot at 5.0 min of team 0 at (10800, 4000)
  5.47  [Playtest] finished armmex team 0 at 5.47 min
  5.56  [Playtest] finished armuwmmm team 0 at 5.56 min
  5.78  [Playtest] finished armmex team 0 at 5.78 min
  5.92  [Playtest] finished armuwmmm team 0 at 5.92 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +551.5 bank 102999/103000, energy +29027.0 bank 1047065/1061550, units 359
  6.04  [Playtest] finished armamsub team 0 at 6.04 min
  6.41  [Playtest] finished armmex team 0 at 6.41 min
  6.62  [Playtest] finished armrad team 0 at 6.62 min
  6.85  [Playtest] finished armllt team 0 at 6.85 min
  6.87  [Playtest] finished armnanotcplat team 0 at 6.86 min
  6.90  [Playtest] finished armuwmmm team 0 at 6.90 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +561.2 bank 103049/103050, energy +29027.0 bank 1026140/1061700, units 366
  7.15  [Playtest] finished armnanotcplat team 0 at 7.15 min
  7.53  [Playtest] finished armllt team 0 at 7.53 min
  7.69  [Playtest] finished armnanotcplat team 0 at 7.69 min
  7.71  [Playtest] finished armrad team 0 at 7.70 min
  7.75  [Playtest] finished armuwmmm team 0 at 7.75 min
  7.96  [Playtest] finished armnanotcplat team 0 at 7.96 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +572.3 bank 103048/103050, energy +29027.0 bank 954137/1061700, units 374
  8.32  [Playtest] finished armllt team 0 at 8.32 min
  8.46  [Playtest] finished armrad team 0 at 8.46 min
  8.53  [Playtest] finished armnanotcplat team 0 at 8.53 min
  8.61  [Playtest] finished armnanotcplat team 0 at 8.61 min
  8.64  [Playtest] finished armnanotcplat team 0 at 8.64 min
  8.79  [Playtest] finished armnanotcplat team 0 at 8.78 min
  8.88  [Playtest] finished armnanotcplat team 0 at 8.88 min
  8.89  [Playtest] finished armnanotcplat team 0 at 8.89 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +572.3 bank 103046/103050, energy +29027.0 bank 836638/1061700, units 387
  9.06  [Playtest] finished armnanotcplat team 0 at 9.06 min
  9.19  [Playtest] finished armllt team 0 at 9.19 min
  9.30  [Playtest] finished armnanotcplat team 0 at 9.30 min
  9.38  [Playtest] finished armnanotcplat team 0 at 9.38 min
  9.44  [Playtest] finished armuwmmm team 0 at 9.44 min
  9.45  [Playtest] finished armrad team 0 at 9.45 min
  9.46  [Playtest] finished armnanotcplat team 0 at 9.46 min
  9.58  [Playtest] finished armnanotcplat team 0 at 9.58 min
  9.66  [Playtest] finished armnanotcplat team 0 at 9.66 min
  9.71  [Playtest] finished armnanotcplat team 0 at 9.71 min
  9.77  [Playtest] finished armnanotcplat team 0 at 9.77 min
  9.79  [Playtest] finished armnanotcplat team 0 at 9.79 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +536.3 bank 103043/103050, energy +29027.0 bank 810183/1061700, units 399
 10.00  [Playtest] camera requested (10800,4000) height=5500
 10.01  [Playtest] camera captured name=ta position=(10800,4000) height=5500
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (10800, 4000)
 10.17  [Playtest] finished armnanotcplat team 0 at 10.17 min
 10.17  [Playtest] finished armnanotcplat team 0 at 10.17 min
 10.26  [Playtest] finished armfrad team 0 at 10.26 min
 10.34  [Playtest] finished armnanotcplat team 0 at 10.34 min
 10.40  [Playtest] finished armnanotcplat team 0 at 10.40 min
 10.64  [Playtest] finished armnanotcplat team 0 at 10.64 min
 10.64  [Playtest] finished armnanotcplat team 0 at 10.64 min
 10.67  [Playtest] finished armnanotcplat team 0 at 10.67 min
 10.67  [Playtest] finished armtl team 0 at 10.67 min
 10.93  [Playtest] finished armnanotcplat team 0 at 10.93 min
 11.00  [Playtest] finished armtl team 0 at 11.00 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +537.3 bank 103044/103050, energy +29027.0 bank 810180/1061700, units 410
 11.31  [Playtest] finished armnanotcplat team 0 at 11.31 min
 11.39  [Playtest] finished armnanotcplat team 0 at 11.39 min
 11.39  [Playtest] finished armnanotcplat team 0 at 11.39 min
 11.41  [Playtest] finished armnanotcplat team 0 at 11.41 min
 11.68  [Playtest] finished armnanotcplat team 0 at 11.68 min
 11.90  [Playtest] finished armshltxuw team 0 at 11.90 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +520.9 bank 103844/103850, energy +29027.0 bank 810771/1063100, units 417
 12.06  [Playtest] finished armnanotcplat team 0 at 12.06 min
 12.11  [Playtest] finished armnanotcplat team 0 at 12.11 min
 12.21  [Playtest] finished armnanotcplat team 0 at 12.21 min
 12.34  [Playtest] finished armnanotcplat team 0 at 12.34 min
 12.43  [Playtest] finished armnanotcplat team 0 at 12.43 min
 12.52  [Playtest] finished armnanotcplat team 0 at 12.52 min
 12.87  [Playtest] finished armnanotcplat team 0 at 12.87 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +516.7 bank 103838/103850, energy +29027.0 bank 810701/1063100, units 428
 13.05  [Playtest] finished armnanotcplat team 0 at 13.05 min
 13.06  [Playtest] finished armnanotcplat team 0 at 13.06 min
 13.10  [Playtest] finished armnanotcplat team 0 at 13.10 min
 13.23  [Playtest] finished armnanotcplat team 0 at 13.23 min
 13.54  [Playtest] finished armnanotcplat team 0 at 13.54 min
 13.61  [Playtest] finished armnanotcplat team 0 at 13.61 min
 13.80  [Playtest] finished armnanotcplat team 0 at 13.80 min
 13.96  [Playtest] finished armnanotcplat team 0 at 13.96 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +523.1 bank 103840/103850, energy +29027.0 bank 810759/1063100, units 439
 14.04  [Playtest] finished armnanotcplat team 0 at 14.04 min
 14.28  [Playtest] finished armnanotcplat team 0 at 14.28 min
 14.29  [Playtest] finished armnanotcplat team 0 at 14.29 min
 14.45  [Playtest] finished armnanotcplat team 0 at 14.45 min
 14.54  [Playtest] finished armnanotcplat team 0 at 14.54 min
 14.70  [Playtest] finished armnanotcplat team 0 at 14.70 min
 14.87  [Playtest] finished armnanotcplat team 0 at 14.87 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +518.2 bank 103839/103850, energy +29027.0 bank 810771/1063100, units 449
 15.09  [Playtest] finished armnanotcplat team 0 at 15.09 min
 15.15  [Playtest] finished armnanotcplat team 0 at 15.15 min
 15.30  [Playtest] finished armnanotcplat team 0 at 15.30 min
 15.41  [Playtest] finished armnanotcplat team 0 at 15.41 min
 15.56  [Playtest] finished armnanotcplat team 0 at 15.56 min
 15.82  [Playtest] finished armnanotcplat team 0 at 15.82 min
 15.85  [Playtest] finished armnanotcplat team 0 at 15.85 min
 15.90  [Playtest] finished armnanotcplat team 0 at 15.90 min
 16.00  [Playtest] eco team 0 at 16.0 min: metal +515.4 bank 103834/103850, energy +29027.0 bank 810696/1063100, units 462
 16.00  [Playtest] camera requested (11000,2800) height=5500
 16.00  [Playtest] camera captured name=ta position=(11000,2800) height=5500
 16.00  [Playtest] screenshot at 16.0 min of team 0 at (11000, 2800)
 16.04  [Playtest] finished armnanotcplat team 0 at 16.04 min
 16.04  [Playtest] finished armnanotcplat team 0 at 16.04 min
 16.05  [Playtest] finished armnanotcplat team 0 at 16.05 min
 16.20  [Playtest] finished armnanotcplat team 0 at 16.20 min
 16.38  [Playtest] finished armnanotcplat team 0 at 16.38 min
 16.39  [Playtest] finished armnanotcplat team 0 at 16.39 min
 16.47  [Playtest] finished armnanotcplat team 0 at 16.47 min
 16.56  [Playtest] finished armnanotcplat team 0 at 16.56 min
 16.71  [Playtest] finished armnanotcplat team 0 at 16.71 min
 16.77  [Playtest] finished armnanotcplat team 0 at 16.77 min
 16.96  [Playtest] finished armnanotcplat team 0 at 16.96 min
 17.00  [Playtest] eco team 0 at 17.0 min: metal +518.0 bank 103842/103850, energy +29027.0 bank 810921/1063100, units 473
 17.05  [Playtest] finished armnanotcplat team 0 at 17.05 min
 17.18  [Playtest] finished armnanotcplat team 0 at 17.18 min
 17.49  [Playtest] finished armnanotcplat team 0 at 17.49 min
 17.52  [Playtest] finished armnanotcplat team 0 at 17.52 min
 17.74  [Playtest] finished armnanotcplat team 0 at 17.74 min
 17.83  [Playtest] finished armnanotcplat team 0 at 17.83 min
 18.00  [Playtest] eco team 0 at 18.0 min: metal +525.8 bank 103841/103850, energy +29027.0 bank 811103/1063100, units 479
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: zone 1 at (5912, 11112) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5912, 11112) facing 2 (id 1)
  0.08  RESERVE: zone 1 released
  0.08  RESERVE: zone 2 at (5864, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5864, 10984) facing 2 (id 2)
  0.08  RESERVE: zone 3 at (5816, 10984) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5816, 10984) facing 2 (id 3)
  0.08  RESERVE: zone 2 released
  0.08  RESERVE: zone 3 released
  0.08  RESERVE: zone 4 at (5880, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5880, 10952) facing 2 (id 4)
  0.08  RESERVE: zone 5 at (5832, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5832, 10952) facing 2 (id 5)
  0.08  RESERVE: zone 6 at (5784, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5784, 10952) facing 2 (id 6)
  0.08  RESERVE: zone 4 released
  0.08  RESERVE: zone 5 released
  0.08  RESERVE: zone 6 released
  0.08  RESERVE: zone 7 at (5912, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5912, 10936) facing 2 (id 7)
  0.08  RESERVE: zone 8 at (5864, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5864, 10936) facing 2 (id 8)
  0.08  RESERVE: zone 9 at (5816, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5816, 10936) facing 2 (id 9)
  0.08  RESERVE: zone 10 at (5768, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5768, 10936) facing 2 (id 10)
  0.08  RESERVE: zone 7 released
  0.08  RESERVE: zone 8 released
  0.08  RESERVE: zone 9 released
  0.08  RESERVE: zone 10 released
  0.08  RESERVE: zone 11 at (5944, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5944, 10920) facing 2 (id 11)
  0.08  RESERVE: zone 12 at (5896, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5896, 10920) facing 2 (id 12)
  0.08  RESERVE: zone 13 at (5848, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5848, 10920) facing 2 (id 13)
  0.08  RESERVE: zone 14 at (5800, 10920) facing 2, 3x3 cells: 9 of 9 held
  0.08  RESERVE: armtide at (5800, 10920) facing 2 (id 14)
  0.08  RESERVE: zone 11 released
  0.08  RESERVE: zone 12 released
  0.08  RESERVE: zone 13 released
  0.08  RESERVE: zone 14 released
  0.12  RESERVE: zone 15 at (5976, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5976, 10936) facing 2 (id 15)
  0.12  RESERVE: zone 16 at (5928, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5928, 10936) facing 2 (id 16)
  0.12  RESERVE: zone 17 at (5880, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5880, 10936) facing 2 (id 17)
  0.12  RESERVE: zone 18 at (5832, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5832, 10936) facing 2 (id 18)
  0.12  RESERVE: zone 19 at (5784, 10936) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5784, 10936) facing 2 (id 19)
  0.12  RESERVE: zone 15 released
  0.12  RESERVE: zone 16 released
  0.12  RESERVE: zone 17 released
  0.12  RESERVE: zone 18 released
  0.12  RESERVE: zone 19 released
  0.12  RESERVE: zone 20 at (6008, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10952) facing 2 (id 20)
  0.12  RESERVE: zone 21 at (5960, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10952) facing 2 (id 21)
  0.12  RESERVE: zone 22 at (5912, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10952) facing 2 (id 22)
  0.12  RESERVE: zone 23 at (5864, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10952) facing 2 (id 23)
  0.12  RESERVE: zone 24 at (5816, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10952) facing 2 (id 24)
  0.12  RESERVE: zone 25 at (5768, 10952) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10952) facing 2 (id 25)
  0.12  RESERVE: zone 26 at (6008, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10904) facing 2 (id 26)
  0.12  RESERVE: zone 27 at (5960, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10904) facing 2 (id 27)
  0.12  RESERVE: zone 28 at (5912, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10904) facing 2 (id 28)
  0.12  RESERVE: zone 29 at (5864, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10904) facing 2 (id 29)
  0.12  RESERVE: zone 30 at (5816, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10904) facing 2 (id 30)
  0.12  RESERVE: zone 31 at (5768, 10904) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10904) facing 2 (id 31)
  0.12  RESERVE: zone 32 at (6008, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10856) facing 2 (id 32)
  0.12  RESERVE: zone 33 at (5960, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10856) facing 2 (id 33)
  0.12  RESERVE: zone 34 at (5912, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10856) facing 2 (id 34)
  0.12  RESERVE: zone 35 at (5864, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10856) facing 2 (id 35)
  0.12  RESERVE: zone 36 at (5816, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10856) facing 2 (id 36)
  0.12  RESERVE: zone 37 at (5768, 10856) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10856) facing 2 (id 37)
  0.12  RESERVE: zone 38 at (6008, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10808) facing 2 (id 38)
  0.12  RESERVE: zone 39 at (5960, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10808) facing 2 (id 39)
  0.12  RESERVE: zone 40 at (5912, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10808) facing 2 (id 40)
  0.12  RESERVE: zone 41 at (5864, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10808) facing 2 (id 41)
  0.12  RESERVE: zone 42 at (5816, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10808) facing 2 (id 42)
  0.12  RESERVE: zone 43 at (5768, 10808) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10808) facing 2 (id 43)
  0.12  RESERVE: zone 44 at (6008, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10760) facing 2 (id 44)
  0.12  RESERVE: zone 45 at (5960, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5960, 10760) facing 2 (id 45)
  0.12  RESERVE: zone 46 at (5912, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5912, 10760) facing 2 (id 46)
  0.12  RESERVE: zone 47 at (5864, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5864, 10760) facing 2 (id 47)
  0.12  RESERVE: zone 48 at (5816, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5816, 10760) facing 2 (id 48)
  0.12  RESERVE: zone 49 at (5768, 10760) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (5768, 10760) facing 2 (id 49)
  0.12  RESERVE: zone 50 at (6008, 10712) facing 2, 3x3 cells: 9 of 9 held
  0.12  RESERVE: armtide at (6008, 10712) facing 2 (id 50)
  0.12  RESERVE: zone 51 at (5960, 10712) facing 2, 3x3 cells: 9 of 9 held
```
