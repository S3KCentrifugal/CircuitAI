// D-488 (owner, 2026-11-07): FRONT and AIR replace any geo on a forward vent
// with the fortified geo (a Cortex T2 constructor builds the Cerberus), and
// reclaim the plant first when the new one does not stack on it. A vent is
// forward when the fortified geo, firing toward the nearest enemy start, reaches
// mid map or beyond. AIR serves the plateau vents only aircraft reach.
//
// Vents are judged once per match (starts are fixed) after the roster is in;
// the flags go to native (SetGeoForward), which the commander group and the
// swap of every geo order read. Native checks each vent (CheckGeoFortify:
// occupant, open orders, reach, threat, the engine site test over the standing
// plant). An ally's plant is never touched.
//
// Cost: while no job is open, one search every RetrySeconds per AI over the
// forward vents (tens), nearest first, one native check each and at most one
// order; a vent that fails is skipped RefusedSeconds. An open job is one task
// handle; joining it is one native check.
namespace ForwardGeo {
    // Engine codes of CEconomyManager::GeoFortify.
    const int READY = 0;
    const int BUILT = 1;
    const int ALLY = 2;
    const int UNREACHABLE = 3;
    const int BUSY = 4;
    const int REFUSED_PLANT = 5;
    const int REFUSED = 6;
    const int ENEMY = 8;
    // Seconds before the vents are judged: the ally roster is in by then.
    const int JudgeAfterSeconds = 30;

    bool judged = false;
    array<int> forward;        // spot indices of forward vents
    array<int> skipUntil;      // per spot index: frame a failed vent is tried again
    array<int> unbuilt;        // per spot index: build jobs that ended without the fortified geo
    array<CCircuitDef@> definitions;
    bool definitionsRead = false;
    IUnitTask@ job;
    int jobSpot = -1;
    bool jobReclaim = false;
    int next = 0;

    bool Enabled() {
        return Global::RoleSettings::ForwardGeo::Enabled
            && (Global::AISettings::Role == AiRole::FRONT || Global::AISettings::Role == AiRole::AIR);
    }

    float NearestDistance(const AIFloat3 &in p, const array<AIFloat3> &in starts) {
        float best = 1e20f;
        for (uint i = 0; i < starts.length(); ++i) best = AiMin(best, p.distance2D(starts[i]));
        return best;
    }

    float Range() {
        CCircuitDef@ def = ai.GetCircuitDef(Global::RoleSettings::ForwardGeo::RangeDefinition);
        const float range = (def is null) ? 0.0f : aiBattle.MainRange(def);
        return (range > 0.0f) ? range : Global::RoleSettings::ForwardGeo::RangeFallback;
    }

