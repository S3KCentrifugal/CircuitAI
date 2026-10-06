#include "terrain/RangedGeometry.h"
#include "ranged_legacy_index.h"
#include <cassert>
#include <chrono>
#include <iostream>
#include <numeric>
#include <random>
#include <set>

using namespace circuit::ranged;
int main()
{
    // Safe endpoints alone must not permit a path through a defended area.
    assert(!SafeSegment({-200,0},{200,0},{0,0},100));
    assert(SafeSegment({-200,150},{200,150},{0,0},100));
    assert(SafeSegment({50,0},{150,0},{0,0},100));
    assert(!SafeSegment({50,0},{-150,0},{0,0},100));
    assert(!SafeSegment({50,0},{50,0},{0,0},100));
    assert(ClosingSpeed({0,0},{100,0},{-30,0})==30);
    assert(ClosingSpeed({0,0},{100,0},{30,0})==0);
    assert(EscapeSeconds(42,120,.007f,true,1)>EscapeSeconds(42,120,.007f,false,1));
    // A stationary forward hull at 120 angle units/frame needs ~9.1 seconds
    // for a half-turn, before the separate acceleration/reaction allowance.
    assert(std::fabs(EscapeSeconds(0,120,1,true,0)-32768.f/120.f/30.f)<.001f);
    assert(UsefulScore(1000,4000,1000,0,true,true,true,1)>
           UsefulScore(1000,4000,1000,4000,true,true,true,1));
    assert(UsefulScore(1000,4000,1000,0,true,true,true,1)>
           UsefulScore(1000,4000,1000,0,true,true,false,1));
    // Spatial lookup has an exact brute-force oracle, including negative
    // coordinates, mutation, reused IDs and clear/rebuild boundaries.
    std::mt19937 rng(207);
    std::uniform_real_distribution<float> coordinate(-8192,8192);
    std::vector<Point> points(4096);
    SpatialIndex index;
    index.Configure(12288,12288);
    ranged_reference::SpatialIndex old;
    for(size_t i=0;i<points.size();++i) { points[i]={coordinate(rng),coordinate(rng)}; index.Add(points[i],int(i)); old.Add(points[i],int(i)); }
    for(int query=0;query<1000;++query) {
        Point p{coordinate(rng),coordinate(rng)}; float radius=64+(rng()%1500);
        std::set<int> expected,actual;
        for(size_t i=0;i<points.size();++i) if(DistanceSq(p,points[i])<=radius*radius) expected.insert(int(i));
        index.Query(p,radius,[&](int i) { if(DistanceSq(p,points[i])<=radius*radius) actual.insert(i); });
        assert(expected==actual);
        // Preserve ordered cell/insertion traversal, not only a set of hits:
        // equal target scores and floating sums depend on this exact sequence.
        std::vector<int> before,after;
        old.Query(p,radius,[&](int i){before.push_back(i);});
        index.Query(p,radius,[&](int i){after.push_back(i);});
        assert(before==after);
        int calls=0;
        const bool any=index.Any(p,radius,[&](int i){++calls;return DistanceSq(p,points[i])<=radius*radius;});
        assert(any==!expected.empty());
        assert(calls<=int(before.size()));
        const int changed=rng()%points.size();
        index.Remove(points[changed],changed); old.Remove(points[changed],changed);
        points[changed]={coordinate(rng),coordinate(rng)};
        index.Add(points[changed],changed); old.Add(points[changed],changed);
    }
    index.Clear(); int count=0; index.Query({0,0},20000,[&](int){++count;}); assert(count==0);
    // Empty/remove/re-add must not duplicate touched buckets or reorder IDs.
    for(int generation=0;generation<100;++generation) {
        index.Add({-1,-1},7); index.Remove({-1,-1},7); index.Add({-1,-1},8);
        index.Add({12288,12288},9); index.Add({16000,16000},10);
        std::vector<int> ids; index.Query({0,0},20000,[&](int i){ids.push_back(i);});
        assert((ids==std::vector<int>{8,9,10}));
        int visits=0; assert(index.Any({0,0},20000,[&](int){++visits;return true;})); assert(visits==1);
        index.Clear(); assert(!index.Any({0,0},20000,[](int){return true;}));
    }
    CellStore<float> sums; sums.Configure(96,96);
    sums.Get(-1,-1)+=3; sums.Get(95,95)+=4; sums.Get(95,95)+=5;
    assert(*sums.Find(-1,-1)==3 && *sums.Find(95,95)==9);
    sums.Clear(); assert(sums.Find(-1,-1)==nullptr); sums.Get(95,95)+=7; assert(*sums.Find(95,95)==7);
    sums.Configure(2000000,2000000); sums.Get(1700000,0)=2; assert(*sums.Find(1700000,0)==2); // sparse allocation fallback
    OrderedIds ordered(32000);
    std::vector<int> ids(32000); std::iota(ids.begin(),ids.end(),0);
    for(int size:{0,1,127,128,2000,5000,10000,32000}) {
        std::shuffle(ids.begin(),ids.end(),rng); auto sorted=ids;
        std::sort(sorted.begin(),sorted.begin()+size); ordered.Sort(ids,size); assert(ids==sorted);
    }
    // Duplicates and IDs outside the advertised engine bound preserve std::sort.
    for(int special:{-1,32000,0}) {
        std::iota(ids.begin(),ids.end(),0); ids[129]=special; auto sorted=ids;
        std::sort(sorted.begin(),sorted.begin()+256); ordered.Sort(ids,256); assert(ids==sorted);
    }
    std::cout << "ranged geometry: ordered legacy/brute-force spatial oracle, early exits, generations, overflow and ID sort PASS\n";
}
