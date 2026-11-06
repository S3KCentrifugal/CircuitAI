void test_two_base_workers_before_expansion() {
 array<int> seats={-1,-1,-1,-1,-1};
 Check(FrontConstructorMath::Missing(seats,false)==3);
 seats[3]=10; Check(FrontConstructorMath::Missing(seats,false)==0);
 seats[0]=20; Check(FrontConstructorMath::Missing(seats,false)==1);
 seats[1]=30; Check(FrontConstructorMath::Missing(seats,false)==2);
 seats[2]=40; Check(FrontConstructorMath::Missing(seats,false)==-1);
 seats[3]=-1; Check(FrontConstructorMath::Missing(seats,false)==3);
}
void test_converter_seat_is_fifth_and_optional() {
 array<int> seats={-1,-1,-1,-1,-1};
 Check(FrontConstructorMath::Missing(seats,true)==3);
 seats[0]=1; seats[1]=2; seats[2]=3; seats[3]=4;
 Check(FrontConstructorMath::Missing(seats,true)==4);
 Check(FrontConstructorMath::Missing(seats,false)==-1);
 seats[4]=5; Check(FrontConstructorMath::Missing(seats,true)==-1);
 seats[1]=-1; Check(FrontConstructorMath::Missing(seats,true)==1);
}
void test_commander_handoff_waits_for_completed_turret() {
 Check(FrontConstructorMath::CommanderPhase(false,0.f)==0);
 Check(FrontConstructorMath::CommanderPhase(true,0.01f)==1);
 Check(FrontConstructorMath::CommanderPhase(true,0.99f)==1);
 Check(FrontConstructorMath::CommanderPhase(true,1.f)==2);
 Check(FrontConstructorMath::CommanderPhase(false,1.f)==0);
}
void test_expansion_and_group_gates() {
 Check(FrontConstructorMath::RecruitAllowed(0,false,false,false,false));
 Check(FrontConstructorMath::RecruitAllowed(3,false,false,false,false));
 Check(!FrontConstructorMath::RecruitAllowed(1,false,false,true,false));
 Check(FrontConstructorMath::RecruitAllowed(1,false,true,false,false));
 Check(!FrontConstructorMath::RecruitAllowed(2,false,true,false,false));
 Check(FrontConstructorMath::RecruitAllowed(2,false,true,true,false));
}
void test_released_converter_seat_is_not_refilled() {
 Check(FrontConstructorMath::RecruitAllowed(4,false,false,false,true));
 Check(FrontConstructorMath::RecruitAllowed(4,true,false,false,true));
 Check(!FrontConstructorMath::RecruitAllowed(4,true,true,true,false));
}
void test_replacements_do_not_restart_opening() {
 Check(FrontConstructorMath::RecruitAllowed(1,true,false,false,false));
 Check(FrontConstructorMath::RecruitAllowed(2,true,false,false,false));
 array<bool> filled={true,false,false,true,false};
 Check(FrontConstructorMath::OpeningDone(filled));
 filled[3]=false; Check(!FrontConstructorMath::OpeningDone(filled));
}
void test_energy_seat_gates() {
 Check(FrontConstructorMath::EnergyHeld(2000.f,2000.f));
 Check(!FrontConstructorMath::EnergyHeld(2000.5f,2000.f));
 Check(FrontConstructorMath::Windy(5.f,10.f,7.f));
 Check(!FrontConstructorMath::Windy(4.f,10.f,7.f));
 Check(!FrontConstructorMath::Windy(0.f,25.f,12.5f));
}
void test_geothermal_backoff() {
 Check(FrontConstructorMath::GeoAllowed(0,3,100,0));
 Check(!FrontConstructorMath::GeoAllowed(1,3,100,200));
 Check(FrontConstructorMath::GeoAllowed(1,3,200,200));
 Check(!FrontConstructorMath::GeoAllowed(3,3,100000,0));
 Check(FrontConstructorMath::GeoBackoffFrames(2,1800)==3600);
 Check(FrontConstructorMath::GeoBackoffFrames(-1,1800)==0);
}
void test_converter_seat_gates() {
 Check(FrontConstructorMath::ConverterWanted(true,false,true,false));
 Check(!FrontConstructorMath::ConverterWanted(false,false,true,false));
 Check(!FrontConstructorMath::ConverterWanted(true,true,true,false));
 Check(!FrontConstructorMath::ConverterWanted(true,false,false,false));
 Check(!FrontConstructorMath::ConverterWanted(true,false,true,true));
 Check(!FrontConstructorMath::ConverterReleases(60.f,60.f));
 Check(FrontConstructorMath::ConverterReleases(60.5f,60.f));
 Check(FrontConstructorMath::ConverterFunded(500.f,1000.f,0.5f,false));
 Check(!FrontConstructorMath::ConverterFunded(499.f,1000.f,0.5f,false));
 Check(!FrontConstructorMath::ConverterFunded(1000.f,1000.f,0.5f,true));
 Check(!FrontConstructorMath::ConverterFunded(0.f,0.f,0.5f,false));
}
void test_dense_block_acceptance() {
 Check(FrontConstructorMath::BlockAccepted(12,4,3,0.75f));
 Check(FrontConstructorMath::BlockAccepted(9,4,3,0.75f));
 Check(!FrontConstructorMath::BlockAccepted(8,4,3,0.75f));
 Check(!FrontConstructorMath::BlockAccepted(0,4,3,0.f));
 Check(!FrontConstructorMath::BlockAccepted(1,0,3,0.f));
}
void test_invalid_state() {
 array<int> seats; array<bool> filled;
 Check(FrontConstructorMath::Missing(seats,true)==-1);
 Check(!FrontConstructorMath::OpeningDone(filled));
 Check(!FrontConstructorMath::RecruitAllowed(-1,true,true,true,true));
 Check(!FrontConstructorMath::RecruitAllowed(5,true,true,true,true));
}
