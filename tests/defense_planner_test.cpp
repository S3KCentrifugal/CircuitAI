#include "control/kernel/DefensePlanner.h"
#include "control/kernel/DefenseClaims.h"
#include <cassert>
#include <string>
using namespace circuit::defense;
int main() {
    assert(Confidence(-1,45)==1 && Confidence(0,0)==1 && Confidence(1,0)==0);
    assert(Confidence(45,45)==0 && Confidence(90,45)==0 && Confidence(15,30)==.5f);
    Economy e{100,1000,20,200,10,100};
    Project p{200,2000,1000,100,5,0,0,90};
    assert(ReadyTime(p,e,0)==105 && ReadyTime(p,e,.5f)==110);
    e.energyPull=200;assert(!std::isfinite(ReadyTime(p,e,0)));
    e.energy=2000;assert(ReadyTime(p,e,0)==105);
    p.buildPower=0;assert(!std::isfinite(ReadyTime(p,e,0)));
    p={100,1000,1000,100,0,0,0,0};e={100,1000,10,100,20,100};
    assert(!std::isfinite(ReadyTime(p,e,0))); // metal drain consumes the bank
    e.metal=200;assert(ReadyTime(p,e,0)==10);
    assert(ResourceSeconds(0,0,0)==0);
    // A slow high-alpha gun cannot convert overkill into spam coverage.
    assert(FireCapacity(4000,10,30,100,.5f)==150);
    assert(FireCapacity(4000,10,30,8000,.5f)==6000);
    assert(FireCapacity(4000,10,9,8000,.5f)==2000);
    assert(SweepScale(2.5f,.1f)==25 && SweepScale(0,.1f)==1 && SweepScale(2.5f,0)==1);
    assert(FireCapacity(0,10,30,8000,.5f)==0);
    assert(FireCapacity(4000,10,0,8000,.5f)==0);
    assert(FireCapacity(4000,10,30,0,.5f)==0);
    Demands d{};d[LIGHT]={10000,50000,100,100};d[HEAVY]={8000,1000,1,8000};
    Rule r;r.def=1;r.weights[HEAVY]=1;r.valueRatio=.75f;
    std::array<float,COUNT> active{},pending{},capacity{};capacity[HEAVY]=6000;
    assert(Marginal(d,active,pending,capacity,r,3500)==0); // spam cannot unlock heavy
    d[HEAVY].value=3000;assert(Marginal(d,active,pending,capacity,r,3500)==.75f);
    active[HEAVY]=4000;pending[HEAVY]=4000;assert(Marginal(d,active,pending,capacity,r,3500)==0);
    assert(Residual(100,90,20)==0 && Residual(100,-10,-20)==100);
    {
        Demands plasma{};plasma[PLASMA].health=10000;
        Rule shield;shield.weights[PLASMA]=1;
        std::array<float,COUNT> ready{},future{},newShield{};
        ready[PLASMA]=4000;future[PLASMA]=1000;newShield[PLASMA]=5000;
        assert(Marginal(plasma,ready,future,newShield,shield,1000)==0);
        newShield[PLASMA]=7000;assert(Marginal(plasma,ready,future,newShield,shield,1000)==.2f);
    }
    r.minMetal=50;r.minEnergy=1000;r.seconds=90;
    p={100,1000,1000,100,0,10,100,0};e={1000,10000,50,1000,10,100};
    const auto good=Evaluate(r,p,e,1,0);assert(good.reason==Reason::READY);
    assert(!Better(good,good));
    assert(UrgencyBand(2,4,true,1)==4 && UrgencyBand(2,4,false,1)==2 && UrgencyBand(2,4,true,0)==2);
    assert(AllowProtectedWork(true,false,false,false,true,true));
    assert(AllowProtectedWork(false,true,true,true,false,false));
    assert(!AllowProtectedWork(false,false,true,true,false,false));
    assert(!AllowProtectedWork(false,true,false,true,false,false));
    assert(!AllowProtectedWork(false,true,true,false,false,false));
    assert(!AllowProtectedWork(false,true,true,true,true,false));
    assert(!AllowProtectedWork(false,true,true,true,false,true));
    auto urgent=good;urgent.band=good.band+1;urgent.score=good.score/100;assert(Better(urgent,good));
    assert(Evaluate(r,p,e,0,0).reason==Reason::COVERED);
    assert(Evaluate(r,p,e,1,r.limit).reason==Reason::LIMIT);
    e.metalIncome=49;assert(Evaluate(r,p,e,1,0).reason==Reason::INCOME);e.metalIncome=50;
    e.energyPull=999;assert(Evaluate(r,p,e,1,0).reason==Reason::ENERGY);e.energyPull=100;
    p.shotEnergy=10000;assert(Evaluate(r,p,e,1,0).reason==Reason::ENERGY);p.shotEnergy=100;
    p.warmup=100;assert(Evaluate(r,p,e,1,0).reason==Reason::TOO_LATE);p.warmup=0;
    p.buildPower=0;assert(Evaluate(r,p,e,1,0).reason==Reason::NO_BUILDER);
    r.priority=0;assert(Evaluate(r,p,e,1,0).reason==Reason::DISABLED);
    assert(std::string(Name(Reason::TOO_LATE))=="ready_too_late" && !Better(Evaluation{},good));
    {
        Settings s; s.enabled=1; s.surplusMetal=2000;
        Rule r; r.def=1; r.minMetal=50; r.minEnergy=500; r.surplusPriority=4;
        Project p{500,1000,1000,100,0,50,100,0};
        Economy e{2001,10000,10,1000,10,100};
        assert(Evaluate(r,p,e,0,0).reason==Reason::INCOME);
        const auto funded=EvaluateSurplus(s,r,p,e,r.limit);
        assert(funded.reason==Reason::READY && funded.surplus && funded.band==0);
        e.metal=2000; assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::DISABLED);
        e.metal=1999; assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::DISABLED); e.metal=2001;
        s.surplusMetal=0; assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::DISABLED); s.surplusMetal=2000;
        s.enabled=0; assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::DISABLED); s.enabled=1;
        assert(EvaluateSurplus(s,r,p,e,32).reason==Reason::LIMIT);
        r.surplusPriority=0; assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::DISABLED); r.surplusPriority=4;
        e.energyPull=851; assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::ENERGY);
        e.energyPull=850; assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::READY);
        e.energy=624; assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::ENERGY);
        e.energy=1000; s.surplusFireSeconds=0; p.shotEnergy=801;
        assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::ENERGY);
        p.shotEnergy=100; s.surplusFireSeconds=10; e.energy=1000;
        r.seconds=6; p.buildTime=100; // 800 bank cannot pay 1000 construction + 500 reserve in six seconds
        assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::TOO_LATE);
        r.seconds=90; e.energy=10000; p.buildPower=0;
        assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::NO_BUILDER); p.buildPower=100;
        e.energyIncome=499; e.energyPull=0;
        assert(EvaluateSurplus(s,r,p,e,0).reason==Reason::INCOME); e.energyIncome=1000;
        auto light=r; light.surplusPriority=1;
        assert(Better(EvaluateSurplus(s,r,p,e,0),EvaluateSurplus(s,light,p,e,0)));
        e.metalIncome=50;
        assert(Better(Evaluate(r,p,e,1,0),EvaluateSurplus(s,r,p,e,0)));
    }
    Claims claims;int seen=0;
    int token=0;claims.Upsert(3,token,{30,-1,100,0,0,1});const int firstToken=token;
    claims.Upsert(3,token,{31,-1,100,0,0,1});assert(token==firstToken && token>0);
    claims.Nearby(0,0,0,0,[&](int owner,const Claim& c){assert(owner==3 && c.def==31);++seen;});assert(seen==1);
    claims.Erase(3,token);seen=0;
    claims.Put(1,0,{10,-1,90,0,0,500,100,1000});
    claims.Nearby(0,0,0,90,[&](int owner,const Claim& c){assert(owner==1 && c.def==10);++seen;});assert(seen==1);
    claims.Nearby(501,0,0,90,[&](int,const Claim&){++seen;});assert(seen==1);
    claims.Nearby(0,0,0,91,[&](int,const Claim&){++seen;});assert(seen==1);
    claims.Put(1,0,{10,-1,100,0,0,500,100,1000});claims.Put(2,0,{20,-1,100,0,0,500,100,1000});
    claims.RemoveOwner(1);claims.Erase(2,0);
    claims.Nearby(0,0,0,99,[&](int,const Claim&){++seen;});assert(seen==1);
}
