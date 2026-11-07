// D-492 (owner, 2026-11-07): Pinpointers (targeting facilities) for the team's
// artillery. Whenever the allied team has a T2 artillery structure or better
// standing and no Pinpointer, TECH builds PinpointerTarget (3) of its own, on
// its layout (Layout::Place: within the turrets' reach, never in a factory's
// exit lane, a corridor or a pocket), with a T2 constructor.
//
// Cost: two native counts over the allied units every PinpointerCheckSeconds
// (CountAlliedFinished, O(allied units)); a work ask is O(1) plus the layout
// placement the other economy rows already make.
namespace TechPinpointers {
    bool wanted = false;
    int nextCheck = 0;
    int missingSince = -1;   // INV-266: since when the team has artillery and no Pinpointer

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

    void Tick()
    {
        if (Global::AISettings::Role != AiRole::TECH || !Global::RoleSettings::Tech::PinpointerEnabled) {
            wanted = false; missingSince = -1; return;
        }
        if (ai.frame < nextCheck) return;
        nextCheck = ai.frame + Global::RoleSettings::Tech::PinpointerCheckSeconds * SECOND;
        CCircuitDef@ def = Def();
        if (def is null) return;
        const int team = ai.CountAlliedFinished(Global::RoleSettings::Tech::PinpointerDefinitions);
        const int artillery = ai.CountAlliedFinished(Global::RoleSettings::Tech::PinpointerTriggerDefinitions);
        const int own = Own(def);
        if (artillery == 0) {
            if (wanted) GenericHelpers::LogUtil("[TECH][Pinpointer] no artillery stands: stop (D-492)", 1);
            wanted = false; missingSince = -1;
            return;
        }
        if (!wanted && team == 0 && own < Global::RoleSettings::Tech::PinpointerTarget) {
            wanted = true;
            GenericHelpers::LogUtil("[TECH][Pinpointer] " + artillery + " artillery stand and no Pinpointer: build "
                + Global::RoleSettings::Tech::PinpointerTarget + " (D-492)", 1);
        }
        if (wanted && own >= Global::RoleSettings::Tech::PinpointerTarget) {
            wanted = false;
            GenericHelpers::LogUtil("[TECH][Pinpointer] " + own + " ordered or standing (D-492)", 1);
        }
        // INV-266: the team never has artillery and no Pinpointer for
        // PinpointerGraceSeconds while TECH has none ordered or standing.
        if (team > 0 || own > 0) missingSince = -1;
        else if (missingSince < 0) missingSince = ai.frame;
        else if (ai.frame - missingSince >= Global::RoleSettings::Tech::PinpointerGraceSeconds * SECOND)
            Invariants::Violation("INV-266", "pinpointer", "the team has had " + artillery + " artillery and no Pinpointer for "
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
        IUnitTask@ t = TechBuild::BuildByLayout(u, name, Task::BuildType::STORE);
        if (t !is null) {
            GenericHelpers::LogUtil("[TECH][Pinpointer] " + u.circuitDef.GetName() + " " + u.id + " orders " + name + " (D-492)", 1);
            return t;
        }
        return TechBuild::AssistNearestOf(u, name);
    }
}
