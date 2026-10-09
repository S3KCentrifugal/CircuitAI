# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.2 min (frame 7476); wall 78 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (68fa9679ca2841d0); AI BARbTest/test; staged 2026-10-05T18:49:24
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T214923Z-13ddbd5e\runs\20261005T215046Z-652978c1\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:34.289961][f=-000001] [RangedArena] frame=0 loaded case=ranged-mixed-sensors variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:43.869459][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3200 z=3500` |
| expect `damage` | seen at 0.8 min | `[t=00:00:50.132441][f=0001490] [RangedArena] frame=1490 damage id=7383 team=1 amount=650 attacker=14370 attackerTeam=0 weapon=196` |
| expect `orders` | seen at 0.3 min | `[t=00:00:45.428965][f=0000600] [RangedArena] frame=600 orders team=0 total=43 nonlua=43 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T214923Z-13ddbd5e\runs\20261005T215046Z-652978c1\screen_2026-10-05_21-50-18-408.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T214923Z-13ddbd5e\runs\20261005T215046Z-652978c1\screen_2026-10-05_21-50-29-102.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-mixed-sensors\glitters\20261005T214923Z-13ddbd5e\runs\20261005T215046Z-652978c1\screen_2026-10-05_21-50-40-841.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 4.5 min
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 984725/1000000, units 18
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 949625/1000000, units 18
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 923825/1000000, units 18
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 898025/1000000, units 18
```

## Native lines (all AIs, first 120)

```
```
