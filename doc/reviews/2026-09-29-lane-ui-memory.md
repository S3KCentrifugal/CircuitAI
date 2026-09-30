# All-player lane UI memory incident — 2026-09-29

The owner reports selecting all-player lanes and then a player name caused the
entire interface to disappear. Read-only inspection of the installed infolog
found, at frame 44395:

```text
[t=00:07:36.587290] Emergency garbage collection due to exceeding 1.2GB LuaRAM
[t=00:07:45.953347] Emergency garbage collection due to exceeding 1.2GB LuaRAM
[t=00:07:55.221902] Emergency garbage collection due to exceeding 1.2GB LuaRAM
[t=00:08:04.218837] LUA_ERRMEM callin=DrawScreen ... not enough memory
[t=00:08:04.965822] LuaUI OOM {alloced,maximum}={1610612743,1610612736}bytes
```

These are condensed log fields, not a widget-specific traceback. The preceding
records show successful survey publication by multiple AIs, all at the same
paused game frame. The widget's installed/source SHA256 was
`f367cb6f31c3f4a1b2f672f0c223488dd52a5c6216c3e93805e54c92f25de6a5`.

## Fix and deterministic verification

[D-141](../decisions.md#d-141--batch-lane-rendering-to-avoid-exhausting-luaui-memory)
batches route lines and reuses projected coordinates. The original renderer
allocated a callback for each stroke and a table for each projected point and
context colour. Recoil stops automatic collection between its explicit GC passes.

The actual widget runs under Lua 5.1 with mocked Spring/GL calls in
[three regression tests](../../tools/playtest/test_lane_ui_memory.py):

- 16 players × nine lanes × 400 points, 120 frames and repeated player clicks:
  peak allocation 80.6 KiB/frame, retained increase 0.1 KiB. The original code
  measured approximately 40 MB/frame in the same fixture.
- Player selection preserves all mode, follows the selected player in player
  mode, and Hide clears all visibility.
- Vertex coordinates, air dashes and clipped gaps remain correct, including
  shorter and empty survey replacements.

## Engine verification

The first headless run delivered surveys but recorded zero draw callbacks and
zero clicks. Its FAIL is retained; it is not rendering evidence. The subsequent
test uses the graphical engine with `--hidden` and a separate write directory,
real DrawScreen calls from DrawGenesis's GL context, 16 AIs, all-player surveys,
a paused simulation and repeated clicks for 90 seconds.

The graphical run completed on 2026-09-29 at 19:16 local time, with all 16
player surveys received. Its final periodic sample records 3,968 draws and
44 clicks; the PASS marker follows at 90 seconds. Peak measured allocation
inside the real widget draw was 127.8 KiB. No emergency collection, Lua memory
error, draw error or gameplay invariant violation was logged. The tested widget
SHA256 is `3aaa20eb91d7547f188a524d2c9978de5ad146d11e21ae21c0620f18fd991a40`.
Whole-LuaUI sampled memory ranged from 132,306 to 332,071 KiB, including the
other game widgets; this is separate from the renderer's per-call allocation.

[Raw report](../../build-theatres/lane-ui-memory/baseline/runs/20260929-191609/report.md)
and [infolog](../../build-theatres/lane-ui-memory/baseline/runs/20260929-191609/infolog.txt)
remain unedited. The generic playtest wrapper labels the run FAIL because the
observer deliberately quits while paused at frame 360, before its four-game-minute
deadline. Its dedicated render-stress expectation passed and every forbid check
was clean; the wrapper verdict is not being presented as an overall passing game.
This exercises real GL calls and clicks in a hidden engine, not a visual review
of the rendered screen.

The original late-game incident has not been replayed; the generic LuaUI error
does not prove no other widget contributed. [KI-431](../known-issues.md#ki-431--lane-ui-memory-fix-needs-confirmation-in-the-original-session)
keeps that limitation explicit. Main game files were never changed.
