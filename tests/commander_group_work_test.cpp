#include "control/kernel/CommanderGroupWork.h"
#include <cassert>
#include <iostream>
#include <new>
#include <array>
using namespace circuit::commander;
int main() {
    for(bool front:{false,true}) for(bool anchor:{false,true}) for(bool member:{false,true}) {
        assert(SupportBoundaryApplies(front,anchor,member)==(!front && anchor && member));
    }
    // Home aircraft and constructors remain unrestricted as engineering moves
    // away; enrolled workers retain their radius, and FRONT uses its own policy.
    assert(!SupportBoundaryApplies(false,true,false));
    assert(SupportBoundaryApplies(false,true,true));
    // Exercise every combination of available offers. Routine weapons cannot
    // suppress a ready sensor; urgent counters win, and owed nanos defer sensors.
    // An accepted offer must stop evaluation (placement has side effects).
    for(bool nanoDue:{false,true}) for(bool nearCombat:{false,true}) for(int ready=0;ready<16;++ready) {
        std::array<int,4> calls{};
        int jobs[4]={0,1,2,3};
        int expected=-1;
        const int middle=nanoDue?1:nearCombat?2:-1;
        if(ready&1) expected=0;
        else if(middle>=0 && (ready&(1<<middle))) expected=middle;
        else if(ready&8) expected=3;
        int combatQueries=0;
        auto* selected=SelectGroupConstruction(nanoDue,[&]{++combatQueries;return nearCombat;},[&](ConstructionPhase phase)->int* {
            const int i=int(phase);
            ++calls[i];
            assert(calls[i]==1); // no repeated placement attempt in the same phase
            return (ready&(1<<i))?&jobs[i]:nullptr;
        });
        assert(selected==(expected<0?nullptr:&jobs[expected]));
        assert(calls[0]==1);
        assert(calls[1]==int(expected!=0 && nanoDue));
        assert(calls[2]==int(expected!=0 && !nanoDue && nearCombat));
        assert(calls[3]==int(expected<0 || expected==3));
        assert(combatQueries==int(expected!=0 && !nanoDue));
    }
    // A completed emergency solar and a later factory assist can occupy the
    // identical address. Retirement must invalidate both identity and kind.
    struct Task { int type; };
    alignas(Task) unsigned char storage[sizeof(Task)];
    auto* solar=new (storage) Task{22};
    WorkIdentity<Task> work;
    work.task=solar; work.kind=22;
    Task other{1};
    work.Retire(&other);
    assert(work.task==solar && work.kind==22); // unrelated task preserves work
    work.Retire(solar);
    solar->~Task();
    auto* assist=new (storage) Task{0};
    assert(work.task!=assist && work.kind==-1);
    work.task=assist; work.kind=0;
    work.Retire(assist); // cancellation uses the same lifecycle as completion
    work.Retire(assist); // repeated notification is harmless
    assert(work.task==nullptr && work.kind==-1);
    assist->~Task();
    // Exact income/bank boundaries, exhausted budgets and custom policy.
    assert(GroupBudget(50,1000,50,1000,170,3500,50,1000,680,14000,30,.25f));
    assert(!GroupBudget(49,1000,50,1000,9999,99999,0,0,680,14000,30,.25f));
    assert(!GroupBudget(50,999,50,1000,9999,99999,0,0,680,14000,30,.25f));
    assert(!GroupBudget(50,1000,50,1000,169,3500,50,1000,680,14000,30,.25f));
    assert(!GroupBudget(50,1000,50,1000,170,3499,50,1000,680,14000,30,.25f));
    assert(GroupBudget(50,1000,50,1000,0,0,40,800,680,14000,30,.25f));
    assert(!GroupBudget(50,1000,50,1000,200,4000,60,1100,680,14000,30,.25f));
    assert(GroupBudget(20,500,20,500,680,14000,100,5000,680,14000,0,1));
    assert(GroupJobInRange(600.f*600,600,150,false));
    assert(!GroupJobInRange(650.f*650,600,150,false));
    assert(GroupJobInRange(650.f*650,600,150,true));
    assert(!GroupJobInRange(751.f*751,600,150,true));
    assert(!GroupJobInRange(-1,600,150,true));
    assert(ReviewLine(true,0,150,1000,500));
    assert(!ReviewLine(false,149,150,100,500));
    assert(ReviewLine(false,150,150,100,500));
    assert(!ReviewLine(false,150,150,501,500));
    assert(UsefulGroupRepair(false,false,false,true,100,100));
    assert(UsefulGroupRepair(false,false,false,false,90,100));
    assert(!UsefulGroupRepair(false,false,false,false,100,100));
    assert(!UsefulGroupRepair(true,false,true,true,90,100));
    assert(!UsefulGroupRepair(false,true,false,false,90,100));
    assert(UsefulGroupRepair(false,true,true,false,90,100));
    assert(!UsefulGroupRepair(false,false,false,true,0,100));
    std::cout << "commander_group_work_test: ownership hysteresis, line review, local repair passed\n";
}
