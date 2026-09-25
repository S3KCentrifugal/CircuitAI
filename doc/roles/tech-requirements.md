# TECH role: the owner's requirements

The register of every requirement the owner has stated for the TECH role,
in the owner's terms, each with the decision that implements it and the
invariant that checks it in play. How the layout and the build sequence work today, in one page:
[`tech-layout-and-sequence.md`](tech-layout-and-sequence.md). The decisions carry the evidence
([`decisions.md`](../decisions.md)); the invariants are listed in
[`invariants.md`](../invariants.md). The game mechanics and theory behind
them live in the shared knowledge base,
`../rjm.bar.docs/knowledge/70-strategy/77-eco-tech-player.md`.

Keep this file current: a new requirement is added here when it is given,
with its decision and invariant once built; a requirement the owner changes
is edited in place with the decision that changed it.

## Working rules

| Requirement | Where |
| --- | --- |
| Never write under the BAR install; change and build only. The owner deploys the build output (DLL, `.dbg` and `script/` together). | memory, `AGENTS.md` |
| `bar-Beyond-All-Reason` and `bar-RecoilEngine` are read-only (the docker build output excepted). | `AGENTS.md` |
| No commit unless asked for that change. | memory |
| Only the TECH role's behaviour changes; other roles' placement is untouched (the layout is TECH's only). | D-093 |
| Every behaviour fix ships an invariant, an `[INVARIANT]` log line, an actor-matrix row and a played run. | D-076, [`practice-invariants.md`](../practice-invariants.md) |
| Tests at zero bonus, Legion enabled, on Supreme Isthmus. | [`benchmarks/tech-rush.md`](../benchmarks/tech-rush.md) |
| Documentation and decision traceability; the docs here and in the docs repo are kept current as the understanding of the game, the roles and the theory evolves, and as benchmarks are beaten. | this file |

## Layout (the TECH base)

| # | Requirement | Decision | Invariant |
| --- | --- | --- | --- |
| L1 | Construction turrets start at the centre of the planned layout and grow outward, connected to the turrets already there. | D-077, D-081 | INV-012 |
| L2 | A turret cluster is a block of 4 rows (3 is acceptable), not one row at a time; a flat-area check around the base; at least one cluster planned forward in clear space, repositioned if an ally takes it. | D-081, D-082 | INV-012, INV-013 |
| L3 | Buildings go in range of the construction turrets first, then where turrets are planned. | D-083 | INV-014 |
| L4 | The first turrets stand near the starting mexes, centred or slightly offset, not against a mountain. | D-083, D-086 | - |
| L5 | The advanced lab stands in range of the turrets, flush like the T1 lab with its nanos. | D-085, D-086, D-088, D-095 | INV-016, INV-017 |
| L6 | Same-type structures grow as a filled rectangle, not an L; the base does not sprawl early (walking is slow). | D-088 | - |
| L7 | A lab faces the front (the nearest enemy; from the north-east start of Supreme Isthmus that is south), stands on the correct side of the turret block, and its exit is never blocked. | D-096, D-098 | INV-018 |
| L8 | The box does not grow: buildings go on the free ground within the turrets' reach, then to the next closest turret cluster. | D-099 | INV-020 |
| L9 | Advanced fusions stand flush against the turrets, in sets of up to 3 lined up away from them; a new set starts flush again. Advanced converters the same, up to 5 a set. | D-101 | INV-022 |
| L10 | The ground of structures TECH reclaims is recycled by the layout. | D-101 | INV-024 |
| L11 | With no construction turret of ours on the map (the start, or a restart after a wipe) a T1 lab may go anywhere; otherwise it follows the layout. | D-101 | INV-023 |
| L13 | A spam cluster layout type: one or more T1 bot labs, each with two construction turrets directly behind it; the two turrets nearest a lab are always focused on that lab. Forward construction turret clusters are small and never block lanes. | D-109 | INV-038 |
| L14 | From +200 metal land factories move toward the front: each new one at least 20% closer to the front (further as needed), in a front factory cluster: the lab with construction turrets directly behind it (T1: 2, T2: 2 x 2, T3: 3 x 2), the turrets built first. Clusters go on flat ground where the factory fits, away from allied buildings when possible. | D-114 | INV-038, INV-045 |
| L16 | A front cluster keeps its shape: a lost turret is rebuilt while its factory stands; a lost factory is rebuilt at its cluster. After the base's advanced lab is rezoned, the advanced lab comes back (at the front) before any new T1 lab (D-102's order). | D-114 | INV-038, INV-025, INV-046 |
| L15 | With 3 land factories of any tier on the map, the land factories at the main base's turret cluster are reclaimed and not rebuilt; their ground becomes economic ground. With no land factory on the map, one may go at the main base again. | D-114 | INV-044 |
| L12 | Every factory type, T1 and T2 air included, stands tight to the construction turrets; air factories may face any way (their units fly). | D-104 | INV-029 |

## Build sequence and economy

