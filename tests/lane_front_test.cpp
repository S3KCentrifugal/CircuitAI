#include "terrain/LaneFront.h"
#include <cassert>
#include <iostream>
using circuit::lane::Front;
int main() {
    { Front f; f.Reset(4096); f.Add(512,768,100,false);
      assert(f.HeldProgress(100,90)==0); }
    {
        Front held;held.Reset(4096);
        assert(held.HeldProgress(0,90)<0);
        held.Add(512,768,100,true);held.Add(512,768,100,true);
        assert(held.HeldProgress(0,90)==896);
        held.Add(3000,3200,100,true);held.Add(3000,3200,100,true);
        held.Add(1500,1700,100,false);
        assert(held.HeldProgress(0,90)==896);
        held.Reset(4096);held.Add(0,2000,100,true);held.Add(0,2000,100,true);
        held.Damage(1000,30);
        assert(held.HeldProgress(60,90)==896);
    }
    Front f;f.Reset(4096);
    assert(f.Status(0,0,90)==Front::UNKNOWN);
    f.Add(500,800,100,true);
    assert(f.Status(f.Index(600),0,90)==Front::UNKNOWN); // lone scout is not a front
    f.Add(500,800,100,true);
    assert(f.Status(f.Index(600),0,90)==Front::SUPPORTED);
    f.Add(1800,2100,300,false);
    f.Add(3500,3800,300,false);
    assert(f.Status(f.Index(2500),0,90)==Front::UNKNOWN); // separate zones, not their average
    assert(f.Limit(1200,3000,128,1.5,0,90)<1800);
    assert(f.Limit(2500,3000,128,1.5,0,90)==3000); // rear threat doesn't send us home
    f.Damage(2500,30);
    assert(f.Status(f.Index(2500),60,90)==Front::ACTIVE);
    assert(f.Limit(2400,3000,128,1.5,60,90)==2400);
    f.Begin();
    assert(f.Status(f.Index(2500),60,90)==Front::ACTIVE);
    assert(f.Status(f.Index(2500),121,90)==Front::UNKNOWN);
    f.Add(2500,2700,100,false,true);
    f.Add(2500,2700,1000,true);f.Add(2500,2700,1000,true);
    assert(f.Limit(2400,3000,128,1.5,200,90)==2400); // uncertain contact cannot be outvoted
    f.Reset(4096);
    assert(f.Status(f.Index(2500),60,90)==Front::UNKNOWN); // route change discards damage
    f.Add(2500,2700,100,false);
    f.Add(2500,2700,100,true);f.Add(2500,2700,100,true);
    assert(f.Limit(2400,3000,128,1.5,200,90)==3000);
    f.Reset(100000);assert(f.count==128);
    f.Reset(0);assert(f.count==0 && f.Limit(100,200,128,1.5,0,90)==200);
    f.Reset(4096);
    assert(std::isinf(f.CombatDistance(1000,0,900)));
    f.Add(512,640,100,true);f.Add(512,640,100,true);
    assert(std::isinf(f.CombatDistance(1000,0,900))); // friendly/fog never triggers
    f.Damage(600,30);
    assert(f.CombatDistance(1000,930,900)==360); // inclusive memory boundary
    assert(std::isinf(f.CombatDistance(1000,931,900)));
    assert(std::isinf(f.CombatDistance(1000,29,900))); // frame rollback
    f.Add(2048,2176,100,false);
    assert(f.CombatDistance(1900,931,900)==148);
    assert(f.CombatDistance(2100,931,900)==0);
    assert(std::isinf(f.CombatDistance(1900,931,900,false))); // stale publication
    f.Begin();assert(std::isinf(f.CombatDistance(1900,931,900)));
    f.Reset(0);assert(std::isinf(f.CombatDistance(0,0,900)));
    std::cout<<"lane front tests passed\n";
}
