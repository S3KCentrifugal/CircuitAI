#include "circuit/terrain/LaneSolver.h"
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
    std::cout << "7 terrain route scenarios passed\n";
}
