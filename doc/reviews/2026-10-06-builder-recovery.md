# Constructor recovery (D-218)

All six experimental roles now request a T1 construction bot from TECH when
their last finished mobile constructor is lost. A surviving commander does not
suppress recovery. The normal commander-only opening is exempt; losing the
commander before producing any constructor starts recovery after a 60-second
opening grace period.

## Production and delivery

The [controller](../../data/script/src/manager/builder_recovery.as) selects one
TECH donor, then retains it throughout production and delivery. Requests retry
every 20 seconds; each donor holds one obligation per recipient. Missing labs
do not discard requests. TECH's T1 bot lab produces the replacement ahead of
ordinary production and repeat spam when it is next available. Retiring labs
remain retiring; TECH's lab reclaim/rebuild sequence is unchanged.

The actual lab's build menu selects the constructor, including captured labs
of another faction. Production temporarily opens one constructor cap slot and
restores the old cap only if another policy has not replaced it. The factory's
matching finished product is reserved as cargo before TECH can claim it as a
primary constructor. Giving happens after the unit-added callback has returned,
so native idle/task registration finishes first.

If TECH already owns a ferry, the existing ferry queue delivers the bot. The
recovery landing search uses the first mex, otherwise the start, and searches
up to 2,400 elmos for safe dry ground. A caller-selected anchor survives a busy
ferry's queue; ordinary T2 deliveries retain their existing landing policy.
Without an available ferry or usable landing, TECH gives the bot directly.
This does not order a new transport solely for recovery. Direct transfer proves
ownership recovery; it does not prove that a land bot can walk to an island.

Independent constructor production cancels the request. Delayed heartbeats from
cancelled episodes cannot recreate it. A TECH that itself needs rescue refuses
donor selection temporarily, allowing another TECH to help. A destroyed factory
releases its failed order without losing the requesting team.

## Lua messaging

The optional [host relay](../../tools/widgets/gui_barb_builder_recovery.lua)
uses `ai.CallUI` -> `RecvSkirmishAIMessage` -> `Spring.SendSkirmishAIMessage` ->
`Main::AiLuaMessage`. It verifies the engine-supplied sender and allied target.
It forwards on the next GameFrame to avoid re-entering an active AngelScript
context. Install it in the host's `LuaUI/Widgets` alongside the existing team
link widget. This task does not modify the live BAR installation.

When the relay is absent, messages use the existing `AiSendMessage` channel.
This fallback is native AI-to-AI messaging, **not Lua**. Both paths are local to
the AI host; separately hosted AIs and human teams are not request recipients.
Logs explicitly identify `channel=lua` or `channel=native`.

## Performance and scope

Constructor add/remove callbacks maintain IDs, with O(1) population queries.
There is no periodic scan of the team's army. The once-per-second request loop
is bounded by allied team count; its duplicate audit is O(R²) for R requests,
not O(U²) for U units. Donor election scans the small allied roster only on a
20-second retry. Landing search occurs once when assigning a finished gift;
native recruit/ferry tasks retain movement ownership. No native C++ policy or
legacy difficulty profile is changed.

Policy settings are in `Global::BuilderRecovery`: enabled, commander counting,
opening grace, retry interval, request lease and landing-search radius.

## Validation method

[Runner](../../tools/playtest/run_builder_recovery.py),
[fixture](../../tools/playtest/widgets/builder_recovery.lua), and
[checks](../../tools/playtest/checks/shared/economy/builder-recovery.json).
The rendered 8v8 Glacial fixtures supply constructors and donor energy, remove
the six recipients' constructors at 30 seconds, and supply TECH's lab at 90
seconds. The requester roles are explicitly switched after map initialization,
and actual role-switch logs are inspected. One healthy ally is a negative
control. A variant replaces a destroyed lab at 150 seconds. Another lets
SUPPORT independently recover at 80 seconds and checks cancellation.

These are isolated recovery tests, not economy or combat benchmarks. Unrelated
builder/factory decisions and role economic updates are frozen only in staged
fixture scripts. The two unrelated TECH layout deadlines are moved beyond the
test horizon because those actors are deliberately frozen. INV-159 and other
runtime violations remain forbidden. No fixture requests a constructor or
commands the recovery factory's production or ferry transport.

The first compilation attempt exposed a roster return-type error and was fixed.
Failed fixture evidence is retained: an unrelated frozen-base deadline, unstable
donor election, and an insufficient coastal landing radius. These failures were
not rewritten as passes.

## Verified results

All three final rendered 8v8 Glacial fixtures passed without script errors or
invariant violations. There were **17 actual T1 constructor transfers**, across
all six requesting roles and all three bot-factory factions. No healthy-team
request or duplicate gift was observed.

| Profile / delivery | Result | Last gift | Evidence |
| --- | --- | --- | --- |
| experimental_terrible / Armada, Lua + ferry | 5 flown gifts; SUPPORT self-recovery cancels | 4:37 | [record](../benchmarks/records/shared/economy/recovery-ferry-lua/2026-10-06/20261006T134230Z-be7e1fb3/README.md) |
| experimental_hard / Cortex, native + direct | 6 gifts; destroyed lab replaced at 2:30 | 5:02 | [record](../benchmarks/records/shared/economy/recovery-walk-native/2026-10-06/20261006T134649Z-eea9988f/README.md) |
| experimental_balanced / Legion, Lua + direct | 6 gifts from captured Legion lab | 3:46 | [record](../benchmarks/records/shared/economy/recovery-walk-lua/2026-10-06/20261006T134950Z-fad54bf4/README.md) |


The table reports game time, not elapsed test wall time. Donor labs were supplied
at 1:30; the destroyed-lab variant lost its first lab at 1:36. Actual switched
roles SUPPORT, TACTICAL and TECH were logged; FRONT, AIR and SEA were already
selected on their matching map spots. The first failed fixture attempted role
switching before setup and is not evidence for six distinct roles.

The full native regression script passed, including six new recovery policy
tests. Script/DLL API parity (310 members), invariant practice, role-doc markers
and test-index checks passed. Documentation link validation reports the same
eight existing links to missing `roles/hover.md` (KI-404); no new broken link
was introduced. The unit-helper audit still reports 170 pre-existing findings
(KI-473/KI-481); this change reuses the existing constructor lists. This is
behavioral evidence, not a measured FPS comparison.

Previous failed observations are retained:

- [premature role switch and frozen-base deadline](../benchmarks/records/shared/economy/recovery-walk-lua/2026-10-06/20261006T133100Z-f1a7ba8e/README.md).
- [donor re-election cancelled active orders; frozen-base deadlines](../benchmarks/records/shared/economy/recovery-ferry-native/2026-10-06/20261006T133654Z-2a8280db/README.md).
- [no dry landing within the original ferry radius](../benchmarks/records/shared/economy/recovery-ferry-lua/2026-10-06/20261006T134052Z-f79cbca8/README.md).

## Remaining limits

Save/load during an active request or flight and network-host migration are not
verified. The generic native `GiveUnits` mechanism detaches a unit before asking
the engine to transfer it; games disabling unit sharing cannot be claimed to
recover through gifts. This pre-existing mechanism is tracked separately.
Natural rebuilding of a fully wiped-out sea base from a donated land bot is not
established by the supplied tests.


## Development output

Published the matched DLL/debug pair plus all 334 current data files to
`C:/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable`.
The optional relay is bundled under `host-widgets/` with installation notes.
Every data file was hash-compared and script/DLL API parity passed there. The
live BAR install was not modified. Eight duplicate playtest symbol files were
losslessly compressed with matching before/after hashes, saving 2.26 GiB without
removing logs, replays or benchmark evidence.