    // Judges every vent once: forward when the point the fortified geo reaches,
    // toward the nearest enemy start, is at least as near the enemy as an ally.
    void Update() {
        if (!Enabled()) {
            // A role change away from FRONT and AIR withdraws the flags.
            if (judged) {
                for (uint i = 0; i < forward.length(); ++i) aiEconomyMgr.SetGeoForward(forward[i], false);
                forward.resize(0);
                judged = false;
                @job = null; jobSpot = -1;
            }
            return;
        }
        if (judged || ai.frame < JudgeAfterSeconds * SECOND) return;
        array<AIFloat3> ours = Lanes::AllyStarts();
        array<AIFloat3> theirs = Lanes::EnemyStarts();
        if (ours.length() == 0 || theirs.length() == 0) return;  // asked again next call
        judged = true;
        const float range = Range();
        const float ratio = Global::RoleSettings::ForwardGeo::MidRatio;
        const int count = ai.GetGeoSpotCount();
        skipUntil.resize(count);
        unbuilt.resize(count);
        for (int i = 0; i < count; ++i) {
            const AIFloat3 vent = ai.GetGeoSpot(i);
            AIFloat3 target = vent;
            float enemy = 1e20f;
            for (uint j = 0; j < theirs.length(); ++j) {
                const float d = vent.distance2D(theirs[j]);
                if (d < enemy) { enemy = d; target = theirs[j]; }
            }
            AIFloat3 reach = vent;
            if (enemy > 1.0f) {
                const float step = AiMin(range, enemy) / enemy;
                reach = AIFloat3(vent.x + (target.x - vent.x) * step, vent.y, vent.z + (target.z - vent.z) * step);
            }
            const float a = NearestDistance(reach, ours), e = NearestDistance(reach, theirs);
            // A vent inside an enemy base is theirs, not a front (natural Glitters, b44:
            // five south AIs sent a T2 constructor to the north team's base vent).
            const bool base = enemy < Global::RoleSettings::ForwardGeo::EnemyBaseRadius;
            const bool on = !base && a >= e * ratio;
            aiEconomyMgr.SetGeoForward(i, on);
            if (on) forward.insertLast(i);
            GenericHelpers::LogUtil("[ForwardGeo] vent " + i + " at " + int(vent.x) + "," + int(vent.z)
                + (on ? " FORWARD" : (base ? " enemy-base" : " back")) + " reach " + int(reach.x) + "," + int(reach.z)
                + " ally " + int(a) + " enemy " + int(e) + " range " + int(range), 1);
        }
    }

    CCircuitDef@ DefinitionFor(CCircuitUnit@ worker) {
        if (!definitionsRead) {
            definitionsRead = true;
            array<string>@ names = Global::RoleSettings::ForwardGeo::Definitions.split(",");
            for (uint i = 0; i < names.length(); ++i) {
                CCircuitDef@ def = ai.GetCircuitDef(names[i]);
                if (def !is null) definitions.insertLast(def);
            }
        }
        for (uint i = 0; i < definitions.length(); ++i) {
            CCircuitDef@ def = definitions[i];
            if (worker.circuitDef.CanBuild(def) && def.IsBuildAllowed() && def.IsAvailable(ai.frame)) return def;
        }
        return null;
    }

    // A fortified geo is never reclaimed for another (by id).
    bool Fortified(const CCircuitDef@ def) {
        for (uint i = 0; i < definitions.length(); ++i) if (definitions[i].id == def.id) return true;
        return false;
    }

    IUnitTask@ Open(IUnitTask@ task, int spot, bool reclaim) {
        if (task is null) return null;
        @job = task; jobSpot = spot; jobReclaim = reclaim;
        return task;
    }

    // A job ended. A build that left no fortified geo counts against its vent;
    // at UnbuiltLimit the vent waits UnbuiltSeconds (natural Forge, b45: one
    // contested mid vent ordered five times by one AI as each frame died).
    void Close(CCircuitUnit@ worker, CCircuitDef@ def) {
        const int spot = jobSpot;
        const bool reclaim = jobReclaim;
        @job = null; jobSpot = -1; jobReclaim = false;
        if (spot < 0 || reclaim) return;
        const bool built = aiEconomyMgr.GeoFortifyState(worker, def, spot, Global::RoleSettings::ForwardGeo::MaxThreat) == BUILT;
        if (built) unbuilt[spot] = 0;
        else if (++unbuilt[spot] >= Global::RoleSettings::ForwardGeo::UnbuiltLimit) {
            unbuilt[spot] = 0;
            skipUntil[spot] = ai.frame + int(Global::RoleSettings::ForwardGeo::UnbuiltSeconds * SECOND);
        }
        const AIFloat3 vent = ai.GetGeoSpot(spot);
        GenericHelpers::LogUtil("[ForwardGeo] job_end vent " + spot + " at " + int(vent.x) + "," + int(vent.z)
            + " built=" + (built ? 1 : 0) + " unbuilt=" + unbuilt[spot], 1);
    }

