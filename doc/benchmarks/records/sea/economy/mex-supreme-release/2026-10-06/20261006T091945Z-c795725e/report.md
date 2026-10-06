# Playtest report: PASS

- Verdict: **PASS** (reached 15 min)
- Game time reached: 15.5 min (frame 27901); wall 1 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T06:09:56
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: sea_compile.json; widget loaded: yes
- Log: build-theatres\games\sea\economy\mex-supreme-release\supreme\20261006T090956Z-4f53ee48\runs\20261006T091945Z-c795725e\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `observer` | seen at -0.0 min | `[t=00:00:31.316502][f=-000001] [SeaWatch] loaded` |
| expect `opening-yard` | seen at 1.5 min | `[t=00:00:47.607268][f=0002645] [SeaWatch] finished frame=2645 id=26482 def=armsy builder=28578` |
| expect `first-ship-exit` | seen at 1.9 min | `[t=00:00:49.716025][f=0003390] [SeaWatch] egress id=19532 yard=26482 seconds=10.6 worker=true` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- build-theatres\games\sea\economy\mex-supreme-release\supreme\20261006T090956Z-4f53ee48\runs\20261006T091945Z-c795725e\screen_2026-10-06_09-13-03-718.png
- build-theatres\games\sea\economy\mex-supreme-release\supreme\20261006T090956Z-4f53ee48\runs\20261006T091945Z-c795725e\screen_2026-10-06_09-13-29-709.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 12, 4 shots, end at 15.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.00  [Playtest] speed 12
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 33
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.20  [Playtest] finished armmex team 0 at 0.20 min
  0.22  [Team][Roster] first mex 6887 at 4608,11072
  0.22  [Team][Roster] Re-announced: roster|1|0|0|SEA|armada|armsy|4764|11076|0|7|1|4608|11072
  0.40  [Playtest] finished armmex team 0 at 0.40 min
  0.51  [Playtest] finished armwin team 0 at 0.51 min
  0.62  [Playtest] finished armwin team 0 at 0.62 min
  0.78  [Playtest] finished armwin team 0 at 0.78 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +6.6 bank 1080/1100, energy +86.4 bank 1001/1001, units 6
  1.47  [Playtest] finished armsy team 0 at 1.47 min
  1.55  [SEA][Layout] berth sea.berth.0 armasy at=6080,10048 facing=2
  1.67  [SEA][Layout] berth sea.berth.1 armplat at=6272,9936 facing=2
  2.00  [Playtest] eco team 0 at 2.0 min: metal +3.2 bank 615/1200, energy +73.8 bank 4/1151, units 9
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.3 bank 242/1200, energy +79.0 bank 1/1201, units 13
  3.13  [Playtest] finished armtide team 0 at 3.13 min
  3.25  [Playtest] finished armwin team 0 at 3.25 min
  3.33  [Playtest] finished armmex team 0 at 3.33 min
  3.36  [Playtest] finished armwin team 0 at 3.36 min
  3.73  [Playtest] finished armmex team 0 at 3.73 min
  3.84  [Playtest] finished armmex team 0 at 3.84 min
  4.00  [Playtest] eco team 0 at 4.0 min: metal +13.5 bank 7/1350, energy +157.5 bank 792/1252, units 19
  4.20  [Playtest] finished armmex team 0 at 4.20 min
  4.36  [Playtest] finished armmex team 0 at 4.36 min
  4.46  [Playtest] finished armmex team 0 at 4.46 min
  4.66  [Playtest] finished armtide team 0 at 4.66 min
  4.77  [Playtest] finished armmex team 0 at 4.77 min
  5.00  [Playtest] eco team 0 at 5.0 min: metal +21.9 bank 268/1550, energy +177.9 bank 1281/1302, units 26
  5.00  [Playtest] target team 0 at (4814, 11077) from its start position
  5.00  [Playtest] camera requested (4814,11077) height=2200
  5.00  [Playtest] camera captured name=ta position=(4814,11077) height=2200
  5.00  [Playtest] screenshot at 5.0 min of team 0 at (4814, 11077)
  5.16  [Playtest] finished armmex team 0 at 5.16 min
  5.16  [Playtest] finished armmex team 0 at 5.16 min
  5.56  [Playtest] finished armmex team 0 at 5.56 min
  5.82  [Playtest] finished armtide team 0 at 5.82 min
  5.88  [Playtest] finished armmex team 0 at 5.88 min
  5.94  [Playtest] finished armnanotcplat team 0 at 5.94 min
  6.00  [Playtest] eco team 0 at 6.0 min: metal +31.1 bank 721/1750, energy +177.3 bank 2/1352, units 34
  6.03  [Playtest] finished armrad team 0 at 6.03 min
  6.04  [Playtest] finished armtide team 0 at 6.04 min
  6.25  [Playtest] finished armllt team 0 at 6.25 min
  6.36  [Playtest] finished armtide team 0 at 6.36 min
  6.39  [Playtest] finished armtide team 0 at 6.39 min
  6.46  [Playtest] finished armmex team 0 at 6.46 min
  6.57  [Playtest] finished armtide team 0 at 6.57 min
  6.71  [Playtest] finished armtide team 0 at 6.71 min
  6.88  [Playtest] finished armtide team 0 at 6.88 min
  6.91  [Playtest] finished armmex team 0 at 6.91 min
  7.00  [Playtest] eco team 0 at 7.0 min: metal +35.7 bank 787/1850, energy +292.3 bank 647/1652, units 45
  7.05  [Playtest] finished armtide team 0 at 7.05 min
  7.12  [Playtest] finished armllt team 0 at 7.12 min
  7.18  [Playtest] finished armtide team 0 at 7.18 min
  7.31  [Playtest] finished armtide team 0 at 7.31 min
  7.48  [Playtest] finished armtide team 0 at 7.48 min
  7.73  [Playtest] finished armllt team 0 at 7.73 min
  7.96  [Playtest] finished armrad team 0 at 7.96 min
  8.00  [Playtest] eco team 0 at 8.0 min: metal +35.7 bank 948/1850, energy +332.2 bank 1180/1852, units 55
  8.32  [Playtest] finished armtide team 0 at 8.32 min
  8.35  [Playtest] finished armllt team 0 at 8.35 min
  8.48  [Playtest] finished armnanotcplat team 0 at 8.48 min
  8.53  [Playtest] finished armtide team 0 at 8.52 min
  8.65  [Playtest] finished armtide team 0 at 8.65 min
  8.66  [Playtest] finished armllt team 0 at 8.66 min
  8.70  [Playtest] finished armtide team 0 at 8.70 min
  8.83  [Playtest] finished armrad team 0 at 8.83 min
  9.00  [Playtest] eco team 0 at 9.0 min: metal +35.7 bank 582/1850, energy +472.7 bank 2052/2052, units 64
  9.52  [Playtest] finished armestor team 0 at 9.52 min
  9.65  [Playtest] finished armwin team 0 at 9.65 min
 10.00  [Playtest] eco team 0 at 10.0 min: metal +35.7 bank 915/1850, energy +512.6 bank 6561/8053, units 71
 10.00  [Playtest] camera requested (4814,11077) height=2200
 10.01  [Playtest] camera captured name=ta position=(4814,11077) height=2200
 10.01  [Playtest] screenshot at 10.0 min of team 0 at (4814, 11077)
 10.27  [Playtest] finished armtide team 0 at 10.27 min
 10.43  [Playtest] finished armmex team 0 at 10.43 min
 10.58  [Playtest] finished armllt team 0 at 10.58 min
 10.67  [Playtest] finished armfmkr team 0 at 10.67 min
 11.00  [Playtest] eco team 0 at 11.0 min: metal +39.0 bank 426/1900, energy +534.7 bank 7923/8103, units 80
 11.60  [Playtest] finished armfmkr team 0 at 11.60 min
 11.62  [Playtest] finished armfmkr team 0 at 11.62 min
 12.00  [Playtest] eco team 0 at 12.0 min: metal +41.0 bank 479/1900, energy +529.7 bank 6254/8103, units 88
 12.00  [Playtest] finished armfmkr team 0 at 12.00 min
 12.08  [Playtest] finished armtide team 0 at 12.08 min
 12.22  [Playtest] finished armfmkr team 0 at 12.22 min
 12.32  [Playtest] finished armtide team 0 at 12.32 min
 12.46  [Playtest] finished armtide team 0 at 12.46 min
 12.46  [Playtest] finished armfmkr team 0 at 12.47 min
 12.65  [Playtest] finished armtide team 0 at 12.65 min
 12.86  [Playtest] finished armtide team 0 at 12.86 min
 12.91  [Playtest] finished armtl team 0 at 12.91 min
 13.00  [Playtest] eco team 0 at 13.0 min: metal +44.0 bank 270/1900, energy +640.9 bank 6566/8353, units 99
 13.00  [Playtest] finished armtide team 0 at 13.00 min
 13.21  [Playtest] finished armfrad team 0 at 13.21 min
 13.42  [Playtest] finished armtide team 0 at 13.42 min
 13.79  [Playtest] finished armfrad team 0 at 13.79 min
 13.82  [Playtest] finished armtl team 0 at 13.82 min
 13.88  [Playtest] finished armtide team 0 at 13.88 min
 14.00  [Playtest] eco team 0 at 14.0 min: metal +44.0 bank 186/1900, energy +703.9 bank 7330/8503, units 107
 14.07  [Playtest] finished armtide team 0 at 14.07 min
 14.38  [Playtest] finished armtide team 0 at 14.38 min
 14.78  [Playtest] finished armtide team 0 at 14.78 min
 14.94  [Playtest] finished armtide team 0 at 14.94 min
 15.00  [Playtest] eco team 0 at 15.0 min: metal +44.0 bank 312/1900, energy +692.6 bank 7678/8703, units 115
 15.23  [Playtest] finished armfrad team 0 at 15.23 min
 15.44  [Playtest] finished armtide team 0 at 15.44 min
 15.50  [Playtest] end at 15.5 min: quitting
