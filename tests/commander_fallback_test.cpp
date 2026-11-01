#include "control/kernel/CommanderFallback.h"
#include <cassert>
#include <iostream>
using namespace circuit::commander;
int main() {
    const auto straight=[](float p){return Point{p,0};};
    // Home is 0, front 4000: a safe canyon exit at 3400 must beat home.
    auto station=NearestFallback(4000,2000,100,straight,[](Point p){return p.x<=3400;});
    assert(station && station->x==3400);
    auto hold=NearestFallback(3400,2000,100,straight,[](Point p){return p.x<=3400;});
    assert(hold && hold->x==3400);
    auto blocked=NearestFallback(4000,2000,100,straight,[](Point p){return p.x<=3400 && p.x!=3400;});
    assert(blocked && blocked->x==3300);
    assert(!NearestFallback(4000,2000,100,straight,[](Point p){return p.x<1900;}));
    // Curved lanes use route progress, not a straight line toward base.
    auto curved=NearestFallback(1000,600,100,[](float p){return Point{100,p};},[](Point p){return p.z<=700;});
    assert(curved && curved->x==100 && curved->z==700);
    int calls=0;
    assert(!NearestFallback(10000,10000,1,straight,[&](Point){++calls;return false;}));
    assert(calls<=33);
    assert(!NearestFallback(-1,2000,100,straight,[](Point){return true;}));
    assert(!NearestFallback(1000,2000,0,straight,[](Point){return true;}));
    assert(FallbackClear({1000,0},{0,0},{0,0},700,120,5,4));
    assert(!FallbackClear({800,0},{0,0},{0,0},700,120,0,0));
    assert(!FallbackClear({1000,0},{0,0},{50,0},700,120,2,4));
    assert(FallbackClear({1000,0},{0,0},{-50,0},700,120,2,4));
    assert(!FallbackClear({1200,0},{0,0},{0,0},1300,120,0,4));
    assert(!FallbackLegClear({0,0},{10,0},{5,0},2));
    assert(FallbackLegClear({0,3},{10,3},{5,0},2));
    assert(FallbackLegClear({1,0},{5,0},{0,0},2));
    assert(!FallbackLegClear({1,0},{-3,0},{0,0},2));
    std::cout << "commander_fallback_test: nearest safe lane, hold, blocked terrain, budget, closing threats passed\n";
}
