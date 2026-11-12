// Start-position pick (systems/world/start_pick.as). Off by default; a profile's
// main.as turns it on. Needs BAR with PR #9749 (2026-10-22), which lets an AI
// team's start point through game_initial_spawn's AllowStartPosition when it lies
// inside the team's start box.
namespace Global { namespace StartPick {
	bool Enabled = false;
	// Distance from the box edge a spot must keep (the gadget rejects points within
	// 1 elmo of the rectangle edge; a little margin keeps the commander's footprint in).
	float BoxMargin = 32.0f;
}}
