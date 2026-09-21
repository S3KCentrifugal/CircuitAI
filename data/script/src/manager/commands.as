// Commands from the local LuaUI widget (Spring.SendSkirmishAIMessage -> Main::AiLuaMessage).
#include "../define.as"
#include "../global.as"
#include "../types/ai_role.as"
#include "../types/role_config.as"
#include "../helpers/generic_helpers.as"
#include "../helpers/unit_helpers.as"
#include "../helpers/limits_helpers.as"
#include "roster.as"
#include "widget_link.as"
#include "layout.as"
#include "../helpers/porc_helpers.as"
#include "../helpers/layout_helpers.as"

/******************************************************************************

WIDGET COMMANDS

Spring.SendSkirmishAIMessage(teamId, text) from unsynced Lua reaches this
instance as Main::AiLuaMessage(text) only when the AI runs on that machine
(CEngineOutHandler::SendLuaMessages walks the local skirmish AIs), so this is a
host-side console, never a network protocol. Lines are "barb|<command>|...":

    barb|query|<teamId>             answer with our roster line (WidgetLink topic "roster")
    barb|setrole|<teamId>|<ROLE>    switch this instance to ROLE at runtime

Every command names the team it is meant for and is ignored by any other
instance: the engine already routes Spring.SendSkirmishAIMessage(teamId, ...)
to that team's AIs only, but a widget that hosts two ally teams in one process
must never be able to steer the wrong one through a broadcast (teamId -1).

RUNTIME ROLE SWITCH

A role is a RoleConfig of delegates that every native hook looks up on each
call through Global::profileController.RoleCfg, plus whatever its InitHandler
did to unit definitions at startup: maxThisUnit caps, SetIgnore flags and main
roles of factory defs. Switching therefore is:

  1. DefState::Restore  put every CCircuitDef back to the caps / ignore / main
                        role it had before the first InitHandler ran (snapshot
                        taken in Setup just before RoleConfigs::ApplyStartLimits)
  2. rebind             Global::AISettings::Role / RoleCfg and
                        Global::profileController.RoleCfg to the new RoleConfig
  3. init               RoleConfigs::ApplyStartLimits runs the new InitHandler
                        (quotas, ally range, caps, attributes, module inits)
  4. limits             merged map + role unit limits recomputed for the new role
  5. announce           roster re-announced so allies and the widget learn it

Everything touched is script-side data or engine-owned per-def values the roles
already write during normal play; no native object is created or destroyed, so
a switch cannot leave a dangling pointer. Units keep their current tasks and
pick up the new role's decisions as they ask for the next one. Role-local
progress flags (e.g. TECH's one-way eco thresholds) keep their values; that is
accepted, a switched-in role behaves as if those gates were already passed.
Switches are rate limited by SwitchCooldownFrames.

******************************************************************************/
namespace Commands {
    const string Prefix = "barb|";
    const int SwitchCooldownFrames = 10 * SECOND;
    int lastSwitchFrame = -1000000;

