#include "circuit/terrain/LaneSolver.h"
#include "circuit/terrain/TerrainCorridor.h"
#include <iostream>
#include <limits>
#include <stdexcept>
using namespace circuit::lane;
static void Check(bool ok, const char* message) { if (!ok) throw std::runtime_error(message); }
int main() {
    Terrain t; t.gw=20; t.gh=12;
    t.height.assign(240,-100); t.surfaceSlope.assign(240,0); t.body8.assign(240,0);
    for (auto& pass:t.pass) pass.assign(240,1);
    Grid threat(240,0);
    Point start(96,0,352), end(1184,0,352);
    for (int z=0;z<12;++z) { t.height[z*20+1]=20; t.height[z*20+18]=20; }
    auto route=Solver(t).PointRoute(start,end,L_AMPH,threat,2.5f,1,8,0);
    Check(!route.empty(),"quiet water crossing");
    for (int z=2;z<10;++z) threat[z*20+10]=100;
    route=Solver(t).PointRoute(start,end,L_AMPH,threat,2.5f,1,8,0);
    Check(!route.empty(),"route around submarine threat");
    for (int c:route) Check(threat[c]==0,"route enters known water threat");
    for (int z=0;z<12;++z) threat[z*20+10]=100;
    Check(Solver(t).PointRoute(start,end,L_AMPH,threat,2.5f,1,8,0).empty(),"fully guarded water must fail closed");
    threat.assign(240,0); t.pass[L_AMPH][5*20+1]=0;
    Check(Solver(t).PointRoute(start,end,L_AMPH,threat,1,1,0,0).empty(),"no snapping blocked origin");
    t.pass[L_AMPH][5*20+1]=1;
    Check(Solver(t).PointRoute({-1,0,0},end,L_AMPH,threat,1,1,0,0).empty(),"invalid endpoint");
    Check(Solver(t).PointRoute(start,end,L_AMPH,threat,1,1,0,std::numeric_limits<float>::quiet_NaN()).empty(),"invalid threshold");
    t.height.assign(240,10);
    Check(!Solver(t).PointRoute(start,end,L_AMPH,threat,1,1,0,0).empty(),"dry map raid remains valid");
    // A narrow cliff between otherwise passable cell centres must reject the edge.
    auto flat=[](float,float){return 10.f;};
    auto cliff=[](float x,float){return x>=28 && x<=36 ? 0.9f : 0.f;};
    Check(!TerrainCorridor(0,32,64,32,0,.412f,10000,false,flat,cliff),"fine cliff not hidden by valid endpoints");
    Check(TerrainCorridor(64,32,128,32,0,.412f,10000,false,flat,cliff),"flat corridor remains valid");
    Check(!TerrainCorridor(0,32,64,32,0,.412f,10000,false,[](float,float){return -100.f;},cliff),"seabed cliffs use loaded slope limit too");
    Check(!TerrainCorridor(16,32,16,32,24,.412f,10000,false,flat,cliff),"check footprint interior, not only corners");
    auto shore=[](float x,float){return x<32 ? -10.f : 10.f;};
    Check(!TerrainCorridor(16,32,64,32,8,.412f,10000,true,shore,[](float,float){return 0.f;}),"dry corridor cannot wade");
    // Forced edge wall with one ramp, including diagonal attempts.
    t.edges.assign(240,255);
    for (int z=0;z<11;++z) { t.edges[z*20+9]&=~(1|16|32);t.edges[z*20+10]&=~(2|64|128); }
    route=Solver(t).PointRoute(start,end,L_AMPH,threat,1,1,0,0);
    Check(!route.empty(),"reachable ramp");
    bool ramp=false;for (int c:route) if (c/20==11) ramp=true;
    Check(ramp,"route must use ramp rather than cliff edge");
    t.edges.clear(); t.height.assign(240,10);
    for (int z=1;z<11;++z) for (int x=6;x<14;++x) t.height[z*20+x]=-10;
    route=Solver(t).PointRoute(start,end,L_AMPH,threat,1,6,0,0);
    for (int c:route) Check(t.height[c]>=0,"land preferred over short water shortcut");
    route=Solver(t).PointRoute(start,end,L_AMPH,threat,2.5f,1,0,0);
    bool water=false;for(int c:route) if(t.height[c]<0) water=true;
    Check(water,"legacy Marauder preference preserved");
    std::vector<char> obstacles(240,0);
    obstacles[5*20+10]=1;
    route=Solver(t).PointRoute(start,end,L_AMPH,threat,1,1,0,0,&obstacles);
    Check(!route.empty(),"route around an allied factory");
    for (int c:route) Check(!obstacles[c],"allied factory waypoint excluded");
    obstacles[5*20+18]=1;
    Check(Solver(t).PointRoute(start,end,L_AMPH,threat,1,1,0,0,&obstacles).empty(),"reject formation slot inside allied factory");
    std::cout << "18 terrain route scenarios passed\n";
}
