# SMRTBARb releases

SMRTBARb is this fork's alias of BARb (upstream `rlcevg/CircuitAI`, branch
`barbarian`). The name exists only in packaging: the code, the CMake target and
the build folder stay `BARb`, so upstream merges keep working.

## What a release is

`SMRTBARb-v<version>.zip`, unzipped into
`<BAR>/data/engine/<engine version>/AI/Skirmish/`, creates:

| Path | From |
| --- | --- |
| `SMRTBARb/stable/AIInfo.lua` | [`packaging/SMRTBARb/AIInfo.lua`](../packaging/SMRTBARb/AIInfo.lua): upstream's with `shortName` and `name` set to `SMRTBARb` |
| `SMRTBARb/stable/AIOptions.lua` | [`data/AIOptions.lua`](../data/AIOptions.lua) (identical to the deployed SMRTBARb's) |
| `SMRTBARb/stable/SkirmishAI.dll` | the `BARb` target of this commit, debug info split off |
| `SMRTBARb/stable/config/`, `script/` | [`data/config`](../data/config), [`data/script`](../data/script) |
| `SMRTBARb/stable/SMRTBARb_VERSION.txt` | version, commit, engine commit |

`SMRTBARb-v<version>-dbg.zip` holds `SkirmishAI.dbg` of the same build: keep it
to read a crash stack trace from that release.

## Version

`MAJOR.MINOR` from [`tools/release/version.sh`](../tools/release/version.sh):

- **MAJOR** is the number in [`SMRTBARb_VERSION`](../SMRTBARb_VERSION); raise it by
  hand for a breaking release.
- **MINOR** is the commit count of the branch (`git rev-list --count HEAD`), so every
  commit is a new minor version without anything committed back.

The AI's own `version` in AIInfo stays `stable`: it names the install folder.

## The pipeline

[`.github/workflows/smrtbarb-release.yml`](../.github/workflows/smrtbarb-release.yml):

1. checks out this repository (full history, for the version) and
   `beyond-all-reason/RecoilEngine` at the commit in
   [`.github/recoil-engine.ref`](../.github/recoil-engine.ref) (the one built
   against locally), with every submodule except `AI/Skirmish/BARb`;
2. runs the engine's docker harness (`docker-build-v2/build.sh`) with this
   repository mounted read-only as `AI/Skirmish/BARb`, exactly as the local build
   does: configure, then compile **only the `BARb` target** (no engine binaries);
3. splits the debug info as the harness does for the engine (`objcopy
   --only-keep-debug`, `strip`, debuglink) inside the same build image;
4. packages with [`tools/release/package.sh`](../tools/release/package.sh) and
   uploads both zips as a workflow artifact;
5. on a push to `master` or `smrt`, or a manual run with *release* ticked, publishes
   the GitHub release `v<version>` with both zips.

Pull requests build and upload the artifact only.

To move to a newer engine, change `.github/recoil-engine.ref` (and rebuild locally
against the same commit).

## Locally

```bash
tools/release/version.sh                  # 1.952
tools/release/package.sh \
  /c/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable/SkirmishAI.dll \
  dist \
  /c/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable/SkirmishAI.dbg
```
