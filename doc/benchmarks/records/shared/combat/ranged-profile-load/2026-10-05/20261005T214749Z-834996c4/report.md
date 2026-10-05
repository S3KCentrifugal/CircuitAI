# Playtest report: PASS

- Verdict: **PASS** (reached 1 min)
- Game time reached: 1.2 min (frame 2100); wall 50 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (68fa9679ca2841d0); AI BARbTest/test; staged 2026-10-05T18:46:56
- Map: Comet Catcher Remake 1.8; game: Beyond All Reason test-31479-433a460; teams: 0=FRONT/armada/test, 1=FRONT/armada/test
- Team 0 (under test): skirmish AI None, role FRONT
- Checks: ranged-profile-load.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\combat\ranged-profile-load\comet\20261005T214655Z-e6f3dd26\runs\20261005T214749Z-834996c4\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | seen at -0.0 min | `[t=00:00:31.179634][f=-000001] [RangedArena] frame=0 loaded case=ranged-profile-load variant=ranged` |
| expect `ranged` | seen at 0.2 min | `[t=00:00:39.926354][f=0000321] Skirmish AI <BARb playtest-test>: RANGED: assigned armfboy(7270) weapons=1` |
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
  0.20  [Playtest] finished armarad team 0 at 0.20 min
  0.22  [Playtest] finished armmex team 0 at 0.22 min
  0.45  [Playtest] finished armsolar team 0 at 0.44 min
  0.66  [Playtest] finished armllt team 0 at 0.66 min
  0.88  [Playtest] finished armsolar team 0 at 0.88 min
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.3 bank 650/1050, energy +70.0 bank 988709/1000100, units 21
  1.10  [Playtest] finished armsolar team 0 at 1.10 min
```

## Native lines (all AIs, first 120)

```
```
