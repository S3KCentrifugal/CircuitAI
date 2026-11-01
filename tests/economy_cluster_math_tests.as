void test_energy_gate_requires_bank_and_no_stall() {
    Check(EconomyClusterMath::EnergyHealthy(false,200,1000,.2f));
    Check(!EconomyClusterMath::EnergyHealthy(false,199,1000,.2f));
    Check(!EconomyClusterMath::EnergyHealthy(true,1000,1000,.2f));
    Check(!EconomyClusterMath::EnergyHealthy(false,0,0,.2f));
}
void test_conversion_accounts_for_other_consumers_and_disabled_capacity() {
    Check(EconomyClusterMath::Surplus(10000,7000,3000,5000,500)==500);
    Check(EconomyClusterMath::Surplus(10000,4000,0,5000,500)==500);
    Check(EconomyClusterMath::Surplus(5000,4000,0,5000,500)<0);
}
void test_conversion_hysteresis_does_not_delay_stall_response() {
    Check(!EconomyClusterMath::ConversionWanted(false,true,99,100,0));
    Check(EconomyClusterMath::ConversionWanted(false,true,101,100,0));
    Check(EconomyClusterMath::ConversionWanted(true,true,99,100,0));
    Check(!EconomyClusterMath::ConversionWanted(true,true,0,100,0));
    Check(!EconomyClusterMath::ConversionWanted(true,false,1000,100,0));
}
void test_batch_reserves_other_commitments_and_entire_cluster() {
    Check(EconomyClusterMath::Funded(true,10000,500,1500,8000));
    Check(!EconomyClusterMath::Funded(true,9999,500,1500,8000));
    Check(!EconomyClusterMath::Funded(false,10000,500,1500,8000));
    Check(!EconomyClusterMath::Funded(true,10000,500,1500,0));
}
void test_outstanding_projects_include_orders_not_only_frames() {
    Check(EconomyClusterMath::CanStart(9,10,true,true));
    Check(!EconomyClusterMath::CanStart(10,10,true,true));
    Check(!EconomyClusterMath::CanStart(0,10,true,false));
    Check(!EconomyClusterMath::CanStart(0,10,false,true));
}
void test_remaining_cost_credits_partial_construction() {
    Check(EconomyClusterMath::Remaining(200,.75f)==50);
    Check(EconomyClusterMath::Remaining(200,1.1f)==0);
    Check(EconomyClusterMath::Remaining(200,-1)==200);
}
void test_funded_turret_then_converter_then_afus_then_fusion() {
    Check(EconomyClusterMath::AssistRank(true,false,false,false,true,50,50)==1);
    Check(EconomyClusterMath::AssistRank(false,true,false,false,true,50,50)==2);
    Check(EconomyClusterMath::AssistRank(false,false,true,false,true,50,50)==3);
    Check(EconomyClusterMath::AssistRank(false,false,false,true,true,50,50)==4);
    Check(EconomyClusterMath::AssistRank(true,false,false,false,false,50,50)==100);
    Check(EconomyClusterMath::AssistRank(true,false,false,false,true,49,50)==100);
}
void test_priority_switches_but_equal_priority_keeps_current_task() {
    Check(EconomyClusterMath::Prefer(1,.01f,2,1,3,.99f,1));
    Check(!EconomyClusterMath::Prefer(3,.99f,2,1,1,.01f,1));
    Check(!EconomyClusterMath::Prefer(3,.99f,2,1,3,.01f,1));
    Check(EconomyClusterMath::Prefer(3,.01f,1,1,3,.99f,2));
}
void test_new_target_prefers_progress_then_stable_id() {
    Check(EconomyClusterMath::Prefer(3,.5f,9,-1,3,.4f,8));
    Check(EconomyClusterMath::Prefer(3,.5f,8,-1,3,.5f,9));
    Check(!EconomyClusterMath::Prefer(3,.5f,9,-1,3,.5f,8));
    Check(!EconomyClusterMath::Prefer(100,1,9,-1,100,-1,-1));
}
