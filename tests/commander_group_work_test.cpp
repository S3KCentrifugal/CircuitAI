#include "control/kernel/CommanderGroupWork.h"
#include <cassert>
#include <iostream>
using namespace circuit::commander;
int main() {
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
