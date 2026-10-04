# Artillery policy verification — 2026-09-29

The owner requested no T1 artillery construction, T2/LRPC/super affordability,
and a `lol` map drawing after a super cannon starts firing. D-142 records the
mechanism/policy boundary and the alternatives rejected.

Native build succeeded. DLL/script API parity passed (225 member uses).
Final native binary SHA-256 prefix: `bf3bc9a63ddaa440`; matching symbols and
current data are published together in the engine build's install output.
The live game directory was not modified.

## Passing engine checks

- `build-theatres/artillery/no-legion/runs/20260929-195957`: two minutes,
  all seven profiles across 16 AIs with Legion disabled. All 16 probes passed
  for the two definitions present (Legion definitions are absent in this game
  configuration); no script errors or invariants. The fixture was corrected
  to count present definitions instead of requiring a nonexistent Legion def.
- `build-theatres/artillery/profiles/runs/20260929-195550`: two minutes,
  16 AIs cycling easy, medium, hard, hard_aggressive, experimental_balanced,
  experimental_hard, experimental_terrible. All seven scripts compile; all
  16 AI probes report PASS for all three forbidden definitions after raising
  caps to 1000 and attempting direct construction enqueue. All nine allowed
  T2/LRPC/super definitions retain construction permission. No invariant or
  script error. Legion enabled.
- `build-theatres/artillery/fire/runs/20260929-195546`: five minutes, legacy
  hard profile, gifted cannons/energy, explicit native target overrides.
  Ragnarok fired at frame 3937, Calamity at 3944, Starfall at 4102. Each logged
  exactly once; the observer counted 96 actual map-line messages and stayed
  at 96 through subsequent firing. No invariant or script error. Both AI
  construction-veto probes passed. The report's nominal TECH labels come from
  staging positions; the loaded script log identifies the actual hard profile.

The fire fixture's early Starfall placement was in water. Moving all cannons
to dry ground permitted its shot; that was a fixture correction, not an AI
behavior change. The prepared experimental fixture's supplied energy caused
existing economy invariants to fire, so the clean firing isolation uses hard.
An earlier experimental run did exercise both Armada and Cortex callbacks.

API parity, role-document and invariant checks pass. The unit report was
regenerated and labels the three construction bans explicitly. The below
pre-existing unit-reference/document-link findings remain unchanged.

The first enqueue-veto implementation exposed an uninitialized `buildDef`
read when a repair task was requested. The guard was corrected to inspect
only construction task types before REPAIR. The next five-minute two-AI run
completed without script errors. That fixture did not get autonomous firing
targets and is not a passing firing test. One intentionally gifted scout also
triggered the existing low-income-combat invariant; the revised firing fixture
contains no combat scouts and uses explicit native target overrides.

All firing evidence uses gifted cannons and energy. It verifies the engine
shot event and drawing, not natural economy progression or target selection.

Static unit-reference checks retain the existing `armsonar`/`corsonar` findings
tracked in KI-425. Missing hover-document links are tracked in KI-404.