| # | Requirement | Decision | Invariant |
| --- | --- | --- | --- |
| S1 | Metal income above spending means build power is short: with nothing starting, the next priority building; with a building under construction and metal still high, a construction turret. | D-075 | INV-004 |
| S2 | Once energy income suffices, windmills, solars and advanced solars are reclaimed; all of them by the time an advanced fusion is built. Only a finished reactor counts. | D-077, D-101 | INV-006, INV-024 |
| S3 | The advanced lab is reclaimed while an advanced fusion is under construction, if the bank has room; every construction turret in range joins any reclaim at once. | D-078 | INV-007, INV-008 |
| S4 | The AI chases metal; energy is kept sufficient, not in large surplus (no advanced fusion started on a big energy surplus). | D-079 | INV-009 |
| S5 | TECH ends the game: no combat under +200 metal (+500 for a T3 rush); the endgame plans (nuke first, T2 assault then T3, T3 rush, LRPC on safe high ground); T2 air constructors from +200. | D-080 | INV-010, INV-011 |
| S6 | Turrets are built one at a time early; in parallel only when the metal and the nearby build power pay for it. | D-097 | INV-019 |
| S7 | No turret and lab at once early; with metal high the build power goes on what is building. | D-098 | INV-019 |
| S8 | The mexes near the base are upgraded before the fusion (the advanced fusion comes sooner). | D-100 | INV-021 |
| S9 | The T1 lab is not rebuilt with 3 or more T1 constructors under +200 metal; the advanced lab goes back up before a T1 lab; T1 labs make constructors at the start and spam from +200. | D-102 | INV-025 |
| S10 | Labs are reclaimed for their metal only before the economy is online; from +200 metal there is no economic reason to reclaim a factory (later only if it is blocked or its ground is rezoned). | D-102, D-105 | INV-026 |
| S11 | T2 constructors are produced whenever the metal bank is over 50%, to a cap of 60. | D-103 | INV-028 |
| S12 | The air labs are built (a T1 air plant and its air constructor first: only air constructors build the advanced aircraft plant). | D-103 | INV-027 |
| S13 | T2 constructors reclaim only as a last resort, when no other build power is in range of the target; otherwise they keep to their build orders. | D-105 | (enforced at the three reclaim acts) |
| S14 | Before reclaiming the advanced lab, a metal projection: bank + income x the advanced fusion's remaining build time; if it covers 85% of the advanced fusion's cost, the lab is kept. | D-105 | INV-031 |
| S15 | T1 constructors add build power before assisting T2 constructions; reclaiming stays the higher priority. | D-105 | (rule order: `power.t1` after the reclaim rows) |
| S17 | Whenever TECH's metal store is over 95%, refresh the team economy and give up to 20% of TECH's metal capacity to the lowest-filled teammate(s), filling their storage: a fallback so no metal is lost to overflow when TECH's build power cannot keep up. | D-106 | INV-033 |
| S18 | The first two T2 air constructors are dedicated: one always builds advanced energy converters, the other always advanced fusions. The other air constructors build converters while energy overflows and assist the advanced fusion the moment converters cannot stay on; every construction turret in range does the same after reclaim. | D-107 | INV-034 |
| S19 | The dedicated advanced-fusion air constructor has one duty and is never interrupted by any other process; the converter one likewise; if either is destroyed it is replaced and both roles stay filled. Advanced fusions keep going up past six. | D-108 | INV-034 to INV-037 |
| S20 | Once the T2 air constructors are up, every T2 land constructor leaves the base to build defences around the mex clusters, long-range AA and flak first. | D-109 | INV-039 |
| S21 | While more than 5 T1 air constructors are up, every T1 land constructor goes forward to build defences and T1 spam bot labs; idle ones build small construction turret clusters near the front to assist, not on a lane. | D-109 | INV-039 |
| S22 | One T1 spam bot lab per +100 metal, started only once the T1 land constructors are free to leave the base (the air constructors do the base building and assisting). | D-109 | INV-038 |
| S23 | If the air constructors of a tier go down, that tier's land constructors return first to an eco cluster that needs them. | D-109 | INV-040 |
| S16 | The metal is spent: a full bank is a waste (no converters then; production and build power are the sinks: T2 constructors, spam labs scaling with income, turrets assisting factories). | D-105 | INV-032, INV-011 |

## Tools the owner asked for

| Requirement | Where |
| --- | --- |
| The BARb widget: covers no other UI element, a better experience, an icon on every button; it must receive the AIs' messages. | D-113: `tools/widgets/gui_barb_team_link.lua` |
| CI builds the AI with the Recoil docker harness and publishes `SMRTBARb-v<version>.zip` as a GitHub release; the minor version rises with every commit. Every test or prod release carries both a Windows build (`-windows.zip`) and a Linux build (`-linux.tar.gz`). | [`../release.md`](../release.md) |
| Every teammate's economy (players included, all fields, free storage) readable from script, refreshed for one teammate or all before a decision. | D-106: `TeamEconomy` (`manager/team_economy.as`), native `CEconomyManager` |
| A playtest shot can centre the camera on a map position. | D-103: `--shots minute@height@x:z` |

## Transport

| # | Requirement | Decision | Invariant |
| --- | --- | --- | --- |
| T1 | The ferry makes sure the unit is picked up (retrying), and never drops it in water or on a building. | D-091 | - |
| T3 | The T2 constructors built for teammates perform no action and take no order from birth until their drop-off, so the transport cannot pick up the wrong unit; a constructor at base is never handed over as delivered. | D-112 | INV-041 |
| T2 | The transport picks up the T2 constructor reliably; from the moment the transport is sent until the drop-off succeeds, neither the transport nor the constructor takes any other order. | D-110 | INV-041, INV-042 |

## Open

Items stated but not yet met, with where they stand:

- The advanced fusion's time in the benchmark varies with a stranded fusion order (the fusion order waits with no builder while T2 builders upgrade mexes); D-101 reports it, the owner's decision is pending.
- INV-028 still fires in some games: T2 constructor production stalls with the bank over half (D-103).
- Late sets of advanced fusions and converters start away from the turrets once the flush ground is used (INV-022, D-101).
