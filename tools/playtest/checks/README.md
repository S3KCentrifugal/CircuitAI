# Game acceptance checks

Use `<domain>/<area>/<check>.json`. New names use lowercase kebab-case.
Existing underscore names are retained as stable public IDs. For example,
`--checks air_edge` and `--checks air/combat/air_edge` resolve to the same file.
Custom file paths and legacy repository paths remain supported by the resolver.

Keep assertions independent from supplied fixture inputs. Every check must
forbid runtime invariants; `tools/knowledge/check_invariants.py` recursively
checks every category. Preserve FAIL verdicts when a focused audit passes only
one aspect of a run. A fixture fix must be recorded as a different observation.

See the [full conventions](../../../doc/test-storage.md).
