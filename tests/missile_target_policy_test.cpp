#include "task/fighter/MissileTargetPolicy.h"
#include <cassert>
#include <limits>
#include <iostream>
int main() {
 using namespace circuit;
 for (const auto* name : {"armmerl", "corvroc", "legavroc"}) assert(IsSlowMissileLauncher(name));
 assert(!IsSlowMissileLauncher("legbar"));
 auto ok=[](float v, float top, bool known=true){ return SlowMissileSpeedAllowed((v/30.f)*(v/30.f),top,known,30.f); };
 assert(ok(0,40)); assert(ok(9.9f,40)); assert(!ok(10,40)); assert(!ok(11,40));
 assert(ok(11.9f,100)); assert(!ok(12,100)); assert(!ok(20,100));
 assert(ok(0,0)); assert(!ok(0.1f,0));
 assert(ok(0,0,false)); assert(!ok(0.1f,0,false));
 assert(!SlowMissileSpeedAllowed(std::numeric_limits<float>::quiet_NaN(),40,true,30));
 std::cout << "Missile targeting: family, stationary, fractional/absolute boundaries, unknown radar, NaN PASS\n";
}
