// Heavy T3 wave hold (owner, 2026-11-16). Settings: settings/shared/heavy_wave.as.
#include "../../define.as"
#include "../../unit.as"
#include "../../global.as"
#include "../../helpers/common/generic_helpers.as"
#include "../../helpers/units/unit_helpers.as"

/******************************************************************************

HEAVY WAVE

TECH and FRONT gantries. Once the first FirstHeavies heavies (Titan armbanth,
Juggernaut corkorg, Sol Invictus legeheatraymech; Thor, Vanguard, Catapult and
Astraeus do not count) are out of our gantries, the next gantry ask takes a
RollChance roll; after that one roll every RollIntervalSeconds. A roll that
falls while a wave is still building or holding waits for its launch.

A hit makes the asking gantry build WaveSize (LateWaveSize once late) of the
side's heavy one after another, skipping the gantry's usual rotation
(TechHeavyChoice / FrontGantry resume where they were). The units are held by
one native gather task (CMilitaryManager::EnqueueGather) RallyOffset elmos from
the gantry towards the nearest enemy start, and launch as one ATTACK squad when
the last is out (power reached) or at the deadline (GatherSecondsPerUnit per
unit from the hit). Losses lower the power needed, so survivors never wait for
a dead unit.

Late: game time >= LateMinutes<Role> AND Economy::GetMinMetalIncomeLast10s()
>= LateIncome<Role> (the income held at or above it for 10 s in a row);
latched once reached.

Log tag [HeavyWave]: count, roll (hit/miss), build k/n, held k/n, launch,
abort. One wave per AI at a time; no periodic job, no world scan.

******************************************************************************/
namespace HeavyWave {
    int heavies = 0;          // heavies produced by our gantries (the first FirstHeavies arm the rolls)
    int nextRoll = -1;        // frame of the next roll; -1 until armed
    int rolls = 0;
    int waves = 0;
    bool late = false;

    bool active = false;
    int gantryId = -1;
    int defId = -1;
    string unitName;
    int size = 0;             // units this wave builds
    int ordered = 0;          // recruits placed (cancelled ones are placed again)
    int expected = 0;         // units the hold waits for (size less losses)
    int admitted = 0;
    int started = -1;
    int deadline = -1;
    float unitPower = 0.0f;
    AIFloat3 rally;
    IUnitTask@ gather;
    array<IUnitTask@> recruits;
    array<int> members;
    array<bool> departed;

    bool Enabled() {
        return Global::HeavyWave::Enabled
            && (Global::AISettings::Role == AiRole::TECH || Global::AISettings::Role == AiRole::FRONT);
    }
    bool IsTech() { return Global::AISettings::Role == AiRole::TECH; }
    string Tag() { return "[HeavyWave][" + (IsTech() ? "TECH" : "FRONT") + "] "; }

    string HeavyName(const string &in side) {
        if (side == "cortex") return "corkorg";            // Juggernaut
        if (side == "legion") return "legeheatraymech";    // Sol Invictus
        return "armbanth";                                 // Titan
    }

    void UpdateLate() {
        if (late) return;
        const int minutes = IsTech() ? Global::HeavyWave::LateMinutesTech : Global::HeavyWave::LateMinutesFront;
        const float income = IsTech() ? Global::HeavyWave::LateIncomeTech : Global::HeavyWave::LateIncomeFront;
        if (ai.frame < minutes * MINUTE) return;
        const float min10 = Economy::GetMinMetalIncomeLast10s();
        if (min10 < income) return;
        late = true;
        GenericHelpers::LogUtil(Tag() + "late: waves of " + Global::HeavyWave::LateWaveSize + " (t=" + (ai.frame / SECOND)
            + " s, 10 s min metal income " + min10 + " >= " + income + ")", 1);
    }

    float RequiredPower() {
        return unitPower * float(expected) * 0.99999f;
    }
    void RefreshPower() {
        if (gather !is null && !gather.IsDead()) aiMilitaryMgr.SetGatherPower(gather, RequiredPower());
    }
    int Alive() {
        int n = 0;
        for (uint i = 0; i < departed.length(); ++i) if (!departed[i]) ++n;
        return n;
    }

    void Close(const string &in why) {
        if (!active) return;
        GenericHelpers::LogUtil(Tag() + "wave " + waves + " closed (" + why + "): built " + admitted + "/" + size
            + " alive " + Alive() + "; next roll at " + (nextRoll / SECOND) + " s", 1);
        if (gather !is null && !gather.IsDead()) aiMilitaryMgr.SetGatherPower(gather, 0.0f);   // release survivors
        active = false;
        @gather = null;
        recruits.resize(0); members.resize(0); departed.resize(0);
        gantryId = -1; defId = -1; size = 0; ordered = 0; expected = 0; admitted = 0;
    }

