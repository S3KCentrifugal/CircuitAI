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
int main() {
    PlanTests();
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
