#include "terrain/RangedGeometry.h"
#include <cassert>
#include <chrono>
#include <iostream>
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
    for(size_t i=0;i<points.size();++i) { points[i]={coordinate(rng),coordinate(rng)}; index.Add(points[i],int(i)); }
    for(int query=0;query<1000;++query) {
        Point p{coordinate(rng),coordinate(rng)}; float radius=64+(rng()%1500);
        std::set<int> expected,actual;
        for(size_t i=0;i<points.size();++i) if(DistanceSq(p,points[i])<=radius*radius) expected.insert(int(i));
        index.Query(p,radius,[&](int i) { if(DistanceSq(p,points[i])<=radius*radius) actual.insert(i); });
        assert(expected==actual);
        const int changed=rng()%points.size();
        index.Remove(points[changed],changed); points[changed]={coordinate(rng),coordinate(rng)};
        index.Add(points[changed],changed);
    }
    index.Clear(); int count=0; index.Query({0,0},20000,[&](int){++count;}); assert(count==0);
    std::cout << "ranged geometry: coverage, retreat, scoring and 1000 spatial oracle mutations PASS\n";
}
