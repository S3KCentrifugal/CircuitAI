void test_decoy_income_rechecks_both_resources_on_each_replacement() {
    Check(!CommanderGroupMath::DecoyIncome(99,2000,100,2000));
    Check(!CommanderGroupMath::DecoyIncome(100,1999,100,2000));
    Check(CommanderGroupMath::DecoyIncome(100,2000,100,2000));
    Check(!CommanderGroupMath::DecoyIncome(20,2000,100,2000));
    Check(CommanderGroupMath::DecoyIncome(150,3000,150,3000));
    Check(!CommanderGroupMath::DecoyIncome(150,3000,-1,3000));
}
void test_decoy_funding_preserves_reserve_and_existing_pull() {
    Check(CommanderGroupMath::ReplacementResource(500,500,100,87,780,60));
    Check(!CommanderGroupMath::ReplacementResource(500,500,100,87,781,60));
    Check(!CommanderGroupMath::ReplacementResource(499,500,100,0,750,60));
    Check(CommanderGroupMath::ReplacementResource(1400,500,100,102,780,60));
    Check(!CommanderGroupMath::ReplacementResource(1400,500,100,103,780,60));
    Check(!CommanderGroupMath::ReplacementResource(500,500,100,87,780,30));
    Check(CommanderGroupMath::ReplacementResource(2000,2000,2000,1800,12000,60));
    Check(!CommanderGroupMath::ReplacementResource(2000,2000,2000,1800,13000,60));
    Check(!CommanderGroupMath::ReplacementResource(2000,500,100,0,750,0));
    Check(!CommanderGroupMath::ReplacementResource(2000,500,100,-1,750,60));
}
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
