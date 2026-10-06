void test_seaplane_requires_sustained_income_even_with_gifted_bank() {
    Check(!SeaMath::SeaplaneEconomyReady(false,80,1500,100000,100000,1450,5000,80,1500,500,1000));
    Check(!SeaMath::SeaplaneEconomyReady(true,79.9f,1500,100000,100000,1450,5000,80,1500,500,1000));
    Check(!SeaMath::SeaplaneEconomyReady(true,80,1499,100000,100000,1450,5000,80,1500,500,1000));
}
void test_seaplane_preserves_full_cost_and_reserve_after_commitments() {
    Check(SeaMath::SeaplaneEconomyReady(true,80,1500,1950,6000,1450,5000,80,1500,500,1000));
    Check(!SeaMath::SeaplaneEconomyReady(true,80,1500,1949,6000,1450,5000,80,1500,500,1000));
    Check(!SeaMath::SeaplaneEconomyReady(true,80,1500,1950,5999,1450,5000,80,1500,500,1000));
    // A 400-metal queued commitment is unavailable even with 2300 banked.
    Check(!SeaMath::SeaplaneEconomyReady(true,100,2000,2300-400,10000,1450,5000,80,1500,500,1000));
    Check(!SeaMath::SeaplaneEconomyReady(true,100,2000,-100,10000,1450,5000,80,1500,500,1000));
}
void test_seaplane_uses_actual_faction_and_modified_costs() {
    Check(SeaMath::SeaplaneEconomyReady(true,80,1500,1900,6500,1400,5500,80,1500,500,1000));
    Check(!SeaMath::SeaplaneEconomyReady(true,80,1500,1950,6000,2900,10000,80,1500,500,1000));
    Check(!SeaMath::SeaplaneEconomyReady(true,80,1500,1950,6000,-1,5000,80,1500,500,1000));
    Check(!SeaMath::SeaplaneEconomyReady(true,80,1500,1950,6000,1450,5000,80,1500,-1,1000));
}
void test_sea_policy_boundaries() {
    Check(!SeaMath::SeaplaneNext(false,true,0,0));
    Check(!SeaMath::SeaplaneNext(true,false,0,0));
    Check(SeaMath::SeaplaneNext(true,true,0,0));
    Check(!SeaMath::SeaplaneNext(true,true,1,0));
    Check(!SeaMath::SeaplaneNext(true,true,0,1));
    Check(SeaMath::RememberThreat(1000,800,0,900)==800);
    Check(SeaMath::RememberThreat(1000,0,899,900)==1000);
    Check(SeaMath::RememberThreat(1000,0,900,900)==0);
    Check(SeaMath::RememberThreat(1000,0,0,0)==0);
    Check(!SeaMath::ReleaseFleet(0,9999,7,1800));
    Check(SeaMath::ReleaseFleet(7,0,7,1800));
    Check(!SeaMath::ReleaseFleet(6,1799,7,1800));
    Check(SeaMath::ReleaseFleet(1,1800,7,1800));
    Check(!SeaMath::NeedsScreen(0,0,1.2f));
    Check(SeaMath::NeedsScreen(1000,1199,1.2f));
    Check(!SeaMath::NeedsScreen(1000,1200,1.2f));
    Check(SeaMath::NewObjective(1,2,0,0,600));
    Check(!SeaMath::NewObjective(1,1,0,599,600));
    Check(SeaMath::NewObjective(1,1,0,600,600));
    Check(SeaMath::Deficit(1000,400,600)==0);
    Check(SeaMath::Deficit(1000,400,200)==400);
    Check(SeaMath::CounterScore(1000,1000,20,false)==0);
    Check(SeaMath::CounterScore(100,1000,20,true)==5);
    Check(SeaMath::CounterScore(1000,1000,10,true)>SeaMath::CounterScore(1000,1000,20,true));
    Check(SeaMath::Missing(5,4,1,5)==0);
    Check(SeaMath::Missing(5,4,0,5)==1);
    Check(SeaMath::Missing(5,8,0,5)==0);
    Check(!SeaMath::TechReady(39,800,1200,2000,40,800,800,4400,22000,150,.65));
    Check(SeaMath::TechReady(40,800,1200,2000,40,800,800,4400,22000,150,.65));
    Check(!SeaMath::TechReady(75,800,799,2000,40,800,800,4400,22000,150,.65));
    Check(!SeaMath::RetireReady(true,false,true,true,false,5000,2900));
    Check(!SeaMath::RetireReady(true,true,true,true,true,5000,2900));
    Check(!SeaMath::RetireReady(true,true,false,true,false,5000,2900));
    Check(SeaMath::RetireReady(true,true,true,true,false,5000,2900));
    Check(!SeaMath::ForwardWorthwhile(4000,3500,700,60,30));
    Check(SeaMath::ForwardWorthwhile(4000,3000,700,60,30));
}
void test_rear_fusion_footprint_keeps_protected_margin() {
    Check(SeaMath::RearFootprint(-160,96,64));
    Check(!SeaMath::RearFootprint(-159,96,64));
    Check(!SeaMath::RearFootprint(160,96,64));
    Check(!SeaMath::RearFootprint(-160,-1,64));
}
void test_shared_factory_support_budget_and_pending_power() {
    Check(SeaMath::ProductionShare(300,1200)==.25f);
    Check(SeaMath::ProductionShare(900,1200)==.75f);
    Check(SeaMath::ProductionShare(300,300)==1);
    Check(SeaMath::ProductionShare(0,0)==0);
    Check(SeaMath::ProductionShare(300,0)==0);
    Check(SeaMath::SupportNeeded(1000,800,300,200,40));
    Check(!SeaMath::SupportNeeded(899,800,300,200,40));
    // Framed/queued 200 BP removes a shortage even before it becomes usable.
    Check(!SeaMath::SupportNeeded(1000,1000,300,200,40));
    Check(!SeaMath::SupportNeeded(20000,8300,300,200,40));
    Check(SeaMath::SupportNeeded(20000,8100,300,200,40));
}
void test_counter_admission_and_time_to_coverage() {
    // Existing and queued coverage together prevent duplicate responses.
    Check(SeaMath::Deficit(1500,900,600)==0);
    Check(SeaMath::Deficit(1500,900,300)==300);
    // Prefer the timely adequate escort over a capital hull for a small raid.
    Check(SeaMath::CounterScore(300,400,10,true)>SeaMath::CounterScore(300,10000,120,true));
    Check(SeaMath::CounterScore(300,400,10,false)==0);
    Check(SeaMath::CounterScore(300,400,0,true)==0);
    Check(SeaMath::CounterScore(0,400,10,true)==0);
    Check(SeaMath::CounterScore(300,0,10,true)==0);
    // A lower income tech transition is still constrained by its full package.
    Check(!SeaMath::TechReady(30,800,800,2000,30,800,800,4400,22000,150,.65));
    Check(SeaMath::TechReady(30,800,1500,2000,30,800,800,4400,22000,150,.65));
    Check(!SeaMath::TechReady(30,799,5000,2000,30,800,800,4400,22000,150,.65));
}
void test_canceled_unframed_berth_is_retryable() {
    Check(SeaMath::RetryBerth(true,false,0));
    Check(!SeaMath::RetryBerth(true,true,0));
    Check(!SeaMath::RetryBerth(true,false,1));
    Check(!SeaMath::RetryBerth(true,false,2));
    Check(!SeaMath::RetryBerth(true,false,3));
    Check(!SeaMath::RetryBerth(true,false,-1));
    Check(!SeaMath::RetryBerth(false,false,0));
}
void test_safety_interruption_restarts_unchanged_site_timer() {
    Check(SeaMath::RestartStability(-1,false));
    Check(SeaMath::RestartStability(1200,true));
    Check(!SeaMath::RestartStability(1200,false));
}

