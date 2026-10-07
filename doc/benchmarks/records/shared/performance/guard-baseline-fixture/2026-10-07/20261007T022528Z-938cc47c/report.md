# Playtest report: FAIL

- Verdict: **FAIL** (deadline)
- Game time reached: 5.1 min (frame 9180); wall 84 s
- DLL: build-theatres\d223\baseline\SkirmishAI.dll (7b443ae28869953b); AI BARbTest/test; staged 2026-10-06T23:23:55
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI 0, role SEA
- Checks: guard-fixture.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\guard-baseline-fixture\supreme\20261007T022354Z-641b6134\runs\20261007T022528Z-938cc47c\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:37.500724][f=-000001] [GuardTest] loaded fixture=true` |
| expect `stop` | seen at 1.3 min | `[t=00:00:56.250408][f=0002280] [GuardTest] PASS stop_recovery` |
| expect `change` | **missing** (by 3 min) | |
| expect `moving` | **missing** (by 4 min) | |
| expect `loss` | seen at 4.3 min | `[t=00:01:16.618032][f=0007800] [GuardTest] PASS target_loss_recovery` |
| expect `assist` | seen at 0.4 min | `[t=00:00:49.570590][f=0000660] [GuardTest] PASS production_assist` |
| expect `production` | seen at 4.5 min | `[t=00:01:17.620546][f=0008100] [GuardTest] PASS production_continues` |
| forbid `errors` | clean |  |

## Failures

- 'change' not seen by 3.0 min
- 'moving' not seen by 4.0 min

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\guard-baseline-fixture\supreme\20261007T022354Z-641b6134\runs\20261007T022528Z-938cc47c\screen_2026-10-07_02-24-59-895.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\guard-baseline-fixture\supreme\20261007T022354Z-641b6134\runs\20261007T022528Z-938cc47c\screen_2026-10-07_02-25-13-163.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\guard-baseline-fixture\supreme\20261007T022354Z-641b6134\runs\20261007T022528Z-938cc47c\screen_2026-10-07_02-25-20-138.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role SEA, team 0, speed 10, 3 shots, end at 5.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 100000/100000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 41
  0.00  [Playtest] speed 10
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4814, 11077) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (7492, 1220) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 41
  0.08  [SEA][Layout] enabled; adopted berths=0 patches=0
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.17  [Playtest] finished armsy team 0 at 0.17 min
  0.17  [Playtest] finished armuwfus team 0 at 0.17 min
  0.18  [SEA][Layout] berth sea.berth.0 armasy at=6528,9968 facing=2
  0.25  [SEA][Layout] berth sea.berth.1 armplat at=5952,9968 facing=2
  0.27  [SEA][Layout] berth sea.berth.2 armshltxuw at=7488,9968 facing=2
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 98996/100200, energy +1251.0 bank 1002827/1002850, units 11
  1.00  [Playtest] camera requested (6150,10800) height=2600
  1.00  [Playtest] camera captured name=ta position=(6150,10800) height=2600
  1.00  [Playtest] screenshot at 1.0 min of team 0 at (6150, 10800)
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 97690/100200, energy +1251.0 bank 1002822/1002850, units 15
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 96006/100200, energy +1251.0 bank 1002803/1002850, units 17
  3.00  [Playtest] camera requested (6150,10800) height=2600
  3.01  [Playtest] camera captured name=ta position=(6150,10800) height=2600
  3.01  [Playtest] screenshot at 3.0 min of team 0 at (6150, 10800)
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 94803/100200, energy +1244.0 bank 1002761/1002800, units 19
  4.00  [Playtest] camera requested (6150,10800) height=2600
  4.00  [Playtest] camera captured name=ta position=(6150,10800) height=2600
  4.00  [Playtest] screenshot at 4.0 min of team 0 at (6150, 10800)
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 93305/100200, energy +1244.0 bank 1002761/1002800, units 21
```

## Native lines (all AIs, first 120)

