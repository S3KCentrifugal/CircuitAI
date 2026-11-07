#include "circuit/terrain/BuildTravelBudget.h"
#include <cstdlib>
#include <iostream>
int main() {
    int failures=0;
    auto check=[&](bool ok,const char* why) { if (!ok) { ++failures; std::cerr<<why<<'\n'; } };
    auto clear=[](float,float) { return true; };
    using circuit::build_travel::Within;
    using circuit::build_travel::PhysicalBlock;
    check(!PhysicalBlock(0x8000,0x8000,0x8000),"planned slots are walkable");
    check(PhysicalBlock(1,0x8000,0x8000),"physical blocker under reservation retained");
    check(PhysicalBlock(0x8000,1,0x8000),"physical structure under reservation retained");
    check(Within(160,0,64,96,clear),"exact budget admitted");
    check(!Within(160,0,64,95,clear),"over budget rejected");
    check(!Within(160,0,64,32.f*2.99f,clear),"2.99 second budget rejects three-second route");
    check(Within(160,0,64,32.f*3.01f,clear),"3.01 second budget admits three-second route");
    check(Within(63,0,64,0,clear),"already at build stance");
    check(!Within(160,0,64,96,[](float x,float) { return x<48; }),"wall rejects direct-distance shortcut");
    check(Within(96,0,16,144,[](float x,float z) { return x!=48 || z>=32; }),"affordable detour");
    check(!Within(32,32,1,46,[](float x,float z) { return x==z; }),"no diagonal corner cut");
    check(!Within(0,0,1,0,[](float,float) { return false; }),"unsafe stance rejected");
    check(!Within(0,0,-1,1,clear),"invalid range rejected");
    check(!Within(160,0,64,0,clear),"immobile builder cannot travel");
    check(!Within(160,0,64,std::numeric_limits<float>::infinity(),clear),"nonfinite budget rejected");
    return failures?EXIT_FAILURE:EXIT_SUCCESS;
}
