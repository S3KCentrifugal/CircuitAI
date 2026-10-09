#include "circuit/terrain/LaneSolver.h"
#include "circuit/terrain/TerrainCorridor.h"
#include <iostream>
#include <limits>
#include <stdexcept>
#include <random>
#include <chrono>
using namespace circuit::lane;
static void Check(bool ok, const char* message) { if (!ok) throw std::runtime_error(message); }
// Frozen full-field point-query contract: the optimized query must return the
// identical ordered cell vector, including strict-cost ties and directed edges.
static std::vector<int> FullRoute(const Terrain& t, int origin, int goal, int cls,
        const Grid& threat, float land, float water, float weight, float ceiling,
        const std::vector<char>* obstacles = nullptr) {
    if (!t.pass[cls][origin] || !t.pass[cls][goal]) return {};
    Grid penalty(threat.size()), distance; std::vector<char> blocked(threat.size());
    for (size_t c=0;c<threat.size();++c) {
        float v=std::isfinite(threat[c]) ? std::max(0.f,threat[c]) : 1e9f;
        blocked[c]=(t.height[c]<0 && v>ceiling) || (obstacles && (*obstacles)[c]);
        penalty[c]=std::min(1e8f,(t.height[c]<0 ? water : land)+v*weight);
    }
    blocked[origin]=false; if(blocked[goal]) return {};
    std::vector<int> previous, result;
    Solver(t).DijkstraMulti({goal},penalty,cls,nullptr,distance,previous,true,0,&blocked);
    if(distance[origin]==std::numeric_limits<float>::max()) return {};
    for(size_t steps=0;steps<threat.size();++steps) {
        result.push_back(origin); if(origin==goal) return result;
        origin=previous[origin]; if(origin<0) break;
    }
    return {};
}
static void Differential() {
    Terrain t; t.gw=31;t.gh=23; const int n=t.gw*t.gh;
    t.height.resize(n);t.surfaceSlope.resize(n);t.body8.assign(n,0);t.edges.resize(n);
    for(auto& p:t.pass) p.resize(n);
    Grid threat(n); std::vector<char> obstacles(n); PointWorkspace ws;
    Grid joinDistance,fullDistance,uniform(n,1.f);
    std::vector<int> joinPrevious,fullPrevious; SearchWorkspace joinSearch;
    std::mt19937 rng(243);
    for(int fixture=0;fixture<80;++fixture) {
        for(int c=0;c<n;++c) {
            t.height[c]=int(rng()%400)-200;t.surfaceSlope[c]=(rng()%30)/100.f;
            t.edges[c]=fixture%2 ? static_cast<unsigned char>(rng()%256) : 255;
            threat[c]=(rng()%5)*.25f; obstacles[c]=rng()%23==0;
            for(auto& p:t.pass) p[c]=rng()%11!=0;
        }
        for(int k=0;k<70;++k) {
            int origin=rng()%n,goal=k%13==0 ? origin : rng()%n,cls=k%_LANE_CLASSES_;
            auto pos=[&](int c){return Point((c%t.gw+.5f)*64,0,(c/t.gw+.5f)*64);};
            float land=k%3+1.f,water=k%4+1.f,weight=k%2 ? 8.f : 0.f,ceiling=k%3*.5f;
            const auto* obs=k%2 ? &obstacles : nullptr;
            auto expected=FullRoute(t,origin,goal,cls,threat,land,water,weight,ceiling,obs);
            auto actual=Solver(t).PointRoute(pos(origin),pos(goal),cls,threat,land,water,weight,ceiling,obs,&ws,fixture+1);
            Check(actual==expected,"early-settle/cache differs from full-field oracle");
            Check(Solver(t).PointRoute(pos(origin),pos(goal),cls,threat,land,water,weight,ceiling,obs,&ws,fixture+1)==expected,"repeated cached route differs");
            // Lane joining uses the default preferShelf=true, uniform costs
            // and no blocked mask; compare its exact predecessor chain too.
            if (t.pass[cls][origin] && t.pass[cls][goal]) {
                Solver(t).DijkstraMulti({goal},uniform,cls,nullptr,fullDistance,fullPrevious);
                Solver(t).DijkstraMulti({goal},uniform,cls,nullptr,joinDistance,joinPrevious,
                    true,0,nullptr,0,true,nullptr,origin,&joinSearch);
                const bool reachable=fullDistance[origin]!=std::numeric_limits<float>::max();
                Check(reachable==(joinSearch.Seen(origin) && joinDistance[origin]!=std::numeric_limits<float>::max()),"lane join reachability");
                if (reachable) for (int c=origin;c>=0;c=fullPrevious[c]) {
                    Check(joinDistance[c]==fullDistance[c] && joinPrevious[c]==fullPrevious[c],"lane join ordered chain");
                    if(c==goal) break;
                }
            }
        }
    }
    // Generation wrap, changed dimensions, and an escaped blocked start must
    // not leave stale visited cells or mutate the next request's obstacles.
    ws.search.generation=std::numeric_limits<std::uint32_t>::max();
    ws.search.Begin(n); Check(ws.search.generation==1 && !ws.search.Seen(0),"generation wrap");
    ws.search.Begin(n+1);Check(!ws.search.Seen(n),"workspace resize");
    std::cout<<"5600 differential route cases (two executions each) passed\n";
}
int main() {
    Differential();
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
