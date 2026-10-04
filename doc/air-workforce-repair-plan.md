# AIR workforce and first advanced factory repair

The reported failures concern experimental AIR. Keep TECH's rules, native
task behavior, shared placement reservations and metal-map opening separate.

## Diagnosis and intended changes

1. T1 aircraft still receive renewable factory guards without checking active
   production. Native builder Wait and task abort do not necessarily clear the
   engine order. Extend AIR's existing advanced-constructor return policy to
   both aircraft tiers, clear the old guard once on ownership transfer, and
   assist concrete unfinished structures instead of guarding mobile builders.
2. The first income-qualified T2 lab is below shared reactor growth and its
   assists in the rule table. Move first-lab admission above discretionary
   growth and overflow support, after recovery and mex upgrades. Keep the
   sustained 50 metal / 1200 energy gate or full lab bank, and twenty completed
   support turrets before additional T2 labs. Do not require two AFUS.
3. Bank-driven constructor targets already exist, but repeated fighter-floor
   replacement and interception can starve the recruitment decision. After
   the initial screen, give funded missing economy workers priority in quiet
   skies; during an incursion allow an economy worker after a configurable
   number of combat orders. Retain transport precedence and the initial
   scout/three-constructors/fighter sequence. This is production allocation,
   not a command rate limit.
4. A sub-threshold economy can spend all income on T1 production forever.
   Add a first-lab capital budget after the existing preparation deadline and
   energy readiness (the existing 450 energy access floor). Preserve recovery, mex upgrades, transports and immediate
   defense, while deferring discretionary strikes and surplus construction
   until the loaded lab cost is banked. The lab still passes the original gate.
5. Add bounded transition/workforce telemetry, pure decision tests and an
   independent engine observer for idle mobile assistance. Verify donations
   with actual transfers from an allied team in an isolated fixture.

## Verification

Compile all experimental profiles; run AIR and shared production math tests.
Repeat natural Glacial games at explicitly recorded starts and another normal
map. Use pinned data snapshots because map registration is being edited in
the shared workspace. Run a controlled donation/workforce case, record actual
constructor and lab completion, economy progression and command counts, and
inspect screenshots. Distinguish supplied-case evidence from natural timing.

Invariants: mobile AIR constructors do not retain factory/constructor guards;
an eligible first lab is considered before shared reactor growth; funded
workforce recruitment cannot be indefinitely displaced by combat production.
No tests claim PvP optimality or universal timing from one seeded match.

## Game basis

BAR's [economy guide](https://www.beyondallreason.info/guide/in-depth-look-at-economy)
treats build power as a separate spending constraint. Its
[construction aircraft reference](https://www.beyondallreason.info/unit/corca)
recommends multiple aircraft because each has little build power and identifies
the T2 aircraft plant as a T1 constructor build option. The local
`../rjm.bar.docs/knowledge/50-economy/51-build-power.md` and loaded game definitions
agree: mobile workers initiate distant economy while turrets supply cheap local
assistance. These mechanics support protecting workforce recruitment; they do
not establish an optimal universal constructor count or a guaranteed tech time.
