# SMRTBARb releases

SMRTBARb is this fork's alias of BARb (upstream `rlcevg/CircuitAI`, branch
`barbarian`). The name exists only in packaging: the code, the CMake target and
the build folder stay `BARb`, so upstream merges keep working.

## Channels

| Branch | Release | Tag / file | GitHub |
| --- | --- | --- | --- |
| `smrt-test` | test build, for trying out | `v<version>-test` / `SMRTBARb-v<version>-test-<platform>.<zip or tar.gz>` | pre-release |
| `smrt-prod` | production build | `v<version>-prod` / `SMRTBARb-v<version>-prod-<platform>.<zip or tar.gz>` | Latest |

Every release carries both platforms: Windows as a `.zip`, Linux as a `.tar.gz`
(the usual Linux archive; it keeps file modes), each with a `-dbg` archive of
its debug symbols. A release is published only when both builds succeeded.

Other branches and pull requests build and upload a workflow artifact
(`-dev`) but publish nothing. Changes land on `smrt-test` first and reach
`smrt-prod` by a pull request.

Download: the repository's **Releases** page (a test release carries the
*Pre-release* badge, the newest prod release is *Latest*), or
`gh release download <tag> -R S3KCentrifugal/CircuitAI -p "SMRTBARb-*"` (or
`-p "*-windows.zip"`, `-p "*-linux.tar.gz"` for one platform).

## Release notes

Written by [`tools/release/notes.py`](../tools/release/notes.py) from the commits
since the channel's previous release, one line per commit subject, grouped:
`feat` under **New**, `fix` under **Fixes**, `perf` under **Improvements**, the
rest (ci, chore, docs, refactor) folded under *Maintenance*; the scope and a
decision id stay as a short tag, e.g. "Gift constructors frozen from birth to
drop-off (ferry, D-112)". So a commit subject is written for the player:
`type(scope): what changed, in plain words`.

## What a release is

`SMRTBARb-v<version>-<channel>-windows.zip` or
`SMRTBARb-v<version>-<channel>-linux.tar.gz` (`tar -xzf`), unpacked into
`<BAR>/data/engine/<engine version>/AI/Skirmish/`, creates:

| Path | From |
| --- | --- |
| `SMRTBARb/stable/AIInfo.lua` | [`packaging/SMRTBARb/AIInfo.lua`](../packaging/SMRTBARb/AIInfo.lua): upstream's with `shortName` and `name` set to `SMRTBARb` |
| `SMRTBARb/stable/AIOptions.lua` | [`data/AIOptions.lua`](../data/AIOptions.lua) (identical to the deployed SMRTBARb's) |
| `SMRTBARb/stable/SkirmishAI.dll` (Windows) or `libSkirmishAI.so` (Linux) | the `BARb` target of this commit, debug info split off |
| `SMRTBARb/stable/config/`, `script/` | [`data/config`](../data/config), [`data/script`](../data/script) |
| `SMRTBARb/stable/SMRTBARb_VERSION.txt` | version, platform, commit, engine commit |

`SMRTBARb-v<version>-<channel>-windows-dbg.zip` (`SkirmishAI.dbg`) and
`...-linux-dbg.tar.gz` (`libSkirmishAI.dbg`) hold the debug symbols of the same
build: keep them to read a crash stack trace from that release.

## Version

`MAJOR.MINOR` from [`tools/release/version.sh`](../tools/release/version.sh):

- **MAJOR** is the number in [`SMRTBARb_VERSION`](../SMRTBARb_VERSION); raise it by
  hand for a breaking release.
- **MINOR** is the commit count of the branch (`git rev-list --count HEAD`), so every
  commit is a new minor version without anything committed back.

The AI's own `version` in AIInfo stays `stable`: it names the install folder.

## The pipeline

[`.github/workflows/smrtbarb-release.yml`](../.github/workflows/smrtbarb-release.yml):

Two build jobs run side by side, `build (windows)` (`amd64-windows`) and
`build (linux)` (`amd64-linux`), each on its own runner with its own compiler
cache; then one `release` job. Each build job:

1. checks out this repository (full history, for the version) and
   `beyond-all-reason/RecoilEngine` at the commit in
   [`.github/recoil-engine.ref`](../.github/recoil-engine.ref) (the one built
   against locally), with every submodule except `AI/Skirmish/BARb`;
2. runs the engine's docker harness (`docker-build-v2/build.sh`) with this
   repository mounted read-only as `AI/Skirmish/BARb`, exactly as the local build
   does: configure for its OS, then compile **only the `BARb` target** (no engine
   binaries);
3. splits the debug info as the harness does for the engine (`objcopy
   --only-keep-debug`, `strip`, debuglink) inside the same build image (the
   harness itself does this for Windows only);
4. packages with [`tools/release/package.sh`](../tools/release/package.sh) (the
   platform follows the library: `SkirmishAI.dll` or `libSkirmishAI.so`) and
   uploads the archive and its `-dbg` archive as a workflow artifact
   (`SMRTBARb-v<version>-<channel>-<os>`).

The `release` job runs on a push to `smrt-test` or `smrt-prod`, or a manual run
there with *release* ticked, and only when both build jobs succeeded. It
downloads both artifacts, refuses to publish unless all four archives are there,
and publishes the GitHub release `v<version>-<channel>` with them and the
generated notes.

Pull requests build and upload the artifacts only.

To move to a newer engine, change `.github/recoil-engine.ref` (and rebuild locally
against the same commit).

## Locally

```bash
tools/release/version.sh                  # 1.952
tools/release/package.sh \
  /c/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable/SkirmishAI.dll \
  dist \
  /c/bardev/bar-RecoilEngine/build-amd64-windows/install/AI/Skirmish/BARb/stable/SkirmishAI.dbg
# -> dist/SMRTBARb-v1.952-windows.zip, dist/SMRTBARb-v1.952-windows-dbg.zip
# a Linux build's libSkirmishAI.so gives dist/SMRTBARb-v1.952-linux.tar.gz
```
