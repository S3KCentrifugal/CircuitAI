# Playtest report: PASS

- Verdict: **PASS** (reached 4 min)
- Game time reached: 4.2 min (frame 7500); wall 72 s
- DLL: build-theatres\d221\candidate1\SkirmishAI.dll (eca9d0229482cc8e); AI BARbTest/test; staged 2026-10-06T16:28:51
- Map: All That Glitters v2.2.3; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI 0, role FRONT
- Checks: ranged-arena.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-sensor-advance\glitters\20261006T192851Z-90dbb105\runs\20261006T193007Z-942686ec\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:28.332509][f=-000001] [RangedArena] frame=0 loaded case=ranged-sensor-advance variant=ranged` |
| expect `spawn` | seen at 0.2 min | `[t=00:00:37.681429][f=0000300] [RangedArena] frame=300 spawn id=14262 team=0 unit=armarad x=3200 z=3500` |
| expect `damage` | seen at 0.8 min | `[t=00:00:44.051261][f=0001526] [RangedArena] frame=1526 damage id=6003 team=1 amount=800 attacker=14370 attackerTeam=0 weapon=196` |
| expect `orders` | seen at 0.3 min | `[t=00:00:39.145697][f=0000600] [RangedArena] frame=600 orders team=0 total=43 nonlua=43 lua=0` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-sensor-advance\glitters\20261006T192851Z-90dbb105\runs\20261006T193007Z-942686ec\screen_2026-10-06_19-29-38-922.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-sensor-advance\glitters\20261006T192851Z-90dbb105\runs\20261006T193007Z-942686ec\screen_2026-10-06_19-29-48-979.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-sensor-advance\glitters\20261006T192851Z-90dbb105\runs\20261006T193007Z-942686ec\screen_2026-10-06_19-30-00-717.png

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
  1.00  [Playtest] eco team 0 at 1.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 975550/1000000, units 18
  2.00  [Playtest] eco team 0 at 2.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 932125/1000000, units 18
  3.00  [Playtest] eco team 0 at 3.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 897750/1000000, units 18
  4.00  [Playtest] eco team 0 at 4.0 min: metal +2.0 bank 1000/1000, energy +30.0 bank 871950/1000000, units 18
```

## Native lines (all AIs, first 120)

```
```
