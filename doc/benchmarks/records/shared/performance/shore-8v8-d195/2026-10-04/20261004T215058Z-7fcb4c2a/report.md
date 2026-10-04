# Playtest report: FAIL

- Verdict: **FAIL** (forbidden line)
- Game time reached: 40.0 min (frame 72021); wall 573 s
- DLL: build-theatres\d194-build\SkirmishAI.dll (d28b4dcb6a319109); AI BARbTest/test; staged 2026-10-04T18:31:11
- Map: Shore_to_Shore_V3; game: Beyond All Reason test-31479-433a460; teams: 0=AIR/armada/test, 1=TECH/armada/test, 2=TACTICAL/cortex/test, 3=SEA/legion/test, 4=SEA/armada/test, 5=SEA/cortex/test, 6=SEA/legion/test, 7=SEA/armada/test, 8=TECH/cortex/test, 9=AIR/legion/test, 10=TACTICAL/armada/test, 11=SEA/cortex/test, 12=SEA/legion/test, 13=SEA/armada/test, 14=SEA/cortex/test, 15=SEA/legion/test
- Team 0 (under test): skirmish AI 0, role AIR
- Checks: skirmish_cpu.json; widget loaded: yes
- Log: C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\shore-8v8-d195\shore-to-shore\20261004T213111Z-b2a38464\runs\20261004T215058Z-7fcb4c2a\infolog.txt

## Checks

| Check | Result | Line |
| --- | --- | --- |
| expect `timing` | seen at 4.0 min | `peed_wanted=1.000 speed_actual=1.000 ai_n=1800 ai_mean_ms=1.569208 ai_p50_ms=1.265625 ai_p95_ms=3.816406 ai_p99_ms=7.044922 ai_max_ms=10.041016 fps_n=61 fps_p10=190.000 fps_p50=203.000 fps_p90=218.000` |
| expect `commands` | seen at 1.0 min | `[t=00:01:02.493183][f=0001800] [AirOrders] frame=1800 team=0 all_apm=64 air_apm=0 repeated=0` |
| forbid `script` | clean |  |
| forbid `instrumentation` | clean |  |
| forbid `invariant` | **hit** | `[INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s` |

## Failures

- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 2.1 min: [INVARIANT] INV-013 the main turret cluster has had no forward cluster planned for 120 s
- forbid 'invariant' hit at 6.1 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1230 (4 by power), bank 0 + 11/s (0 by metal))
- forbid 'invariant' hit at 7.1 min: [INVARIANT] INV-019 2 turret frames under construction, 1 allowed (build power 1230 (4 by power), bank 1 + 11/s (0 by metal))
- forbid 'invariant' hit at 14.0 min: [INVARIANT] INV-008 4 turret(s) in range of the reclaim of coralab 30368 are not on it
- forbid 'invariant' hit at 16.6 min: [INVARIANT] INV-008 5 turret(s) in range of the reclaim of armalab 11239 are not on it
- forbid 'invariant' hit at 17.4 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 20.8 min: [INVARIANT] INV-029 armaap 17999 stands 5 cells from the turrets, not tight
- forbid 'invariant' hit at 22.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 23.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 25.7 min: [INVARIANT] INV-022 a new set of armmmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 26.5 min: [INVARIANT] INV-014 armmmkr packed at (352, 1712) with no turret slot within 450
- forbid 'invariant' hit at 27.1 min: [INVARIANT] INV-022 a new set of armmmkr starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 27.7 min: [INVARIANT] INV-014 armmmkr packed at (336, 1776) with no turret slot within 450
- forbid 'invariant' hit at 27.7 min: [INVARIANT] INV-022 a new set of cormmkr starts 1 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.4 min: [INVARIANT] INV-029 armalab 17055 stands 16 cells from the turrets, not tight
- forbid 'invariant' hit at 28.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 15 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 28.9 min: [INVARIANT] INV-014 armmmkr packed at (352, 816) with no turret slot within 450
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-016 the advanced lab 17055 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 352 elmos away, not flush (160)
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-014 armmmkr packed at (192, 960) with no turret slot within 450
- forbid 'invariant' hit at 29.9 min: [INVARIANT] INV-022 a new set of armmmkr starts 20 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.2 min: [INVARIANT] INV-029 coralab 24266 stands 11 cells from the turrets, not tight
- forbid 'invariant' hit at 30.2 min: [INVARIANT] INV-022 a new set of cormmkr starts 3 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 30.4 min: [INVARIANT] INV-014 armafus packed at (368, 736) with no turret slot within 450
- forbid 'invariant' hit at 30.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 30.9 min: [INVARIANT] INV-016 the advanced lab 17055 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 30.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 352 elmos away, not flush (160)
- forbid 'invariant' hit at 30.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 30.9 min: [INVARIANT] INV-052 ferry run for cargo 18596 unloading for 16 s
- forbid 'invariant' hit at 31.2 min: [INVARIANT] INV-022 a new set of corafus starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 31.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 31.7 min: [INVARIANT] INV-016 the advanced lab 24266 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 31.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 272 elmos away, not flush (160)
- forbid 'invariant' hit at 31.7 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 2 structures in its exit lane
- forbid 'invariant' hit at 31.9 min: [INVARIANT] INV-016 the advanced lab 17055 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 31.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 352 elmos away, not flush (160)
- forbid 'invariant' hit at 31.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 32.1 min: [INVARIANT] INV-022 a new set of cormmkr starts 5 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 32.3 min: [INVARIANT] INV-014 armafus packed at (272, 736) with no turret slot within 450
- forbid 'invariant' hit at 32.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-016 the advanced lab 24266 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 272 elmos away, not flush (160)
- forbid 'invariant' hit at 32.7 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 2 structures in its exit lane
- forbid 'invariant' hit at 32.9 min: [INVARIANT] INV-016 the advanced lab 17055 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 32.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 352 elmos away, not flush (160)
- forbid 'invariant' hit at 32.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 33.3 min: [INVARIANT] INV-014 armafus ordered outside the layout (no room in the turret boxes): native's site search around the base centre
- forbid 'invariant' hit at 33.5 min: [INVARIANT] INV-053 air constructor 30146 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 33.5 min: [INVARIANT] INV-053 air constructor 1864 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 33.5 min: [INVARIANT] INV-053 air constructor 29653 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 33.5 min: [INVARIANT] INV-053 air constructor 20578 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 33.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 33.7 min: [INVARIANT] INV-016 the advanced lab 24266 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 33.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 272 elmos away, not flush (160)
- forbid 'invariant' hit at 33.7 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 2 structures in its exit lane
- forbid 'invariant' hit at 33.7 min: [INVARIANT] INV-022 a new set of cormmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 33.9 min: [INVARIANT] INV-016 the advanced lab 17055 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 33.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 352 elmos away, not flush (160)
- forbid 'invariant' hit at 33.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 34.0 min: [INVARIANT] INV-053 air constructor 619 has done nothing for 60 s (task type 2, last rule power.turret)
- forbid 'invariant' hit at 34.2 min: [INVARIANT] INV-022 a new set of corafus starts 10 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 34.4 min: [INVARIANT] INV-020 no layout room for armmmkr for 124 s
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 10932 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 22586 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 17160 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 14313 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 27193 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 261 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 28767 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 24765 has done nothing for 60 s (task type 2, last rule lab.front)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 28802 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 16124 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 17574 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 28462 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 5251 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 20341 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-053 air constructor 2611 has done nothing for 60 s (task type 2, last rule wait)
- forbid 'invariant' hit at 34.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 34.7 min: [INVARIANT] INV-016 the advanced lab 24266 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 34.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 272 elmos away, not flush (160)
- forbid 'invariant' hit at 34.7 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 2 structures in its exit lane
- forbid 'invariant' hit at 34.9 min: [INVARIANT] INV-016 the advanced lab 17055 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 34.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 352 elmos away, not flush (160)
- forbid 'invariant' hit at 34.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-053 air constructor 20601 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-053 air constructor 7491 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-053 air constructor 17631 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-053 air constructor 24221 has done nothing for 60 s (task type 2, last rule chain.next)
- forbid 'invariant' hit at 35.0 min: [INVARIANT] INV-053 air constructor 28262 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.4 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (10 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 35.4 min: [INVARIANT] INV-020 no layout room for armmmkr for 185 s
- forbid 'invariant' hit at 35.4 min: [INVARIANT] INV-022 a new set of armmmkr starts 11 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 10994 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 24128 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 18432 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 26119 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 30045 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 21849 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 435 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 1864 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 26517 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 21366 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 21319 has done nothing for 60 s (task type 2, last rule mex.upgrade)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 11283 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 27406 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 13820 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 28495 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-053 air constructor 19298 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 35.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 35.7 min: [INVARIANT] INV-016 the advanced lab 24266 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 35.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 272 elmos away, not flush (160)
- forbid 'invariant' hit at 35.7 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 2 structures in its exit lane
- forbid 'invariant' hit at 35.9 min: [INVARIANT] INV-016 the advanced lab 17055 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 35.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 352 elmos away, not flush (160)
- forbid 'invariant' hit at 35.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 3517 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 31010 has done nothing for 60 s (task type 2, last rule mex.upgrade)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 4584 has done nothing for 60 s (task type 2, last rule mex.upgrade)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 29811 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 29922 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 26443 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 23377 has done nothing for 60 s (task type 2, last rule mex.upgrade)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 6121 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 9694 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 26379 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 36.0 min: [INVARIANT] INV-053 air constructor 21553 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 36.2 min: [INVARIANT] INV-032 a armmmkr ordered with the metal bank full for 15 s
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 30146 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-053 air constructor 20341 has done nothing for 60 s (task type 2, last rule mex.upgrade)
- forbid 'invariant' hit at 36.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 36.7 min: [INVARIANT] INV-016 the advanced lab 24266 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 36.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 272 elmos away, not flush (160)
- forbid 'invariant' hit at 36.7 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 2 structures in its exit lane
- forbid 'invariant' hit at 36.9 min: [INVARIANT] INV-016 the advanced lab 17055 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 36.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 352 elmos away, not flush (160)
- forbid 'invariant' hit at 36.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 37.2 min: [INVARIANT] INV-032 a armmmkr ordered with the metal bank full for 15 s
- forbid 'invariant' hit at 37.4 min: [INVARIANT] INV-020 no layout room for armmmkr for 120 s
- forbid 'invariant' hit at 37.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 37.6 min: [INVARIANT] INV-022 a new set of cormmkr starts 6 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 37.7 min: [INVARIANT] INV-016 the advanced lab 24266 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 37.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 272 elmos away, not flush (160)
- forbid 'invariant' hit at 37.7 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 2 structures in its exit lane
- forbid 'invariant' hit at 37.9 min: [INVARIANT] INV-016 the advanced lab 17055 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 37.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 352 elmos away, not flush (160)
- forbid 'invariant' hit at 37.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 20601 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 30045 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 14313 has done nothing for 60 s (task type 2, last rule air.dedicated)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 21849 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 435 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 24221 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.0 min: [INVARIANT] INV-053 air constructor 2611 has done nothing for 60 s (task type 2, last rule mex.upgrade)
- forbid 'invariant' hit at 38.2 min: [INVARIANT] INV-032 a armmmkr ordered with the metal bank full for 15 s
- forbid 'invariant' hit at 38.4 min: [INVARIANT] INV-037 no new advanced fusion for 180 s (10 stand or build) with the fusion role held and the metal bank over half
- forbid 'invariant' hit at 38.4 min: [INVARIANT] INV-020 no layout room for armmmkr for 180 s
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 10641 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-053 air constructor 26379 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 38.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 38.6 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 2 has 144 free
- forbid 'invariant' hit at 38.7 min: [INVARIANT] INV-016 the advanced lab 24266 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 38.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 272 elmos away, not flush (160)
- forbid 'invariant' hit at 38.7 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 2 structures in its exit lane
- forbid 'invariant' hit at 38.7 min: [INVARIANT] INV-022 a new set of cormmkr starts 11 cell(s) from the turrets, not flush
- forbid 'invariant' hit at 38.9 min: [INVARIANT] INV-016 the advanced lab 17055 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 38.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 352 elmos away, not flush (160)
- forbid 'invariant' hit at 38.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 28317 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 17160 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 27193 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 619 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 261 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 29653 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 21319 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 23377 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 9694 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 23876 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 28462 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.0 min: [INVARIANT] INV-053 air constructor 5251 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.2 min: [INVARIANT] INV-032 a armmmkr ordered with the metal bank full for 15 s
- forbid 'invariant' hit at 39.4 min: [INVARIANT] INV-014 cormmkr packed at (14960, 1776) with no turret slot within 450
- forbid 'invariant' hit at 39.4 min: [INVARIANT] INV-020 no layout room for armmmkr for 240 s
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-042 the run for cargo 5785 has lasted 600 s
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 6008 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 30614 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 30146 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 17051 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 16124 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 13792 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 10450 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 17574 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 28495 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 19298 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-053 air constructor 2699 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 39.5 min: [INVARIANT] INV-015 a dear chain order has had no frame for 45 s
- forbid 'invariant' hit at 39.6 min: [INVARIANT] INV-033 metal over 95% for 60 s while team 2 has 153 free
- forbid 'invariant' hit at 39.7 min: [INVARIANT] INV-016 the advanced lab 24266 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 39.7 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 272 elmos away, not flush (160)
- forbid 'invariant' hit at 39.7 min: [INVARIANT] INV-018 the advanced lab faces 0 (the front 3) with 2 structures in its exit lane
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-052 ferry run for cargo 27089 unloading for 16 s
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-016 the advanced lab 17055 has stood 90 s with no turret or turret slot within 260
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-017 the advanced lab's nearest construction turret is 352 elmos away, not flush (160)
- forbid 'invariant' hit at 39.9 min: [INVARIANT] INV-018 the advanced lab faces 3 (the front 1) with 0 structures in its exit lane
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 22586 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 7491 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 22567 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 24765 has done nothing for 60 s (task type 2, last rule keep.current)
- forbid 'invariant' hit at 40.0 min: [INVARIANT] INV-053 air constructor 28262 has done nothing for 60 s (task type 2, last rule keep.current)

## Screenshots

- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\shore-8v8-d195\shore-to-shore\20261004T213111Z-b2a38464\runs\20261004T215058Z-7fcb4c2a\screen_2026-10-04_21-34-23-076.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\shore-8v8-d195\shore-to-shore\20261004T213111Z-b2a38464\runs\20261004T215058Z-7fcb4c2a\screen_2026-10-04_21-36-38-809.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\shore-8v8-d195\shore-to-shore\20261004T213111Z-b2a38464\runs\20261004T215058Z-7fcb4c2a\screen_2026-10-04_21-40-39-561.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\shore-8v8-d195\shore-to-shore\20261004T213111Z-b2a38464\runs\20261004T215058Z-7fcb4c2a\screen_2026-10-04_21-44-40-259.png
- C:\bardev\s3k-CircuitAI\build-theatres\games\shared\performance\shore-8v8-d195\shore-to-shore\20261004T213111Z-b2a38464\runs\20261004T215058Z-7fcb4c2a\screen_2026-10-04_21-50-44-396.png

## Timeline (team 0)

```
  0.00  [Playtest] widget loaded: role AIR, team 0, speed 4, 6 shots, end at 60.5 min
  0.00  [Playtest] Autoquit widget disabled
  0.00  [Playtest] finished armcom team 0 at 0.00 min
  0.00  [Playtest] eco team 0 at 0.0 min: metal +0.0 bank 1000/1000, energy +0.0 bank 1000/1000, units 1
  0.00  [Playtest] frame 1 team 0 ally 0 side armada ai true dead false start (550, 1740) units 1
  0.00  [Playtest] frame 1 team 1 ally 0 side armada ai true dead false start (550, 730) units 1
  0.00  [Playtest] frame 1 team 2 ally 0 side cortex ai true dead false start (550, 2700) units 1
  0.00  [Playtest] frame 1 team 3 ally 0 side legion ai true dead false start (2000, 400) units 1
  0.00  [Playtest] frame 1 team 4 ally 0 side armada ai true dead false start (2000, 950) units 1
  0.00  [Playtest] frame 1 team 5 ally 0 side cortex ai true dead false start (2000, 1500) units 1
  0.00  [Playtest] frame 1 team 6 ally 0 side legion ai true dead false start (2000, 2050) units 1
  0.00  [Playtest] frame 1 team 7 ally 0 side armada ai true dead false start (2000, 2600) units 1
  0.00  [Playtest] frame 1 team 8 ally 1 side cortex ai true dead false start (14800, 730) units 1
  0.00  [Playtest] frame 1 team 9 ally 1 side legion ai true dead false start (14800, 1740) units 1
  0.00  [Playtest] frame 1 team 10 ally 1 side armada ai true dead false start (14800, 2700) units 1
  0.00  [Playtest] frame 1 team 11 ally 1 side cortex ai true dead false start (13250, 400) units 1
  0.00  [Playtest] frame 1 team 12 ally 1 side legion ai true dead false start (13250, 950) units 1
  0.00  [Playtest] frame 1 team 13 ally 1 side armada ai true dead false start (13250, 1500) units 1
  0.00  [Playtest] frame 1 team 14 ally 1 side cortex ai true dead false start (13250, 2050) units 1
  0.00  [Playtest] frame 1 team 15 ally 1 side legion ai true dead false start (13250, 2600) units 1
  0.00  [Playtest] frame 1 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.00  [Playtest] frame 1 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.00  [Playtest] speed 4
  0.00  [Playtest] speed 4 at 0.00 min
  0.05  [Playtest] frame 90 team 0 ally 0 side armada ai true dead false start (550, 1740) units 1
  0.05  [Playtest] frame 90 team 1 ally 0 side armada ai true dead false start (550, 730) units 1
  0.05  [Playtest] frame 90 team 2 ally 0 side cortex ai true dead false start (550, 2700) units 1
  0.05  [Playtest] frame 90 team 3 ally 0 side legion ai true dead false start (2000, 400) units 1
  0.05  [Playtest] frame 90 team 4 ally 0 side armada ai true dead false start (2000, 950) units 1
  0.05  [Playtest] frame 90 team 5 ally 0 side cortex ai true dead false start (2000, 1500) units 1
  0.05  [Playtest] frame 90 team 6 ally 0 side legion ai true dead false start (2000, 2050) units 1
  0.05  [Playtest] frame 90 team 7 ally 0 side armada ai true dead false start (2000, 2600) units 1
  0.05  [Playtest] frame 90 team 8 ally 1 side cortex ai true dead false start (14800, 730) units 1
  0.05  [Playtest] frame 90 team 9 ally 1 side legion ai true dead false start (14800, 1740) units 1
  0.05  [Playtest] frame 90 team 10 ally 1 side armada ai true dead false start (14800, 2700) units 1
  0.05  [Playtest] frame 90 team 11 ally 1 side cortex ai true dead false start (13250, 400) units 1
  0.05  [Playtest] frame 90 team 12 ally 1 side legion ai true dead false start (13250, 950) units 1
  0.05  [Playtest] frame 90 team 13 ally 1 side armada ai true dead false start (13250, 1500) units 1
  0.05  [Playtest] frame 90 team 14 ally 1 side cortex ai true dead false start (13250, 2050) units 1
  0.05  [Playtest] frame 90 team 15 ally 1 side legion ai true dead false start (13250, 2600) units 1
  0.05  [Playtest] frame 90 team 16 ally 2 side armada ai false dead false start (64, 64) units 1
  0.05  [Playtest] frame 90 team 17 ally 3 side  ai false dead false start (0, 0) units 0
  0.08  [AIR][Layout] enabled; adopted 0 bays, 0 wind clusters
  0.08  [AIR][Capacity] own=2/30 usage=0/0 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.08  [AIR][Economy] BOOTSTRAP M=0 bank=997 E=0 bank=990 pull=0 plants=0/0 aircraftDemand=0/0
  0.08  [AIR][Projects] energyQueued=0 committed=0/0
  0.08  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.08  [AIR][Fusion] target=1200s mexes=0 upgraded=pending reactor=pending
  0.10  [AIR][Claim] cancel unowned native order armap
  0.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.10  [Layout] home centre (618, 1485), 269 from the start
  0.10  [Team][Roster] Announced: roster|1|0|0|AIR|armada|armap|601|1753|0|1|1|-1|-1
  0.10  [Team][Roster] Team 1 (AI 1): role=TECH side=armada start=(550,727) factory=armlab landLocked=no spot=0 known=1/7
  0.10  [Team][Roster] Team 2 (AI 2): role=TACTICAL side=cortex start=(547,2771) factory=corhp landLocked=no spot=2 known=2/7
  0.10  [Team][Roster] Team 3 (AI 3): role=SEA side=legion start=(1991,407) factory=legsy landLocked=no spot=3 known=3/7
  0.10  [Team][Roster] Team 4 (AI 4): role=SEA side=armada start=(1934,916) factory=armsy landLocked=no spot=3 known=4/7
  0.10  [Team][Roster] Team 5 (AI 5): role=SEA side=cortex start=(1999,1501) factory=corsy landLocked=no spot=4 known=5/7
  0.10  [Team][Roster] Team 6 (AI 6): role=SEA side=legion start=(1936,2043) factory=legsy landLocked=no spot=4 known=6/7
  0.10  [Team][Roster] Team 7 (AI 7): role=SEA side=armada start=(1957,2671) factory=armsy landLocked=no spot=5 known=7/7
  0.15  [Team][Roster] team 1 first mex at 624,688
  0.17  [Team][Roster] team 3 first mex at 1840,336
  0.17  [Team][Roster] team 5 first mex at 1888,1487
  0.20  [Team][Roster] team 2 first mex at 544,2927
  0.20  [Team][Roster] team 4 first mex at 1792,832
  0.25  [Team][Roster] team 7 first mex at 1808,2912
  0.27  [AIR][Capacity] own=2/30 usage=8/83 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.27  [AIR][Economy] BOOTSTRAP M=1 bank=961 E=18 bank=721 pull=83 plants=0/0 aircraftDemand=0/0
  0.27  [AIR][Projects] energyQueued=0 committed=0/0
  0.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.27  [Playtest] finished armmex team 0 at 0.27 min
  0.28  [Team][Roster] first mex 18726 at 784,1792
  0.28  [Team][Roster] Re-announced: roster|1|0|0|AIR|armada|armap|601|1753|0|1|1|784|1792
  0.28  [AIR][Rule] opening.mex builder=23642
  0.32  [Team][Roster] team 6 first mex at 1568,1952
  0.43  [AIR][Capacity] own=2/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.43  [AIR][Economy] BOOTSTRAP M=2 bank=987 E=30 bank=1000 pull=3 plants=0/0 aircraftDemand=0/0
  0.43  [AIR][Projects] energyQueued=0 committed=0/0
  0.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.60  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.60  [AIR][Economy] BOOTSTRAP M=4 bank=1030 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  0.60  [AIR][Projects] energyQueued=0 committed=0/0
  0.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  0.77  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=4 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.77  [AIR][Economy] BOOTSTRAP M=4 bank=1039 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  0.77  [AIR][Projects] energyQueued=0 committed=0/0
  0.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  0.93  [AIR][Capacity] own=4/30 usage=0/3 gifts=0 sent=4 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  0.93  [AIR][Economy] BOOTSTRAP M=4 bank=1039 E=30 bank=998 pull=3 plants=0/0 aircraftDemand=0/0
  0.93  [AIR][Projects] energyQueued=0 committed=0/0
  0.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  0.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.00  [Playtest] eco team 0 at 1.0 min: metal +4.0 bank 1043/1050, energy +30.0 bank 985/1000, units 2
  1.01  [AIR][Starter] nearby distance=160
  1.01  [AIR][Rule] opening.plant builder=23642
  1.02  [AIR][EcoLayout] reserved air.eco.0 reactor=336,2144 converters=8 support=12 zone=22
  1.03  [AIR][EcoLayout] reserved air.eco.1 reactor=336,352 converters=8 support=12 zone=52
  1.05  [AIR][EcoLayout] reserved air.eco.2 reactor=1104,2656 converters=8 support=0 zone=88
  1.07  [AIR][EcoLayout] reserved air.eco.3 reactor=1360,1632 converters=8 support=12 zone=119
  1.10  [AIR][Capacity] own=4/30 usage=35/63 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.10  [AIR][Economy] BOOTSTRAP M=4 bank=921 E=30 bank=816 pull=63 plants=0/0 aircraftDemand=0/0
  1.10  [AIR][Projects] energyQueued=0 committed=480/813
  1.10  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=true savingLab=false
  1.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.10  [AIR][Bay] 0 plant=11102 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.27  [AIR][Capacity] own=4/30 usage=35/63 gifts=0 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.27  [AIR][Economy] BOOTSTRAP M=4 bank=604 E=30 bank=493 pull=63 plants=0/0 aircraftDemand=0/0
  1.27  [AIR][Projects] energyQueued=0 committed=122/207
  1.27  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.27  [AIR][Bay] 0 plant=11102 BP=0 nanos=0+0/0 available=yes firstSlot=0
  1.32  [Playtest] finished armap team 0 at 1.32 min
  1.33  [AIR][Claim] cancel unowned native order armnanotc
  1.33  [AIR][Claim] cancel unowned native order armnanotc
  1.33  [AIR][State] T1_CONTEST
  1.34  [AIR][Produce] opening.scout armpeep plant=11102 projected=1/1
  1.34  [AIR][Rule] opening.commander.guard builder=23642
  1.43  [AIR][Capacity] own=4/30 usage=0/25 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=475 E=30 bank=14 pull=169 plants=1/0 aircraftDemand=3/121
  1.43  [AIR][Projects] energyQueued=0 committed=0/0
  1.43  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.43  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Capacity] own=4/30 usage=1/36 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.60  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=517 E=30 bank=3 pull=169 plants=1/0 aircraftDemand=3/121
  1.60  [AIR][Projects] energyQueued=0 committed=0/0
  1.60  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.60  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  1.77  [AIR][Capacity] own=4/30 usage=0/30 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.77  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=554 E=30 bank=5 pull=169 plants=1/0 aircraftDemand=3/121
  1.77  [AIR][Projects] energyQueued=0 committed=0/0
  1.77  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.77  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  1.93  [AIR][Capacity] own=4/30 usage=0/30 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  1.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=589 E=30 bank=1 pull=169 plants=1/0 aircraftDemand=3/121
  1.93  [AIR][Projects] energyQueued=0 committed=0/0
  1.93  [AIR][Workforce] t1=0/3 t2=0/2 targetBP=0 floating=false savingLab=false
  1.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  1.93  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.00  [Playtest] eco team 0 at 2.0 min: metal +4.0 bank 609/1150, energy +30.0 bank 1/1100, units 4
  2.02  [AIR][Produce] constructor.recovery armca plant=11102 projected=1/3
  2.02  [AIR][Scout] opening drone=8301 enemy starts=8
  2.10  [AIR][Capacity] own=4/30 usage=0/0 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.10  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=629 E=30 bank=0 pull=128 plants=1/0 aircraftDemand=3/121
  2.10  [AIR][Projects] energyQueued=0 committed=0/0
  2.10  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.10  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.27  [AIR][Capacity] own=4/30 usage=0/0 gifts=1 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=662 E=30 bank=3 pull=128 plants=1/0 aircraftDemand=3/121
  2.27  [AIR][Projects] energyQueued=0 committed=0/0
  2.27  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.27  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][Capacity] own=4/30 usage=0/2 gifts=0 sent=0 excess=0 pressure=true mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.43  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=683 E=30 bank=0 pull=107 plants=1/0 aircraftDemand=3/121
  2.43  [AIR][Projects] energyQueued=0 committed=0/0
  2.43  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.43  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.43  [AIR][BaseResponse] contact=true
  2.43  [AIR][BaseResponse] group=0 target=29852
  2.43  [AIR][BaseResponse] group=2 target=29852
  2.55  [AIR][BaseResponse] contact=false
  2.55  [AIR][BaseResponse] group=0 target=-1
  2.55  [AIR][BaseResponse] group=2 target=-1
  2.60  [AIR][Capacity] own=4/30 usage=0/0 gifts=1 sent=0 excess=0 pressure=false mobile=0 arriving=50 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  2.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=698 E=30 bank=12 pull=128 plants=1/0 aircraftDemand=3/121
  2.60  [AIR][Projects] energyQueued=0 committed=0/0
  2.60  [AIR][Workforce] t1=1/3 t2=0/2 targetBP=50 floating=false savingLab=false
  2.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.60  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.60  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  2.71  [AIR][Produce] constructor.recovery armca plant=11102 projected=2/3
  2.72  [AIR][Rule] recovery.energy builder=3095
  2.77  [AIR][Capacity] own=4/30 usage=3/55 gifts=1 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=57 reason=funded workload
  2.77  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=704 E=30 bank=60 pull=191 plants=1/0 aircraftDemand=3/121
  2.77  [AIR][Projects] energyQueued=0 committed=151/0
  2.77  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=157 floating=false savingLab=false
  2.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.77  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  2.93  [AIR][Capacity] own=4/35 usage=2/0 gifts=0 sent=0 excess=0 pressure=false mobile=50 arriving=50 idle=0 ecoStatic=0 working=50 shortage=67 reason=funded workload
  2.93  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=662 E=34 bank=0 pull=86 plants=1/0 aircraftDemand=3/121
  2.93  [AIR][Projects] energyQueued=0 committed=121/0
  2.93  [AIR][Workforce] t1=2/3 t2=0/2 targetBP=167 floating=false savingLab=false
  2.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  2.93  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.00  [Playtest] eco team 0 at 3.0 min: metal +4.0 bank 654/1150, energy +35.0 bank 0/1125, units 6
  3.00  [Playtest] speed 1 at 3.00 min
  3.10  [AIR][Produce] constructor.recovery armca plant=11102 projected=3/3
  3.10  [AIR][Capacity] own=4/35 usage=7/86 gifts=1 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=50 ecoStatic=0 working=49 shortage=0 reason=available or arriving power
  3.10  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=645 E=35 bank=71 pull=128 plants=1/0 aircraftDemand=3/121
  3.10  [AIR][Projects] energyQueued=0 committed=92/0
  3.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.10  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.10  [AIR][Attack] home=0 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.10  [AIR][Rule] recovery.energy builder=3388
  3.27  [AIR][Capacity] own=4/40 usage=5/3 gifts=1 sent=0 excess=0 pressure=false mobile=100 arriving=50 idle=0 ecoStatic=0 working=100 shortage=0 reason=available or arriving power
  3.27  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=573 E=36 bank=772 pull=191 plants=1/0 aircraftDemand=3/121
  3.27  [AIR][Projects] energyQueued=0 committed=199/0
  3.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.27  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.32  [AIR][Produce] opening.screen armfig plant=11102 projected=1/6
  3.32  [AIR][Rule] recovery.energy builder=4938
  3.35  [AIR][Layout] cluster=0 labs=1 at=1825,2305
  3.35  [AIR][Naval] theatre=0:4:0 enemy=580 friendly=600 subs=580 antiSub=0 deficit=580
  3.37  [AIR][Layout] cluster=1 labs=1 at=1921,2689
  3.38  [AIR][Layout] cluster=2 labs=1 at=2017,961
  3.39  [AIR][Rule] commander.factory.guard builder=23642
  3.43  [AIR][Capacity] own=4/40 usage=18/375 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.43  [AIR][Economy] T1_CONTEST M=4 bank=477 E=40 bank=657 pull=375 plants=1/0 aircraftDemand=3/121
  3.43  [AIR][Projects] energyQueued=0 committed=283/0
  3.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.43  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/2 available=yes firstSlot=0
  3.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.48  [AIR][Produce] opening.screen armfig plant=11102 projected=2/6
  3.48  [AIR][Screen] fighters=1 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.52  [AIR][Naval] theatre=0:5:0 enemy=1200 friendly=300 subs=1200 antiSub=0 deficit=1200
  3.60  [AIR][Capacity] own=4/45 usage=13/189 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.60  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=369 E=45 bank=84 pull=272 plants=1/0 aircraftDemand=3/127
  3.60  [AIR][Projects] energyQueued=0 committed=193/0
  3.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.60  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.60  [AIR][Attack] home=1 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  3.61  [Playtest] finished armsolar team 0 at 3.61 min
  3.63  [AIR][Rule] recovery.assist builder=3095
  3.65  [AIR][Screen] fighters=1 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.68  [AIR][Produce] opening.screen armfig plant=11102 projected=3/6
  3.77  [AIR][Capacity] own=4/45 usage=14/230 gifts=1 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  3.77  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=289 E=45 bank=161 pull=297 plants=1/0 aircraftDemand=3/127
  3.77  [AIR][Projects] energyQueued=0 committed=108/0
  3.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.77  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.80  [Playtest] target team 0 at (550, 1740) from its start position
  3.80  [Playtest] camera requested (776,1936) height=2200
  3.80  [Playtest] camera captured name=ta position=(776,1936) height=2200
  3.80  [Playtest] screenshot at 3.8 min of team 0 at (776, 1936)
  3.82  [AIR][Screen] fighters=2 cells=8 centre=949,734 width=600 advance=400 responding=false
  3.83  [Playtest] finished armsolar team 0 at 3.83 min
  3.85  [AIR][Naval] theatre=0:3:0 enemy=580 friendly=1050 subs=580 antiSub=0 deficit=580
  3.85  [AIR][Rule] mex.expand builder=3388
  3.90  [AIR][Layout] cluster=3 labs=1 at=1537,481
  3.90  [AIR][Produce] opening.screen armfig plant=11102 projected=4/6
  3.93  [AIR][Capacity] own=4/65 usage=6/131 gifts=0 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=50 shortage=0 reason=no funded workload
  3.93  [AIR][Economy] T1_CONTEST RECOVERY M=5 bank=233 E=65 bank=406 pull=131 plants=1/0 aircraftDemand=3/127
  3.93  [AIR][Projects] energyQueued=0 committed=54/0
  3.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  3.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  3.93  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  3.98  [AIR][Screen] fighters=3 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.00  [Playtest] eco team 0 at 4.0 min: metal +4.0 bank 193/1150, energy +85.0 bank 6/1275, units 13
  4.00  [Playtest] speed 4 at 4.00 min
  4.09  [Playtest] finished armsolar team 0 at 4.09 min
  4.10  [AIR][Capacity] own=4/85 usage=10/181 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.10  [AIR][Economy] T1_CONTEST RECOVERY M=4 bank=169 E=85 bank=227 pull=181 plants=1/0 aircraftDemand=3/127
  4.10  [AIR][Projects] energyQueued=0 committed=0/0
  4.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.10  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.10  [AIR][Attack] home=3 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.10  [AIR][Rule] recovery.energy builder=3095
  4.11  [AIR][Produce] opening.screen armfig plant=11102 projected=5/6
  4.11  [AIR][Rule] mex.expand builder=4938
  4.15  [AIR][Rule] recovery.assist builder=3388
  4.15  [AIR][Screen] fighters=4 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.18  [AIR][Naval] theatre=0:5:0 enemy=740 friendly=300 subs=0 antiSub=0 deficit=440
  4.22  [AIR][Rule] recovery.assist builder=4938
  4.27  [AIR][Capacity] own=4/95 usage=15/288 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=150 shortage=0 reason=no funded workload
  4.27  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=130 E=103 bank=166 pull=313 plants=1/0 aircraftDemand=3/127
  4.27  [AIR][Projects] energyQueued=0 committed=119/0
  4.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.27  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.27  [AIR][Commander] cleared factory guard for commander.idle.assist
  4.27  [AIR][Rule] commander.idle.assist builder=23642
  4.28  [AIR][Produce] opening.screen armfig plant=11102 projected=6/6
  4.32  [AIR][Screen] fighters=5 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.40  [Playtest] finished armsolar team 0 at 4.40 min
  4.40  [AIR][Claim] cancel unowned native order armmakr
  4.41  [AIR][Rule] commander.factory.guard builder=23642
  4.41  [AIR][Rule] mex.expand builder=3095
  4.42  [AIR][Rule] mex.expand builder=3388
  4.42  [AIR][Rule] mex.expand builder=4938
  4.43  [AIR][Capacity] own=4/105 usage=3/135 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.43  [AIR][Economy] T1_CONTEST RECOVERY M=6 bank=33 E=105 bank=1361 pull=135 plants=1/0 aircraftDemand=3/127
  4.43  [AIR][Projects] energyQueued=0 committed=0/0
  4.43  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.43  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.43  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.43  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.48  [AIR][Screen] fighters=5 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.51  [AIR][Wind] cluster=0 slots=6 at=1040,1992 local=false builder=23642
  4.51  [AIR][Commander] cleared factory guard for commander.idle.energy
  4.51  [AIR][Rule] commander.idle.energy builder=23642
  4.60  [AIR][Capacity] own=4/125 usage=7/35 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=100 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  4.60  [AIR][Economy] T1_CONTEST M=6 bank=32 E=123 bank=1375 pull=35 plants=1/0 aircraftDemand=3/127
  4.60  [AIR][Projects] energyQueued=0 committed=13/61
  4.60  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.60  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.60  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.60  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.60  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  4.63  [Playtest] finished armwin team 0 at 4.63 min
  4.64  [AIR][Rule] commander.energy.local builder=23642
  4.65  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.74  [Playtest] finished armwin team 0 at 4.74 min
  4.77  [AIR][Capacity] own=4/125 usage=2/13 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  4.77  [AIR][Economy] T1_CONTEST M=6 bank=36 E=125 bank=1373 pull=13 plants=1/0 aircraftDemand=3/127
  4.77  [AIR][Projects] energyQueued=0 committed=36/159
  4.77  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.77  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.77  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.77  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.77  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.82  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.85  [Playtest] finished armwin team 0 at 4.85 min
  4.86  [AIR][Rule] commander.idle.energy builder=23642
  4.92  [AIR][Layout] cluster=4 labs=1 at=1825,1825
  4.93  [AIR][Capacity] own=4/158 usage=7/35 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  4.93  [AIR][Economy] T1_CONTEST M=6 bank=45 E=156 bank=1376 pull=35 plants=1/0 aircraftDemand=3/127
  4.93  [AIR][Projects] energyQueued=0 committed=17/77
  4.93  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  4.93  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  4.93  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/2 available=yes firstSlot=0
  4.93  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.93  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  4.97  [Playtest] finished armwin team 0 at 4.97 min
  4.98  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  4.99  [AIR][Rule] commander.energy.local builder=23642
  5.00  [Playtest] eco team 0 at 5.0 min: metal +4.0 bank 46/1150, energy +172.8 bank 1375/1377, units 21
  5.01  [AIR][Produce] recon.replace armpeep plant=11102 projected=1/1
  5.08  [Playtest] finished armwin team 0 at 5.08 min
  5.09  [AIR][Rule] commander.factory.guard builder=23642
  5.10  [AIR][Capacity] own=4/161 usage=9/113 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=50 ecoStatic=0 working=0 shortage=0 reason=no funded workload
  5.10  [AIR][Economy] T1_CONTEST M=6 bank=33 E=164 bank=1359 pull=113 plants=1/0 aircraftDemand=3/127
  5.10  [AIR][Projects] energyQueued=0 committed=0/0
  5.10  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.10  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
  5.10  [AIR][Bay] 0 plant=11102 BP=150 nanos=0+0/2 available=yes firstSlot=0
  5.10  [AIR][Bay] 1 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 2 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 3 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 4 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Bay] 5 plant=-1 BP=0 nanos=0+0/0 available=yes firstSlot=0
  5.10  [AIR][Attack] home=6 target=6 heldBombers=0 escorts=0 wave=0 enemyAir=0
  5.15  [AIR][Screen] fighters=6 cells=8 centre=949,734 width=600 advance=400 responding=false
  5.19  [AIR][Produce] air.control armfig plant=11102 projected=7/7
  5.19  [AIR][Commander] cleared factory guard for commander.energy.local
  5.19  [AIR][Rule] commander.energy.local builder=23642
  5.19  [AIR][Scout] opening drone=5638 enemy starts=8
  5.27  [AIR][Capacity] own=4/190 usage=10/160 gifts=2 sent=0 excess=0 pressure=false mobile=150 arriving=0 idle=0 ecoStatic=0 working=300 shortage=0 reason=no funded workload
  5.27  [AIR][Economy] T1_CONTEST M=6 bank=24 E=184 bank=1363 pull=160 plants=1/0 aircraftDemand=3/127
  5.27  [AIR][Projects] energyQueued=0 committed=10/44
  5.27  [AIR][Workforce] t1=3/3 t2=0/2 targetBP=150 floating=false savingLab=false
  5.27  [AIR][Fusion] target=1200s mexes=1 upgraded=pending reactor=pending
... 3612 more
```

## Native lines (all AIs, first 120)

```
  0.08  EXP: approach: armcom(23642) at (601, 1754) walks to (651, 1764), 136 from the armmex site (784, 1792)
  0.08  RESERVE: factory pair 'tech.factory.start' committed atomically facing 1
  0.08  RESERVE: zone 7 at (453, 1269) facing 1, 60x77 cells: 3972 of 4620 held
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (949, 1269) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (901, 1269) facing 1: 13 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (853, 1269) facing 1: 11 of 13 slots (group 5, held, zone)
  0.08  RESERVE: grid of armnanotc 13x1 gap 0 behind (805, 1269) facing 1: 11 of 13 slots (group 5, held, zone)
  0.08  RESERVE: armalab at (1032, 1032) facing 1 (id 59)
  0.08  RESERVE: armlab at (1968, 688) facing 1 (id 60)
  0.08  RESERVE: zone 8 at (1896, 688) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1920, 688) facing 1: 2 of 2 slots (group 6, zone)
  0.08  RESERVE: armlab at (1968, 816) facing 1 (id 63)
  0.08  RESERVE: zone 9 at (1896, 816) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1920, 816) facing 1: 2 of 2 slots (group 7, zone)
  0.08  RESERVE: armlab at (1968, 560) facing 1 (id 66)
  0.08  RESERVE: zone 10 at (1896, 560) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (1920, 560) facing 1: 2 of 2 slots (group 8, zone)
  0.08  RESERVE: armlab at (3968, 816) facing 1 (id 69)
  0.08  RESERVE: zone 11 at (3896, 816) facing 1, 3x6 cells: 18 of 18 held
  0.08  RESERVE: grid of armnanotc 2x1 gap 0 behind (3920, 816) facing 1: 2 of 2 slots (group 9, zone)
  0.08  RESERVE: corridor 12 at (3944, 912) facing 1, 21x6 cells: 126 of 126 held
  0.08  RESERVE: zone 13 at (3944, 816) facing 0, 9x6 cells: 0 of 54 held
  0.08  RESERVE: corridor 13 at (4192, 816) facing 1, 20x10 cells: 190 of 200 held
  0.09  RESERVE: factory pair 'tech.factory.start' committed atomically facing 3
  0.09  RESERVE: zone 7 at (14872, 1253) facing 3, 62x77 cells: 4049 of 4774 held
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14376, 1253) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14424, 1253) facing 3: 13 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14472, 1253) facing 3: 11 of 13 slots (group 5, held, zone)
  0.09  RESERVE: grid of cornanotc 13x1 gap 0 behind (14520, 1253) facing 3: 11 of 13 slots (group 5, held, zone)
  0.09  RESERVE: coralab at (14296, 1016) facing 3 (id 59)
  0.09  RESERVE: corlab at (13424, 528) facing 3 (id 60)
  0.09  RESERVE: zone 8 at (13496, 528) facing 3, 3x6 cells: 18 of 18 held
  0.09  RESERVE: grid of cornanotc 2x1 gap 0 behind (13472, 528) facing 3: 2 of 2 slots (group 6, zone)
  0.09  RESERVE: corridor 9 at (13448, 432) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: corridor 10 at (13448, 624) facing 3, 21x6 cells: 126 of 126 held
  0.09  RESERVE: zone 11 at (13448, 528) facing 0, 9x6 cells: 0 of 54 held
  0.09  RESERVE: corridor 11 at (13200, 528) facing 3, 20x10 cells: 180 of 200 held
  0.09  EXP: approach: legcom(6297) at (14750, 1700) walks to (14593, 1486), 137 from the legmex site (14512, 1376)
  0.17  RESERVE: armlab at (1968, 688) facing 1 (id 72)
  0.17  RESERVE: zone 14 at (1896, 688) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 816) facing 1 (id 73)
  0.17  RESERVE: zone 14 at (1896, 816) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (1968, 560) facing 1 (id 74)
  0.17  RESERVE: zone 14 at (1896, 560) facing 1, 3x6 cells: 0 of 18 held
  0.17  RESERVE: armlab at (3968, 1456) facing 1 (id 75)
  0.17  RESERVE: zone 14 at (3896, 1456) facing 1, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of armnanotc 2x1 gap 0 behind (3920, 1456) facing 1: 2 of 2 slots (group 10, zone)
  0.17  EXP: approach: corcom(27050) at (14799, 731) walks to (14663, 456), 139 from the cormex site (14544, 384)
  0.17  RESERVE: corlab at (13424, 912) facing 3 (id 63)
  0.17  RESERVE: zone 12 at (13496, 912) facing 3, 3x6 cells: 18 of 18 held
  0.17  RESERVE: grid of cornanotc 2x1 gap 0 behind (13472, 912) facing 3: 2 of 2 slots (group 7, zone)
  0.17  RESERVE: corridor 13 at (13448, 816) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: corridor 14 at (13448, 1008) facing 3, 21x6 cells: 126 of 126 held
  0.17  RESERVE: zone 15 at (13448, 912) facing 0, 9x6 cells: 0 of 54 held
  0.17  RESERVE: corridor 15 at (13200, 912) facing 3, 20x10 cells: 180 of 200 held
  0.26  RESERVE: coralab at (13448, 1224) facing 3 (id 66)
  0.26  RESERVE: zone 16 at (13568, 1224) facing 3, 6x7 cells: 42 of 42 held
  0.26  RESERVE: grid of cornanotc 2x2 gap 0 behind (13520, 1224) facing 3: 4 of 4 slots (group 8, zone)
  0.26  RESERVE: zone 17 at (13496, 1224) facing 0, 15x9 cells: 12 of 135 held
  0.26  RESERVE: corridor 18 at (13200, 1224) facing 3, 20x13 cells: 260 of 260 held
  0.28  EXP: approach: armcom(23642) at (719, 1778) walks to (420, 1592), 136 from the armmex site (304, 1520)
  0.33  RESERVE: armlab at (1968, 688) facing 1 (id 78)
  0.33  RESERVE: zone 15 at (1896, 688) facing 1, 3x6 cells: 0 of 18 held
  0.33  RESERVE: armlab at (1968, 816) facing 1 (id 79)
  0.33  RESERVE: zone 15 at (1896, 816) facing 1, 3x6 cells: 0 of 18 held
  0.33  RESERVE: armlab at (1968, 560) facing 1 (id 80)
  0.33  RESERVE: zone 15 at (1896, 560) facing 1, 3x6 cells: 0 of 18 held
  0.33  RESERVE: armlab at (3968, 1456) facing 1 (id 81)
  0.33  RESERVE: zone 15 at (3896, 1456) facing 1, 3x6 cells: 0 of 18 held
  0.34  RESERVE: coralab at (13448, 1400) facing 3 (id 71)
  0.34  RESERVE: zone 19 at (13568, 1400) facing 3, 6x7 cells: 42 of 42 held
  0.34  RESERVE: grid of cornanotc 2x2 gap 0 behind (13520, 1400) facing 3: 4 of 4 slots (group 9, zone)
  0.34  RESERVE: zone 20 at (13496, 1400) facing 0, 15x9 cells: 12 of 135 held
  0.34  RESERVE: corridor 21 at (13200, 1400) facing 3, 20x13 cells: 220 of 260 held
  0.37  EXP: approach: legcom(6297) at (14551, 1429) walks to (15079, 1412), 137 from the legmex site (15216, 1408)
  0.38  EXP: approach: armcom(23642) at (719, 1778) walks to (420, 1592), 136 from the armmex site (304, 1520)
  0.40  EXP: approach: armcom(23642) at (720, 1779) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.41  EXP: approach: armcom(23642) at (720, 1779) walks to (419, 1592), 136 from the armmex site (304, 1520)
  0.42  RESERVE: corgant at (13472, 2576) facing 3 (id 76)
  0.42  RESERVE: zone 22 at (13688, 2576) facing 3, 15x30 cells: 434 of 450 held
  0.42  RESERVE: grid of cornanotc 10x5 gap 0 behind (13568, 2576) facing 3: 46 of 50 slots (group 10, zone)
  0.42  RESERVE: zone 22 released
  0.42  RESERVE: zone 23 at (13688, 2576) facing 3, 15x24 cells: 344 of 360 held
  0.42  RESERVE: grid of cornanotc 8x5 gap 0 behind (13568, 2576) facing 3: 36 of 40 slots (group 11, zone)
  0.42  RESERVE: zone 23 released
  0.42  RESERVE: zone 24 at (13664, 2576) facing 3, 12x24 cells: 272 of 288 held
  0.42  RESERVE: grid of cornanotc 8x4 gap 0 behind (13568, 2576) facing 3: 28 of 32 slots (group 12, zone)
  0.42  RESERVE: zone 24 released
  0.42  RESERVE: zone 25 at (13664, 2576) facing 3, 12x18 cells: 200 of 216 held
  0.42  RESERVE: grid of cornanotc 6x4 gap 0 behind (13568, 2576) facing 3: 20 of 24 slots (group 13, zone)
  0.42  RESERVE: zone 25 released
  0.42  RESERVE: zone 26 at (13640, 2576) facing 3, 9x18 cells: 146 of 162 held
  0.42  RESERVE: grid of cornanotc 6x3 gap 0 behind (13568, 2576) facing 3: 14 of 18 slots (group 14, zone)
  0.42  RESERVE: zone 26 released
  0.42  RESERVE: zone 27 at (13616, 2576) facing 3, 6x10 cells: 58 of 60 held
  0.42  RESERVE: grid of cornanotc 3x2 gap 0 behind (13568, 2576) facing 3: 5 of 6 slots (group 15, zone)
  0.42  RESERVE: zone 27 released
  0.42  RESERVE: corgant at (13472, 2576) facing 3 (id 226)
  0.42  RESERVE: zone 28 at (13688, 2576) facing 3, 15x30 cells: 434 of 450 held
  0.42  RESERVE: grid of cornanotc 10x5 gap 0 behind (13568, 2576) facing 3: 46 of 50 slots (group 16, zone)
  0.42  RESERVE: zone 28 released
  0.42  RESERVE: zone 29 at (13688, 2576) facing 3, 15x24 cells: 344 of 360 held
  0.42  RESERVE: grid of cornanotc 8x5 gap 0 behind (13568, 2576) facing 3: 36 of 40 slots (group 17, zone)
  0.42  RESERVE: zone 29 released
  0.42  RESERVE: zone 30 at (13664, 2576) facing 3, 12x24 cells: 272 of 288 held
  0.42  RESERVE: grid of cornanotc 8x4 gap 0 behind (13568, 2576) facing 3: 28 of 32 slots (group 18, zone)
  0.42  RESERVE: zone 30 released
  0.42  RESERVE: zone 31 at (13664, 2576) facing 3, 12x18 cells: 200 of 216 held
  0.42  RESERVE: grid of cornanotc 6x4 gap 0 behind (13568, 2576) facing 3: 20 of 24 slots (group 19, zone)
  0.42  RESERVE: zone 31 released
  0.42  RESERVE: zone 32 at (13640, 2576) facing 3, 9x18 cells: 146 of 162 held
  0.42  RESERVE: grid of cornanotc 6x3 gap 0 behind (13568, 2576) facing 3: 14 of 18 slots (group 20, zone)
  0.42  RESERVE: zone 32 released
  0.42  RESERVE: zone 33 at (13616, 2576) facing 3, 6x10 cells: 58 of 60 held
  0.42  RESERVE: grid of cornanotc 3x2 gap 0 behind (13568, 2576) facing 3: 5 of 6 slots (group 21, zone)
  0.42  RESERVE: zone 33 released
  0.43  EXP: approach: corcom(27050) at (14637, 509) walks to (15107, 284), 139 from the cormex site (15232, 224)
  0.44  EXP: approach: armcom(3460) at (707, 1034) walks to (892, 355), 136 from the armmex site (928, 224)
  0.47  EXP: approach: legcom(6297) at (14551, 1429) walks to (14807, 1836), 137 from the legmex site (14880, 1952)
  0.50  RESERVE: armlab at (1968, 688) facing 1 (id 82)
```
