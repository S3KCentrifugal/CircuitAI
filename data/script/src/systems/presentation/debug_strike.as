// Debug strikes (owner 2026-10-31, branch debug-widget-test): the widget's debug window.
#include "../../define.as"
#include "../../helpers/common/generic_helpers.as"
#include "widget_link.as"

/******************************************************************************

DEBUG STRIKE

The team link widget's debug window (tools/widgets/gui_barb_team_link.lua)
sends, to every AI its host may command:

    barb|debug|<teamId>|nuke|pos|<x>|<z>   every nuke silo: fire at will, nuke (x, z) again and again
    barb|debug|<teamId>|nuke|team|<team>   every nuke silo: the richest aim point of that team's
                                           scouted units, until none is left after a launch
    barb|debug|<teamId>|lol|pos|<x>|<z>    every lolcannon that reaches (x, z) fires at it
    barb|debug|<teamId>|nuke|player|<player>  the same on the team that player plays (the widget's
                                           # field: a player id; units carry only their team, so the
                                           DLL resolves it with the engine's GetPlayerTeam)
    barb|debug|<teamId>|lol|player|<player>  lolcannons, the same way
    barb|debug|<teamId>|lol|team|<team>    every lolcannon in range of a scouted unit of that
                                           team fires at the dearest one it reaches
    barb|debug|<teamId>|nuke|off           back to normal targeting (lol|off the same)

The orders are native (CSuperTask::UpdateDebug, task/static/DebugStrike.h);
this file parses the line and publishes the state back as the widget state key
"debug": "barb|debug|<team>|<ally>|<nuke state>|<lol state>", each state one
of "off", "pos x z units launches", "team T units launches",
"player P T units launches", "done T launches" or "done T launches P"
(CMilitaryManager::GetDebugStrikeState). Nothing is published before the first
debug command, so games that never use the window write no extra state.

******************************************************************************/
namespace DebugStrike {
    const int NUKE = 0, LOL = 1;
    const int OFF = 0, POS = 1, TEAM = 2;
    const int TickFrames = SECOND;   // the state is read once a second, only after a command
    bool used = false;
    int lastTick = -1000000;
    string lastState;

    bool ParseFloat(const string &in s, float &out v)
    {
        uint consumed = 0;
        v = float(parseFloat(s, consumed));
        return consumed == s.length() && consumed > 0 && v == v;
    }
    bool ParseInt(const string &in s, int &out v)
    {
        uint consumed = 0;
        v = int(parseInt(s, 10, consumed));
        return consumed == s.length() && consumed > 0;
    }

    // parts: "barb", "debug", <teamId>, <weapon>, <mode>, ...; true when handled
    bool Handle(array<string>@ parts)
    {
        if (parts.length() < 5) return false;
        const int weapon = (parts[3] == "nuke") ? NUKE : ((parts[3] == "lol") ? LOL : -1);
        if (weapon < 0) return false;
        bool ok = false;
        if (parts[4] == "off") {
            ok = aiMilitaryMgr.SetDebugStrike(weapon, OFF, 0.f, 0.f, -1);
        } else if (parts[4] == "pos" && parts.length() == 7) {
            float x, z;
            ok = ParseFloat(parts[5], x) && ParseFloat(parts[6], z)
                && aiMilitaryMgr.SetDebugStrike(weapon, POS, x, z, -1);
        } else if (parts[4] == "team" && parts.length() == 6) {
            int team;
            ok = ParseInt(parts[5], team) && aiMilitaryMgr.SetDebugStrike(weapon, TEAM, 0.f, 0.f, team);
        } else if (parts[4] == "player" && parts.length() == 6) {
            int player;
            ok = ParseInt(parts[5], player) && aiMilitaryMgr.SetDebugStrikePlayer(weapon, player);
        }
        GenericHelpers::LogUtil("[DebugStrike] " + parts[3] + " " + parts[4] + (ok ? " set" : " refused (malformed or invalid)"), 1);
        used = true;
        lastTick = -1000000;   // publish the new state at the next tick
        return true;
    }

    // From Commands::DrawTick (Main::AiUpdate)
    void Tick()
    {
        if (!used || ai.frame - lastTick < TickFrames) return;
        lastTick = ai.frame;
        const string state = aiMilitaryMgr.GetDebugStrikeState(NUKE) + "|" + aiMilitaryMgr.GetDebugStrikeState(LOL);
        if (state == lastState) return;
        lastState = state;
        WidgetLink::SetState("debug", WidgetLink::Line("debug", state));
    }
}
