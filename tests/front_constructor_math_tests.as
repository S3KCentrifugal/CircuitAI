void test_two_base_workers_before_expansion() {
 array<int> seats={-1,-1,-1,-1};
 Check(FrontConstructorMath::Missing(seats)==3);
 seats[3]=10; Check(FrontConstructorMath::Missing(seats)==0);
 seats[0]=20; Check(FrontConstructorMath::Missing(seats)==1);
 seats[1]=30; Check(FrontConstructorMath::Missing(seats)==2);
 seats[2]=40; Check(FrontConstructorMath::Missing(seats)==-1);
 seats[3]=-1; Check(FrontConstructorMath::Missing(seats)==3);
}
void test_commander_handoff_waits_for_completed_turret() {
 Check(FrontConstructorMath::CommanderPhase(false,0.f)==0);
 Check(FrontConstructorMath::CommanderPhase(true,0.01f)==1);
 Check(FrontConstructorMath::CommanderPhase(true,0.99f)==1);
 Check(FrontConstructorMath::CommanderPhase(true,1.f)==2);
 Check(FrontConstructorMath::CommanderPhase(false,1.f)==0);
}
void test_expansion_and_group_gates() {
 Check(FrontConstructorMath::RecruitAllowed(0,false,false,false));
 Check(FrontConstructorMath::RecruitAllowed(3,false,false,false));
 Check(!FrontConstructorMath::RecruitAllowed(1,false,false,true));
 Check(FrontConstructorMath::RecruitAllowed(1,false,true,false));
 Check(!FrontConstructorMath::RecruitAllowed(2,false,true,false));
 Check(FrontConstructorMath::RecruitAllowed(2,false,true,true));
}
void test_replacements_do_not_restart_opening() {
 Check(FrontConstructorMath::RecruitAllowed(1,true,false,false));
 Check(FrontConstructorMath::RecruitAllowed(2,true,false,false));
 array<bool> filled={true,false,false,true};
 Check(FrontConstructorMath::OpeningDone(filled));
 filled[3]=false; Check(!FrontConstructorMath::OpeningDone(filled));
}
void test_invalid_state() {
 array<int> seats; array<bool> filled;
 Check(FrontConstructorMath::Missing(seats)==-1);
 Check(!FrontConstructorMath::OpeningDone(filled));
 Check(!FrontConstructorMath::RecruitAllowed(-1,true,true,true));
 Check(!FrontConstructorMath::RecruitAllowed(4,true,true,true));
}
