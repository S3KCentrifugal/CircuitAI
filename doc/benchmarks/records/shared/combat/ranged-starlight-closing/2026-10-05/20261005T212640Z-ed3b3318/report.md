# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.1 min (frame 7350); wall 74 s
- DLL: build-theatres\ranged-rework\baseline\SkirmishAI.dll (9af405acf9a6180b); AI BARbTest/test; staged 2026-10-05T18:25:22
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-closing\glitters\20261005T212521Z-d10e78e2\runs\20261005T212640Z-ed3b3318\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.454929][f=-000001] [RangedArena] frame=0 loaded case=ranged-starlight-closing variant=baseline` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:41.429695][f=0000301] [RangedArena] frame=301 spawn id=14262 team=0 unit=armarad x=3600 z=4750` |
| expect `damage` | seen at 0.2 min | `[t=00:00:41.574958][f=0000330] [RangedArena] frame=330 damage id=15598 team=1 amount=148 attacker=7383 attackerTeam=0 weapon=236` |
| expect `orders` | seen at 0.3 min | `[t=00:00:42.775106][f=0000600] [RangedArena] frame=600 orders team=0 total=87 nonlua=87 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-closing\glitters\20261005T212521Z-d10e78e2\runs\20261005T212640Z-ed3b3318\screen_2026-10-05_21-26-13-161.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-closing\glitters\20261005T212521Z-d10e78e2\runs\20261005T212640Z-ed3b3318\screen_2026-10-05_21-26-23-162.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-starlight-closing\glitters\20261005T212521Z-d10e78e2\runs\20261005T212640Z-ed3b3318\screen_2026-10-05_21-26-34-899.png

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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 993500/1000000, units 10
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 979500/1000000, units 9
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 974500/1000000, units 9
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 971500/1000000, units 9
```

## Native lines (all AIs, first 120)

```
```
