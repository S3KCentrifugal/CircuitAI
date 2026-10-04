# Game cases

Use `<domain>/<area>/<scenario>.json`, with short lowercase kebab-case scenario
names. AIR's supplied combat scenarios live in [air/combat](air/combat/edge-glitters.json).
Each JSON describes fixture inputs; its `checks` field selects the independent
acceptance checks. Never encode a previous result as a fixture expectation.

`air_arena.py list` discovers cases recursively. Both `--case edge-glitters`
and `--case air/combat/edge-glitters` work. Old explicit paths are resolved
through `../storage-aliases.json`. Duplicate short names require a category.
Custom JSON paths remain supported. Keep reusable script fixtures in `fixtures/`
and observers in `widgets/`; keep generated map/faction variants in the allocated
game directory rather than adding ad hoc files to the repository root.

See the [full conventions](../../../doc/test-storage.md).
