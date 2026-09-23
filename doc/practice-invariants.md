# The invariant practice

How a fix is made so the same bug does not come back under a new name.
Introduced by
[D-076](decisions.md#d-076--one-lifecycle-state-per-structure-invariants-checked-in-every-game-the-actor-matrix)
after the T1 lab was reclaimed by a constructor and a turret while the factory
rows kept it producing a Lazarus.

## Why

From D-063 to D-075 every decision added a rule inside one actor. None asked
which other actors act on the same object, and none left a check behind. The
same class of bug returned under different names: the commander re-asked off
its lab, turret frames abandoned by the chain, the T1 lab reclaimed at full
storage, the light-laser loop, production during reclaim. Each was fixed where
it was seen, not where it was caused, and each was verified by reading one log
once.

## The four rules

1. **One lifecycle state per structure, read by every actor.** A structure is
   framed, active, retiring or gone. The act that decides the end of a
   structure records it once in `Lifecycle` (`data/script/src/manager/lifecycle.as`)
   and every other actor reads it there: production stops, guards and assists
   end, layout releases what it held, only reclaim may target it. No actor
   keeps a private idea of an object's state.
2. **Every bug becomes an invariant with a check.** A fix ships three things
   beside the code: the invariant written in the decision (an `**Invariant.**`
   paragraph), a `[INVARIANT] INV-nnn` log line from `Invariants`
   (`data/script/src/manager/invariants.as`) when it is broken, and the line
   forbidden in every playtest check file. The benchmark loop is then the
   regression suite. The register is [`invariants.md`](invariants.md).
3. **An actor matrix per object.** [`actor-matrix.md`](actor-matrix.md) lists,
   for each object kind, every act that reads or orders on it and which state
   it reads. A change to how an object is handled updates the matrix; every
   rule row of the TECH table must appear in it.
4. **Play the fix, not the log.** A fix is Built until a game has been watched
   for the specific sequence; the run that played it is named in the decision
   and its check file carries the forbid pattern.

## What is enforced

`tools/knowledge/check_invariants.py`, run by the pre-commit hook whenever a
script, a check file, `doc/invariants.md`, `doc/actor-matrix.md`,
`doc/decisions.md` or a role document is staged:

- every `INV-nnn` a script can log has a row in `invariants.md`, and every row
  is logged by a script;
- every `tools/playtest/checks/*.json` forbids `[INVARIANT]`;
- every `Rule("key", ...)` in `tech_rules.as` appears in `actor-matrix.md`;
- every decision from D-076 on has an `**Invariant` paragraph.

`python tools/knowledge/check_invariants.py` runs it by hand; exit 0 is clean.

## Adding an invariant

1. State it in one sentence in the decision's `**Invariant.**` paragraph.
2. Add the check to `Invariants` (a `Violation("INV-nnn", subject, message)`
   call from `Tick`, or from the hook where the event is observable), one line
   a minute per subject.
3. Add the row to `invariants.md`: id, statement, where it is checked, the
   decision.
4. Run the check files (they already forbid the line) and play a game: the
   decision names the run.

## Reading a violation

A playtest that prints `forbid 'invariant' hit at N min: [INVARIANT] INV-nnn
...` has broken a promise. The message names the subject (unit, step, bank);
the register row says which actors are involved; the actor matrix says who
else touches that object. Fix the cause in the owner of the state, not in the
actor that saw the symptom.
