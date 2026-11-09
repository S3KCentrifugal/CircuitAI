// One-shot read-only audit. Never included in deployed profiles.
namespace LayoutTerrainProbe {
    bool done=false;
    void Tick() {
        if(done || ai.teamId!=0 || !Layout::HasSpine()) return;
        done=true;
        const int last=Layout::labSlot>Layout::spineFusionSlot?Layout::labSlot:Layout::spineFusionSlot;
        int checked=0, blocked=0;
        // The startup spine and its service sites are allocated before this
        // final service ID. Inspect all still-unclaimed reservations, not the
        // enclosing rectangular zone, which deliberately contains terrain holes.
        for(int id=1;id<=last;++id) {
            if(aiTerrainMgr.GetReservationState(id)!=0) continue;
            ++checked;
            if(!aiTerrainMgr.IsReservationBuildable(id)) {
                ++blocked;
                const AIFloat3 p=aiTerrainMgr.GetReservationPos(id);
                AiLog("[LayoutTerrain] blocked slot="+id+" x="+p.x+" z="+p.z);
            }
        }
        AiLog("[LayoutTerrain] "+(checked>0 && blocked==0?"PASS":"FAIL")
            +" startup slots checked="+checked+" blocked="+blocked);
    }
}