void test_yard_whole_footprint_stays_forward_of_economy() {
    Check(SeaMath::ForwardFootprint(300,100,72,128));
    Check(!SeaMath::ForwardFootprint(299,100,72,128));
    Check(!SeaMath::ForwardFootprint(300,-1,72,128));
    Check(!SeaMath::ForwardFootprint(300,100,72,-1));
}
void test_opening_exception_does_not_return_after_factory_loss() {
    Check(SeaMath::OpeningFactory(true,true,true,true));
    Check(!SeaMath::OpeningFactory(false,true,true,true));
    Check(!SeaMath::OpeningFactory(true,false,true,true));
    Check(!SeaMath::OpeningFactory(true,true,false,true));
    Check(!SeaMath::OpeningFactory(true,true,true,false));
}
void test_aa_screen_slots_stay_separate_and_overlap() {
    // Reinforcements/losses do not move survivors' slots. Fixed six columns
    // form as many rows as necessary rather than collapsing to a centre.
    for (int n=0;n<120;++n) for (int j=0;j<n;++j)
        Check(SeaMath::AAColumn(n,6)!=SeaMath::AAColumn(j,6)
            || SeaMath::AARow(n,6)!=SeaMath::AARow(j,6));
    Check(SeaMath::AAColumn(0,6)==0 && SeaMath::AAColumn(1,6)==1 && SeaMath::AAColumn(2,6)==-1);
    Check(SeaMath::AARow(6,6)==1 && SeaMath::AAColumn(6,6)==0);
    Check(SeaMath::AARow(6,0)==6); // invalid column tuning cannot divide by zero
    Check(SeaMath::AASpacing(320,750)==320);
    Check(SeaMath::AASpacing(320,400)==220);
}
void test_interception_respects_speed_weapon_reach_and_horizon() {
    Check(SeaMath::InterceptLead(700,60,750,12)==0);
    Check(SeaMath::InterceptLead(990,60,750,12)==4);
    Check(SeaMath::InterceptLead(5000,60,750,12)==12);
    Check(SeaMath::InterceptLead(5000,0,750,12)==0);
    Check(SeaMath::InterceptLead(5000,60,750,0)==0);
}

void test_recovery_low_metal_hysteresis() {
    Check(SeaMath::RecoveryLowMetal(false,199,1000,.2f,.4f));
    Check(!SeaMath::RecoveryLowMetal(false,200,1000,.2f,.4f));
    Check(SeaMath::RecoveryLowMetal(true,399,1000,.2f,.4f));
    Check(!SeaMath::RecoveryLowMetal(true,400,1000,.2f,.4f));
    Check(!SeaMath::RecoveryLowMetal(true,0,0,.2f,.4f));
}
void test_recovery_fleet_and_income_both_scale_capacity() {
    Check(SeaMath::RecoveryCount(1000,1499,60,6000)==0);
    Check(SeaMath::RecoveryCount(20,1500,60,6000)==1);
    Check(SeaMath::RecoveryCount(60,6000,60,6000)==2);
    Check(SeaMath::RecoveryCount(600,6000,60,6000)==2);
    Check(SeaMath::RecoveryCount(120,60000,60,6000)==3);
    Check(SeaMath::RecoveryCount(600,60000,60,6000)==11);
    Check(SeaMath::RecoveryCount(60,6000,0,6000)==0);
}
