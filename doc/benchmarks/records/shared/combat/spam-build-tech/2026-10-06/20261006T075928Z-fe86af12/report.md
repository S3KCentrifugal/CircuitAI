# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.1 min (frame 10895); wall 83 s
- DLL: build-theatres\d216\SkirmishAI.dll (fff6f12b014ad652); AI BARbTest/test; staged 2026-10-06T04:58:00
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: spam-build.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T075800Z-10c99d22\runs\20261006T075928Z-fe86af12\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `spawn` | seen at 2.0 min | `[t=00:00:51.221563][f=0003677] [RangedArena] frame=3677 finished id=4077 team=0 unit=armlab cost=500` |
| expect `repeat` | seen at 2.1 min | `[t=00:00:51.397402][f=0003720] [RangedArena] frame=3720 factory id=4077 unit=armlab repeat=true builds=1 building=3744` |
| expect `offspring` | seen at 2.1 min | `[t=00:00:51.747931][f=0003804] [RangedArena] frame=3804 finished id=3744 team=0 unit=armpw cost=54` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T075800Z-10c99d22\runs\20261006T075928Z-fe86af12\screen_2026-10-06_07-58-46-038.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T075800Z-10c99d22\runs\20261006T075928Z-fe86af12\screen_2026-10-06_07-58-52-275.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T075800Z-10c99d22\runs\20261006T075928Z-fe86af12\screen_2026-10-06_07-59-00-279.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role TECH, team 0, speed 8, 0 shots, end at 6.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 3000/3000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [Layout] on for this AI
  0.08  [TECH][Opening] mexes within 700 elmos first (nearest 3); start factory held up to 240 s
  0.08  [TECH][Build] experimental build system on: direct range 1600, search radius 512
  0.08  [TECH][Opening] complete after 0 mexes, 0 s: the rush chain owns the opening; the lab is next
  0.08  [Layout] on for this AI
  0.08  [Layout] native factory pair committed facing 0, side offset -16 cells, forward offset 0 cells
  0.08  [Layout] home centre (3898, 2442), 98 from the start
  0.08  [Layout] turret box 40x44 cells at (4282, 2442), from the start rear 0, side 24, ground 98%, halo 87%: zone 7, 4 rows, 51 of 52 turret slots
  0.08  [Layout] advanced lab on the front line at (4042, 2866) facing 0, 0 cells ahead of turret row 0
  0.08  [Layout] the front is (3072, 5120): the labs face 0 (lane (3072, 5120), the pair faces 0)
  0.08  [Layout] advanced lab faces 0 (the pair faces 0)
  0.08  [Layout] advanced lab's footprint reserved at (4040, 2872), 451 from the home centre, 21 turret slots within reach, 7 flush (D-095)
  0.08  [Layout] forward cluster 40x44 cells at (4602, 3274), 8 cells ahead of the main cluster, ground 99%: zone 8, 4 rows, 52 turret slots
  0.08  [Rule] table of 50 rules loaded
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.17  [Playtest] finished armafus team 0 at 0.17 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armafus team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmmkr team 0 at 0.18 min
  0.18  [Playtest] finished armmex team 0 at 0.18 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.19  [Playtest] finished armmmkr team 0 at 0.19 min
  0.20  [Playtest] finished armmmkr team 0 at 0.19 min
  0.20  [Rule] chain.next for armcom 28429 | M +0 E 0/61 T1 E-float M-float
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Team][Roster] first mex 14262 at 3984,2608
  0.20  [Team][Roster] Re-announced: roster|1|0|0|TECH|armada|armlab|3997|2443|0|6|1|3984|2608
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.20  [Playtest] finished armmmkr team 0 at 0.20 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.21  [Playtest] finished armmmkr team 0 at 0.21 min
  0.22  [Playtest] finished armalab team 0 at 0.22 min
  0.23  [Playtest] finished armnanotc team 0 at 0.23 min
  0.23  [Rule] chain.next for armck 30293 | M +0 E 6/63 T2 E-float M-float
  0.23  [Playtest] finished armnanotc team 0 at 0.23 min
  0.23  [TECH][Factory] armalab: T2 constructor 1 of 10 (bank 3050 of 3050) (D-103)
  0.23  [Rule] chain.next for armck 25829 | M +0 E 6/63 T2 E-float M-float
  0.24  [Rule] chain.next for armck 4089 | M +0 E 12/66 T2 E-float M-float
  0.24  [TECH][Build] armck 4097 expands to a mex at (3184, 1904) at +0 metal
  0.24  [Rule] mex.expand for armck 4097 | M +0 E 12/66 T2 E-float M-float
  0.38  [Ferry] requested a transport (TECH at +20 metal, no transport)
  0.42  [Playtest] finished armmex team 0 at 0.43 min
  0.44  [Rule] power.turret for armcom 28429 | M +199 E 24056/4050 T2 E-float M-float
  0.45  [TECH][Factory] combat production unlocked at +210.719 metal (gate 200)
  0.48  [TECH][Factory] armalab: T2 constructor 2 of 10 (bank 3300 of 3300) (D-103)
  0.48  [TECH][Build] the economy is online (+210 metal): no lab is reclaimed for metal from now on (D-102, D-105)
  0.48  [Rule] power.turret for armack 19861 | M +210 E 24058/4274 T2 E-float M-float
  0.53  [Playtest] finished armmex team 0 at 0.53 min
  0.67  [Playtest] finished armmex team 0 at 0.67 min
  0.69  [Rule] defence.fortify for armack 19861 | M +214 E 24067/4344 T2 E-float M-float
  0.73  [TECH][Factory] armalab: T2 constructor 3 of 10 (bank 3400 of 3400) (D-103)
  0.73  [Rule] defence.fortify for armack 7961 | M +214 E 24072/4344 T2 E-float M-float
  0.77  [Playtest] finished armmex team 0 at 0.77 min
  0.78  [Rule] weapons.cluster for armck 4097 | M +214 E 24072/4347 T2 E-float M-float
  0.84  [Playtest] finished armmex team 0 at 0.84 min
  0.85  [Rule] weapons.cluster for armck 4089 | M +216 E 24072/4380 T2 E-float M-float
  0.95  [TECH][Factory] armalab: T2 constructor 4 of 10 (bank 3500 of 3500) (D-103)
  0.96  [Rule] chain.next for armack 17428 | M +218 E 24086/4421 T2 E-float M-float
  1.00  [Playtest] eco team 0 at 1.0 min: metal +219.9 bank 3493/3500, energy +24100.0 bank 1066443/1072700, units 47
  1.05  [Rule] power.turret for armcom 28429 | M +219 E 24086/4458 T2 E-float M-float
  1.18  [TECH][Factory] armalab: T2 constructor 5 of 10 (bank 3500 of 3500) (D-103)
  1.52  [Playtest] finished armmoho team 0 at 1.52 min
  1.54  [TECH][Factory] armalab: T2 constructor 6 of 10 (bank 3878 of 4050) (D-103)
  1.61  [Playtest] finished armnanotc team 0 at 1.61 min
  1.73  [Playtest] finished armnanotc team 0 at 1.73 min
  1.75  [Rule] chain.next for armack 12393 | M +225 E 24123/4568 T2 E-float M-float
  1.75  [Rule] weapons.cluster for armck 25829 | M +225 E 24126/4568 T2 E-float M-float
  1.76  [Rule] weapons.cluster for armck 30293 | M +225 E 24126/4568 T2 E-float M-float
  1.76  [Rule] assist.any for armcom 28429 | M +225 E 24126/4568 T2 E-float M-float
  1.76  [TECH][Factory] armalab: T2 constructor 7 of 10 (bank 4050 of 4050) (D-103)
  1.76  [Rule] chain.next for armack 22763 | M +225 E 24126/4568 T2 E-float M-float
  1.81  [Playtest] finished armrl team 0 at 1.81 min
  1.83  [Rule] weapons.cluster for armck 4097 | M +225 E 24128/4568 T2 E-float M-float
  1.83  [Playtest] finished armfort team 0 at 1.83 min
  1.84  [Rule] defence.fortify for armack 7961 | M +225 E 24128/4568 T2 E-float M-float
  1.91  [Playtest] finished armrl team 0 at 1.91 min
  1.93  [Playtest] finished armfort team 0 at 1.93 min
  1.93  [Playtest] finished armfort team 0 at 1.93 min
  1.93  [Rule] power.turret for armcom 28429 | M +225 E 24130/4568 T2 E-float M-float
  1.94  [Rule] defence.fortify for armack 19861 | M +225 E 24142/4568 T2 E-float M-float
  1.94  [Rule] defence.fortify for armack 7961 | M +225 E 24142/4568 T2 E-float M-float
  2.00  [TECH][Factory] armalab: T2 constructor 8 of 10 (bank 4050 of 4050) (D-103)
  2.00  [Rule] power.turret for armack 7059 | M +225 E 24142/4568 T2 E-float M-float
  2.00  [Playtest] eco team 0 at 2.0 min: metal +225.4 bank 4025/4050, energy +24142.0 bank 1066862/1073100, units 63
  2.03  [Playtest] finished armfort team 0 at 2.03 min
  2.03  [Playtest] finished armfort team 0 at 2.03 min
  2.04  [Rule] defence.fortify for armack 19861 | M +225 E 24142/4568 T2 E-float M-float
  2.04  [Playtest] finished armlab team 0 at 2.04 min
  2.04  [Rule] defence.fortify for armack 7961 | M +225 E 24142/4568 T2 E-float M-float
  2.05  [Rule] mex.upgrade for armack 17428 | M +225 E 24142/4568 T2 E-float M-float
  2.06  [Rule] power.turret for armack 8806 | M +225 E 24142/4568 T2 E-float M-float
  2.13  [Playtest] finished armfort team 0 at 2.13 min
  2.14  [Playtest] finished armfort team 0 at 2.14 min
  2.15  [Rule] defence.fortify for armack 7961 | M +225 E 24142/4568 T2 E-float M-float
  2.16  [Rule] defence.fortify for armack 19861 | M +225 E 24144/4568 T2 E-float M-float
  2.22  [TECH][Factory] armalab: T2 constructor 9 of 10 (bank 4150 of 4150) (D-103)
  2.22  [Rule] power.turret for armack 18926 | M +225 E 24156/4568 T2 E-float M-float
  2.23  [Playtest] finished armfort team 0 at 2.23 min
  2.24  [Playtest] finished armnanotc team 0 at 2.24 min
  2.25  [Rule] defence.fortify for armack 7961 | M +225 E 24156/4568 T2 E-float M-float
  2.27  [Playtest] finished armfort team 0 at 2.27 min
  2.34  [Playtest] finished armnanotc team 0 at 2.34 min
  2.34  [Playtest] finished armfort team 0 at 2.34 min
  2.37  [Rule] chain.next for armcom 28429 | M +225 E 24165/4568 T2 E-float M-float
  2.38  [Playtest] finished armrl team 0 at 2.38 min
  2.45  [TECH][Factory] armalab: T2 constructor 10 of 10 (bank 4150 of 4150) (D-103)
  2.67  [Playtest] finished armnanotc team 0 at 2.67 min
  2.76  [Playtest] finished armnanotc team 0 at 2.76 min
  2.79  [Rule] defence.fortify for armack 10131 | M +225 E 24188/4568 T2 E-float M-float
  2.79  [Rule] defence.fortify for armack 8806 | M +225 E 24188/4568 T2 E-float M-float
  2.80  [Rule] weapons.cluster for armck 25829 | M +225 E 24188/4568 T2 E-float M-float
  2.81  [Rule] weapons.cluster for armck 4089 | M +225 E 24188/4568 T2 E-float M-float
  2.81  [Rule] power.turret for armack 19861 | M +225 E 24188/4568 T2 E-float M-float
  2.81  [Rule] weapons.cluster for armck 30293 | M +225 E 24188/4568 T2 E-float M-float
  2.82  [Rule] weapons.cluster for armck 4097 | M +225 E 24188/4568 T2 E-float M-float
  2.82  [Rule] power.turret for armack 7961 | M +225 E 24188/4568 T2 E-float M-float
  2.83  [Rule] lab.base.reclaim for armfark 3624 | M +225 E 24188/4568 T2 E-float M-float
  2.88  [Playtest] finished armmoho team 0 at 2.88 min
  2.89  [Rule] lab.base.reclaim for armack 17428 | M +225 E 24193/4568 T2 E-float M-float
  2.95  [Playtest] finished armmoho team 0 at 2.95 min
  2.96  [Rule] lab.base.reclaim for armack 12393 | M +225 E 24199/4568 T2 E-float M-float
  2.98  [Playtest] finished armlab team 0 at 2.98 min
  2.99  [Rule] lab.base.reclaim for armack 7059 | M +225 E 24204/4568 T2 E-float M-float
  3.00  [Rule] lab.base.reclaim for armack 26630 | M +225 E 24204/4568 T2 E-float M-float
  3.00  [Playtest] eco team 0 at 3.0 min: metal +236.4 bank 5162/5350, energy +24210.0 bank 1067346/1073625, units 93
  3.08  [Playtest] finished armnanotc team 0 at 3.08 min
  3.09  [Rule] weapons.cluster for armck 25829 | M +236 E 24210/4788 T2 E-float M-float
  3.38  [Ferry] requested a transport (TECH at +20 metal, no transport)
  3.45  [Rule] lab.front for armack 7059 | M +236 E 24210/4788 T1 E-float M-float
  3.46  [Rule] lab.front for armack 26630 | M +236 E 24210/4788 T1 E-float M-float
  3.46  [Rule] lab.front for armack 17428 | M +236 E 24210/4788 T1 E-float M-float
  3.47  [Playtest] finished armfort team 0 at 3.47 min
  3.47  [Rule] defence.fortify for armack 12393 | M +236 E 24210/4788 T1 E-float M-float
  3.47  [Rule] lab.front for armfark 3624 | M +236 E 24210/4788 T1 E-float M-float
  3.48  [Rule] lab.front for armack 8806 | M +236 E 24210/4788 T1 E-float M-float
  3.64  [Playtest] finished armrl team 0 at 3.64 min
  3.65  [Playtest] finished armfus team 0 at 3.65 min
  3.66  [Rule] lab.front for armack 18926 | M +236 E 24210/4788 T1 E-float M-float
  3.67  [Rule] lab.front for armack 22763 | M +236 E 24210/4788 T1 E-float M-float
  3.67  [Rule] weapons.cluster for armck 4089 | M +236 E 24210/4788 T1 E-float M-float
  3.68  [Rule] lab.front for armack 19861 | M +236 E 24210/4788 T1 E-float M-float
  3.69  [Rule] lab.front for armack 7961 | M +236 E 24210/4788 T1 E-float M-float
  3.69  [Rule] power.turret for armcom 28429 | M +236 E 24210/4788 T1 E-float M-float
  3.84  [Playtest] finished armnanotc team 0 at 3.84 min
  3.85  [Rule] power.turret for armack 7059 | M +236 E 24810/4788 T1 E-float M-float
  3.85  [Rule] power.turret for armack 26630 | M +236 E 24810/4788 T1 E-float M-float
  3.86  [Rule] power.turret for armack 17428 | M +236 E 24810/4788 T1 E-float M-float
  3.86  [Rule] power.turret for armack 8806 | M +236 E 24810/4788 T1 E-float M-float
  3.87  [Rule] power.turret for armack 18926 | M +236 E 24810/4788 T1 E-float M-float
  3.87  [Rule] power.turret for armack 22763 | M +236 E 24810/4788 T1 E-float M-float
  3.88  [Rule] power.turret for armfark 3624 | M +236 E 24810/4788 T1 E-float M-float
  3.88  [Rule] power.turret for armack 19861 | M +236 E 24810/4788 T1 E-float M-float
  3.89  [Rule] weapons.cluster for armck 4097 | M +236 E 24960/4788 T1 E-float M-float
  3.89  [Rule] power.turret for armack 7961 | M +236 E 24960/4788 T1 E-float M-float
  3.91  [Playtest] finished armfort team 0 at 3.91 min
  3.91  [Playtest] finished armnanotc team 0 at 3.91 min
  3.92  [Rule] defence.fortify for armack 10131 | M +236 E 24960/4788 T1 E-float M-float
  3.93  [Playtest] finished armnanotc team 0 at 3.93 min
  3.94  [Rule] chain.next for armack 7059 | M +236 E 24960/4788 T1 E-float M-float
  3.94  [Rule] lab.t2 for armack 26630 | M +236 E 24960/4788 T1 E-float M-float
  3.95  [Rule] lab.t2 for armack 17428 | M +236 E 24960/4788 T1 E-float M-float
  3.95  [Rule] lab.t2 for armack 8806 | M +236 E 24960/4788 T1 E-float M-float
  3.96  [Rule] lab.t2 for armack 18926 | M +236 E 24960/4788 T1 E-float M-float
  3.97  [Rule] weapons.cluster for armck 25829 | M +236 E 24960/4788 T1 E-float M-float
  3.98  [Rule] weapons.cluster for armck 30293 | M +236 E 24960/4788 T1 E-float M-float
  4.00  [Playtest] eco team 0 at 4.0 min: metal +236.4 bank 5140/5150, energy +24960.0 bank 1070075/1075925, units 130
  4.07  [Rule] power.turret for armcom 28429 | M +236 E 24960/4788 T1 E-float M-float
  4.10  [Rule] power.turret for armack 22763 | M +236 E 24960/4788 T1 E-float M-float
  4.11  [Rule] power.turret for armfark 3624 | M +236 E 24960/4788 T1 E-float M-float
  4.12  [Rule] power.turret for armack 19861 | M +236 E 24960/4788 T1 E-float M-float
  4.12  [Rule] power.turret for armack 17428 | M +236 E 24960/4788 T1 E-float M-float
  4.15  [Rule] power.turret for armack 7961 | M +236 E 24960/4788 T1 E-float M-float
  4.15  [Playtest] finished armfort team 0 at 4.15 min
  4.17  [Rule] defence.fortify for armack 10131 | M +236 E 24960/4788 T1 E-float M-float
  4.20  [Playtest] finished armnanotc team 0 at 4.20 min
  4.22  [Rule] weapons.cluster for armck 4097 | M +236 E 24960/4788 T1 E-float M-float
  4.25  [Playtest] finished armfort team 0 at 4.25 min
  4.26  [Rule] defence.fortify for armack 10131 | M +236 E 24960/4788 T1 E-float M-float
  4.29  [Playtest] finished armnanotc team 0 at 4.29 min
  4.32  [Rule] weapons.cluster for armck 4089 | M +236 E 24960/4788 T1 E-float M-float
  4.34  [Playtest] finished armnanotc team 0 at 4.34 min
  4.36  [Playtest] finished armfort team 0 at 4.36 min
  4.36  [Rule] defence.fortify for armack 22763 | M +236 E 24960/4788 T1 E-float M-float
  4.37  [Rule] weapons.cluster for armck 25829 | M +236 E 24960/4788 T1 E-float M-float
  4.39  [Rule] power.turret for armack 10131 | M +236 E 24960/4788 T1 E-float M-float
  4.47  [Playtest] finished armfort team 0 at 4.47 min
  4.49  [Rule] defence.fortify for armack 12393 | M +236 E 24960/4788 T1 E-float M-float
  4.51  [Playtest] finished armnanotc team 0 at 4.51 min
  4.52  [Rule] weapons.cluster for armck 25829 | M +236 E 24960/4788 T1 E-float M-float
  4.55  [Playtest] finished armrl team 0 at 4.55 min
  4.57  [Rule] weapons.cluster for armck 30293 | M +236 E 24960/4788 T1 E-float M-float
  4.58  [Playtest] finished armnanotc team 0 at 4.58 min
  4.60  [Rule] weapons.cluster for armck 4089 | M +236 E 24960/4788 T1 E-float M-float
  4.61  [Playtest] finished armfort team 0 at 4.61 min
  4.62  [Rule] defence.fortify for armack 12393 | M +236 E 24960/4788 T1 E-float M-float
  4.69  [Playtest] finished armnanotc team 0 at 4.69 min
  4.70  [Playtest] finished armfort team 0 at 4.70 min
  4.70  [Rule] defence.fortify for armck 25829 | M +236 E 24960/4788 T1 E-float M-float
  4.71  [Rule] power.turret for armack 12393 | M +236 E 24960/4788 T1 E-float M-float
  4.72  [Playtest] finished armmoho team 0 at 4.72 min
  4.73  [Rule] power.turret for armack 7059 | M +236 E 24960/4788 T1 E-float M-float
  4.76  [Rule] lab.front for armack 7961 | M +236 E 24960/4788 T1 E-float M-float
  4.81  [Playtest] finished armrl team 0 at 4.81 min
  4.82  [Rule] lab.front for armack 7059 | M +236 E 24960/4788 T1 E-float M-float
  4.83  [Rule] lab.front for armack 10131 | M +236 E 24960/4788 T1 E-float M-float
  4.83  [Playtest] finished armnanotc team 0 at 4.83 min
  4.83  [Rule] chain.next for armack 17428 | M +236 E 24960/4788 T1 E-float M-float
  4.85  [Rule] weapons.cluster for armck 4097 | M +236 E 24960/4788 T1 E-float M-float
  4.86  [Rule] power.turret for armack 7059 | M +236 E 24960/4788 T1 E-float M-float
  4.86  [Rule] power.turret for armack 10131 | M +236 E 24960/4788 T1 E-float M-float
  4.87  [Layout] turrets: order 6 of 8 allowed (build power 3450 (13 by power), bank 5700 + 241/s (8 by metal), 0 dear frames take a slot)
  4.87  [Rule] power.turret for armck 30293 | M +241 E 24960/4898 T1 E-float M-float
  4.88  [Rule] power.turret for armack 7961 | M +241 E 24960/4898 T1 E-float M-float
  4.91  [Rule] power.turret for armack 12393 | M +241 E 24960/4898 T1 E-float M-float
  4.91  [Rule] power.turret for armfark 3624 | M +241 E 24960/4898 T1 E-float M-float
  4.92  [Playtest] finished armfort team 0 at 4.91 min
  4.93  [Rule] defence.fortify for armack 7059 | M +241 E 24960/4898 T1 E-float M-float
  4.94  [Rule] power.turret for armack 22763 | M +241 E 24960/4898 T1 E-float M-float
  5.00  [Playtest] eco team 0 at 5.0 min: metal +241.9 bank 5681/5700, energy +24960.0 bank 1069956/1075925, units 189
  5.04  [Rule] power.turret for armack 8806 | M +241 E 24960/4898 T1 E-float M-float
  5.21  [Playtest] finished armdrag team 0 at 5.21 min
  5.23  [Rule] defence.fortify for armck 25829 | M +241 E 24960/4898 T1 E-float M-float
  5.23  [Playtest] finished armnanotc team 0 at 5.23 min
  5.25  [Rule] weapons.cluster for armck 30293 | M +241 E 24960/4898 T1 E-float M-float
  5.25  [Playtest] finished armcir team 0 at 5.25 min
  5.27  [Playtest] finished armrl team 0 at 5.27 min
  5.28  [Playtest] finished armdrag team 0 at 5.28 min
  5.29  [Rule] defence.fortify for armack 19861 | M +241 E 24960/4898 T1 E-float M-float
  5.29  [Layout] turrets: order 7 of 8 allowed (build power 2190 (8 by power), bank 5700 + 242/s (8 by metal), 0 dear frames take a slot)
  5.29  [Rule] turret.build for armck 4097 | M +241 E 24960/4898 T1 E-float M-float
  5.30  [Rule] storage.metal for armcom 28429 | M +241 E 24960/4898 T1 E-float M-float
  5.33  [Layout] turrets: order 8 of 8 allowed (build power 2190 (8 by power), bank 5700 + 242/s (8 by metal), 0 dear frames take a slot)
  5.33  [Rule] turret.build for armck 25829 | M +241 E 24960/4898 T1 E-float M-float
  5.33  [Rule] storage.metal for armck 4089 | M +241 E 24960/4898 T1 E-float M-float
  5.37  [Rule] power.turret for armack 10131 | M +241 E 24960/4898 T1 E-float M-float
  5.38  [Rule] power.turret for armack 8806 | M +241 E 24960/4898 T1 E-float M-float
  5.38  [Rule] power.turret for armack 12393 | M +241 E 24960/4898 T1 E-float M-float
  5.40  [Rule] power.turret for armack 22763 | M +241 E 24960/4898 T1 E-float M-float
  5.41  [Rule] power.turret for armfark 3624 | M +241 E 24960/4898 T1 E-float M-float
  5.43  [Playtest] finished armnanotc team 0 at 5.43 min
  5.44  [Rule] power.turret for armack 7961 | M +241 E 24960/4898 T1 E-float M-float
  5.46  [Layout] turrets: order 8 of 8 allowed (build power 2640 (9 by power), bank 5700 + 241/s (8 by metal), 0 dear frames take a slot)
  5.46  [Rule] power.turret for armck 30293 | M +241 E 24960/4898 T1 E-float M-float
  5.59  [Playtest] finished armmstor team 0 at 5.59 min
  5.60  [Playtest] finished armnanotc team 0 at 5.60 min
  5.61  [Rule] chain.next for armcom 28429 | M +241 E 24960/4898 T1 E-float
  5.61  [Playtest] finished armfort team 0 at 5.61 min
  5.62  [Rule] defence.fortify for armck 30293 | M +241 E 24960/4898 T1 E-float
  5.63  [Layout] new set of armmmkr at (4176, 2576), 0 cell(s) from a turret
  5.63  [Rule] energy.convert.float for armack 7059 | M +241 E 24960/4898 T1 E-float
  5.71  [Playtest] finished armfort team 0 at 5.71 min
  5.73  [Rule] defence.fortify for armack 19861 | M +241 E 24960/4898 T1 E-float
  5.74  [Playtest] finished armnanotc team 0 at 5.74 min
  5.76  [Rule] weapons.cluster for armck 4097 | M +241 E 24960/4898 T1 E-float M-float
  5.81  [Playtest] finished armfort team 0 at 5.81 min
  5.82  [Playtest] finished armnanotc team 0 at 5.82 min
  5.82  [Rule] energy.convert.float for armack 19861 | M +241 E 24960/4898 T1 E-float M-float
  5.84  [Rule] defence.fortify for armck 25829 | M +241 E 24960/4898 T1 E-float M-float
  5.88  [Playtest] finished armnanotc team 0 at 5.88 min
  5.89  [Rule] chain.next for armck 4097 | M +241 E 24960/4898 T1 E-float M-float
  5.95  [Playtest] finished armmstor team 0 at 5.95 min
  5.96  [Rule] chain.next for armck 4089 | M +241 E 24960/4898 T1 E-float
  6.00  [Playtest] eco team 0 at 6.0 min: metal +241.9 bank 9121/11700, energy +24960.0 bank 1070216/1075925, units 253
