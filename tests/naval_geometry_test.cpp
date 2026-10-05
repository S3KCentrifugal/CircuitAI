#include "terrain/NavalGeometry.h"
#include <cassert>
#include <limits>
#include <iostream>
int main() {
    using circuit::naval::Corridor;
    const auto deep = [](float, float) { return -40.f; };
    for (int f=0; f<4; ++f) assert(Corridor(100,100,f,400,60,30,deep));
    assert(!Corridor(100,100,0,400,60,50,deep));
    const auto neck=[](float x,float z) { return z>190 && z<210 && x>125 ? -5.f : -40.f; };
    assert(!Corridor(100,100,0,400,60,15,neck));
    assert(Corridor(100,100,0,400,16,15,neck));
    const auto edge=[](float x,float) { return x<0 ? std::numeric_limits<float>::quiet_NaN() : -40.f; };
    assert(!Corridor(20,100,3,100,20,15,edge));
    assert(!Corridor(0,0,4,100,20,15,deep));
    assert(!Corridor(0,0,0,-1,20,15,deep));
    assert(!Corridor(std::numeric_limits<float>::quiet_NaN(),0,0,100,20,15,deep));
    std::cout << "naval geometry tests passed\n";
}
