// Real method bodies, narrow engine adapter. This catches the candidate-04 bug
// where retry restoration deleted a transient reservation before reusing it.
#include <cassert>
#include <iostream>
#include <map>
#include <string>

struct Point { float x=0, z=0; Point operator-() const { return {-x,-z}; } };
const Point RgtVector{1,1};
namespace geom { bool is_valid(Point p) { return p.x >= 0; } }
struct int2 { int x=0, y=0; };
struct Definition {
    float GetExtractsM() const { return 0; }
    Definition* GetDef() { return this; }
    const char* GetName() const { return "radar"; }
};
struct SReservation {
    int id=1, zone=0, facing=0, unitId=0;
    bool consumed=false, claimed=true;
    Definition* def=nullptr;
    Point pos;
};
namespace allied_layout { struct Reservations { enum { SLOT }; }; }
struct Claims { void Erase(int,int,int) {} void EraseSlot(int) {} };
struct Ally { Claims claims; Claims& GetLayoutReservations() { return claims; } };
struct Economy { bool IsMetalMap() const { return false; } };
class CTerrainManager;
struct Circuit {
    CTerrainManager* terrain;
    Economy economy;
    Ally ally;
    CTerrainManager* GetTerrainManager() { return terrain; }
    Economy* GetEconomyManager() { return &economy; }
    Ally* GetAllyTeam() { return &ally; }
    int GetTeamId() const { return 0; }
    template<class... T> void LOG(const char*, T...) {}
};
class CTerrainManager {
public:
    Circuit* circuit;
    std::map<int,SReservation> reservations;
    std::map<std::string,int> layoutInts;
    Claims localReservations;
    unsigned packingRevision=0;
    bool free=true;
    int GetLayoutInt(const std::string& key,int fallback) const {
        auto it=layoutInts.find(key); return it==layoutInts.end()?fallback:it->second;
    }
    bool ReservationCells(Definition*,Point,int,int2&,int2&) { return true; }
    bool IsSlotFree(int2,int2,int,int) { return free; }
    void MarkReservation(int2,int2,bool) {}
    void UnmarkSlot(int2,int2) {}
    void ShareSlot(int) {}
    void EraseReservation(int id) {
        reservations.erase(id); layoutInts.erase("native.transient."+std::to_string(id));
    }
    void ReleaseReservation(int);
    void RestoreReservation(int);
    void UnclaimReservation(int);
};
struct Manager { Circuit* circuit; Circuit* GetCircuit() { return circuit; } };
class IBuilderTask {
public:
    Manager* manager;
    void* target=nullptr;
    Point buildPos;
    int reservationId=-1, pinnedReservation=-1;
    bool pinRequired=true;
    void SetBuildPos(Point p) { buildPos=p; }
    void Cancel();
};

#include "reservation_lifecycle_bodies.inc"

int main() {
    Definition definition;
    CTerrainManager terrain;
    Circuit circuit{&terrain,{}, {}}; terrain.circuit=&circuit;
    Manager manager{&circuit};
    auto setup = [&](bool transient,bool consumed) {
        terrain.reservations.clear(); terrain.layoutInts.clear(); terrain.free=true;
        SReservation slot; slot.def=&definition; slot.consumed=consumed;
        terrain.reservations.emplace(1,slot);
        if(transient) terrain.layoutInts["native.transient.1"]=1;
        slot.id=2; terrain.reservations.emplace(2,slot); // unrelated claim
    };
    for(bool transient : {true,false}) for(bool consumed : {true,false}) {
        setup(transient,consumed);
        terrain.RestoreReservation(1);
        assert(terrain.reservations.count(1)==1); // retry keeps the exact ID
        assert(!terrain.reservations.at(1).consumed);
        assert(terrain.reservations.count(2)==1);
        // Repeat restores must not delete a still-live task's footprint.
        terrain.RestoreReservation(1);
        assert(terrain.reservations.count(1)==1);
        IBuilderTask task; task.manager=&manager; task.reservationId=1;
        task.pinnedReservation=1;
        task.Cancel();
        assert(task.reservationId==-1);
        assert(terrain.reservations.count(1)==(transient?0:1));
        assert(terrain.reservations.count(2)==1);
        if(!transient) assert(!terrain.reservations.at(1).claimed);
        // Never-served pinned cancellation uses the other Cancel branch.
        setup(transient,false); task.reservationId=-1; task.Cancel();
        assert(terrain.reservations.count(1)==(transient?0:1));
        // A real frame owns its consumed footprint; cancellation leaves it.
        setup(transient,true); task.target=&definition; task.reservationId=1;
        task.Cancel(); assert(terrain.reservations.count(1)==1);
        // Occupied geometry cannot be restored even for persistent slots.
        setup(transient,true); terrain.free=false; terrain.RestoreReservation(1);
        assert(terrain.reservations.count(1)==0 && terrain.reservations.count(2)==1);
    }
    std::cout << "reservation lifecycle: retry, cancellation, occupied and framed cases passed\n";
}