    IUnitTask@ Work(CCircuitUnit@ worker) {
        if (worker is null || !Enabled() || !worker.circuitDef.IsMobile()) return null;
        Update();
        if (forward.length() == 0) return null;
        CCircuitDef@ def = DefinitionFor(worker);
        if (def is null) return null;  // no constructor here builds a fortified geo
        if (job !is null && job.IsDead()) Close(worker, def);
        const float maxThreat = Global::RoleSettings::ForwardGeo::MaxThreat;
        if (job !is null) {
            if (worker.task is job) return job;
            const float join = Global::RoleSettings::ForwardGeo::JoinDistance;
            if (jobReclaim || MapHelpers::SqDist(worker.GetPos(ai.frame), ai.GetGeoSpot(jobSpot)) > join * join) return null;
            return aiEconomyMgr.EnqueueFortifiedGeo(worker, def, jobSpot, maxThreat);  // the open order, when it can join
        }
        if (ai.frame < next) return null;
        next = ai.frame + int(Global::RoleSettings::ForwardGeo::RetrySeconds * SECOND);
        if (Economy::GetMinMetalIncomeLast10s() < Global::RoleSettings::ForwardGeo::MinMetalIncome) return null;
        // Nearest forward vent first (insertion order over tens of vents).
        const AIFloat3 from = worker.GetPos(ai.frame);
        array<int> order;
        array<float> distance;
        for (uint i = 0; i < forward.length(); ++i) {
            const int spot = forward[i];
            if (ai.frame < skipUntil[spot]) continue;
            const float d = MapHelpers::SqDist(from, ai.GetGeoSpot(spot));
            uint at = order.length();
            while (at > 0 && distance[at - 1] > d) --at;
            order.insertAt(at, spot);
            distance.insertAt(at, d);
        }
        const int refused = ai.frame + int(Global::RoleSettings::ForwardGeo::RefusedSeconds * SECOND);
        for (uint i = 0; i < order.length(); ++i) {
            const int spot = order[i];
            const int state = aiEconomyMgr.GeoFortifyState(worker, def, spot, maxThreat);
            const AIFloat3 vent = ai.GetGeoSpot(spot);
            if (state == READY) {
                IUnitTask@ task = aiEconomyMgr.EnqueueFortifiedGeo(worker, def, spot, maxThreat);
                if (task !is null) {
                    GenericHelpers::LogUtil("[ForwardGeo] build worker " + worker.id + " def " + def.GetName()
                        + " vent " + spot + " at " + int(vent.x) + "," + int(vent.z), 1);
                    return Open(task, spot, false);
                }
            }
            if (state == REFUSED_PLANT && Global::RoleSettings::ForwardGeo::Reclaim) {
                CCircuitUnit@ plant = aiEconomyMgr.OwnGeoAt(spot);
                if (plant !is null && !Fortified(plant.circuitDef) && aiEconomyMgr.CanSpareGeo(plant)) {
                    IUnitTask@ task = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::HIGH, plant,
                        Global::RoleSettings::ForwardGeo::ReclaimSeconds * SECOND));
                    if (task !is null) {
                        GenericHelpers::LogUtil("[ForwardGeo] reclaim worker " + worker.id + " plant " + plant.circuitDef.GetName()
                            + " vent " + spot + " at " + int(vent.x) + "," + int(vent.z) + " for " + def.GetName(), 1);
                        return Open(task, spot, true);
                    }
                }
            }
            // A vent this worker cannot serve now (threat, reach, an open order)
            // stays in the next search; a refused, built or allied one waits.
            if (state != UNREACHABLE && state != BUSY) {
                skipUntil[spot] = refused;
                if (state == REFUSED || state == REFUSED_PLANT)
                    GenericHelpers::LogUtil("[ForwardGeo] refused def " + def.GetName() + " vent " + spot
                        + " at " + int(vent.x) + "," + int(vent.z) + " plant=" + (state == REFUSED_PLANT ? 1 : 0), 1);
            }
        }
        return null;
    }
}
