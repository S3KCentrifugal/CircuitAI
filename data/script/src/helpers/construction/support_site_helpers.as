// Prerequisite support must cover the requesting site, not extend old rows.
namespace SupportSites {
    // Revalidate admission before requesting prerequisites or issuing an order.
    // Engine terrain/occupancy may have changed since startup; do not cache it
    // or permanently discard a slot blocked only by a temporary occupant.
    bool Usable(CCircuitUnit@ worker, int slot) {
        return slot>=0 && aiTerrainMgr.IsReservationBuildable(slot)
            && (worker is null || aiTerrainMgr.CanReachAtSafe(worker,
                aiTerrainMgr.GetReservationPos(slot),worker.circuitDef.GetBuildDistance()));
    }
    int Nearest(CCircuitUnit@ worker, CCircuitDef@ def, int group, const AIFloat3& in position) {
        if(worker is null || def is null || group<=0) return -1;
        // Existing indexed selection; no new cache. Live reach/buildability
        // invalidates the preferred choice. At most eight fallback admissions.
        const int slot=aiTerrainMgr.NextSlotAny(group,position);
        if(Usable(worker,slot)) return slot;
        return aiTerrainMgr.NextReachableSlot(worker,def,0,group,8);
    }
}
