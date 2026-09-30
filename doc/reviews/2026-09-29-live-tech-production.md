# Live Glacial Gap TECH production investigation

The owner's observation is supported by the log. It contains two distinct
problems: the live installation does not contain the new flank feature, and
ordinary TECH combat infrastructure progresses too slowly despite high income.
The earlier successful isolated games do not establish that this installation
or full-team production is fixed.

## Evidence from the owner's game

The preserved log is
`build-theatres/tech-production-investigation/user-infolog.txt` (about 3.1 MB),
with the lobby script beside it. It is Glacial Gap v1.1, experimental_balanced,
16 AIs, with Cortex TECH on teams 0 and 15. Team 15 is the high-income instance.

| Game time | Team 15 event |
| --- | --- |
| 9.93 min, frame 17865 | Spam activates at +67 metal and +1817 energy, zero routes |
| 10.93 min, frame 19666 | Ordinary T2 lab begins retirement for an advanced fusion |
| 17.18 min, frame 30916 | Economy-online latch reaches +205 metal |
| 19.65 min, frame 35368 | First forward T1 cluster planned; first turret ordered |
| 22.73 min, frame 40906 | INV-039: forward production has made no new order for 180 seconds |
| 25.46 min, frame 45832 | Advanced aircraft plant requests T2 air constructor 60 of 60 |
| 28.73 min, frame 51706 | INV-039 still reports forward-production inactivity |
| 29.41 min, frame 52944 | T2 bot lab requests constructor 5 of 10 while bank is almost full |
| 29.46 min, frame 53032 | First spam lab finally ordered, at +876 metal |

The AI was running, and factories were making constructors. This is not an
AngelScript startup failure. Spam activation is a demand flag; it does not mean
a spam factory has been built. The cluster-first policy, ordinary-T2 prerequisite,
builder allocation and constructor-first production all gate the actual
combat stream. INV-047 also reports a structure occupying a T3 corridor.
The logs do not justify claiming that updating the installation alone fixes
ordinary T1/T2/T3 production. This is tracked as KI-430.

## Deployment mismatch

Loaded scripts explicitly come from the installed `SMRTBARb/stable` directory.
That tree has no `script/src/roles/tech_flank.as`. Its TECH, factory and rule
files differ from the tested workspace. Three installed directories advertise
the same SMRTBARb/stable identity; the engine warns about the conflict and
selects SMRTBARbzzz's AIInfo.lua. The exact native DLL selected is ambiguous;
none of the three installed hashes matches the tested build:

| Directory | DLL SHA-256 prefix | Flank script |
| --- | --- | --- |
| SMRTBARb | 95da090944812c97 | Missing |
| SMRTBARb_V1 | 15e244d50bedf53f | Missing |
| SMRTBARbzzz | 9e5274f931ee9f98 | Missing |
| Tested D-136 build | fe1b62f48707ccfc | Present |

This establishes that the inspected stable script tree cannot run the new
all-terrain factory. It does not establish which files were present in every
game reported by the owner. See KI-429. No live installation was modified.

Follow-up inspection after the owner identified the copy destination found
the current DLL (`fe1b62f48707ccfc`) and `script/src/roles/tech_flank.as`
directly under `SMRTBARb/`, alongside `stable/`. Those files were one directory
above the version directory shown in the inspected log. `SMRTBARb/stable/`
still contains the older DLL (`95da090944812c97`) and lacks the flank script.
For the existing stable identity, the DLL, `script/` and `config/` belong
inside `SMRTBARb/stable/`, retaining metadata identifying SMRTBARb/stable.
The uniquely versioned package remains the way to avoid the duplicate identity.

**Owner correction:** scripts/config are intentionally copied from `data/`
and the DLL separately from build output. That is a valid deployment workflow.
The observed filesystem snapshot does not establish what was installed for
every reported test, and must not be treated as a sufficient explanation for
the reported absence of all-terrain production. The owner reports the failure
with all correct files copied. Fresh isolated faction simulations are required.
Do not automatically deploy to the main game directory: the owner actively
tests there while the harness runs separate simulations.

## Current full-team control

A fresh 16-AI run used the current D-136 DLL and data, the same map/game and
experimental_balanced, without supplied economy, units or relaxed invariant
settings. It completed 35 minutes:
[original report](../../build-theatres/tech-production-investigation/current-16/runs/20260929-131933/report.md).

The west TECH was destroyed before reaching +200. The eastern Legion TECH
still reported +193 metal and zero combat army at minute 34. This does not
reproduce or clear the owner's +600-or-more condition. It reinforces that the
previous 1v1 observations cannot be generalized to full-team behavior. The
overall report is FAIL. Its reused 1v1 expectations target teams 0/1 and the
older watcher, so those missing-expectation rows are not valid full-team
feature verdicts; native traces and TeamStats are the evidence here. No claim
of a new gameplay fix is made.

## Concrete update artifact

The complete package is
[SMRTBARb-flank-20260929.zip](../../build-theatres/tech-production-investigation/SMRTBARb-flank-20260929.zip).
It contains all 230 DLL/debug/data files, changing only AIInfo metadata to the
unique `SMRTBARb/flank-20260929` identity. Script/DLL API parity checks all 225
members with zero findings. Every file is hashed in the adjacent manifest.

Follow the [installation instructions](../../build-theatres/tech-production-investigation/INSTALL.md)
and select that explicit version in the next game. The archive includes
matching debug symbols. It is the previously tested flank implementation,
not a fix for KI-430. Owner deployment is required by repository AGENTS.md:
"The assistant never writes to the live BAR install ... the owner deploys
the required build output above (script and DLL together)."
