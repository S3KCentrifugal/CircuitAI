void test_t2_allocation_requires_both_incomes_and_retains_earned_seats() {
    Check(CommanderGroupMath::DesiredT2(0,49,2000,50,1000,120,2500,240,5000)==0);
    Check(CommanderGroupMath::DesiredT2(0,100,999,50,1000,120,2500,240,5000)==0);
    Check(CommanderGroupMath::DesiredT2(0,50,1000,50,1000,120,2500,240,5000)==1);
    Check(CommanderGroupMath::DesiredT2(0,120,2500,50,1000,120,2500,240,5000)==2);
    Check(CommanderGroupMath::DesiredT2(0,240,5000,50,1000,120,2500,240,5000)==3);
    Check(CommanderGroupMath::DesiredT2(3,0,0,50,1000,120,2500,240,5000)==3);
    Check(CommanderGroupMath::DesiredT2(99,0,0,50,1000,120,2500,240,5000)==3);
}
void test_replacements_preserve_survivors_and_economy_worker() {
    array<int> seats={10,-1,30,-1,-1,-1};
    Check(CommanderGroupMath::Admission(false,seats,3)==-2);
    Check(CommanderGroupMath::Admission(true,seats,3)==1);
    Check(CommanderGroupMath::Admission(true,seats,1)==-1);
    seats[1]=20;Check(CommanderGroupMath::Admission(true,seats,3)==-1);
    seats[0]=-1;seats[1]=-1;seats[2]=-1;
    Check(CommanderGroupMath::Admission(true,seats,3)==0);
    array<int> empty;Check(CommanderGroupMath::Admission(true,empty,3)==-1);
}