    AIFloat3 RallyFor(CCircuitUnit@ g) {
        const AIFloat3 from = g.GetPos(ai.frame);
        array<AIFloat3> enemies = Lanes::EnemyStarts();
        float best = -1.0f;
        AIFloat3 goal = from;
        for (uint i = 0; i < enemies.length(); ++i) {
            const float d = from.SqDistance2D(enemies[i]);
            if (best < 0.0f || d < best) { best = d; goal = enemies[i]; }
        }
        if (best <= 0.0f) return from;
        const float len = sqrt(best);
        const float step = AiMin(Global::HeavyWave::RallyOffset, len * 0.5f);
        return AIFloat3(from.x + (goal.x - from.x) / len * step, from.y, from.z + (goal.z - from.z) / len * step);
    }

    void Roll(CCircuitUnit@ g, const string &in side) {
        nextRoll = ai.frame + AiMax(1, Global::HeavyWave::RollIntervalSeconds) * SECOND;
        ++rolls;
        const int n = AiMax(1, late ? Global::HeavyWave::LateWaveSize : Global::HeavyWave::WaveSize);
        const float chance = Global::HeavyWave::RollChance;
        bool hit = chance >= 1.0f;
        if (!hit && chance > 0.0f) {
            const array<float> weights = {1.0f - chance, chance};
            hit = AiDice(weights) == 1;   // AiDice's rare -1 counts as a miss (KI-628)
        }
        GenericHelpers::LogUtil(Tag() + "roll " + rolls + (hit ? " HIT" : " miss") + " (" + int(chance * 100.0f) + "%, "
            + (late ? "late " : "") + "size " + n + ") at gantry " + g.circuitDef.GetName() + " " + g.id
            + " t=" + (ai.frame / SECOND) + " s; next roll at " + (nextRoll / SECOND) + " s", 1);
        if (!hit) return;
        unitName = HeavyName(side);
        CCircuitDef@ def = ai.GetCircuitDef(unitName);
        if (def is null || !g.circuitDef.CanBuild(def) || def.power <= 0.0f) {
            GenericHelpers::LogUtil(Tag() + "roll hit but " + g.circuitDef.GetName() + " cannot build '" + unitName + "'", 1);
            return;
        }
        ++waves;
        active = true;
        gantryId = g.id; defId = def.id; unitPower = def.power;
        size = n; ordered = 0; expected = n; admitted = 0;
        started = ai.frame;
        deadline = started + n * AiMax(1, Global::HeavyWave::GatherSecondsPerUnit) * SECOND;
        rally = RallyFor(g);
        @gather = null;
        recruits.resize(0); members.resize(0); departed.resize(0);
        GenericHelpers::LogUtil(Tag() + "wave " + waves + " hold: " + n + " x " + unitName + " back to back at gantry "
            + g.id + ", rally (" + int(rally.x) + "," + int(rally.z) + "), deadline " + (deadline / SECOND) + " s", 1);
    }

    // Called by the TECH and FRONT gantry policies before their rotation; null = rotate as usual
    IUnitTask@ Produce(CCircuitUnit@ g, const string &in side) {
        if (!Enabled() || g is null || g.circuitDef is null) return null;
        if (!UnitHelpers::IsGantryLab(g.circuitDef.GetName()) || g.GetBuildProgress() < 1.0f) return null;
        UpdateLate();
        if (active && gather is null && admitted == 0 && ai.frame >= deadline) Close("deadline with no unit out");
        if (!active && nextRoll >= 0 && ai.frame >= nextRoll) Roll(g, side);
        if (!active || g.id != gantryId || ordered >= size) return null;
        array<string> one = {unitName};
        IUnitTask@ task = Factory::EnqueueGantryBatchFrom(g, one, 1, Task::Priority::HIGH);
        if (task is null) {
            // capped or unavailable: the wave is what was already placed
            GenericHelpers::LogUtil(Tag() + "wave " + waves + ": '" + unitName + "' unavailable, wave cut to " + ordered, 1);
            size = ordered; expected = AiMin(expected, ordered);
            if (ordered == 0) Close("no unit buildable");
            else RefreshPower();
            return null;
        }
        recruits.insertLast(task);
        ++ordered;
        GenericHelpers::LogUtil(Tag() + "wave " + waves + " build " + ordered + "/" + size + " " + unitName
            + " at gantry " + g.id, 1);
        return task;
    }

