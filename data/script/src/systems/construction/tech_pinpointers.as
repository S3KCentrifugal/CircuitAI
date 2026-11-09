#include "../../helpers/math/pinpointer_math.as"
// D-492 / D-493 (owner, 2026-11-07): Pinpointers (targeting facilities) for the
// team's artillery. Whenever the allied team has a T2 artillery structure or
// better standing and no Pinpointer, one TECH AI builds PinpointerTarget (3) of
// its own, on its layout (Layout::PlaceUtility: within the turrets' reach, never
// in a factory's exit lane, a corridor or a pocket), with a T2 constructor.
//
// One builder per team (PinpointerMath::Elected): the lowest team id among this
// AI, when TECH, and its TECH allies in the roster. Rules pure and tested in
// helpers/math/pinpointer_math.as.
//
// Cost: the definition lists are resolved to handles once; every
// PinpointerCheckSeconds one O(1) native count per definition (a dozen;
// CAllyTeam::FinishedCount rebuilds once per friendly-unit refresh) and an
// O(allies) roster pass. A work ask is O(1) plus the layout placement.
namespace TechPinpointers {
    bool wanted = false;
    int nextCheck = 0;
    int missingSince = -1;   // INV-266: since when the team has artillery and no Pinpointer
    array<CCircuitDef@> pinpointers;
    array<CCircuitDef@> artillery;
    bool resolved = false;

    string NameForSide(const string &in side)
    {
        if (side == "armada") return "armtarg";
        if (side == "cortex") return "cortarg";
        if (side == "legion") return "legtarg";
        return "";
    }
    CCircuitDef@ Def() { return ai.GetCircuitDef(NameForSide(Global::AISettings::Side)); }
    int Own(CCircuitDef@ def)
    {
        return def.count + aiBuilderMgr.GetQueuedBuildCount(int(Task::BuildType::STORE), def);
    }

    void Resolve(const string &in names, array<CCircuitDef@>@ result)
    {
        result.resize(0);
        array<string>@ list = names.split(",");
        for (uint i = 0; i < list.length(); ++i) {
            CCircuitDef@ def = ai.GetCircuitDef(list[i]);
            if (def !is null) result.insertLast(def);
        }
    }
    int AlliedFinished(const array<CCircuitDef@>@ defs)
    {
        int n = 0;
        for (uint i = 0; i < defs.length(); ++i) n += ai.AlliedFinishedCount(defs[i]);
        return n;
    }

    // This AI builds them: it is TECH and the lowest TECH team in the roster.
    bool Elected()
    {
        array<int> techAllies;
        array<int> allies = Team::Roster::AllyTeamIds();
        for (uint i = 0; i < allies.length(); ++i) {
            Team::Roster::Entry@ e;
            if (Team::Roster::entries.get("" + allies[i], @e) && e !is null && e.role == AiRole::TECH)
                techAllies.insertLast(allies[i]);
        }
        return PinpointerMath::Elected(ai.teamId, Global::AISettings::Role == AiRole::TECH, techAllies) == ai.teamId;
    }

    void Tick()
    {
        if (Global::AISettings::Role != AiRole::TECH || !Global::RoleSettings::Tech::PinpointerEnabled) {
            wanted = false; missingSince = -1; return;
        }
        if (ai.frame < nextCheck) return;
        nextCheck = ai.frame + Global::RoleSettings::Tech::PinpointerCheckSeconds * SECOND;
        if (!resolved) {
            resolved = true;
            Resolve(Global::RoleSettings::Tech::PinpointerDefinitions, pinpointers);
            Resolve(Global::RoleSettings::Tech::PinpointerTriggerDefinitions, artillery);
        }
        CCircuitDef@ def = Def();
        if (def is null) return;
        const int team = AlliedFinished(pinpointers);
        const int guns = AlliedFinished(artillery);
        const int own = Own(def);
        const bool elected = Elected();
        const bool was = wanted;
        wanted = elected && PinpointerMath::Wanted(wanted, team, guns, own, Global::RoleSettings::Tech::PinpointerTarget);
        if (wanted && !was)
            GenericHelpers::LogUtil("[TECH][Pinpointer] " + guns + " artillery stand and no Pinpointer: build "
                + Global::RoleSettings::Tech::PinpointerTarget + " (D-492)", 1);
        else if (!wanted && was)
            GenericHelpers::LogUtil("[TECH][Pinpointer] stop: " + own + " of ours, " + team + " on the team, " + guns
                + " artillery" + (elected ? "" : ", another TECH builds them") + " (D-493)", 1);
        // INV-266: the team never has artillery and no Pinpointer for
        // PinpointerGraceSeconds while its elected TECH has none ordered or standing.
        if (!elected || guns == 0 || team > 0 || own > 0) missingSince = -1;
        else if (missingSince < 0) missingSince = ai.frame;
        else if (ai.frame - missingSince >= Global::RoleSettings::Tech::PinpointerGraceSeconds * SECOND)
            Invariants::Violation("INV-266", "pinpointer", "the team has had " + guns + " artillery and no Pinpointer for "
                + int((ai.frame - missingSince) / SECOND) + " s with none ordered (D-492)");
    }

    IUnitTask@ Work(CCircuitUnit@ u)
    {
        if (!wanted || u is null) return null;
        CCircuitDef@ def = Def();
        if (def is null || !u.circuitDef.CanBuild(def)) return null;
        const string name = def.GetName();
        if (Own(def) >= Global::RoleSettings::Tech::PinpointerTarget) return TechBuild::AssistNearestOf(u, name);
        TechBuild::LiftCapForRole(name);
        IUnitTask@ t = Layout::PlaceUtility(def, u);
        if (t !is null) {
            GenericHelpers::LogUtil("[TECH][Pinpointer] " + u.circuitDef.GetName() + " " + u.id + " orders " + name + " (D-492)", 1);
            return t;
        }
        return TechBuild::AssistNearestOf(u, name);
    }
}