```
  0.18  RESERVE: zone 1 at (6528, 9968) facing 2, 12x12 cells: 144 of 144 held
  0.18  RESERVE: armasy at (6528, 9968) facing 2 (id 1)
  0.18  RESERVE: corridor 2 at (6528, 9472) facing 2, 18x50 cells: 900 of 900 held
  0.18  RESERVE: zone 3 at (6536, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6536, 10120) facing 2 (id 2)
  0.18  RESERVE: zone 4 at (6680, 9976) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6680, 9976) facing 2 (id 3)
  0.18  RESERVE: zone 5 at (6392, 9976) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6392, 9976) facing 2 (id 4)
  0.18  RESERVE: zone 6 at (6584, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6584, 10120) facing 2 (id 5)
  0.18  RESERVE: zone 7 at (6488, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6488, 10120) facing 2 (id 6)
  0.18  RESERVE: zone 8 at (6680, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6680, 10024) facing 2 (id 7)
  0.18  RESERVE: zone 9 at (6392, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6392, 10024) facing 2 (id 8)
  0.18  RESERVE: zone 10 at (6680, 9928) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6680, 9928) facing 2 (id 9)
  0.18  RESERVE: zone 11 at (6392, 9928) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6392, 9928) facing 2 (id 10)
  0.18  RESERVE: zone 12 at (6632, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6632, 10120) facing 2 (id 11)
  0.18  RESERVE: zone 13 at (6440, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6440, 10120) facing 2 (id 12)
  0.18  RESERVE: zone 14 at (6680, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6680, 10072) facing 2 (id 13)
  0.18  RESERVE: zone 15 at (6392, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6392, 10072) facing 2 (id 14)
  0.18  RESERVE: zone 16 at (6536, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6536, 10168) facing 2 (id 15)
  0.18  RESERVE: zone 17 at (6728, 9976) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6728, 9976) facing 2 (id 16)
  0.18  RESERVE: zone 18 at (6344, 9976) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6344, 9976) facing 2 (id 17)
  0.18  RESERVE: zone 19 at (6584, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6584, 10168) facing 2 (id 18)
  0.18  RESERVE: zone 20 at (6488, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6488, 10168) facing 2 (id 19)
  0.18  RESERVE: zone 21 at (6728, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6728, 10024) facing 2 (id 20)
  0.18  RESERVE: zone 22 at (6344, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6344, 10024) facing 2 (id 21)
  0.18  RESERVE: zone 23 at (6728, 9928) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6728, 9928) facing 2 (id 22)
  0.18  RESERVE: zone 24 at (6344, 9928) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6344, 9928) facing 2 (id 23)
  0.18  RESERVE: zone 25 at (6680, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6680, 10120) facing 2 (id 24)
  0.18  RESERVE: zone 26 at (6392, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6392, 10120) facing 2 (id 25)
  0.18  RESERVE: zone 27 at (6632, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6632, 10168) facing 2 (id 26)
  0.18  RESERVE: zone 28 at (6440, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6440, 10168) facing 2 (id 27)
  0.18  RESERVE: zone 29 at (6728, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6728, 10072) facing 2 (id 28)
  0.18  RESERVE: zone 30 at (6344, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6344, 10072) facing 2 (id 29)
  0.18  RESERVE: zone 31 at (6728, 9880) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6728, 9880) facing 2 (id 30)
  0.18  RESERVE: zone 32 at (6344, 9880) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6344, 9880) facing 2 (id 31)
  0.18  RESERVE: zone 33 at (6536, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6536, 10216) facing 2 (id 32)
  0.18  RESERVE: zone 34 at (6680, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6680, 10168) facing 2 (id 33)
  0.18  RESERVE: zone 35 at (6392, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6392, 10168) facing 2 (id 34)
  0.18  RESERVE: zone 36 at (6728, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6728, 10120) facing 2 (id 35)
  0.18  RESERVE: zone 37 at (6344, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6344, 10120) facing 2 (id 36)
  0.18  RESERVE: zone 38 at (6296, 9976) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6296, 9976) facing 2 (id 37)
  0.18  RESERVE: zone 39 at (6584, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6584, 10216) facing 2 (id 38)
  0.18  RESERVE: zone 40 at (6488, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6488, 10216) facing 2 (id 39)
  0.18  RESERVE: zone 41 at (6296, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6296, 10024) facing 2 (id 40)
  0.18  RESERVE: zone 42 at (6296, 9928) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6296, 9928) facing 2 (id 41)
  0.18  RESERVE: zone 43 at (6632, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6632, 10216) facing 2 (id 42)
  0.18  RESERVE: zone 44 at (6440, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6440, 10216) facing 2 (id 43)
  0.18  RESERVE: zone 45 at (6296, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6296, 10072) facing 2 (id 44)
  0.18  RESERVE: zone 46 at (6296, 9880) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6296, 9880) facing 2 (id 45)
  0.18  RESERVE: zone 47 at (6728, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6728, 10168) facing 2 (id 46)
  0.18  RESERVE: zone 48 at (6344, 10168) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6344, 10168) facing 2 (id 47)
  0.18  RESERVE: zone 49 at (6680, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6680, 10216) facing 2 (id 48)
  0.18  RESERVE: zone 50 at (6392, 10216) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6392, 10216) facing 2 (id 49)
  0.18  RESERVE: zone 51 at (6296, 10120) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6296, 10120) facing 2 (id 50)
  0.18  RESERVE: zone 52 at (6536, 10264) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6536, 10264) facing 2 (id 51)
  0.18  RESERVE: zone 53 at (6248, 9976) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6248, 9976) facing 2 (id 52)
  0.18  RESERVE: zone 54 at (6584, 10264) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6584, 10264) facing 2 (id 53)
  0.18  RESERVE: zone 55 at (6488, 10264) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6488, 10264) facing 2 (id 54)
  0.18  RESERVE: zone 56 at (6248, 10024) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6248, 10024) facing 2 (id 55)
  0.18  RESERVE: zone 57 at (6248, 9928) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6248, 9928) facing 2 (id 56)
  0.18  RESERVE: zone 58 at (6632, 10264) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6632, 10264) facing 2 (id 57)
  0.18  RESERVE: zone 59 at (6440, 10264) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6440, 10264) facing 2 (id 58)
  0.18  RESERVE: zone 60 at (6248, 10072) facing 2, 3x3 cells: 9 of 9 held
  0.18  RESERVE: armnanotcplat at (6248, 10072) facing 2 (id 59)
  0.18  RESERVE: zone 61 at (6248, 9880) facing 2, 3x3 cells: 9 of 9 held
```
