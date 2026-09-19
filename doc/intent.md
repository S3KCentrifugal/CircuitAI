# Design intent

Why this fork exists, what it is aiming at, and the architectural rule that
follows from it. Read this before making a decision about *where* a behaviour
should live.

## Contents

- [Goals](#goals)
- [The architectural rule](#the-architectural-rule)
- [What that means in practice](#what-that-means-in-practice)
- [Playing like a strong player](#playing-like-a-strong-player)
- [Where knowledge lives](#where-knowledge-lives)

## Goals

**Long term: the game drives the AI.** The intended end state is that BAR's
mission and scenario API hands this AI *objectives* — take this position, deny
this expansion, survive until this time, escort this unit — and the AI plans
against them. The AngelScript layer is the surface that will receive those
objectives, because it is the layer that can be edited, shipped and iterated
without rebuilding the engine or the AI binary.

The `strategic_objectives` type family in `data/script/src/types/` and the
objective manager under `data/script/src/manager/` are the first draft of that
surface. They are currently fed by per-map tables; the goal is that they can
equally be fed by the game.

**Short and medium term: play better.** Make the Skirmish AI materially more
proficient, and specifically make it play more like a strong human player
rather than like a rules engine. That means the AI should:

- value things the way a good player does — a metal extractor upgrade over a
  converter, a reactor over a windmill, a jammer over an army it cannot hurt;
- act with the group rather than per unit — bombers that concentrate, waves
  that launch together, defences that answer a push;
- spend a limited resource on the highest-value thing available, and hold it
  when nothing is worth it, rather than always doing *something*.

Most of the defects worth fixing in this repository are failures of one of
those three, not missing features.

## The architectural rule

> **Build orders and behaviour policy stay controllable from AngelScript.**
> C++ is where mechanism lives; AngelScript is where policy lives.

C++ changes are expected and welcome. What is not acceptable is a C++ change
that takes a *policy* decision away from script without putting an equivalent
lever back.

When a behaviour genuinely has to be native — because script has no access to
the data or the commands, which is common (see below) — the native code should
be **driven by configuration that script or JSON owns**, not hardcoded. The
pulse, EMP and bomber policies are the pattern to copy: the selection runs in
C++ because `CCircuitUnit` exposes no movement or attack commands to script and
there is no spatial enemy query, but *what* it prefers, in what order, and
under what gates is a block in `behaviour.json` that can be edited and
redeployed without a rebuild.

## What that means in practice

| Situation | Where it goes |
| --- | --- |
| A build-order decision (what to build next, in what order, gated on what) | AngelScript, in the role or a shared helper |
| A numeric threshold | `Global::RoleSettings::<Role>` in `global.as`, or a JSON block |
| Target selection needing enemy positions, unit commands, or the threat map | C++, with the priorities and gates in a JSON config block |
| A new fact about the game (unit stats, mechanics, counters) | `../rjm.bar.docs/knowledge/`, never duplicated here |
| A diagnosed problem left unfixed | `doc/known-issues.md`, with a proposed solution |

Two consequences worth stating explicitly:

1. **Prefer widening the script API over moving policy into C++.** If a role
   cannot express a decision because the data is not registered in
   `src/circuit/script/`, registering it is usually the better change. A C++
   method is not script-accessible merely because it is public.
2. **A native default is a fallback, not a policy.** Where a manager falls
   through to `Default*`, that is the engine's opinion, and it is frequently
   wrong for this AI's goals — `CBombTask` ranking by lowest health, the
   super-weapon scan ranking by group metal cost. Treat every `Default*`
   fallback as a place a policy is missing.

## Playing like a strong player

The practical test for a change is not "is this reasonable" but "is this what a
strong player would do with the same information". Three recurring gaps:

**Opportunity cost.** The AI evaluates each option against a threshold, not
against the alternatives. A converter passes its gate and gets built while a
metal extractor upgrade — strictly better value — is available and unbuilt,
because nothing compares them. A strong player ranks; the AI filters.

**Finite before infinite.** Metal spots, geo spots and map objectives are
finite and contested; converters, energy and nanos are not. Spend on the finite
thing first. The AI currently has no notion of this ordering.

**Hold rather than act.** A stockpile weapon with no worthwhile target should
wait. A bomber group that cannot kill what it is aiming at should wait for more
bombers. Doing something cheap because nothing expensive qualifies is how the
AI loses value, and it is the failure mode the `Default*` fallbacks encourage.

## Where knowledge lives

- **Game truth** — unit stats, mechanics, economy arithmetic, counters,
  doctrine: `../rjm.bar.docs/knowledge/`. Never copied into this repository.
- **Implementation knowledge** — how this AI works and where it is wrong:
  `doc/`, indexed by `AGENTS.md`'s Repository Map.
- **Open problems** — `doc/known-issues.md`.

## Related

- [`AGENTS.md`](../AGENTS.md) — repository map and working rules.
- [`angelscript-references.md`](angelscript-references.md) — what is registered
  to script, and what is deliberately not.
- [`known-issues.md`](known-issues.md) — the open register.
