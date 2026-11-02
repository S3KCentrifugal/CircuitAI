#include "terrain/CoastalSupport.h"
#include <iostream>
#include <limits>
int main() {
    using circuit::coastal_support::ReachesLand;
    int failures=0;
    auto check=[&](bool ok){ if(!ok) ++failures; };
    check(ReachesLand(-20,10,336*336,400));
    check(!ReachesLand(-20,10,337*337,400));
    check(!ReachesLand(0,10,0,400));
    check(!ReachesLand(-20,-1,0,400));
    check(!ReachesLand(-20,10,0,64));
    check(!ReachesLand(-20,10,-1,400));
    check(!ReachesLand(-20,10,0,std::numeric_limits<float>::infinity()));
    check(!ReachesLand(-20,10,std::numeric_limits<float>::quiet_NaN(),400));
    std::cout << "8 coastal support checks; " << failures << " failures\n";
    return failures != 0;
}