```

## Native lines (all AIs, first 120)

```
  1.48  RESERVE: zone 1 at (5768, 10872) facing 2, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (5768, 10872) facing 2 (id 1)
  1.48  RESERVE: zone 1 released
  1.48  RESERVE: corridor 2 at (5808, 10416) facing 2, 12x30 cells: 232 of 360 held
  1.48  RESERVE: zone 3 at (5936, 11488) facing 2, 40x40 cells: 1600 of 1600 held
  1.48  RESERVE: zone 3 released
  1.48  RESERVE: zone 4 at (6064, 11488) facing 2, 40x40 cells: 1600 of 1600 held
  1.48  RESERVE: zone 4 released
  1.48  RESERVE: zone 5 at (6192, 11488) facing 2, 40x40 cells: 1600 of 1600 held
  1.48  RESERVE: grid of armnanotcplat 4x4 gap 0 behind (6192, 11392) facing 2: 9 of 16 slots (group 3, held, zone)
  1.48  RESERVE: zone 5 released
  1.48  RESERVE: zone 1 at (6472, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6472, 1464) facing 0 (id 1)
  1.48  RESERVE: zone 2 at (6520, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6520, 1464) facing 0 (id 2)
  1.48  RESERVE: zone 1 released
  1.48  RESERVE: zone 2 released
  1.48  RESERVE: zone 3 at (6408, 1480) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6408, 1480) facing 0 (id 3)
  1.48  RESERVE: zone 4 at (6456, 1480) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6456, 1480) facing 0 (id 4)
  1.48  RESERVE: zone 5 at (6504, 1480) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6504, 1480) facing 0 (id 5)
  1.48  RESERVE: zone 3 released
  1.48  RESERVE: zone 4 released
  1.48  RESERVE: zone 5 released
  1.48  RESERVE: zone 6 at (6328, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6328, 1464) facing 0 (id 6)
  1.48  RESERVE: zone 7 at (6376, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6376, 1464) facing 0 (id 7)
  1.48  RESERVE: zone 8 at (6424, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6424, 1464) facing 0 (id 8)
  1.48  RESERVE: zone 9 at (6472, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6472, 1464) facing 0 (id 9)
  1.48  RESERVE: zone 10 at (6520, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6520, 1464) facing 0 (id 10)
  1.48  RESERVE: zone 11 at (6328, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6328, 1512) facing 0 (id 11)
  1.48  RESERVE: zone 6 released
  1.48  RESERVE: zone 7 released
  1.48  RESERVE: zone 8 released
  1.48  RESERVE: zone 9 released
  1.48  RESERVE: zone 10 released
  1.48  RESERVE: zone 11 released
  1.48  RESERVE: zone 12 at (6264, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6264, 1416) facing 0 (id 12)
  1.48  RESERVE: zone 13 at (6312, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6312, 1416) facing 0 (id 13)
  1.48  RESERVE: zone 14 at (6360, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6360, 1416) facing 0 (id 14)
  1.48  RESERVE: zone 15 at (6408, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6408, 1416) facing 0 (id 15)
  1.48  RESERVE: zone 16 at (6456, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6456, 1416) facing 0 (id 16)
  1.48  RESERVE: zone 17 at (6264, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6264, 1464) facing 0 (id 17)
  1.48  RESERVE: zone 18 at (6312, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6312, 1464) facing 0 (id 18)
  1.48  RESERVE: zone 19 at (6360, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6360, 1464) facing 0 (id 19)
  1.48  RESERVE: zone 20 at (6408, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6408, 1464) facing 0 (id 20)
  1.48  RESERVE: zone 21 at (6456, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6456, 1464) facing 0 (id 21)
  1.48  RESERVE: zone 22 at (6264, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6264, 1512) facing 0 (id 22)
  1.48  RESERVE: zone 23 at (6312, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6312, 1512) facing 0 (id 23)
  1.48  RESERVE: zone 12 released
  1.48  RESERVE: zone 13 released
  1.48  RESERVE: zone 14 released
  1.48  RESERVE: zone 15 released
  1.48  RESERVE: zone 16 released
  1.48  RESERVE: zone 17 released
  1.48  RESERVE: zone 18 released
  1.48  RESERVE: zone 19 released
  1.48  RESERVE: zone 20 released
  1.48  RESERVE: zone 21 released
  1.48  RESERVE: zone 22 released
  1.48  RESERVE: zone 23 released
  1.48  RESERVE: zone 24 at (6216, 1368) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6216, 1368) facing 0 (id 24)
  1.48  RESERVE: zone 25 at (6264, 1368) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6264, 1368) facing 0 (id 25)
  1.48  RESERVE: zone 26 at (6312, 1368) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6312, 1368) facing 0 (id 26)
  1.48  RESERVE: zone 27 at (6360, 1368) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6360, 1368) facing 0 (id 27)
  1.48  RESERVE: zone 28 at (6408, 1368) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6408, 1368) facing 0 (id 28)
  1.48  RESERVE: zone 29 at (6216, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6216, 1416) facing 0 (id 29)
  1.48  RESERVE: zone 30 at (6264, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6264, 1416) facing 0 (id 30)
  1.48  RESERVE: zone 31 at (6312, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6312, 1416) facing 0 (id 31)
  1.48  RESERVE: zone 32 at (6360, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6360, 1416) facing 0 (id 32)
  1.48  RESERVE: zone 33 at (6408, 1416) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6408, 1416) facing 0 (id 33)
  1.48  RESERVE: zone 34 at (6216, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6216, 1464) facing 0 (id 34)
  1.48  RESERVE: zone 35 at (6264, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6264, 1464) facing 0 (id 35)
  1.48  RESERVE: zone 36 at (6312, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6312, 1464) facing 0 (id 36)
  1.48  RESERVE: zone 37 at (6360, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6360, 1464) facing 0 (id 37)
  1.48  RESERVE: zone 38 at (6408, 1464) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6408, 1464) facing 0 (id 38)
  1.48  RESERVE: zone 39 at (6216, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6216, 1512) facing 0 (id 39)
  1.48  RESERVE: zone 40 at (6264, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6264, 1512) facing 0 (id 40)
  1.48  RESERVE: zone 41 at (6312, 1512) facing 0, 3x3 cells: 9 of 9 held
  1.48  RESERVE: armnanotcplat at (6312, 1512) facing 0 (id 41)
  1.48  RESERVE: zone 24 released
  1.48  RESERVE: zone 25 released
  1.48  RESERVE: zone 26 released
  1.48  RESERVE: zone 27 released
```