    // The native manager settings a role's InitHandler may change: captured once
    // at Setup, restored before the next role's InitHandler runs (CR-007).
    namespace NativeState {
        bool taken = false;
        float reclEnergyEff;
        bool assistNanoEnabled;
        float assistNanoIncomeMod;
        bool holdStartFactory;
        bool experimentalBuild;
        float experimentalDirectRange;
        float experimentalSearchRadius;
        bool autoStorageEnabled;
        bool reclaimOldConvertersAlways;
        uint quotaScout;
        float quotaAttack;
        float quotaAttackWait;
        float quotaAttackScale;
        float raidMin;
        float raidAvg;
        int porcMode;
        float porcBudgetMod;
        int porcAllyAA;
        void Snapshot()
        {
            if (taken) return;
            reclEnergyEff = aiEconomyMgr.reclEnergyEff;
            assistNanoEnabled = aiEconomyMgr.assistNanoEnabled;
            assistNanoIncomeMod = aiEconomyMgr.assistNanoIncomeMod;
            holdStartFactory = aiEconomyMgr.holdStartFactory;
            experimentalBuild = aiBuilderMgr.experimentalBuild;
            experimentalDirectRange = aiBuilderMgr.experimentalDirectRange;
            experimentalSearchRadius = aiBuilderMgr.experimentalSearchRadius;
            autoStorageEnabled = aiEconomyMgr.autoStorageEnabled;
            reclaimOldConvertersAlways = aiEconomyMgr.reclaimOldConvertersAlways;
            quotaScout = aiMilitaryMgr.quota.scout;
            quotaAttack = aiMilitaryMgr.quota.attack;
            quotaAttackWait = aiMilitaryMgr.quota.attackWait;
            quotaAttackScale = aiMilitaryMgr.quota.attackScale;
            raidMin = aiMilitaryMgr.quota.raid.min;
            raidAvg = aiMilitaryMgr.quota.raid.avg;
            porcMode = aiMilitaryMgr.porcMode;
            porcBudgetMod = aiMilitaryMgr.porcBudgetMod;
            porcAllyAA = aiMilitaryMgr.porcAllyAA;
            taken = true;
            GenericHelpers::LogUtil("[Commands] Native manager state snapshot taken", 3);
        }
        void Restore()
        {
            if (!taken) return;
            aiEconomyMgr.reclEnergyEff = reclEnergyEff;
            aiEconomyMgr.assistNanoEnabled = assistNanoEnabled;
            aiEconomyMgr.assistNanoIncomeMod = assistNanoIncomeMod;
            aiEconomyMgr.holdStartFactory = holdStartFactory;
            aiBuilderMgr.experimentalBuild = experimentalBuild;
            aiBuilderMgr.experimentalDirectRange = experimentalDirectRange;
            aiBuilderMgr.experimentalSearchRadius = experimentalSearchRadius;
            aiEconomyMgr.autoStorageEnabled = autoStorageEnabled;
            aiEconomyMgr.reclaimOldConvertersAlways = reclaimOldConvertersAlways;
            aiMilitaryMgr.quota.scout = quotaScout;
            aiMilitaryMgr.quota.attack = quotaAttack;
            aiMilitaryMgr.quota.attackWait = quotaAttackWait;
            aiMilitaryMgr.quota.attackScale = quotaAttackScale;
            aiMilitaryMgr.quota.raid.min = raidMin;
            aiMilitaryMgr.quota.raid.avg = raidAvg;
            aiMilitaryMgr.porcMode = porcMode;
            aiMilitaryMgr.porcBudgetMod = porcBudgetMod;
            aiMilitaryMgr.porcAllyAA = porcAllyAA;
            GenericHelpers::LogUtil("[Commands] Native manager state restored", 2);
        }
    }

    namespace DefState {
        bool taken = false;
        array<int> maxThis;
        array<bool> ignore;
        array<int> mainRole;

        // Setup calls this once, before any role InitHandler runs.
        void Snapshot()
        {
            if (taken) return;
            const int count = ai.GetDefCount();
            maxThis.resize(count + 1);
            ignore.resize(count + 1);
            mainRole.resize(count + 1);
            for (int id = 1; id <= count; ++id) {
                CCircuitDef@ d = ai.GetCircuitDef(Id(id));
                if (d is null) continue;
                maxThis[id] = d.maxThisUnit;
                ignore[id] = d.IsIgnore();
                mainRole[id] = int(d.GetMainRole());
            }
            taken = true;
            GenericHelpers::LogUtil("[Commands] Def state snapshot taken for " + count + " defs", 3);
        }

        void Restore()
        {
            if (!taken) return;
            const int count = ai.GetDefCount();
            int changed = 0;
            for (int id = 1; id <= count && id < int(maxThis.length()); ++id) {
                CCircuitDef@ d = ai.GetCircuitDef(Id(id));
                if (d is null) continue;
                if (d.maxThisUnit != maxThis[id]) { d.maxThisUnit = maxThis[id]; ++changed; }
                if (d.IsIgnore() != ignore[id]) { d.SetIgnore(ignore[id]); ++changed; }
                if (int(d.GetMainRole()) != mainRole[id]) { d.SetMainRole(Type(mainRole[id])); ++changed; }
            }
            GenericHelpers::LogUtil("[Commands] Def state restored, " + changed + " value(s) reverted", 2);
        }
    }

