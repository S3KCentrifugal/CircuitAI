class AIFloat3 { float x=0,y=0,z=0; }
class CCircuitDef { float GetBuildDistance() {return 100;} }
class CCircuitUnit { CCircuitDef@ circuitDef; CCircuitUnit() {@circuitDef=CCircuitDef();} }
class Terrain {
    int preferred=7, fallback=9, calls=0, budget=0;
    bool buildable=true, reachable=true;
    int NextSlotAny(int group,const AIFloat3& in position) {return preferred;}
    bool IsReservationBuildable(int slot) {return buildable;}
    bool CanReachAtSafe(CCircuitUnit@ unit,const AIFloat3& in pos,float range) {return reachable;}
    AIFloat3 GetReservationPos(int slot) {return AIFloat3();}
    int NextReachableSlot(CCircuitUnit@ unit,CCircuitDef@ def,int zone,int group,int limit) {++calls;budget=limit;return fallback;}
}
Terrain aiTerrainMgr;
void Reset() {aiTerrainMgr.preferred=7;aiTerrainMgr.fallback=9;aiTerrainMgr.calls=0;aiTerrainMgr.buildable=true;aiTerrainMgr.reachable=true;}
void test_near_reserved_support_wins_without_connected_frontier_search() {
    Reset();CCircuitUnit worker;
    Check(SupportSites::Nearest(worker,worker.circuitDef,1,AIFloat3())==7);
    Check(aiTerrainMgr.calls==0);
}
void test_blocked_or_unreachable_support_uses_bounded_live_fallback() {
    Reset();CCircuitUnit worker;aiTerrainMgr.buildable=false;
    Check(SupportSites::Nearest(worker,worker.circuitDef,1,AIFloat3())==9);
    Check(aiTerrainMgr.calls==1 && aiTerrainMgr.budget==8);
    aiTerrainMgr.buildable=true;aiTerrainMgr.reachable=false;
    Check(SupportSites::Nearest(worker,worker.circuitDef,1,AIFloat3())==9);
    Check(aiTerrainMgr.calls==2);
    aiTerrainMgr.fallback=-1;
    Check(SupportSites::Nearest(worker,worker.circuitDef,1,AIFloat3())==-1);
}
void test_missing_support_inputs_do_not_search() {
    Reset();CCircuitUnit worker;
    Check(SupportSites::Nearest(null,worker.circuitDef,1,AIFloat3())==-1);
    Check(SupportSites::Nearest(worker,null,1,AIFloat3())==-1);
    Check(SupportSites::Nearest(worker,worker.circuitDef,0,AIFloat3())==-1);
    Check(aiTerrainMgr.calls==0);
}
void test_admission_rechecks_terrain_even_when_worker_can_reach() {
    Reset();CCircuitUnit worker;
    Check(SupportSites::Usable(worker,7));
    aiTerrainMgr.buildable=false;
    Check(!SupportSites::Usable(worker,7));
    Check(!SupportSites::Usable(null,7));
    aiTerrainMgr.buildable=true;aiTerrainMgr.reachable=false;
    Check(!SupportSites::Usable(worker,7));
    Check(SupportSites::Usable(null,7));
    Check(!SupportSites::Usable(worker,-1));
    aiTerrainMgr.reachable=true;
    Check(SupportSites::Usable(worker,7)); // obstruction cleared, no permanent blacklist
}
