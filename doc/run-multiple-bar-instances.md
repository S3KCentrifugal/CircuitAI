# Running several Beyond All Reason games at once

This guide runs two or more local BAR games side by side on Windows. Your normal
install, settings and lobby are left untouched.

## How it works

The engine (`spring.exe`) takes a `--write-dir <folder>` option. Everything the
game creates goes into that folder: logs, settings, widget state, screenshots,
replays and caches. The game and map files are still read from your normal install.
If each copy has its own folder, the copies can't interfere with each other or with
your main setup.

## What you need

- BAR installed and launched at least once through the lobby.
- The map you want, downloaded once through the lobby.
- About 2–4 GB of RAM per copy (less with the headless engine, see step 7).

## Paths used below

| Name | Default location |
| --- | --- |
| `DATA` | `%LOCALAPPDATA%\Programs\Beyond-All-Reason\data` |
| `ENGINE` | `DATA\engine\<newest version>\` (contains `spring.exe`) |
| `GAMES` | Any empty folder of your own, e.g. `C:\bar-games` |

Run this in PowerShell to find the newest engine folder:

```powershell
Get-ChildItem "$env:LOCALAPPDATA\Programs\Beyond-All-Reason\data\engine" |
  Sort-Object LastWriteTime | Select-Object -Last 1 -ExpandProperty FullName
```

## Steps

### 1. Make one folder per copy

```powershell
mkdir C:\bar-games\game1, C:\bar-games\game2
```

Never give two running copies the same folder.

### 2. Copy your settings into each folder

```powershell
$data = "$env:LOCALAPPDATA\Programs\Beyond-All-Reason\data"
Copy-Item "$data\springsettings.cfg" C:\bar-games\game1\
Copy-Item "$data\springsettings.cfg" C:\bar-games\game2\
```

### 3. Edit each folder's `springsettings.cfg`

Change these lines, or add them if they're missing. Replace `<you>` with your
Windows user name:

```
SpringData = C:\Users\<you>\AppData\Local\Programs\Beyond-All-Reason\data
Fullscreen = 0
WindowBorderless = 0
XResolutionWindowed = 960
YResolutionWindowed = 540
WindowPosX = 0
WindowPosY = 0
```

- `SpringData` tells the copy where to find the game and maps. **This line is required.**
- Give each copy a different `WindowPosX` and `WindowPosY` (e.g. `0` and `960`) so
  the windows don't overlap.

### 4. Get the game version string

Open `DATA\_script.txt`, which the lobby writes for the last game you started.
Copy the value of `GameType=...;`, for example
`GameType=Beyond All Reason test-27xxx-abcdef;`.

### 5. Write a start script in each folder

Save this as `script.txt` in `game1` and again in `game2`. It sets up an
AI-vs-AI game that you watch as a spectator.

```
[GAME]
{
	GameType=Beyond All Reason test-XXXXX-xxxxxxx;
	MapName=Supreme Isthmus v1.7;
	StartPosType=3;
	IsHost=1;
	HostIP=127.0.0.1;
	HostPort=0;
	MyPlayerName=Viewer;
	NumPlayers=1;
	GameStartDelay=0;
	[MODOPTIONS] { }
	[ALLYTEAM0] { NumAllies=0; }
	[ALLYTEAM1] { NumAllies=0; }
	[ALLYTEAM2] { NumAllies=0; }
	[PLAYER0] { Name=Viewer; Spectator=1; Team=2; IsFromDemo=0; Rank=0; }
	[TEAM0] { AllyTeam=0; TeamLeader=0; Side=armada; RgbColor=0 0.3 1; StartPosX=1000; StartPosZ=1000; Handicap=0; }
	[TEAM1] { AllyTeam=1; TeamLeader=0; Side=cortex; RgbColor=1 0.2 0; StartPosX=7000; StartPosZ=7000; Handicap=0; }
	[TEAM2] { AllyTeam=2; TeamLeader=0; Side=armada; RgbColor=0.5 0.5 0.5; StartPosX=64; StartPosZ=64; Handicap=0; }
	[AI0] { ShortName=BARb; Version=stable; Name=AI-0; Team=0; Host=0; IsFromDemo=0; }
	[AI1] { ShortName=BARb; Version=stable; Name=AI-1; Team=1; Host=0; IsFromDemo=0; }
}
```

Before saving:

- Replace the `GameType` line with the one from step 4.
- Set `MapName` to a map you have downloaded.
- Set the start positions to points on that map, in elmos (1 map square = 512 elmos).
- **Keep the spectator on its own team and ally team (`TEAM2` / `ALLYTEAM2`).**
  If it shares an ally team with an AI, BAR can kill that side at frame 1.

*Shortcut:* to play the lobby's last setup instead, copy `DATA\_script.txt` into
each folder and rename it `script.txt`.

### 6. Launch each copy

```powershell
$eng = (Get-ChildItem "$env:LOCALAPPDATA\Programs\Beyond-All-Reason\data\engine" |
        Sort-Object LastWriteTime | Select-Object -Last 1).FullName

Start-Process "$eng\spring.exe" -WorkingDirectory $eng `
  -ArgumentList '--write-dir', 'C:\bar-games\game1', 'C:\bar-games\game1\script.txt'

Start-Process "$eng\spring.exe" -WorkingDirectory $eng `
  -ArgumentList '--write-dir', 'C:\bar-games\game2', 'C:\bar-games\game2\script.txt'
```

Each copy opens its own window. Its log is `C:\bar-games\gameN\infolog.txt`.

### 7. (Optional) Run without a window

Swap `spring.exe` for `spring-headless.exe`, which is in the same folder. This
saves a lot of RAM and GPU, and you can run more copies. Follow progress in each
folder's `infolog.txt`:

```powershell
Get-Content C:\bar-games\game1\infolog.txt -Wait -Tail 20
```

### 8. Stop one copy

Close its window, or kill it by its folder so that other copies (and any game you
are playing yourself) keep running:

```powershell
Get-CimInstance Win32_Process -Filter "Name='spring.exe' or Name='spring-headless.exe'" |
  Where-Object { $_.CommandLine -match '--write-dir\s+"?C:\\bar-games\\game1"?(\s|$)' } |
  ForEach-Object { Stop-Process -Id $_.ProcessId -Force }
```

The pattern matches the folder name exactly, so stopping `game1` won't also catch
`game10`.

## Troubleshooting

| Symptom | Cause / fix |
| --- | --- |
| Window opens and closes at once | Read `infolog.txt` in that copy's folder. It's usually a wrong `GameType`, a map you haven't downloaded, or a missing `SpringData` line. |
| "Game not found" / "map not found" | `SpringData` doesn't point at the install's `data` folder, or the version or map isn't downloaded. Start that game once from the lobby. |
| One side dies instantly | The spectator shares an ally team with an AI. Give it its own (step 5). |
| Copies change each other's settings | Two copies are using the same `--write-dir`. Give each its own folder. |
| PC stutters | Too many windowed copies. Use `spring-headless.exe`, a smaller window, or fewer copies. |

## Cleaning up

Delete the `C:\bar-games\gameN` folders. Nothing else was changed.
