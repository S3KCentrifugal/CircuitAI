# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 0.0 min (frame 0); wall 3 s
- DLL: C:\bardev\bar-RecoilEngine\build-amd64-windows\install\AI\Skirmish\BARb\stable\SkirmishAI.dll (15958e3e8775d55b); AI BARbTest/test; staged 2026-10-05T19:52:08
- Map: Supreme Isthmus v1.7; game: Beyond All Reason test-31479-433a460; teams: 0=SEA/armada/test, 1=SEA/armada/test
- Team 0 (under test): skirmish AI None, role SEA
- Checks: sea-control-lost-yard.json; widget loaded: not seen in log
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\sea\combat\control-yard-lost-cand\supreme\20261005T225208Z-e0873a13\runs\20261005T225214Z-b756e48d\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `loaded` | **missing** (by 1 min) | |
| expect `yard-visible` | **missing** (by 1 min) | |
| expect `radar-removed` | **missing** (by 1 min) | |
| expect `yard-lost-from-vision` | **missing** (by 1 min) | |
| expect `yard-damaged` | **missing** (by 3 min) | |
| expect `yard-destroyed` | **missing** (by 4 min) | |
| forbid `script` | clean |  |
| forbid `invariant` | clean |  |
| forbid `fixture` | clean |  |
| forbid `crash` | **hit** | `ning writeable data-directory C:/bardev/s3k-CircuitAI/build-theatres/games/sea/combat/control-yard-lost-cand/supreme/20261005T225208Z-e0873a13/" msgCaption="Spring: caught std::exception" mainThread=0` |

## Failures

- forbid 'crash' hit at 0.0 min: ning writeable data-directory C:/bardev/s3k-CircuitAI/build-theatres/games/sea/combat/control-yard-lost-cand/supreme/20261005T225208Z-e0873a13/" msgCaption="Spring: caught std::exception" mainThread=0

## Screenshots

- none

## Timeline (team 0)

```
```

## Native lines (all AIs, first 120)

```
```
