# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.0 min (frame 7200); wall 72 s
- DLL: build-theatres\ranged-rework\baseline\SkirmishAI.dll (9af405acf9a6180b); AI BARbTest/test; staged 2026-10-05T17:22:07
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-bait\glitters\20261005T202207Z-8bf83acb\runs\20261005T202323Z-24fed6ac\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:30.852446][f=-000001] [RangedArena] frame=0 loaded case=ranged-starlight-bait variant=baseline` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:39.302851][f=0000301] [RangedArena] frame=301 spawn id=14262 team=0 unit=armarad x=3600 z=4750` |
| expect `damage` | seen at 0.2 min | `[t=00:00:39.591292][f=0000370] [RangedArena] frame=370 damage id=15598 team=1 amount=155 attacker=18782 attackerTeam=0 weapon=236` |
| expect `orders` | seen at 0.3 min | `[t=00:00:40.721296][f=0000600] [RangedArena] frame=600 orders team=0 total=66 nonlua=66 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-bait\glitters\20261005T202207Z-8bf83acb\runs\20261005T202323Z-24fed6ac\screen_2026-10-05_20-22-56-550.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-bait\glitters\20261005T202207Z-8bf83acb\runs\20261005T202323Z-24fed6ac\screen_2026-10-05_20-23-06-544.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-bait\glitters\20261005T202207Z-8bf83acb\runs\20261005T202323Z-24fed6ac\screen_2026-10-05_20-23-18-285.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 4.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000000/1000000, energy +0.0 bank 1000000/1000000, units 1
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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 951500/1000000, units 10
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 944500/1000000, units 10
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 941500/1000000, units 10
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000000/1000000, energy +30.0 bank 938500/1000000, units 10
```

## Native lines (all AIs, first 120)

```
```
