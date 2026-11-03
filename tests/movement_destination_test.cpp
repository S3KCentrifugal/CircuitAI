#include "terrain/MovementDestination.h"
#include <cassert>
#include <limits>

int main()
{
    using circuit::movement_destination::Free;
    const auto factory=[](int x,int z){return x>=4&&x<8&&z>=4&&z<8;};
    assert(!Free(96,96,16,16,16,16,factory)); // lane rejoin inside factory
    assert(!Free(63,96,16,16,16,16,factory)); // centre clear, footprint overlaps
    assert(Free(48,96,16,16,16,16,factory)); // touching edge is clear
    assert(Free(96,160,16,16,16,16,factory)); // farther lane detour
    assert(Free(240,240,16,16,16,16,factory)); // exact map edge
    assert(!Free(241,240,16,16,16,16,factory));
    assert(!Free(-1,16,16,16,16,16,factory));
    assert(!Free(std::numeric_limits<float>::infinity(),16,16,16,16,16,factory));
    assert(!Free(16,16,16,0,16,16,factory));
    int visits=0;
    assert(Free(32,32,16,16,16,16,[&](int,int){++visits;return false;}));
    assert(visits==4); // no map-wide scan
}
