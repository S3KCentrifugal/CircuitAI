# Playtest report: PASS

- Verdict: **PASS** (reached 6 min)
- Game time reached: 6.1 min (frame 11011); wall 84 s
- DLL: build-theatres\d216-final\SkirmishAI.dll (45eb0f2e89a285e3); AI BARbTest/test; staged 2026-10-06T05:13:25
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=TECH/armada/test, 1=TECH/armada/test
- Team 0 (under test): skirmish AI 0, role TECH
- Checks: spam-build.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T081325Z-f9282d86\runs\20261006T081453Z-66b86353\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `spawn` | seen at 2.1 min | `[t=00:00:52.238488][f=0003815] [RangedArena] frame=3815 finished id=5644 team=0 unit=armlab cost=500` |
| expect `repeat` | seen at 2.1 min | `[t=00:00:52.470402][f=0003870] [RangedArena] frame=3870 factory id=5644 unit=armlab repeat=true builds=1 building=25277` |
| expect `offspring` | seen at 2.2 min | `[t=00:00:52.815113][f=0003953] [RangedArena] frame=3953 finished id=25277 team=0 unit=armpw cost=54` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T081325Z-f9282d86\runs\20261006T081453Z-66b86353\screen_2026-10-06_08-14-11-410.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T081325Z-f9282d86\runs\20261006T081453Z-66b86353\screen_2026-10-06_08-14-17-655.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\spam-build-tech\glitters\20261006T081325Z-f9282d86\runs\20261006T081453Z-66b86353\screen_2026-10-06_08-14-25-646.png

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
  0.18  [Playtest] finished armmmkr team 0 at 0.19 min
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
  0.23  [Rule] chain.next for armck 4097 | M +0 E 6/63 T2 E-float M-float
  0.24  [Rule] chain.next for armck 4089 | M +0 E 12/66 T2 E-float M-float
  0.24  [TECH][Build] armck 25829 expands to a mex at (3936, 1232) at +0 metal
  0.24  [Rule] mex.expand for armck 25829 | M +0 E 12/66 T2 E-float M-float
  0.38  [Ferry] requested a transport (TECH at +20 metal, no transport)
  0.42  [Playtest] finished armmex team 0 at 0.43 min
  0.44  [Rule] power.turret for armcom 28429 | M +199 E 24056/4050 T2 E-float M-float
  0.45  [TECH][Factory] combat production unlocked at +210.719 metal (gate 200)
  0.48  [TECH][Build] the economy is online (+210 metal): no lab is reclaimed for metal from now on (D-102, D-105)
  0.48  [Rule] power.turret for armack 19861 | M +210 E 24058/4274 T2 E-float M-float
  0.49  [TECH][Factory] armalab: T2 constructor 2 of 10 (bank 3300 of 3300) (D-103)
  0.52  [Playtest] finished armmex team 0 at 0.52 min
  0.67  [Playtest] finished armmex team 0 at 0.67 min
  0.69  [Rule] defence.fortify for armack 19861 | M +214 E 24067/4347 T2 E-float M-float
  0.72  [Rule] defence.fortify for armack 7961 | M +214 E 24072/4347 T2 E-float M-float
  0.72  [TECH][Factory] armalab: T2 constructor 3 of 10 (bank 3400 of 3400) (D-103)
  0.76  [Playtest] finished armmex team 0 at 0.76 min
  0.78  [Rule] weapons.cluster for armck 4097 | M +214 E 24072/4347 T2 E-float M-float
  0.86  [Playtest] finished armmex team 0 at 0.86 min
  0.87  [Rule] weapons.cluster for armck 25829 | M +216 E 24073/4380 T2 E-float M-float
  0.95  [Rule] chain.next for armack 17428 | M +217 E 24084/4417 T2 E-float M-float
  0.95  [TECH][Factory] armalab: T2 constructor 4 of 10 (bank 3500 of 3500) (D-103)
  1.00  [Playtest] eco team 0 at 1.0 min: metal +219.9 bank 3493/3500, energy +24100.0 bank 1066443/1072700, units 47
  1.00  [Rule] power.turret for armcom 28429 | M +218 E 24086/4421 T2 E-float M-float
  1.18  [TECH][Factory] armalab: T2 constructor 5 of 10 (bank 3500 of 3500) (D-103)
  1.38  [Playtest] finished armmoho team 0 at 1.38 min
  1.48  [TECH][Factory] armalab: T2 constructor 6 of 10 (bank 4050 of 4050) (D-103)
  1.72  [TECH][Factory] armalab: T2 constructor 7 of 10 (bank 4050 of 4050) (D-103)
  1.80  [Playtest] finished armrl team 0 at 1.80 min
  1.82  [Playtest] finished armfort team 0 at 1.82 min
  1.88  [Playtest] finished armnanotc team 0 at 1.88 min
  1.93  [Playtest] finished armfort team 0 at 1.93 min
  1.93  [Playtest] finished armrl team 0 at 1.93 min
  1.94  [TECH][Factory] armalab: T2 constructor 8 of 10 (bank 4050 of 4050) (D-103)
  1.95  [Playtest] finished armnanotc team 0 at 1.95 min
  1.97  [Rule] defence.fortify for armck 30293 | M +225 E 24142/4568 T2 E-float M-float
  1.98  [Rule] defence.fortify for armack 19861 | M +225 E 24142/4568 T2 E-float M-float
  1.98  [Rule] weapons.cluster for armck 25829 | M +225 E 24142/4568 T2 E-float M-float
  1.99  [Rule] chain.next for armack 8806 | M +225 E 24142/4568 T2 E-float M-float
  1.99  [Rule] power.turret for armack 7961 | M +225 E 24142/4568 T2 E-float M-float
  2.00  [Rule] power.turret for armack 17428 | M +225 E 24142/4568 T2 E-float M-float
  2.00  [Playtest] eco team 0 at 2.0 min: metal +225.4 bank 4035/4050, energy +24156.0 bank 1066836/1073100, units 58
  2.00  [Rule] power.turret for armack 27839 | M +225 E 24142/4568 T2 E-float M-float
  2.01  [Rule] power.turret for armack 12393 | M +225 E 24142/4568 T2 E-float M-float
  2.01  [Rule] power.turret for armack 13370 | M +225 E 24142/4568 T2 E-float M-float
  2.06  [Playtest] finished armfort team 0 at 2.06 min
  2.08  [Rule] defence.fortify for armack 19861 | M +225 E 24146/4568 T2 E-float M-float
  2.12  [Playtest] finished armlab team 0 at 2.12 min
  2.16  [Playtest] finished armfort team 0 at 2.16 min
  2.17  [Rule] defence.fortify for armack 13370 | M +225 E 24154/4568 T2 E-float M-float
  2.17  [Rule] power.turret for armack 19861 | M +225 E 24156/4568 T2 E-float M-float
  2.18  [TECH][Factory] armalab: T2 constructor 9 of 10 (bank 4150 of 4150) (D-103)
  2.20  [Rule] power.turret for armack 10751 | M +225 E 24156/4568 T2 E-float M-float
  2.39  [Playtest] finished armnanotc team 0 at 2.39 min
  2.40  [TECH][Factory] armalab: T2 constructor 10 of 10 (bank 4150 of 4150) (D-103)
  2.64  [Playtest] finished armnanotc team 0 at 2.64 min
  2.65  [Rule] assist.any for armcom 28429 | M +225 E 24184/4568 T2 E-float M-float
  2.69  [Playtest] finished armdrag team 0 at 2.69 min
  2.72  [Playtest] finished armnanotc team 0 at 2.72 min
  2.74  [Rule] defence.fortify for armck 4089 | M +225 E 24184/4568 T2 E-float M-float
  2.75  [Rule] weapons.cluster for armck 30293 | M +225 E 24184/4568 T2 E-float M-float
  2.76  [Rule] weapons.cluster for armck 25829 | M +225 E 24184/4568 T2 E-float M-float
  2.77  [Rule] lab.base.reclaim for armack 17428 | M +225 E 24184/4568 T2 E-float M-float
  2.77  [Rule] lab.base.reclaim for armcom 28429 | M +225 E 24184/4568 T2 E-float M-float
  2.77  [Rule] lab.base.reclaim for armack 28741 | M +225 E 24184/4568 T2 E-float M-float
  2.78  [Rule] lab.base.reclaim for armack 10055 | M +225 E 24184/4568 T2 E-float M-float
  2.78  [Rule] lab.base.reclaim for armack 27839 | M +225 E 24184/4568 T2 E-float M-float
  2.79  [Rule] lab.base.reclaim for armack 12393 | M +225 E 24186/4568 T2 E-float M-float
  2.79  [Rule] lab.base.reclaim for armack 10751 | M +225 E 24186/4568 T2 E-float M-float
  2.80  [Rule] lab.base.reclaim for armfark 26630 | M +225 E 24186/4568 T2 E-float M-float
  2.92  [Playtest] finished armlab team 0 at 2.92 min
  2.93  [Rule] weapons.cluster for armck 4097 | M +225 E 24202/4568 T2 E-float M-float
  2.96  [Playtest] finished armfort team 0 at 2.96 min
  2.97  [Rule] defence.fortify for armack 13370 | M +225 E 24210/4568 T2 E-float M-float
  3.00  [Playtest] eco team 0 at 3.0 min: metal +225.4 bank 4235/4250, energy +25710.0 bank 1067355/1073625, units 86
  3.05  [Playtest] finished armfort team 0 at 3.05 min
  3.06  [Rule] defence.fortify for armack 13370 | M +225 E 24210/4568 T2 E-float M-float
  3.13  [Playtest] finished armfort team 0 at 3.13 min
  3.14  [Playtest] finished armmoho team 0 at 3.14 min
  3.16  [Rule] lab.base.reclaim for armack 19861 | M +225 E 24210/4568 T2 E-float M-float
  3.16  [Rule] lab.base.reclaim for armack 8806 | M +225 E 24210/4568 T2 E-float M-float
  3.17  [Rule] lab.base.reclaim for armack 7961 | M +225 E 24210/4568 T2 E-float M-float
  3.23  [Playtest] finished armfort team 0 at 3.23 min
  3.25  [Rule] defence.fortify for armack 13370 | M +225 E 24210/4568 T2 E-float M-float
  3.29  [Rule] power.turret for armack 19861 | M +225 E 24210/4568 T1 E-float M-float
  3.30  [Rule] power.turret for armack 8806 | M +230 E 24210/4678 T1 E-float M-float
  3.31  [Rule] power.turret for armack 7961 | M +230 E 24210/4678 T1 E-float M-float
  3.31  [Rule] power.turret for armack 17428 | M +230 E 24210/4678 T1 E-float M-float
  3.32  [Rule] power.turret for armfark 26630 | M +230 E 24210/4678 T1 E-float M-float
  3.32  [Rule] power.turret for armcom 28429 | M +230 E 24210/4678 T1 E-float M-float
  3.32  [Playtest] finished armfort team 0 at 3.32 min
  3.33  [Rule] defence.fortify for armack 28741 | M +230 E 24210/4678 T1 E-float M-float
  3.33  [Rule] power.turret for armack 10055 | M +230 E 24210/4678 T1 E-float M-float
  3.33  [Rule] power.turret for armack 27839 | M +230 E 24210/4678 T1 E-float M-float
  3.34  [Rule] power.turret for armack 12393 | M +230 E 24210/4678 T1 E-float M-float
  3.34  [Rule] power.turret for armack 10751 | M +230 E 24210/4678 T1 E-float M-float
  3.35  [Rule] power.turret for armack 13370 | M +230 E 24210/4678 T1 E-float M-float
  3.38  [Ferry] requested a transport (TECH at +20 metal, no transport)
  3.50  [Playtest] finished armdrag team 0 at 3.50 min
  3.52  [Rule] defence.fortify for armck 4089 | M +230 E 24210/4678 T1 E-float M-float
  3.57  [Playtest] finished armdrag team 0 at 3.57 min
  3.60  [Playtest] finished armnanotc team 0 at 3.60 min
  3.61  [Rule] weapons.cluster for armck 4097 | M +230 E 24210/4678 T1 E-float M-float
  3.65  [Playtest] finished armdrag team 0 at 3.64 min
  3.65  [Rule] defence.fortify for armack 27839 | M +230 E 24210/4678 T1 E-float M-float
  3.66  [Playtest] finished armrl team 0 at 3.66 min
  3.67  [Rule] weapons.cluster for armck 4089 | M +230 E 24210/4678 T1 E-float M-float
  3.68  [Rule] weapons.cluster for armck 25829 | M +230 E 24210/4678 T1 E-float M-float
  3.75  [Playtest] finished armnanotc team 0 at 3.75 min
  3.76  [Rule] weapons.cluster for armck 30293 | M +230 E 24210/4678 T1 E-float M-float
  3.77  [Rule] chain.next for armack 19861 | M +230 E 24210/4678 T1 E-float M-float
  3.85  [Playtest] finished armnanotc team 0 at 3.85 min
  3.86  [Rule] weapons.cluster for armck 4097 | M +230 E 24210/4678 T1 E-float M-float
  4.00  [Playtest] eco team 0 at 4.0 min: metal +230.9 bank 4584/4600, energy +24210.0 bank 1067129/1073425, units 130
  4.10  [Playtest] finished armnanotc team 0 at 4.10 min
  4.12  [Rule] weapons.cluster for armck 25829 | M +230 E 24210/4678 T1 E-float M-float
  4.12  [Rule] lab.front for armack 8806 | M +230 E 24210/4678 T1 E-float M-float
  4.13  [Rule] lab.front for armack 7961 | M +230 E 24210/4678 T1 E-float M-float
  4.13  [Rule] lab.front for armack 17428 | M +230 E 24210/4678 T1 E-float M-float
  4.14  [Rule] lab.front for armfark 26630 | M +230 E 24210/4678 T1 E-float M-float
  4.15  [Rule] lab.front for armack 10055 | M +230 E 24210/4678 T1 E-float M-float
  4.15  [Rule] lab.front for armack 12393 | M +230 E 24210/4678 T1 E-float M-float
  4.16  [Rule] lab.front for armack 13370 | M +230 E 24210/4678 T1 E-float M-float
  4.16  [Rule] lab.front for armack 10751 | M +230 E 24210/4678 T1 E-float M-float
  4.19  [Playtest] finished armnanotc team 0 at 4.19 min
  4.20  [Rule] weapons.cluster for armck 4089 | M +230 E 24210/4678 T1 E-float M-float
  4.21  [Rule] power.turret for armack 8806 | M +230 E 24210/4678 T1 E-float M-float
  4.21  [Rule] power.turret for armack 7961 | M +230 E 24210/4678 T1 E-float M-float
  4.22  [Rule] power.turret for armack 17428 | M +230 E 24210/4678 T1 E-float M-float
  4.22  [Rule] power.turret for armfark 26630 | M +230 E 24210/4678 T1 E-float M-float
  4.23  [Rule] power.turret for armack 10055 | M +230 E 24210/4678 T1 E-float M-float
  4.24  [Rule] power.turret for armack 12393 | M +230 E 24210/4678 T1 E-float M-float
  4.24  [Rule] power.turret for armack 13370 | M +230 E 24210/4678 T1 E-float M-float
  4.25  [Rule] power.turret for armack 10751 | M +230 E 24210/4678 T1 E-float M-float
  4.26  [Playtest] finished armnanotc team 0 at 4.26 min
  4.28  [Rule] weapons.cluster for armck 25829 | M +230 E 24210/4678 T1 E-float M-float
  4.28  [Playtest] finished armfort team 0 at 4.28 min
  4.29  [Rule] defence.fortify for armack 8806 | M +230 E 24210/4678 T1 E-float M-float
  4.33  [Rule] lab.front for armack 28741 | M +230 E 24210/4678 T1 E-float M-float
  4.39  [Playtest] finished armfort team 0 at 4.39 min
  4.42  [Rule] defence.fortify for armack 27839 | M +230 E 24210/4678 T1 E-float M-float
  4.44  [Playtest] finished armmoho team 0 at 4.44 min
  4.46  [Rule] lab.front for armack 19861 | M +230 E 24210/4678 T1 E-float M-float
  4.47  [Playtest] finished armnanotc team 0 at 4.47 min
  4.48  [Playtest] finished armrl team 0 at 4.48 min
  4.51  [Rule] weapons.cluster for armck 30293 | M +230 E 24210/4678 T1 E-float M-float
  4.51  [Rule] power.turret for armack 19861 | M +230 E 24210/4678 T1 E-float M-float
  4.52  [Rule] weapons.cluster for armck 25829 | M +230 E 24210/4678 T1 E-float M-float
  4.57  [Playtest] finished armnanotc team 0 at 4.57 min
  4.58  [Rule] weapons.cluster for armck 4089 | M +230 E 24210/4678 T1 E-float M-float
  4.59  [Rule] lab.front for armack 19861 | M +230 E 24210/4678 T1 E-float M-float
  4.59  [Rule] lab.front for armack 7961 | M +230 E 24210/4678 T1 E-float M-float
  4.60  [Rule] lab.front for armack 17428 | M +230 E 24210/4678 T1 E-float M-float
  4.60  [Rule] lab.front for armfark 26630 | M +236 E 24210/4788 T1 E-float M-float
  4.61  [Playtest] finished armfort team 0 at 4.61 min
  4.61  [Rule] defence.fortify for armack 10055 | M +236 E 24210/4788 T1 E-float M-float
  4.61  [Rule] lab.front for armack 12393 | M +236 E 24210/4788 T1 E-float M-float
  4.62  [Rule] lab.front for armack 13370 | M +236 E 24210/4788 T1 E-float M-float
  4.62  [Rule] lab.front for armack 10751 | M +236 E 24210/4788 T1 E-float M-float
  4.63  [Playtest] finished armnanotc team 0 at 4.63 min
  4.64  [Rule] power.turret for armack 27839 | M +236 E 24210/4788 T1 E-float M-float
  4.64  [Rule] power.turret for armack 19861 | M +236 E 24210/4788 T1 E-float M-float
  4.66  [Rule] power.turret for armack 7961 | M +236 E 24210/4788 T1 E-float M-float
  4.66  [Rule] power.turret for armack 17428 | M +236 E 24210/4788 T1 E-float M-float
  4.67  [Rule] power.turret for armfark 26630 | M +236 E 24210/4788 T1 E-float M-float
  4.68  [Rule] power.turret for armack 28741 | M +236 E 24210/4788 T1 E-float M-float
  4.68  [Playtest] finished armrl team 0 at 4.68 min
  4.68  [Rule] power.turret for armack 12393 | M +236 E 24210/4788 T1 E-float M-float
  4.68  [Rule] power.turret for armack 13370 | M +236 E 24210/4788 T1 E-float M-float
  4.69  [Rule] power.turret for armack 10751 | M +236 E 24210/4788 T1 E-float M-float
  4.70  [Rule] weapons.cluster for armck 4097 | M +236 E 24210/4788 T1 E-float M-float
  4.72  [Playtest] finished armnanotc team 0 at 4.72 min
  4.73  [Rule] weapons.cluster for armck 30293 | M +236 E 24210/4788 T1 E-float M-float
  4.77  [Playtest] finished armfort team 0 at 4.77 min
  4.77  [Rule] defence.fortify for armack 10751 | M +236 E 24210/4788 T1 E-float M-float
  4.79  [Rule] power.turret for armack 8806 | M +236 E 24210/4788 T1 E-float M-float
  4.89  [Playtest] finished armnanotc team 0 at 4.89 min
  4.90  [Rule] lab.front for armck 4089 | M +236 E 24210/4788 T1 E-float M-float
  4.95  [Playtest] finished armnanotc team 0 at 4.95 min
  4.97  [Rule] lab.front for armck 25829 | M +236 E 24210/4788 T1 E-float M-float
  5.00  [Playtest] eco team 0 at 5.0 min: metal +236.4 bank 5125/5150, energy +24210.0 bank 1066863/1073425, units 183
  5.12  [Playtest] finished armnanotc team 0 at 5.12 min
  5.13  [Rule] weapons.cluster for armck 4089 | M +236 E 24210/4788 T1 E-float M-float
  5.20  [Playtest] finished armnanotc team 0 at 5.20 min
  5.22  [Playtest] finished armfort team 0 at 5.22 min
  5.22  [Rule] defence.fortify for armck 4089 | M +236 E 24210/4788 T1 E-float M-float
  5.24  [Rule] lab.front for armack 10055 | M +236 E 24210/4788 T1 E-float M-float
  5.26  [Playtest] finished armnanotc team 0 at 5.26 min
  5.27  [Rule] lab.front for armck 25829 | M +236 E 24210/4788 T1 E-float M-float
  5.29  [Playtest] finished armfort team 0 at 5.29 min
  5.29  [Playtest] finished armcir team 0 at 5.29 min
  5.30  [Playtest] finished armrl team 0 at 5.30 min
  5.30  [Rule] defence.fortify for armack 10751 | M +236 E 24210/4788 T1 E-float M-float
  5.31  [Rule] lab.front for armck 30293 | M +236 E 24210/4788 T1 E-float M-float
  5.31  [Rule] lab.front for armack 19861 | M +236 E 24210/4788 T1 E-float M-float
  5.32  [Rule] lab.front for armack 8806 | M +236 E 24210/4788 T1 E-float M-float
  5.32  [Rule] lab.front for armack 7961 | M +236 E 24210/4788 T1 E-float M-float
  5.32  [Playtest] finished armnanotc team 0 at 5.32 min
  5.36  [Layout] turrets: order 2 of 5 allowed (build power 1350 (5 by power), bank 5150 + 237/s (8 by metal), 0 dear frames take a slot)
  5.36  [Rule] power.turret for armck 4097 | M +236 E 24210/4788 T1 E-float M-float
  5.36  [Rule] power.turret for armack 19861 | M +236 E 24210/4788 T1 E-float M-float
  5.37  [Layout] turrets: order 3 of 5 allowed (build power 1350 (5 by power), bank 5150 + 237/s (8 by metal), 0 dear frames take a slot)
  5.37  [Rule] power.turret for armck 25829 | M +236 E 24210/4788 T1 E-float M-float
  5.38  [Rule] power.turret for armack 8806 | M +236 E 24210/4788 T1 E-float M-float
  5.38  [Rule] power.turret for armack 7961 | M +236 E 24210/4788 T1 E-float M-float
  5.38  [Playtest] finished armfort team 0 at 5.38 min
  5.39  [Rule] defence.fortify for armack 10055 | M +236 E 24210/4788 T1 E-float M-float
  5.40  [Rule] chain.next for armack 19861 | M +236 E 24210/4788 T1 E-float M-float
  5.40  [Rule] chain.next for armack 8806 | M +236 E 24210/4788 T1 E-float M-float
  5.42  [Rule] storage.metal for armcom 28429 | M +236 E 24210/4788 T1 E-float M-float
  5.49  [Rule] power.turret for armack 7961 | M +236 E 24210/4788 T1 E-float M-float
  5.49  [Rule] power.turret for armack 17428 | M +236 E 24210/4788 T1 E-float M-float
  5.50  [Rule] power.turret for armfark 26630 | M +236 E 24210/4788 T1 E-float M-float
  5.51  [Rule] power.turret for armack 28741 | M +236 E 24210/4788 T1 E-float M-float
  5.52  [Rule] power.turret for armack 27839 | M +236 E 24210/4788 T1 E-float M-float
  5.52  [Rule] power.turret for armack 12393 | M +236 E 24210/4788 T1 E-float M-float
  5.53  [Rule] power.turret for armack 13370 | M +236 E 24210/4788 T1 E-float M-float
  5.53  [Rule] power.turret for armack 10751 | M +236 E 24210/4788 T1 E-float M-float
  5.53  [Playtest] finished armfort team 0 at 5.53 min
  5.54  [Playtest] finished armnanotc team 0 at 5.54 min
  5.55  [Rule] defence.fortify for armack 10055 | M +236 E 24210/4788 T1 E-float M-float
  5.56  [Rule] lab.front for armck 25829 | M +236 E 24210/4788 T1 E-float M-float
  5.57  [Rule] lab.front for armack 7961 | M +236 E 24210/4788 T1 E-float M-float
  5.57  [Rule] lab.front for armack 17428 | M +236 E 24210/4788 T1 E-float M-float
  5.57  [Rule] lab.front for armfark 26630 | M +236 E 24210/4788 T1 E-float M-float
  5.58  [Rule] lab.front for armack 28741 | M +236 E 24210/4788 T1 E-float M-float
  5.58  [Playtest] finished armnanotc team 0 at 5.58 min
  5.58  [Rule] lab.front for armack 27839 | M +236 E 24210/4788 T1 E-float M-float
  5.59  [Rule] lab.front for armack 12393 | M +236 E 24210/4788 T2 E-float M-float
  5.59  [Rule] assist.any for armack 13370 | M +236 E 24210/4788 T2 E-float M-float
  5.60  [Rule] assist.any for armack 10751 | M +236 E 24210/4788 T2 E-float M-float
  5.61  [Layout] turrets: order 2 of 8 allowed (build power 2130 (8 by power), bank 5150 + 237/s (8 by metal), 0 dear frames take a slot)
  5.61  [Rule] turret.build for armck 30293 | M +236 E 24210/4788 T2 E-float M-float
  5.61  [Layout] turrets: order 3 of 8 allowed (build power 2130 (8 by power), bank 5150 + 237/s (8 by metal), 0 dear frames take a slot)
  5.61  [Rule] turret.build for armck 25829 | M +236 E 24210/4788 T2 E-float M-float
  5.61  [Rule] assist.any for armack 7961 | M +236 E 24210/4788 T2 E-float M-float
  5.62  [Rule] assist.any for armack 17428 | M +236 E 24210/4788 T2 E-float M-float
  5.63  [Rule] assist.any for armfark 26630 | M +236 E 24210/4788 T2 E-float M-float
  5.63  [Playtest] finished armfort team 0 at 5.63 min
  5.63  [Rule] defence.fortify for armack 28741 | M +236 E 24210/4788 T2 E-float M-float
  5.65  [Rule] assist.any for armack 10055 | M +236 E 24210/4788 T2 E-float M-float
  5.65  [Playtest] finished armnanotc team 0 at 5.65 min
  5.67  [Layout] turrets: order 3 of 8 allowed (build power 2820 (10 by power), bank 5150 + 236/s (8 by metal), 0 dear frames take a slot)
  5.69  [Playtest] finished armdrag team 0 at 5.69 min
  5.70  [Rule] defence.fortify for armck 4089 | M +236 E 24210/4788 T2 E-float M-float
  5.71  [Rule] power.turret for armack 7961 | M +236 E 24210/4788 T2 E-float M-float
  5.71  [Rule] power.turret for armack 10055 | M +236 E 24210/4788 T2 E-float M-float
  5.72  [Rule] power.turret for armack 13370 | M +236 E 24210/4788 T2 E-float M-float
  5.72  [Playtest] finished armnanotc team 0 at 5.72 min
  5.72  [Rule] power.turret for armack 10751 | M +236 E 24210/4788 T2 E-float M-float
  5.73  [Layout] turrets: order 3 of 8 allowed (build power 3660 (13 by power), bank 5082 + 236/s (8 by metal), 0 dear frames take a slot)
  5.73  [Rule] power.turret for armck 25829 | M +236 E 24210/4788 T2 E-float M-float
  5.74  [Rule] power.turret for armack 17428 | M +236 E 24210/4788 T2 E-float M-float
  5.75  [Rule] power.turret for armfark 26630 | M +236 E 24210/4788 T2 E-float M-float
  5.75  [Playtest] finished armdrag team 0 at 5.75 min
  5.76  [Rule] defence.fortify for armack 13370 | M +236 E 24210/4788 T2 E-float M-float
  5.76  [Layout] turrets: order 4 of 8 allowed (build power 3660 (13 by power), bank 4996 + 237/s (8 by metal), 0 dear frames take a slot)
  5.76  [Rule] power.turret for armck 4089 | M +236 E 24210/4788 T2 E-float M-float
  5.84  [Playtest] finished armalab team 0 at 5.84 min
  5.86  [Layout] new set of armmmkr at (4144, 2576), 0 cell(s) from a turret
  5.86  [Rule] energy.convert for armack 7961 | M +236 E 24210/4788 T2 E-float
  5.86  [Rule] energy.convert for armack 17428 | M +236 E 24210/4788 T2 E-float
  5.87  [Rule] chain.next for armfark 26630 | M +236 E 24210/4788 T2 E-float
  5.87  [Rule] energy.convert for armack 10055 | M +236 E 24210/4788 T2 E-float
  5.87  [Playtest] finished armfort team 0 at 5.87 min
  5.88  [Rule] defence.fortify for armack 27839 | M +236 E 24210/4788 T2 E-float
  5.88  [Rule] assist.any for armack 12393 | M +236 E 24210/4788 T2 E-float
  5.88  [Rule] assist.any for armack 10751 | M +236 E 24210/4788 T2 E-float
  5.89  [Rule] assist.any for armack 28741 | M +236 E 24210/4788 T2 E-float
  5.90  [Playtest] finished armnanotc team 0 at 5.90 min
  5.92  [Playtest] finished armnanotc team 0 at 5.92 min
  5.92  [Layout] turrets: order 3 of 7 allowed (build power 4140 (15 by power), bank 4024 + 237/s (8 by metal), 1 dear frames take a slot)
  5.92  [Rule] power.t1 for armck 25829 | M +236 E 24210/4788 T2 E-float
  5.93  [Layout] turrets: order 4 of 7 allowed (build power 4140 (15 by power), bank 4024 + 237/s (8 by metal), 1 dear frames take a slot)
  5.93  [Rule] power.t1 for armck 30293 | M +236 E 24210/4788 T2 E-float
  5.93  [Playtest] finished armfort team 0 at 5.93 min
  5.94  [Rule] defence.fortify for armack 12393 | M +236 E 24210/4788 T2 E-float
  5.94  [Playtest] finished armmstor team 0 at 5.94 min
  5.96  [Rule] chain.next for armfark 17994 | M +236 E 24210/4788 T2 E-float
  5.96  [Rule] chain.next for armcom 28429 | M +236 E 24210/4788 T2 E-float
  5.97  [Rule] assist.any for armack 13370 | M +236 E 24210/4788 T2 E-float
  5.98  [Playtest] finished armnanotc team 0 at 5.98 min
  6.00  [Layout] turrets: order 4 of 6 allowed (build power 4380 (16 by power), bank 4043 + 237/s (8 by metal), 2 dear frames take a slot)
  6.00  [Playtest] eco team 0 at 6.0 min: metal +236.4 bank 4089/8350, energy +24222.0 bank 1066726/1073650, units 256
  6.00  [Rule] chain.next for armack 28741 | M +236 E 24210/4788 T2 E-float
  6.01  [Rule] chain.next for armack 13370 | M +236 E 24210/4788 T2 E-float
  6.01  [Playtest] finished armnanotc team 0 at 6.01 min
  6.01  [Rule] chain.next for armack 10751 | M +236 E 24210/4788 T2 E-float
  6.02  [Layout] turrets: order 4 of 6 allowed (build power 5070 (19 by power), bank 4198 + 236/s (8 by metal), 2 dear frames take a slot)
  6.02  [Rule] power.t1 for armck 4097 | M +236 E 24210/4788 T2 E-float
  6.06  [Playtest] finished armnanotc team 0 at 6.06 min
  6.08  [Layout] turrets: order 4 of 6 allowed (build power 5910 (22 by power), bank 4144 + 236/s (230 by metal), 2 dear frames take a slot)
  6.08  [Rule] power.t1 for armck 30293 | M +236 E 24210/4788 T2 E-float
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
  0.23  EXP: approach: armck(4097) at (3620, 1800) walks to (3303, 1876), 123 from the armmex site (3184, 1904)
  0.23  RESERVE: corridor 15 at (4400, 2032) facing 0, 14x20 cells: 0 of 280 held
  0.24  EXP: approach: armck(4089) at (3860, 1800) walks to (4088, 1791), 123 from the armmex site (4192, 1856)
  0.24  EXP: approach: armck(25829) at (3740, 1800) walks to (3896, 1348), 123 from the armmex site (3936, 1232)
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
