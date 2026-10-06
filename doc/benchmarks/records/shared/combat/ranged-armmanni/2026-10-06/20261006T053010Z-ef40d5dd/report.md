# Playtest report: PASS

- Verdict: **PASS** (reached 5 min)
- Game time reached: 5.0 min (frame 9000); wall 77 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T02:28:50
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-armmanni\glitters\20261006T052849Z-4fa930f2\runs\20261006T053010Z-ef40d5dd\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:27.783832][f=-000001] [RangedArena] frame=0 loaded case=ranged-armmanni variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:36.707458][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3900 z=4750` |
| expect `damage` | seen at 0.3 min | `[t=00:00:37.734938][f=0000548] [RangedArena] frame=548 damage id=15598 team=1 amount=156 attacker=29202 attackerTeam=0 weapon=236` |
| expect `orders` | seen at 0.3 min | `[t=00:00:37.952437][f=0000600] [RangedArena] frame=600 orders team=0 total=154 nonlua=154 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-armmanni\glitters\20261006T052849Z-4fa930f2\runs\20261006T053010Z-ef40d5dd\screen_2026-10-06_05-29-35-938.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-armmanni\glitters\20261006T052849Z-4fa930f2\runs\20261006T053010Z-ef40d5dd\screen_2026-10-06_05-29-45-921.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-armmanni\glitters\20261006T052849Z-4fa930f2\runs\20261006T053010Z-ef40d5dd\screen_2026-10-06_05-29-57-661.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 5.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 991843/1000050, units 9
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 989263/1000050, units 9
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 986683/1000050, units 9
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 984103/1000050, units 9
  5.00  [Playtest] eco team 0 at 5.0 min: metal +2.0 bank 1000/1000, energy +37.0 bank 981523/1000050, units 9
```

## Native lines (all AIs, first 120)

```
```
