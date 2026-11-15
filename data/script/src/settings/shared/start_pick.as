// Start-position pick (systems/world/start_pick.as). Off by default; a profile's
// main.as turns it on. Needs BAR with PR #9749 (2026-10-22), which lets an AI
// team's start point through game_initial_spawn's AllowStartPosition when it lies
// inside the team's start box.
namespace Global { namespace StartPick {
	bool Enabled = false;
	// Distance from the box edge a spot must keep (the gadget rejects points within
	// 1 elmo of the rectangle edge; a little margin keeps the commander's footprint in).
	float BoxMargin = 32.0f;
	// Furthest a side's out-of-box spot is pulled into the box; beyond it the spot is skipped.
	float MaxPull = 1500.0f;
	// Clamp target depth inside the polygon box (start_boxes.as): BoxMargin plus room.
	float BoxInset = 48.0f;
	// A clamped point keeps this far from the side's other spots (game rejects < 350).
	float StartSpacing = 360.0f;
	// A clamped spot also gets a backup point this deep, sent before the clamp point: the
	// game keeps the last accepted point, so a clamp point on a rock (Sector 318C P5,
	// 2026-11-15) still lands near the spot instead of the game's own guess.
	float BackupInset = 200.0f;
	// Footing of a clamped point: every slope-map cell within FootHalf elmos at most
	// FootMaxSlope (engine slope 1 - cos; commanders climb 54 degrees = 0.41).
	float FootHalf = 32.0f;
	float FootMaxSlope = 0.3f;
}}
