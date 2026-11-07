void test_no_recruitment_while_support_exists_or_is_pending() {
    Check(RushBootstrapMath::Needed(0,0,0,5));
    Check(RushBootstrapMath::Needed(4,0,0,5));
    Check(!RushBootstrapMath::Needed(5,0,0,5));
    Check(!RushBootstrapMath::Needed(0,1,0,5));
    Check(!RushBootstrapMath::Needed(0,0,1,5));
    Check(!RushBootstrapMath::Needed(0,0,0,0));
}
void test_locality_prefers_local_assistant_over_remote_idle_worker() {
    Check(RushBootstrapMath::Prefer(800*800,false,801*801,true,800));
    Check(RushBootstrapMath::Prefer(700*700,true,100*100,false,800));
    Check(RushBootstrapMath::Prefer(100*100,true,200*200,true,800));
    Check(!RushBootstrapMath::Prefer(100*100,true,100*100,true,800));
    Check(RushBootstrapMath::Prefer(1000000,true,1000001,true,800));
}
void test_timeout_tracks_progress_not_total_journey_length() {
    Check(!RushBootstrapMath::Stalled(1000,900,300));
    Check(RushBootstrapMath::Stalled(1200,900,300));
    Check(!RushBootstrapMath::Stalled(1200,900,0));
}
