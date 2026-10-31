#include "../../helpers/math/production_math.as"

namespace AirReclaim {
    class Job {
        int target = -1;
        int slot = -1;
        IUnitTask@ task;
    }
    array<Job@> jobs;

    void Tick()
    {
        for (int i = int(jobs.length()) - 1; i >= 0; --i) {
            if (ai.GetTeamUnit(jobs[i].target) is null) {
                if (jobs[i].slot >= 0) aiTerrainMgr.ReleasePersistentBuilding(jobs[i].slot);
                jobs.removeAt(i);
            } else if (jobs[i].task is null || jobs[i].task.IsDead()) jobs.removeAt(i);
        }
    }
    bool Allowed()
    {
        return AirEconomy::HasReactor() && !AirEconomy::recovery && !aiEconomyMgr.isEnergyStalling;
    }
    float Output(CCircuitUnit@ unit) {
        const string name=unit.circuitDef.GetName();
        const string side=UnitHelpers::GetSideForUnitName(name);
        if(name==UnitHelpers::GetWindNameForSide(side))
            return AiMax(0.0f,AiMin(25.0f,(ai.GetWindMin()+ai.GetWindMax())*0.5f));
        return aiEconomyMgr.GetEnergyMake(unit.circuitDef);
    }
    bool CandidateFits(CCircuitUnit@ unit, float pendingOutput, float pendingRefund) {
        return AirMath::EnergyRetirementFits(AirEconomy::energy,aiEconomyMgr.energy.pull,
            Output(unit),pendingOutput,Global::RoleSettings::Air::ReclaimEnergyMargin,
            aiEconomyMgr.metal.current,aiEconomyMgr.metal.storage,unit.circuitDef.costM,pendingRefund);
    }
    IUnitTask@ MakeTask(CCircuitUnit@ worker)
    {
        Tick();
        // Reuse one owned-ID snapshot; O(3N + J) for fixed three energy types,
        // J bounded cleanup jobs. Reserve output and refunds before another order.
        if (worker is null || !worker.circuitDef.IsMobile() || !Allowed()
            || jobs.length() >= uint(Global::RoleSettings::Air::ReclaimEnergyConcurrent)) return null;
        float pendingOutput=0.0f,pendingRefund=0.0f;
        for(uint j=0;j<jobs.length();++j) {
            CCircuitUnit@ target=ai.GetTeamUnit(jobs[j].target);
            if(target !is null) {pendingOutput+=Output(target);pendingRefund+=target.circuitDef.costM;}
        }
        const string side = Global::AISettings::Side;
        const array<string> names = {UnitHelpers::GetWindNameForSide(side), UnitHelpers::GetSolarNameForSide(side), UnitHelpers::GetAdvSolarNameForSide(side)};
        array<Id>@ ids = ai.GetOwnedUnitIds();
        for (uint tier = 0; tier < names.length(); ++tier) {

            CCircuitUnit@ best = null;
            float distance = Global::RoleSettings::Air::ReclaimEnergyRadius * Global::RoleSettings::Air::ReclaimEnergyRadius;
            for (uint i = 0; i < ids.length(); ++i) {
                CCircuitUnit@ u = ai.GetTeamUnit(ids[i]);
                if (u is null || u.GetBuildProgress() < 1.0f || u.circuitDef.GetName() != names[tier]) continue;
                bool pending = false;
                for (uint j = 0; j < jobs.length(); ++j) if (jobs[j].target == u.id) pending = true;
                if (pending || !CandidateFits(u,pendingOutput,pendingRefund) || !AirHome::EconomySite(u.GetPos(ai.frame))
                    || !aiTerrainMgr.CanReachAt(worker, u.GetPos(ai.frame), worker.circuitDef.GetBuildDistance())) continue;
                const float sq = MapHelpers::SqDist(worker.GetPos(ai.frame), u.GetPos(ai.frame));
                if (sq < distance) { @best = u; distance = sq; }
            }
            if (best is null) continue;
            IUnitTask@ task = aiBuilderMgr.Enqueue(TaskB::Reclaim(Task::Priority::NORMAL, best, 120 * SECOND));
            if (task is null) continue;
            Job job; job.target = best.id; @job.task = task;
            for (uint c = 0; c < AirLayout::windClusters.length(); ++c)
                for (uint s = 0; s < AirLayout::windClusters[c].slots.length(); ++s)
                    if (aiTerrainMgr.GetReservationUnit(AirLayout::windClusters[c].slots[s]) is best)
                        job.slot = AirLayout::windClusters[c].slots[s];
            jobs.insertLast(job);
            Lifecycle::Retire(best, "AIR low-tier energy replaced by completed reactor");
            if (!AirEconomy::HasReactor()) Invariants::Violation("INV-110", "AIR", "low-tier energy reclaim without completed reactor");
            GenericHelpers::LogUtil("[AIR][Reclaim] " + names[tier] + " id=" + best.id + " worker=" + worker.id, 1);
            return task;
        }
        return null;
    }
}
