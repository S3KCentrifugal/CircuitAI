#include "control/kernel/CommanderJammerCoverage.h"
#include "control/kernel/CommanderJammerPlan.h"
#include "control/kernel/DefenseClaims.h"
#include <cassert>
#include <iostream>
using namespace circuit::commander;
static JammerPlan Demand() {
    JammerPlan p;p.enabled=true;p.persistent=true;p.radius=500;
    p.probes[0]={{0,0},3,true};p.probes[1]={{0,-300},2,true};
    p.probes[2]={{0,300},2,false};return p;
}
static void PlanTests() {
    assert(JammerPlan{}.Allows({0,0})); // unrelated builders retain their policy
    auto p=Demand();p.Prepare();assert(p.Allows({0,0}));assert(p.Gain({0,0})==1);
    p.infrastructure={{{0,0},500}};p.Prepare();assert(!p.Allows({0,0}));
    // A different tier alone does not justify a duplicate.
    p.radius=760;assert(!p.Allows({0,0}));
    // A larger radius can fill a real forward gap while sharing an old center.
    p.probes[2]={{0,650},2,false};p.Prepare();assert(p.Allows({0,0}));
    // Critical gaps override minimum gain and soft spacing, never containment.
    p=Demand();p.minimumGain=1;p.infrastructure={{{0,400},500}};p.Prepare();
    assert(p.CriticalGap({0,-300}));assert(p.Allows({0,-300}));
    assert(p.Score({0,-300})>p.Score({0,400}));
    p.persistent=false;assert(!p.Allows({0,-300}));
    // Unequal radii and union coverage: no buried gap, no redundant upgrade.
    p=Demand();p.infrastructure={{{0,-300},360},{{0,300},700}};p.Prepare();assert(!p.Allows({0,0}));
    // Long outage opens ONLY critical replacement demand, not routine infill.
    p=Demand();p.unavailable={{{0,0},700}};p.Prepare();assert(p.probes[0].missing);assert(!p.probes[2].missing);
    JammerOutage outage;
    assert(outage.Reserve(false,false,1,0,1800));
    assert(outage.Reserve(false,false,1,1799,1800));
    assert(!outage.Reserve(false,false,1,1800,1800));
    assert(outage.Reserve(true,false,1,1801,1800));
    assert(outage.Reserve(false,false,2,4000,1800)); // reused ID/new definition
    assert(outage.Reserve(false,true,2,8000,1800)); // construction is a reservation
    JammerDemandMemory memory;
    assert(!memory.Stable({0,0},0,300,128));
    assert(!memory.Stable({0,0},299,300,128));assert(memory.Stable({0,0},300,300,128));
    assert(!memory.Stable({0,200},301,300,128)); // advancing or retreating resets demand
    assert(memory.Stable({0,200},601,300,128));
    // Shared task ledger: accepted intent, relocation, frame handoff, cancellation,
    // owner removal and expiry. Own retry excludes itself in the adapter.
    circuit::defense::Claims claims;int token=0;
    claims.Upsert(1,token,{7,-1,1000,0,0,500,100,0});
    auto planned=[&]() {auto q=Demand();claims.Nearby(0,0,100,0,[&](int owner,const circuit::defense::Claim& c) {
        if(owner!=2 && c.frameId<0) q.infrastructure.push_back({{c.x,c.z},c.radius});
    });q.Prepare();return q;};
    assert(!planned().Allows({0,0}));
    claims.Upsert(1,token,{7,-1,1000,3000,0,500,100,0});assert(planned().Allows({0,0}));
    claims.Upsert(1,token,{7,42,1000,0,0,500,100,0});assert(planned().Allows({0,0}));
    claims.Erase(1,token);assert(planned().Allows({0,0}));
    claims.Upsert(1,token,{7,-1,1000,0,0,500,100,0});claims.RemoveOwner(1);assert(planned().Allows({0,0}));
    claims.Upsert(1,token,{7,-1,1,0,0,500,100,0});
    int remaining=0;claims.Nearby(0,0,100,2,[&](int,const circuit::defense::Claim&) {++remaining;});assert(remaining==0);
}
// KI-756: an independent copy of Recoil's MidpointCircleAlgoPerLine and
// CLosMap::AddCircle (rts/Sim/Misc/LosMap.cpp), filling a grid of cells.
static std::vector<char> EngineFill(int radius,int size,int base) {
    std::vector<char> grid(size_t(size*size),0);
    auto func=[&](int width,int y) {
        const int row=base+y;
        if(row<0 || row>=size) return;
        for(int x=std::max(0,base-width);x<std::min(size,base+width+1);++x) grid[size_t(row*size+x)]=1;
    };
    int x=radius,y=0,d=1-x;
    while(x>=y) {
        func(x,y); if(y!=0) func(x,-y);
        if(d<=0) { y++;d+=2*y+1; }
        else { if(x!=y) { func(y,x); if(x!=0) func(y,-x); } y++;x--;d+=2*(y-x)+1; }
    }
    return grid;
}
static void JamCellTests() {
    constexpr int square=8,mip=2,cell=32;
    const JamCells cells(square,mip,760);
    assert(cells.Valid() && cells.CellSize()==cell);
    // Engine truncation: Castro 360, Sneaky Pete 500, Veil 760 -> 11, 15, 23.
    assert(cells.Radius(360)==11 && cells.Radius(500)==15 && cells.Radius(760)==23);
    assert(cells.Radius(0)==0 && cells.Radius(-5)==0 && !JamCells().Valid());
    // Rows equal the engine's filled cells for every radius up to Veil's.
    for(int r=1;r<=23;++r) {
        const int size=2*r+5,base=r+2;
        const auto grid=EngineFill(r,size,base);
        const JamCell jammer{base,base};
        for(int z=0;z<size;++z) for(int x=0;x<size;++x) {
            const Point p{(x+.5f)*cell,(z+.5f)*cell};
            assert(cells.Covers(jammer,r,false,p)==bool(grid[size_t(z*size+x)]));
        }
    }
    // Engine bounds over every in-cell jammer offset and direction: never
    // jammed beyond the cell reach, always jammed inside the certain radius.
    struct Bound { int radius; float certain,never; };
    // Measured by the same sweep: certain within 333/453/712, never past 407/528/788.
    for(const auto& b:{Bound{360,330,410},Bound{500,450,532},Bound{760,708,792}}) {
        const int r=cells.Radius(b.radius);
        int insetMisses=0,insetTests=0;
        for(float ox=0;ox<cell;ox+=4) for(float oz=0;oz<cell;oz+=4) {
            const Point center{3200+ox,3200+oz};
            const JamCell jammer=cells.CellOf(center);
            for(int deg=0;deg<360;deg+=3) {
                const Point dir{std::cos(deg*.0174533f),std::sin(deg*.0174533f)};
                assert(cells.Covers(jammer,r,false,center+dir*b.certain));
                assert(!cells.Covers(jammer,r,false,center+dir*b.never));
                ++insetTests;
                if(!cells.Covers(jammer,r,false,center+dir*(b.radius-4.f))) ++insetMisses;
            }
        }
        // The old 4-elmo inset is outside real coverage a good share of the time.
        assert(insetMisses*20>insetTests);
    }
    // A mobile jammer's engine centre may sit one cell over: coverage then
    // holds only where every neighbouring centre covers the point.
    const Point center{3216,3216};
    const JamCell jammer=cells.CellOf(center);
    const int r=cells.Radius(500);
    for(int z=-r-2;z<=r+2;++z) for(int x=-r-2;x<=r+2;++x) {
        const Point p=center+Point{float(x*cell),float(z*cell)};
        bool all=true;
        for(int sz=-1;sz<=1;++sz) for(int sx=-1;sx<=1;++sx)
            all=all && cells.Covers({jammer.x+sx,jammer.z+sz},r,false,p);
        assert(cells.Covers(jammer,r,true,p)==all);
    }
    assert(cells.Covers(jammer,r,false,center+Point{float(r*cell),0}));
    assert(!cells.Covers(jammer,r,true,center+Point{float(r*cell),0}));
    // Firing points: inside the engine's cells with half a cell to spare, as far
    // out towards the target as that allows, on the jammer-to-target ray.
    for(bool mobile:{false,true}) for(int deg=0;deg<360;deg+=7) {
        const Point dir{std::cos(deg*.0174533f),std::sin(deg*.0174533f)};
        Point at;
        assert(cells.FiringPoint(center,jammer,r,mobile,500,0,center+dir*900,16,16,at));
        for(float dz=-16;dz<=16;dz+=4) for(float dx=-16;dx<=16;dx+=4)
            assert(cells.Covers(jammer,r,mobile,at+Point{dx,dz}));
        const float reach=Length(at-center);
        assert(reach>(mobile?380.f:420.f) && reach<=500);
        assert(Length(at-(center+dir*reach))<.5f);
    }
    // A target inside coverage is the firing point itself; no jam, no point.
    Point at;
    assert(cells.FiringPoint(center,jammer,r,false,500,40,center+Point{100,0},16,16,at));
    assert(Length(at-(center+Point{100,0}))<.01f);
    assert(!cells.FiringPoint(center,jammer,0,false,500,0,center+Point{900,0},16,16,at));
    assert(!cells.FiringPoint(center,jammer,r,false,500,0,center+Point{900,0},16,0,at));
    std::cout<<"jam cell tests passed\n";
}
int main() {
    PlanTests();
    JamCellTests();
    assert(JammerCoverage().NearUnjammed({0,0},100));
    JammerCoverage single({{{0,0},500}});
    assert(!single.NearUnjammed({399,0},100));
    assert(single.NearUnjammed({400,0},100));
    assert(single.NearUnjammed({500,0},0));
    assert(single.NearUnjammed({800,0},100));
    JammerCoverage duplicate({{{0,0},500},{{0,0},500},{{0,0},200}});
    assert(!duplicate.NearUnjammed({399,0},100));
    assert(duplicate.NearUnjammed({400,0},100));
    // The individual circle boundaries at x=0 are buried in the union. A
    // nearest-circle-edge rule would wrongly permit another central jammer.
    JammerCoverage overlap({{{-200,0},500},{{200,0},500}});
    assert(!overlap.NearUnjammed({280,0},100));
    assert(!overlap.NearUnjammed({0,350},100));
    assert(overlap.NearUnjammed({0,370},100));
    assert(overlap.NearUnjammed({610,0},100));
    JammerCoverage asymmetric({{{0,0},500},{{450,0},250}});
    assert(!asymmetric.NearUnjammed({450,0},100));
    assert(asymmetric.NearUnjammed({620,0},100));
    // Internal unjammed holes count too, unlike a convex hull of coverage.
    JammerCoverage hole({{{-110,0},100},{{110,0},100},{{0,110},100},{{0,-110},100}});
    assert(hole.NearUnjammed({0,0},10));
    assert(hole.NearUnjammed({15,0},10));
    std::cout<<"commander_jammer_coverage_test passed\n";
}
