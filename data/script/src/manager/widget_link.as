// Mirror of team coordination events to a local LuaUI widget.
#include "../define.as"
#include "../helpers/generic_helpers.as"

/******************************************************************************

WIDGET LINK

ai.CallUI(msg) is the engine's AI -> LuaUI channel: CAICallback::CallLuaUI
invokes the unsynced callin RecvSkirmishAIMessage(aiTeam, dataStr) on the
LuaUI of the machine that runs this AI instance. BAR's widget handler does NOT
forward that callin to widgets (it is not in barwidgets.lua's callInLists), so
the widget installs the LuaUI global itself (D-113). It is local only: the host
of the AIs sees it, playing or spectating; a client on another machine does not.
It never reaches gadgets, other AIs or other players, so it is safe to mirror
internal state through it.

Every line is "barb|<topic>|<senderTeamId>|<senderAllyTeamId>|<payload>". The
ally team id lets a widget that watches several locally hosted ally teams keep
them apart. Topics mirrored today:
    roster    payload = the roster line (see roster.as), sent when we announce
              ourselves ("self") and when an ally's entry is first stored ("ally")
    orphan    request / donate events of the orphan rescue (team.as)
    donation  T2 constructor hand-outs (donation.as)
    role      reply to a widget command (commands.as)
    ferry     ferry runs (ferry.as); spam  on / off / front / focus (spam.as);
    seaassist shipyard unlocks and hand-outs (sea_assist.as); layout  the
              planned base for the overlay (shared leased feed below)

tools/widgets/gui_barb_team_link.lua is a widget that displays them.

******************************************************************************/
namespace WidgetLink {
    bool Enabled = true;
    const string Prefix = "barb|";

    void Send(const string &in topic, const string &in payload)
    {
        if (!Enabled) return;
        ai.CallUI(Prefix + topic + "|" + ai.teamId + "|" + ai.allyTeamId + "|" + payload);
    }
    // Local observation only: one feed for every role using native layouts.
    // Stop all serialization when hidden; renew the lease from the UI so a
    // removed widget cannot leave a permanent background polling workload.
    bool layoutOverlay = false;
    int layoutUntil = -1, layoutFrame = -1;
    string layoutLast;
    void SetLayoutOverlay(bool on, bool refresh = true)
    {
        const bool starting = on && !layoutOverlay;
        layoutOverlay = on;
        layoutUntil = ai.frame + 45 * SECOND;
        if (!on) { layoutLast = ""; layoutFrame = -1; return; }
        if (starting) { layoutLast = ""; layoutFrame = -1; }
        LayoutTick(starting || refresh);
    }
    void LayoutTick(bool force = false)
    {
        if (!layoutOverlay) return;
        if (ai.frame > layoutUntil) { SetLayoutOverlay(false); return; }
        if (!force && layoutFrame >= 0 && ai.frame - layoutFrame < 4 * SECOND) return;
        layoutFrame = ai.frame;
        const string snapshot = aiTerrainMgr.IsLayoutEnabled() ? aiTerrainMgr.DescribeLayout() : "";
        if (!force && snapshot == layoutLast) return;
        layoutLast = snapshot;
        const uint parts = (snapshot.length() + 2999) / 3000;
        if (parts == 0) Send("layout", "0|0|none");
        for (uint i = 0; i < parts; ++i)
            Send("layout", "" + (i + 1) + "|" + parts + "|" + snapshot.substr(i * 3000, 3000));
    }
}
