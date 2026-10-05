void test_sea_policy_boundaries() {
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