    // Returns true when the line was a command for us.
    bool Handle(const string &in data)
    {
        if (data.length() < Prefix.length() || data.substr(0, Prefix.length()) != Prefix) return false;
        array<string>@ parts = data.split("|");
        if (parts.length() < 3) return false;
        const string cmd = parts[1];
        if (int(parseInt(parts[2])) != ai.teamId) {
            GenericHelpers::LogUtil("[Commands] Ignored command addressed to team " + parts[2] + ": " + data, 3);
            return true;
        }

        if (cmd == "query") {
            if (Team::Roster::IsReady()) {
                WidgetLink::Send("roster", "self|" + Team::Roster::Encode());
            } else {
                WidgetLink::Send("role", "?|not ready");
            }
            return true;
        }
        if (cmd == "setrole" && parts.length() >= 4) {
            SwitchRole(parts[3]);
            return true;
        }
        // barb|layout|<team>|on|off : push the planned base to the widget's overlay (D-053)
        if (cmd == "layout" && parts.length() >= 4) {
            Layout::SetOverlay(parts[3] == "on");
            if (!Layout::planned) WidgetLink::Send("layout", "0|0|none");
            return true;
        }
        GenericHelpers::LogUtil("[Commands] Unknown command: " + data, 2);
        return true;
    }

    void _Reply(const string &in roleName, const string &in status)
    {
        WidgetLink::Send("role", roleName + "|" + status);
    }

    void SwitchRole(const string &in roleName)
    {
        const string current = Team::Roster::RoleName(Global::AISettings::Role);
        if (!Global::Map::MapResolved || Global::profileController is null) {
            _Reply(current, "refused: not initialised yet");
            return;
        }
        const AiRole role = Team::Roster::RoleFromName(roleName);
        if (Team::Roster::RoleName(role) != roleName) {
            _Reply(current, "refused: unknown role " + roleName);
            return;
        }
        if (role == Global::AISettings::Role) {
            _Reply(current, "already " + current);
            return;
        }
        if (ai.frame - lastSwitchFrame < SwitchCooldownFrames) {
            _Reply(current, "refused: cooldown");
            return;
        }
        RoleConfig@ cfg = RoleConfigs::Get(role);
        if (cfg is null) {
            _Reply(current, "refused: no RoleConfig registered for " + roleName);
            return;
        }
        if (!DefState::taken) {
            _Reply(current, "refused: no def snapshot (setup incomplete)");
            return;
        }

        GenericHelpers::LogUtil("[Commands] Role switch " + current + " -> " + roleName + " requested by widget", 1);
        // Leave: the old role's layout (reservations, zones, the native flag)
        // and the native manager settings its InitHandler changed (CR-007).
        Layout::OnRoleLeave();
        NativeState::Restore();
        DefState::Restore();

        Global::AISettings::Role = role;
        Global::Map::StartRole = role;
        @Global::AISettings::RoleCfg = cfg;
        @Global::profileController.RoleCfg = cfg;
        RoleConfigs::ApplyStartLimits();   // runs the incoming InitHandler

        dictionary@ merged = LimitsHelpers::ComputeAndStoreMergedUnitLimits(Global::Map::Config, role);
        UnitHelpers::ApplyUnitLimits(merged);

        // Enter: the incoming role's porc chain and layout plan, as Setup does.
        PorcHelpers::ApplyForRole();
        LayoutHelpers::ApplyForRole();

        lastSwitchFrame = ai.frame;
        Team::Roster::Reannounce();
        GenericHelpers::LogUtil("[Commands] Role switch complete: now " + roleName, 1);
        _Reply(roleName, "ok");
    }
}  // namespace Commands
