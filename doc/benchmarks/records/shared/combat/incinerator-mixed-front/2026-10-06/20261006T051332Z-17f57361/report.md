# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.0 min (frame 7200); wall 70 s
- DLL: build-theatres\d212-final\SkirmishAI.dll (f224e17dc3c6f798); AI BARbTest/test; staged 2026-10-06T02:12:18
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/legion/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\incinerator-mixed-front\glitters\20261006T051217Z-9324362c\runs\20261006T051332Z-17f57361\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:28.165080][f=-000001] [RangedArena] frame=0 loaded case=incinerator-mixed-front variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:36.965987][f=0000301] [RangedArena] frame=301 spawn id=14262 team=0 unit=armarad x=3200 z=5100` |
| expect `damage` | seen at 0.2 min | `[t=00:00:37.096081][f=0000333] [RangedArena] frame=333 damage id=25497 team=1 amount=850 attacker=22963 attackerTeam=0 weapon=1030` |
| expect `orders` | seen at 0.3 min | `[t=00:00:38.263636][f=0000600] [RangedArena] frame=600 orders team=0 total=245 nonlua=245 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\incinerator-mixed-front\glitters\20261006T051217Z-9324362c\runs\20261006T051332Z-17f57361\screen_2026-10-06_05-13-03-329.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\incinerator-mixed-front\glitters\20261006T051217Z-9324362c\runs\20261006T051332Z-17f57361\screen_2026-10-06_05-13-07-580.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\incinerator-mixed-front\glitters\20261006T051217Z-9324362c\runs\20261006T051332Z-17f57361\screen_2026-10-06_05-13-15-692.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished legcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side legion ai true dead false start (4000, 2400) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side legion ai true dead false start (4000, 2400) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 9800) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.17  [Playtest] finished armarad team 0 at 0.17 min
  0.20  [Playtest] finished leginc team 0 at 0.20 min
  0.20  [Playtest] finished leginc team 0 at 0.20 min
  0.22  [Playtest] finished leginc team 0 at 0.22 min
  0.22  [Playtest] finished leginc team 0 at 0.22 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +35.0 bank 992532/1000050, units 18
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +35.0 bank 991432/1000050, units 18
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +35.0 bank 993532/1000050, units 18
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +35.0 bank 995632/1000050, units 18
```

## Native lines (all AIs, first 120)

```
```
