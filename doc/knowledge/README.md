# CircuitAI knowledge (AI-specific)

Game knowledge - units, mechanics, economy, counters, tactics, strategy,
theory - lives in the shared docs repository, a sibling of this checkout:

- Path: `C:\bardev\rjm.bar.docs` (relative: `../rjm.bar.docs`)
- Entry point: `../rjm.bar.docs/knowledge/README.md`
- Unit pages: `../rjm.bar.docs/knowledge/30-units/<faction>/<id>.md`

Search there first for any question about the game or engine; read the BAR or
Recoil trees only when the knowledge base lacks the fact, and then add the
fact there.

This folder holds only what is specific to CircuitAI/BARb:

| File | Content |
| --- | --- |
| [90-agent-decision-guides/](90-agent-decision-guides/) | decision architecture, build-order selection, response tables, engagement rules, economy policies, open questions - all tied to BARb hooks |
| [barb-unit-config.md](barb-unit-config.md) | generated: every reachable unit's BARb roles, attributes, limits, threat, factory lists and script references across all profiles, plus the configuration gap lists |
| [barb-status-by-topic.md](barb-status-by-topic.md) | where BARb stands against each game-knowledge topic (sections lifted from the game docs when they moved) |

Related AI documents elsewhere in this repository: [`../roles/tech.md`](../roles/tech.md),
[`../roles/hover.md`](../roles/hover.md), [`../bomber-targeting.md`](../bomber-targeting.md),
[`../t2-constructor-stall.md`](../t2-constructor-stall.md),
[`../angelscript-references.md`](../angelscript-references.md).

Regenerate `barb-unit-config.md` after the shared cache or the configs change:

```text
python ../rjm.bar.docs/tools/knowledge/extract.py   # if the game cache is stale
python tools/knowledge/barb_report.py
```
