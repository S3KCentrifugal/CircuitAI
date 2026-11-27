// Production PaintWindow body, open terrain adapter. No routing policy is copied.
#include "circuit/terrain/AlliedReservations.h"
#include <iostream>
#include <map>
#include <set>
#include <vector>
namespace allied_layout = circuit::allied_layout;
struct int2 { int x, y; };
struct Point { float x=0, z=0; };
struct Ally { allied_layout::Reservations entries; auto& GetLayoutReservations() { return entries; } };
struct Circuit { Ally ally; int GetTeamId() const { return 0; } Ally* GetAllyTeam() { return &ally; } };
struct Terrain {
    struct Zone { int2 c1,c2; bool corridor=false; };
    struct Slot { int def=0; Point pos; int facing=0; };
    Circuit* circuit;
    std::map<int,Zone> zones;
    std::map<int,Slot> reservations;
    std::set<int> clearingZones;
    // This adapter supplies no local slots; real shared claims are used below.
    bool ReservationCells(int,Point,int,int2&,int2&) { return false; }
};
class CFactoryCorridors {
public:
    struct Route { std::vector<allied_layout::Rect> rectangles; };
    Terrain& terrain;
    int windowW=0,windowH=0;
    std::vector<std::uint8_t> blocked,reused,allyZones,allyExits;
    std::map<int,Route> routes;
    std::vector<allied_layout::Rect> road;
    bool CellOpen(int,int,int) { return true; } // deliberately all flat, open terrain
    void PaintWindow(const allied_layout::Rect&,int);
};
#include "clearing_corridor_body.inc"
int main() {
    int checks=0,failures=0;
    auto check=[&](bool ok,const char* name) {++checks;if(!ok){++failures;std::cerr<<name<<'\n';}};
    Circuit circuit; Terrain terrain{&circuit}; CFactoryCorridors corridors{terrain};
    terrain.zones[1]={{2,2},{5,5},false};
    circuit.ally.entries.Put(0,allied_layout::Reservations::COMMITTED_ZONE,1,{2,2,5,5});
    auto paint=[&](){corridors.PaintWindow({0,0,8,8},1);};
    auto at=[&](int x,int z){return corridors.blocked[z*8+x]!=0;};
    paint(); check(!at(3,3),"ordinary own district still permits a road");
    terrain.clearingZones.insert(1);
    paint(); check(at(3,3),"own clearing envelope blocks roads before early gun reservation");
    check(!at(5,3),"touching outer edge stays free");
    corridors.road.push_back({3,3,4,4});
    paint(); check(at(3,3)&&corridors.reused[3*8+3],"road reuse cannot erase clearing exclusion");
    terrain.clearingZones.erase(1);
    paint(); check(!at(3,3),"released clearing lease allows planning again");
    circuit.ally.entries.Put(1,allied_layout::Reservations::COMMITTED_ZONE,2,{1,1,2,2});
    circuit.ally.entries.Put(0,allied_layout::Reservations::TASK,1,{6,6,7,7});
    paint(); check(at(1,1),"foreign committed zone remains protected");
    check(at(6,6),"own ordinary task remains protected");
    std::cout<<checks<<" clearing corridor checks; "<<failures<<" failures\n";
    return failures!=0;
}
