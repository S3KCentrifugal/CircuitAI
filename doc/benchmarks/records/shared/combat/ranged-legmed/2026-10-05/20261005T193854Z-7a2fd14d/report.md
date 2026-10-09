# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 0.3 min (frame 526); wall 113 s
- DLL: C:\bardev\bar-RecoilEngine-s3k-build\build-amd64-windows\AI\Skirmish\BARb\data\SkirmishAI.dll (b4a2104c2ce12a1f); AI BARbTest/test; staged 2026-10-05T16:36:57
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/legion/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-legmed\glitters\20261005T193656Z-eca943db\runs\20261005T193854Z-7a2fd14d\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:27.877942][f=-000001] [RangedArena] frame=0 loaded case=ranged-legmed variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:36.728652][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3900 z=4750` |
| expect `damage` | seen at 0.3 min | `[t=00:00:37.556619][f=0000500] [RangedArena] frame=500 damage id=14262 team=0 amount=500 attacker=29202 attackerTeam=0 weapon=983` |
| expect `orders` | **missing** (by 2 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | **hit** | `[t=00:00:37.758676][f=0000526] Error: Spring 2026.07.04 has crashed.` |

## Failures

- forbid 'crash' hit at 0.3 min: [t=00:00:37.758676][f=0000526] Error: Spring 2026.07.04 has crashed.
- forbid 'crash' hit at 0.3 min: [t=00:00:37.825277][f=0000526] Error: Exception: Access violation (0xc0000005)

## Screenshots

- none

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
```

## Native lines (all AIs, first 120)

```
```
