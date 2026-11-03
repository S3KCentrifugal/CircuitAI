void test_income_not_storage_funds_support() {
    Check(FrontFactoryMath::FundedPower(1000,100,1000,10,100)==100);
    Check(FrontFactoryMath::FundedPower(1000,100,1000,100,50)==50);
    Check(FrontFactoryMath::FundedPower(1000,100,0,10,0)==100);
    Check(FrontFactoryMath::FundedPower(0,100,1000,10,100)==0);
    Check(FrontFactoryMath::FundedPower(1000,0,1000,10,100)==100);
    Check(FrontFactoryMath::FundedPower(1000,0,0,10,100)==0);
    Check(FrontFactoryMath::FundedPower(1000,100,1000,0,100)==0);
    Check(FrontFactoryMath::FundedPower(1000,100,1000,10,0)==0);
}
void test_absent_t2_does_not_withhold_t1_budget() {
    Check(FrontFactoryMath::FirstShare(false,0.6f)==1.f);
    Check(FrontFactoryMath::FirstShare(true,0.6f)==0.6f);
    Check(FrontFactoryMath::FirstShare(true,-1.f)==0.f);
    Check(FrontFactoryMath::FirstShare(true,2.f)==1.f);
}
void test_native_factory_power_is_not_counted_as_assist_demand() {
    Check(FrontFactoryMath::SupportDemand(100,80)==20);
    Check(FrontFactoryMath::SupportDemand(50,80)==0);
}
void test_t1_protected_and_shared_turret_assigned_once() {
    Check(FrontFactoryMath::Choose(true,true,100,500)==0);
    Check(FrontFactoryMath::Choose(true,true,0,500)==1);
    Check(FrontFactoryMath::Choose(false,true,100,500)==1);
    Check(FrontFactoryMath::Choose(true,false,0,500)==-1);
    Check(FrontFactoryMath::Choose(false,false,100,500)==-1);
}
void test_exclusive_coverage_precedes_shared_coverage() {
    array<uint> masks={3,1};array<float> power={100,100};
    array<float> demand={100,100};array<int> owners;
    FrontFactoryMath::Allocate(masks,power,demand,owners);
    Check(owners[0]==1 && owners[1]==0);
    Check(demand[0]==0 && demand[1]==0);
}
void test_discrete_shortfall_and_incomplete_support() {
    array<uint> masks={3,2,3};array<float> power={100,0,100};
    array<float> demand={150,100};array<int> owners;
    FrontFactoryMath::Allocate(masks,power,demand,owners);
    Check(owners[0]==0 && owners[1]==-1 && owners[2]==0);
    Check(demand[0]==-50 && demand[1]==100);
}
void test_no_demand_and_invalid_snapshot() {
    array<uint> masks={1,3};array<float> power={100,100};
    array<float> demand={0,0};array<int> owners;
    FrontFactoryMath::Allocate(masks,power,demand,owners);
    Check(owners[0]==-1 && owners[1]==-1);
    power.resize(1);
    FrontFactoryMath::Allocate(masks,power,demand,owners);
    Check(owners[0]==-1 && owners[1]==-1);
}
void test_forward_compact_precedes_sideways_pair() {
    // Goal straight ahead, interior to the "primary+1" side: both sides, that one first.
    for(int primary=0;primary<4;++primary) {
        const int right=(primary+1)%4;
        const float gx=primary==1?1000.f:(primary==3?-1000.f:0.f), gz=primary==0?1000.f:(primary==2?-1000.f:0.f);
        const float ix=right==1?500.f:(right==3?-500.f:0.f), iz=right==0?500.f:(right==2?-500.f:0.f);
        Check(FrontFactoryMath::LayoutFacing(primary,0,gx,gz,ix,iz)==primary);
        Check(FrontFactoryMath::LayoutFacing(primary,1,gx,gz,ix,iz)==primary);
        Check(FrontFactoryMath::LayoutFacing(primary,2,gx,gz,ix,iz)==right);
        Check(FrontFactoryMath::LayoutFacing(primary,3,gx,gz,ix,iz)==right);
        Check(FrontFactoryMath::LayoutFacing(primary,4,gx,gz,ix,iz)==(primary+3)%4);
        Check(FrontFactoryMath::LayoutFacing(primary,5,gx,gz,ix,iz)==(primary+3)%4);
    }
    Check(FrontFactoryMath::LayoutFacing(-1,0,0,1,0,0)==-1);
    Check(FrontFactoryMath::LayoutFacing(4,0,0,1,0,0)==-1);
    Check(FrontFactoryMath::LayoutFacing(0,6,0,1,0,0)==-1);
}
// D-460 (KI-743): Glitters team 11 at the west edge, goal north-east: the
// first side is east (toward the goal), west (away from it) is never offered.
void test_side_toward_goal_first_never_away() {
    const float dx=800.f,dz=-6000.f,ix=2400.f,iz=-3000.f;
    Check(FrontFactoryMath::LayoutFacing(2,2,dx,dz,ix,iz)==1);
    Check(FrontFactoryMath::LayoutFacing(2,4,dx,dz,ix,iz)==-1);
    // Goal exactly ahead at the west edge: east (interior) before west.
    Check(FrontFactoryMath::LayoutFacing(2,2,0.f,-6000.f,2400.f,-3000.f)==1);
    Check(FrontFactoryMath::LayoutFacing(2,4,0.f,-6000.f,2400.f,-3000.f)==3);
}