    bool Admit(CCircuitUnit@ unit) {
        if (!active || unit is null || unit.circuitDef is null) return false;
        const int member = members.find(unit.id);
        if (member >= 0) return !departed[member];
        if (admitted >= size || unit.circuitDef.id != defId
            || unit.GetProducerId() != gantryId || unit.GetProductionFrame() < started) return false;
        members.insertLast(unit.id); departed.insertLast(false); ++admitted;
        GenericHelpers::LogUtil(Tag() + "wave " + waves + " held " + admitted + "/" + size + " " + unitName
            + " " + unit.id + " (alive " + Alive() + ")", 1);
        return true;
    }

    // Military UnitAdded: counts the first heavies, admits wave members. True = a held wave member.
    bool UnitAdded(CCircuitUnit@ unit) {
        if (!Enabled() || unit is null || unit.circuitDef is null) return false;
        if (unit.GetProducerId() >= 0 && unit.circuitDef.GetName() == HeavyName(Global::AISettings::Side)) {
            const bool member = members.find(unit.id) >= 0;
            if (!member) {
                ++heavies;
                if (nextRoll < 0 && heavies >= Global::HeavyWave::FirstHeavies) {
                    nextRoll = ai.frame;   // the next gantry ask rolls
                    GenericHelpers::LogUtil(Tag() + "heavy " + heavies + " (" + unit.circuitDef.GetName()
                        + ") out at t=" + (ai.frame / SECOND) + " s: wave rolls armed", 1);
                }
            }
        }
        return Admit(unit);
    }

    IUnitTask@ MilitaryTask(CCircuitUnit@ unit) {
        if (!active || unit is null) return null;
        const int member = members.find(unit.id);
        if (member < 0 || departed[member]) return null;
        if (gather !is null && gather.IsDead()) { Close("gather task gone"); return null; }
        if (gather is null) {
            const int until = AiMax(deadline, ai.frame + SECOND);
            @gather = aiMilitaryMgr.EnqueueGather(TaskF::Defend(Task::FightType::ATTACK, RequiredPower()), rally, until);
            if (gather is null) { Close("gather refused"); return null; }
        }
        return gather;
    }

    void UnitRemoved(CCircuitUnit@ unit) {
        if (!active || unit is null) return;
        const int member = members.find(unit.id);
        if (member < 0 || departed[member]) return;
        departed[member] = true;
        expected = AiMax(0, expected - 1);
        GenericHelpers::LogUtil(Tag() + "wave " + waves + " lost held " + unitName + " " + unit.id
            + " (alive " + Alive() + ", waiting for " + expected + ")", 1);
        RefreshPower();
    }

    void RecruitRemoved(IUnitTask@ task, bool done) {
        if (!active || task is null) return;
        for (uint i = 0; i < recruits.length(); ++i) {
            if (recruits[i] !is task) continue;
            recruits.removeAt(i);
            if (!done) ordered = AiMax(0, ordered - 1);   // the gantry places it again on its next ask
            return;
        }
    }

    void FactoryRemoved(CCircuitUnit@ unit) {
        if (!active || unit is null || unit.id != gantryId) return;
        // finished members still idle join the released squad (as FrontOpener)
        if (gather !is null && !gather.IsDead()) {
            for (uint i = 0; i < members.length(); ++i) {
                if (departed[i]) continue;
                CCircuitUnit@ m = ai.GetTeamUnit(members[i]);
                if (m !is null && m.task !is null && m.task.GetType() == Task::Type::IDLE)
                    aiMilitaryMgr.TransferUnit(m, gather);
            }
        }
        Close("gantry lost, survivors released");
    }

    void TaskRemoved(IUnitTask@ task, bool done) {
        if (!active || task is null || gather !is task) return;
        GenericHelpers::LogUtil(Tag() + "wave " + waves + (Alive() > 0 ? " LAUNCH: " : " gone before launch: ")
            + Alive() + " x " + unitName + " (built "
            + admitted + "/" + size + ") after " + ((ai.frame - started) / SECOND) + " s"
            + (ai.frame >= deadline ? " at the deadline" : ""), 1);
        @gather = null;   // native moved the units to the attack squad
        Close("launched");
    }

    void Load() {
        Close("reload");
    }
}  // namespace HeavyWave
