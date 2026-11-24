// Owner 2026-11-24: the TECH t3rush opening's units (RoleTech::Tech_T3RushProduce: Razorback +
// Vanguard, Shiva + Catapult, Daedalus + Myrmidon, T3RushUnitCount in all from the gantries) form
// one native battle squad (behaviour.json "squad_formations" t3_rush, control/group/BattleSquads.h)
// instead of leaving one by one. On the first rush order a finished T2 factory of ours builds the
// squad's utility: 2 radar, 2 jammer, 2 flak of its own type (bot lab or vehicle plant). The squad
// holds at a rally off the gantry until every rush unit and every utility unit is out (or
// T3RushSquadGatherSeconds pass), then moves out as an artillery squad: assault mechs in front,
// utility in the middle, the long-range artillery at the back at its height-aware reach.
// Settings: Global::RoleSettings::Tech::T3RushSquad*. Log [TECH][RushSquad].
#include "../../define.as"
#include "../../unit.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/units/unit_helpers.as"

namespace TechRushSquad {
    int squad = -1;          // the held native squad, -1 none
    int started = -1;
    int deadline = -1;
    int expected = 0;        // units the hold waits for (rush units + utility queued, less losses)
    int admitted = 0;
    int utilityLab = -1;     // the T2 factory building the utility
    array<int> members;
    array<string> rushNames;
    array<string> utilityNames;
    AIFloat3 rally;

    bool Enabled() {
        return Global::RoleSettings::Tech::T3RushSquad && BattleSquads::Has("t3_rush");
    }

    // The 2 radar, 2 jammer, 2 flak a T2 factory of this name builds; empty when it is no T2 ground lab.
    array<string> UtilityFor(const string &in lab) {
        array<string> u;
        const int n = AiMax(0, Global::RoleSettings::Tech::T3RushSquadUtilityEach);
        array<string> kinds;
        if (lab == "armalab") kinds = array<string> = {"armmark", "armaser", "armaak"};        // Compass, Smuggler, Archangel
        else if (lab == "coralab") kinds = array<string> = {"corvoyr", "corspec", "coraak"};   // Augur, Deceiver, Manticore
        else if (lab == "legalab") kinds = array<string> = {"legaradk", "legajamk", "legadvaabot"};
        else if (lab == "armavp") kinds = array<string> = {"armseer", "armjam", "armyork"};
        else if (lab == "coravp") kinds = array<string> = {"corvrad", "coreter", "corsent"};
        else if (lab == "legavp") kinds = array<string> = {"legavrad", "legavjam", "legvflak"};
        for (uint k = 0; k < kinds.length(); ++k)
            for (int i = 0; i < n; ++i) u.insertLast(kinds[k]);
        return u;
    }

    CCircuitUnit@ T2Lab() {
        array<string>@ keys = Factory::allFactories.getKeys();
        for (uint i = 0; i < keys.length(); ++i) {
            CCircuitUnit@ f = null;
            if (!Factory::allFactories.get(keys[i], @f) || f is null || f.circuitDef is null || f.GetBuildProgress() < 1.0f) continue;
            if (UtilityFor(f.circuitDef.GetName()).length() > 0) return f;
        }
        return null;
    }

    // RoleTech::Tech_T3RushProduce, on the opening's first order. O(factories).
    void Begin(CCircuitUnit@ gantry, const array<string> &in pair, int total) {
        if (squad >= 0 || started >= 0 || !Enabled() || gantry is null) return;
        started = ai.frame;
        deadline = ai.frame + AiMax(60, Global::RoleSettings::Tech::T3RushSquadGatherSeconds) * SECOND;
        rally = BattleSquads::RallyFrom(gantry.GetPos(ai.frame), Global::RoleSettings::Tech::T3RushSquadRallyOffset);
        squad = aiMilitaryMgr.BattleSquadCreate("t3_rush", "t3 rush", rally);
        if (squad < 0) return;
        rushNames = pair;
        expected = total;
        string queued = "";
        CCircuitUnit@ lab = T2Lab();
        if (lab !is null) {
            utilityLab = lab.id;
            array<string> names = UtilityFor(lab.circuitDef.GetName());
            for (uint i = 0; i < names.length(); ++i) {
                CCircuitDef@ d = ai.GetCircuitDef(names[i]);
                if (d is null || !lab.circuitDef.CanBuild(d) || !d.IsAvailable(ai.frame)) continue;
                IUnitTask@ r = aiFactoryMgr.Enqueue(TaskS::Recruit(Task::RecruitType::FIREPOWER, Task::Priority::HIGH, d, lab.GetPos(ai.frame), 64.f));
                if (r is null) continue;
                if (utilityNames.find(names[i]) < 0) utilityNames.insertLast(names[i]);
                ++expected;
                queued += (queued == "" ? "" : ", ") + names[i];
            }
        }
        GenericHelpers::LogUtil("[TECH][RushSquad] battle squad " + squad + " holds at (" + int(rally.x) + ", " + int(rally.z)
            + ") for " + total + " rush units + utility " + (lab is null ? "none (no finished T2 factory)" : "from " + lab.circuitDef.GetName()
            + " " + lab.id + ": " + queued) + "; deadline " + (deadline / SECOND) + " s", 1);
    }

    // Military UnitAdded: a rush unit from a gantry, or utility from the chosen lab, made since the start.
    void UnitAdded(CCircuitUnit@ unit) {
        if (squad < 0 || unit is null || unit.circuitDef is null || unit.GetProductionFrame() < started) return;
        if (members.find(unit.id) >= 0) return;
        const string n = unit.circuitDef.GetName();
        bool mine = false;
        if (rushNames.find(n) >= 0) {
            CCircuitUnit@ p = ai.GetTeamUnit(unit.GetProducerId());
            mine = p !is null && p.circuitDef !is null && UnitHelpers::IsGantryLab(p.circuitDef.GetName());
        } else if (utilityNames.find(n) >= 0) {
            mine = unit.GetProducerId() == utilityLab;
        }
        if (!mine || !aiMilitaryMgr.BattleSquadAdd(squad, unit)) return;
        members.insertLast(unit.id);
        ++admitted;
        GenericHelpers::LogUtil("[TECH][RushSquad] held " + admitted + "/" + expected + " " + n + " " + unit.id, 1);
    }

    void UnitRemoved(CCircuitUnit@ unit) {
        if (squad < 0 || unit is null) return;
        const int k = members.find(unit.id);
        if (k < 0) return;
        members.removeAt(uint(k));
        expected = AiMax(0, expected - 1);
        --admitted;
    }

    // AiUpdate: launch once full or at the deadline. O(1).
    void Update() {
        if (squad < 0) return;
        const int alive = aiMilitaryMgr.BattleSquadSize(squad);
        if (alive < 0) { squad = -1; return; }
        const bool full = alive > 0 && alive >= expected;
        if (!full && ai.frame < deadline) return;
        if (alive <= 0) {
            aiMilitaryMgr.BattleSquadRelease(squad);
            GenericHelpers::LogUtil("[TECH][RushSquad] deadline with no unit out: no squad", 1);
            squad = -1;
            return;
        }
        aiMilitaryMgr.BattleSquadLaunch(squad);
        BattleSquads::Track(squad, rally);
        GenericHelpers::LogUtil("[TECH][RushSquad] battle squad " + squad + " moves out with " + alive + " unit(s) after "
            + ((ai.frame - started) / SECOND) + " s (" + (full ? "full" : "deadline, " + expected + " expected") + ")", 1);
        squad = -1;
    }

    void Load() { squad = -1; }
}
