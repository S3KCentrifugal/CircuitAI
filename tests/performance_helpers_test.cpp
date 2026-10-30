#include "control/kernel/DefenseClaims.h"
#include "control/service/CombatSnapshot.h"
#include "terrain/LanePath.h"
#include "terrain/LocalReservations.h"
#include "util/IdMembership.h"
#include <cassert>
#include <random>
#include <climits>
#include <iostream>
using namespace circuit;
int main() {
    IdMembership ids;
    for(int id:{-1,0,63,64,65535,65536,INT_MAX}) {ids.Add(id);ids.Add(id);assert(ids.Contains(id));}
    assert(!ids.Contains(65));ids.Clear();
    for(int id:{-1,0,63,64,65535,65536,INT_MAX}) assert(!ids.Contains(id));
    ids.Add(64);assert(ids.Contains(64));ids.Clear();
    std::mt19937 rng(42);
    defense::Claims indexed;std::map<std::pair<int,int>,defense::Claim> oracle;
    for(int step=0;step<10000;++step) {
        int owner=int(rng()%16),token=int(rng()%120);
        if(step%7==0) {indexed.RemoveOwner(owner);for(auto it=oracle.begin();it!=oracle.end();)it=it->first.first==owner?oracle.erase(it):std::next(it);}
        else if(step%5==0) {indexed.Erase(owner,token);oracle.erase({owner,token});}
        else {
            defense::Claim c{token,-1,step+int(rng()%100),float(int(rng()%30000)-15000),float(int(rng()%30000)-15000),float(rng()%5000)};
            indexed.Put(owner,token,c);oracle[{owner,token}]=c;
        }
        float x=float(int(rng()%30000)-15000),z=float(int(rng()%30000)-15000),r=float(rng()%1000);
        if(step%11==0)r=100000; // wide-query fallback
        std::vector<std::pair<int,int>> expected,actual;
        for(auto it=oracle.begin();it!=oracle.end();) {
            const auto& c=it->second;
            if(c.until<step){it=oracle.erase(it);continue;}
            if(std::hypot(x-c.x,z-c.z)<=r+c.radius)expected.emplace_back(it->first.first,c.def);
            ++it;
        }
        indexed.Nearby(x,z,r,step,[&](int o,const auto& c){actual.emplace_back(o,c.def);});assert(actual==expected);
    }
    // Random lane bends, cross-lane long range, remembered uncertainty and
    // clamped map-edge positions: accepted contacts must match in exact order.
    for(int run=0;run<80;++run) {
        lane::Path path;std::vector<lane::Point> points;
        for(int i=0;i<10;++i)points.push_back({float(rng()%10000),0,float(rng()%10000)});
        path.Set(points);auto lo=path.Lower(),hi=path.Upper();
        for(const auto& p:points)assert(p.x>=lo.x && p.x<=hi.x && p.z>=lo.z && p.z<=hi.z);
        CCombatSnapshot snapshot;snapshot.Reset(16384,16384);
        for(int i=0;i<800;++i) {
            CCombatSnapshot::Entry e;e.id=i;e.pos={float(int(rng()%22000)-2000),float(int(rng()%22000)-2000)};
            e.landRange=i%13==0?10000:float(rng()%1000);snapshot.Add(e);
        }
        std::vector<int> expected,actual;
        auto accept=[&](const auto& e){return path.Project({e.pos.x,0,e.pos.z}).distance<=300+e.landRange+664;};
        snapshot.Query({8192,8192},40000,[&](const auto& e){if(accept(e))expected.push_back(e.id);});
        snapshot.QueryInfluencing({lo.x,lo.z},{hi.x,hi.z},964,[&](const auto& e){if(accept(e))actual.push_back(e.id);});
        assert(actual==expected);
        snapshot.Reset(16384,16384);actual.clear();
        snapshot.QueryInfluencing({lo.x,lo.z},{hi.x,hi.z},964,[&](const auto& e){actual.push_back(e.id);});assert(actual.empty());
    }
    {
        CCombatSnapshot snapshot;snapshot.Reset(16384,16384);
        CCombatSnapshot::Entry local;local.id=1;local.pos={100,100};snapshot.Add(local);
        auto far=local;far.id=2;far.pos={15000,15000};snapshot.Add(far);
        auto artillery=far;artillery.id=3;artillery.pos={10000,100};artillery.landRange=12000;snapshot.Add(artillery);
        std::vector<int> seen;
        snapshot.QueryInfluencing({0,0},{200,200},964,[&](const auto& e){seen.push_back(e.id);});
        assert((seen==std::vector<int>{1,3}));
        snapshot.Reset(16384,16384);far.id=4;far.landRange=10;snapshot.Add(far);seen.clear();
        snapshot.QueryInfluencing({0,0},{200,200},964,[&](const auto& e){seen.push_back(e.id);});assert(seen.empty());
        snapshot.Reset(1024,1024);snapshot.Add(local);
        snapshot.QueryInfluencing({0,0},{200,200},964,[&](const auto& e){seen.push_back(e.id);});assert((seen==std::vector<int>{1}));
    }
    // Zone occupancy oracle, including overlaps, replacement and removal.
    local_layout::Reservations zones;std::map<int,local_layout::Reservations::Rect> rects;
    for(int i=0;i<2000;++i) {
        int id=rng()%30;
        if(i%4==0){zones.EraseZone(id);rects.erase(id);}
        else {int x=rng()%200,z=rng()%200;auto r=local_layout::Reservations::Rect{x,z,x+1+int(rng()%20),z+1+int(rng()%20)};zones.PutZone(id,r);rects[id]=r;}
        int x=rng()%200,z=rng()%200;local_layout::Reservations::Rect q{x,z,x+8,z+8};bool expected=false;
        for(const auto& [key,r]:rects)expected|=q.x1<r.x2 && r.x1<q.x2 && q.z1<r.z2 && r.z1<q.z2;
        assert(zones.OverlapsZone(q)==expected);
    }
    {
        CCombatSnapshot snapshot;snapshot.Reset(16384,16384);
        CCombatSnapshot::Entry e;e.id=9;e.pos={15000,15000};e.landRange=0;snapshot.Add(e);
        int seen=0;snapshot.QueryInfluencing({0,0},{100,100},964,[&](const auto&){++seen;});assert(seen==0);
        CCombatSnapshot::InvalidateRangeBounds();
        snapshot.QueryInfluencing({0,0},{100,100},964,[&](const auto&){++seen;});assert(seen==1);
        snapshot.Reset(16384,16384);snapshot.Add(e);
        snapshot.QueryInfluencing({0,0},{100,100},964,[&](const auto&){++seen;});assert(seen==2);
    }
    std::cout<<"performance_helpers_test: exact oracles passed\n";
}
