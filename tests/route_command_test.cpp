#include "circuit/spring/RouteCommand.h"
#include "circuit/terrain/RangedGeometry.h"
#include <stdexcept>
#include <iostream>
using circuit::routecommand::Command;
void Check(bool value) { if(!value) throw std::runtime_error("route command assertion"); }
int main() {
    std::vector<Command> sent{{10,0,100,1,2,3},{10,32,100,4,5,6},{10,32,100,7,8,9}},live=sent;
    auto match=[&](int frame) { return circuit::routecommand::LiveSuffix(sent,live.size(),frame,
        [&](int i,Command& c){ c=live[i];return true; }); };
    Check(match(99));live.erase(live.begin());Check(match(100));Check(!match(101));
    live[0].options=0;Check(!match(99));live[0]=sent[1];
    live[0].timeout=101;Check(!match(99));live[0]=sent[1];
    live[0].id=0;Check(!match(99));live[0]=sent[1];
    live[0].x+=1;Check(!match(99));live.clear();Check(!match(99));
    struct Pos { float x,y,z; };
    std::vector<Pos> line{{0,0,0},{64,0,0},{128,0,0},{192,0,0},{256,0,0},{320,0,0}};
    circuit::ranged::CompactStraightRoute(line);Check(line.size()==2 && line[0].x==0 && line[1].x==320);
    // Projected flank path has a shore-induced bend absent from the centerline.
    std::vector<Pos> flank{{0,0,64},{64,0,64},{128,0,0},{192,0,64},{256,0,64}};
    circuit::ranged::CompactStraightRoute(flank);Check(flank.size()==5);
    std::vector<Pos> reversal{{0,0,0},{64,0,0},{0,0,0}};
    circuit::ranged::CompactStraightRoute(reversal);Check(reversal.size()==3);
    std::cout<<"route commands: exact live suffix, expiry, recovery, projected bends and reversals PASS\n";
}