```

## Native lines (all AIs, first 120)

```
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 0
  0.08  RESERVE: zone 7 at (4283, 2299) facing 0, 77x63 cells: 4373 of 4851 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4283, 2795) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4283, 2747) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4283, 2699) facing 0: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4283, 2651) facing 0: 12 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (4040, 2872) facing 0 (id 62)
  0.08  RESERVE: zone 8 at (4603, 3275) facing 0, 41x45 cells: 1837 of 1845 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4603, 3627) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4603, 3579) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4603, 3531) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (4603, 3483) facing 0: 13 of 13 slots (group 6, held, zone)
  0.08  RESERVE: armlab at (3360, 2864) facing 0 (id 115)
  0.08  RESERVE: zone 9 at (3360, 2792) facing 0, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (3360, 2816) facing 0: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: corridor 10 at (3456, 2840) facing 0, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 11 at (3360, 2840) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 11 at (3360, 3088) facing 0, 10x20 cells: 190 of 200 held
  0.08  RESERVE: armlab at (3088, 8880) facing 2 (id 1)
  0.08  RESERVE: zone 1 at (3088, 8952) facing 2, 6x3 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (3088, 8928) facing 2: 2 of 2 slots (group 1, zone)
  0.08  RESERVE: corridor 2 at (3184, 8904) facing 2, 6x21 cells: 114 of 126 held
  0.08  RESERVE: corridor 3 at (2992, 8904) facing 2, 6x21 cells: 126 of 126 held
  0.08  RESERVE: zone 4 at (3088, 8904) facing 0, 6x9 cells: 0 of 54 held
  0.08  RESERVE: corridor 4 at (3088, 8656) facing 2, 10x20 cells: 180 of 200 held
  0.17  RESERVE: armlab at (3120, 2784) facing 0 (id 118)
  0.17  RESERVE: zone 12 at (3120, 2712) facing 0, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3120, 2736) facing 0: 2 of 2 slots (group 8, zone)
  0.17  RESERVE: corridor 13 at (3216, 2760) facing 0, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 14 at (3120, 2760) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 14 at (3120, 3008) facing 0, 10x20 cells: 182 of 200 held
  0.17  RESERVE: armlab at (3968, 8784) facing 2 (id 4)
  0.17  RESERVE: zone 5 at (3968, 8856) facing 2, 6x3 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3968, 8832) facing 2: 2 of 2 slots (group 2, zone)
  0.17  RESERVE: corridor 6 at (4064, 8808) facing 2, 6x21 cells: 126 of 126 held
  0.17  RESERVE: zone 7 at (3968, 8808) facing 0, 6x9 cells: 0 of 54 held
  0.17  RESERVE: corridor 7 at (3968, 8560) facing 2, 10x20 cells: 190 of 200 held
  0.23  EXP: approach: armck(30293) at (3500, 1800) walks to (3594, 1896), 123 from the armmex site (3680, 1984)
  0.23  EXP: approach: armck(25829) at (3740, 1800) walks to (4117, 1759), 123 from the armmex site (4192, 1856)
  0.23  RESERVE: corridor 15 at (4400, 2032) facing 0, 14x20 cells: 0 of 280 held
  0.24  EXP: approach: armck(4089) at (3860, 1800) walks to (3920, 1354), 123 from the armmex site (3936, 1232)
  0.24  EXP: approach: armck(4097) at (3620, 1800) walks to (3303, 1876), 123 from the armmex site (3184, 1904)
  0.25  RESERVE: corridor 15 at (4400, 2032) facing 0, 14x20 cells: 0 of 280 held
  0.25  RESERVE: armalab at (3864, 3144) facing 0 (id 121)
  0.25  RESERVE: zone 15 at (3864, 3024) facing 0, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (3864, 3072) facing 0: 4 of 4 slots (group 9, zone)
  0.25  RESERVE: zone 16 at (3864, 3096) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 17 at (3864, 3392) facing 0, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 18 at (4480, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4480, 3744) facing 0 (id 126)
  0.25  RESERVE: zone 19 at (4448, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4448, 3744) facing 0 (id 127)
  0.25  RESERVE: zone 20 at (4416, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4416, 3744) facing 0 (id 128)
  0.25  RESERVE: zone 21 at (4384, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4384, 3744) facing 0 (id 129)
  0.25  RESERVE: zone 22 at (4352, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4352, 3744) facing 0 (id 130)
  0.25  RESERVE: zone 23 at (4320, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4320, 3744) facing 0 (id 131)
  0.25  RESERVE: zone 24 at (4288, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4288, 3744) facing 0 (id 132)
  0.25  RESERVE: zone 25 at (4256, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4256, 3744) facing 0 (id 133)
  0.25  RESERVE: zone 26 at (4224, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4224, 3744) facing 0 (id 134)
  0.25  RESERVE: zone 27 at (4192, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4192, 3744) facing 0 (id 135)
  0.25  RESERVE: zone 28 at (4160, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (4160, 3744) facing 0 (id 136)
  0.25  RESERVE: zone 29 at (3840, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3840, 3744) facing 0 (id 137)
  0.25  RESERVE: zone 30 at (3808, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3808, 3744) facing 0 (id 138)
  0.25  RESERVE: zone 31 at (3776, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3776, 3744) facing 0 (id 139)
  0.25  RESERVE: zone 32 at (3744, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3744, 3744) facing 0 (id 140)
  0.25  RESERVE: zone 33 at (3648, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3648, 3744) facing 0 (id 141)
  0.25  RESERVE: zone 34 at (3616, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3616, 3744) facing 0 (id 142)
  0.25  RESERVE: zone 35 at (3584, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3584, 3744) facing 0 (id 143)
  0.25  RESERVE: zone 36 at (3552, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3552, 3744) facing 0 (id 144)
  0.25  RESERVE: zone 37 at (3520, 3744) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3520, 3744) facing 0 (id 145)
  0.25  RESERVE: zone 38 at (4256, 3632) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armllt at (4256, 3632) facing 0 (id 146)
  0.25  RESERVE: zone 39 at (3736, 3624) facing 0, 3x3 cells: 9 of 9 held
  0.25  RESERVE: armrl at (3736, 3624) facing 0 (id 147)
  0.25  RESERVE: armalab at (2760, 8904) facing 2 (id 7)
  0.25  RESERVE: zone 8 at (2760, 9024) facing 2, 7x6 cells: 42 of 42 held
  0.25  RESERVE: grid of armnanotc 2x2 gap 0 behind (2760, 8976) facing 2: 4 of 4 slots (group 3, zone)
  0.25  RESERVE: zone 9 at (2760, 8952) facing 0, 9x15 cells: 12 of 135 held
  0.25  RESERVE: corridor 10 at (2760, 8656) facing 2, 13x20 cells: 260 of 260 held
  0.25  RESERVE: zone 11 at (3520, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3520, 8496) facing 0 (id 12)
  0.25  RESERVE: zone 12 at (3552, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3552, 8496) facing 0 (id 13)
  0.25  RESERVE: zone 13 at (3584, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3584, 8496) facing 0 (id 14)
  0.25  RESERVE: zone 14 at (3616, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3616, 8496) facing 0 (id 15)
  0.25  RESERVE: zone 15 at (3648, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3648, 8496) facing 0 (id 16)
  0.25  RESERVE: zone 16 at (3680, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3680, 8496) facing 0 (id 17)
  0.25  RESERVE: zone 17 at (3712, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3712, 8496) facing 0 (id 18)
  0.25  RESERVE: zone 18 at (3744, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3744, 8496) facing 0 (id 19)
  0.25  RESERVE: zone 19 at (3776, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3776, 8496) facing 0 (id 20)
  0.25  RESERVE: zone 20 at (3808, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3808, 8496) facing 0 (id 21)
  0.25  RESERVE: zone 21 at (3840, 8496) facing 0, 2x2 cells: 4 of 4 held
  0.25  RESERVE: armdrag at (3840, 8496) facing 0 (id 22)
  0.25  RESERVE: zone 22 at (4160, 8496) facing 0, 2x2 cells: 4 of 4 held
```
