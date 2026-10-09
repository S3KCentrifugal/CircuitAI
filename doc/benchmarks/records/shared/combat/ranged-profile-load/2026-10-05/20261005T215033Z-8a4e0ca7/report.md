# Playtest report: PASS

- Verdict: **PASS** (reached 1 min)
- Game time reached: 1.1 min (frame 1950); wall 49 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (68fa9679ca2841d0); AI BARbTest/test; staged 2026-10-05T18:49:40
- Map: Comet Catcher Remake 1.8; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI None, role FRONT
- Checks: ranged-profile-load.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-profile-load\comet\20261005T214939Z-01a8241d\runs\20261005T215033Z-8a4e0ca7\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:30.147163][f=-000001] [RangedArena] frame=0 loaded case=ranged-profile-load variant=ranged` |
| expect `ranged` | seen at 0.2 min | `[t=00:00:39.401498][f=0000321] Skirmish AI <BARb playtest-test>: RANGED: assigned armfboy(7270) weapons=1` |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | clean |  |
| forbid `policy` | clean |  |

## Screenshots

- none

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role FRONT, team 0, speed 8, 0 shots, end at 1.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000000/1000000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (4000, 1800) units 1
  0.00  [Playtest] frame 1 team 1 ally 1 side armada ai true dead false start (4000, 6144) units 1
  0.00  [Playtest] frame 1 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 8
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (4000, 1800) units 1
  0.05  [Playtest] frame 90 team 1 ally 1 side armada ai true dead false start (4000, 6144) units 1
  0.05  [Playtest] frame 90 team 2 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 3 ally 3 side  ai false dead false start (0, 0) units 0
  0.19  [Playtest] finished armarad team 0 at 0.19 min
  0.23  [Playtest] finished armmex team 0 at 0.23 min
  0.40  [Playtest] finished armsolar team 0 at 0.40 min
  0.56  [Playtest] finished armsolar team 0 at 0.56 min
  0.94  [Playtest] finished armlab team 0 at 0.94 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 266/1150, energy +70.0 bank 987410/1000200, units 20
```

## Native lines (all AIs, first 120)

```
```
