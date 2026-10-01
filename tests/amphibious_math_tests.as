void test_role_scope() { Check(AmphibiousMath::Scope(true,false,true)); Check(AmphibiousMath::Scope(false,true,true)); Check(!AmphibiousMath::Scope(false,false,true)); Check(!AmphibiousMath::Scope(true,false,false)); }
void test_formation_spreads_centre_out_without_duplicate_slots() {
    Check(AmphibiousMath::FormationLane(0)==0);
    Check(AmphibiousMath::FormationLane(1)==1);
    Check(AmphibiousMath::FormationLane(2)==-1);
    Check(AmphibiousMath::FormationLane(5)==3);
    Check(AmphibiousMath::FormationLane(-1)==0);
}
void test_empty_wave_never_arrives() { Check(!AmphibiousMath::Gathered(0,0,0.8f)); }
void test_quorum_rounds_up() { Check(!AmphibiousMath::Gathered(6,4,0.8f)); Check(AmphibiousMath::Gathered(6,5,0.8f)); }
void test_no_single_unit_trickle() { Check(!AmphibiousMath::Release(1,1,6,3,9000,2700,0.8f)); }
void test_timeout_releases_partial_wave_only_when_gathered() { Check(AmphibiousMath::Release(3,3,6,3,2700,2700,0.8f)); Check(!AmphibiousMath::Release(3,2,6,3,2700,2700,0.8f)); }
void test_full_wave_waits_for_late_member() { Check(!AmphibiousMath::Release(6,4,6,3,0,2700,0.8f)); }
void test_contested_land_cannot_be_secure() { Check(!AmphibiousMath::Secured(6,6,0.8f,true,9999,540)); }
void test_secure_timer_and_quorum_required() { Check(!AmphibiousMath::Secured(6,6,0.8f,false,539,540)); Check(!AmphibiousMath::Secured(6,4,0.8f,false,540,540)); Check(AmphibiousMath::Secured(6,5,0.8f,false,540,540)); }
void test_underwater_is_not_landing() { Check(!AmphibiousMath::Landing(true,-10)); Check(AmphibiousMath::Landing(true,1)); Check(!AmphibiousMath::Landing(false,1)); }
void test_stalled_crossing_cannot_skip_security() { Check(!AmphibiousMath::MayAdvance(false,false)); Check(AmphibiousMath::MayAdvance(true,false)); Check(AmphibiousMath::MayAdvance(false,true)); }
void test_marauder_economy_priority() { Check(AmphibiousMath::TargetScore(true,true,100,800,0)>AmphibiousMath::TargetScore(true,false,200,800,0)); Check(AmphibiousMath::TargetScore(false,true,100,800,0)<AmphibiousMath::TargetScore(false,false,200,800,0)); }
void test_recruit_reserves_economy_bank() {
    Check(AmphibiousMath::RecruitReady(80,80,300,300,900,600,300,2000,1500,false));
    Check(!AmphibiousMath::RecruitReady(80,80,300,300,899,600,300,2000,1500,false));
    Check(!AmphibiousMath::RecruitReady(80,80,300,300,900,600,300,1499,1500,false));
    Check(!AmphibiousMath::RecruitReady(80,80,300,300,900,600,300,2000,1500,true));
}
void test_brief_income_spike_cannot_recruit() {
    Check(!AmphibiousMath::RecruitReady(80,80,299,300,2000,600,300,2000,1500,false));
    Check(!AmphibiousMath::RecruitReady(79,80,300,300,2000,600,300,2000,1500,false));
}
void test_energy_limits_recruitment_even_with_metal_float() {
    Check(AmphibiousMath::RecruitSeconds(600,13200,80,1000,0.15f,0.2f)>65.9f);
    Check(AmphibiousMath::RecruitSeconds(600,13200,80,2000,0.15f,0.2f)<50.1f);
    Check(AmphibiousMath::RecruitSeconds(600,13200,80,0,0.15f,0.2f)<0);
}
void test_guard_split_preserves_assault_and_group_bound() {
    Check(AmphibiousMath::GuardAllocation(6,3,3,0,2)==3);
    Check(AmphibiousMath::GuardAllocation(5,3,3,0,2)==0);
    Check(AmphibiousMath::GuardAllocation(6,3,3,2,2)==0);
}
void test_empty_beach_is_never_valuable() {
    Check(AmphibiousMath::BeachScore(0,10,10,0)==0);
    Check(AmphibiousMath::BeachScore(100,500,100,0)>AmphibiousMath::BeachScore(100,2000,100,0));
}
void test_guard_survives_brief_observation_gap_but_releases_lost_claim() {
    Check(!AmphibiousMath::GuardRelease(false,59,60,false));
    Check(AmphibiousMath::GuardRelease(false,60,60,false));
    Check(!AmphibiousMath::GuardRelease(true,600,60,false));
    Check(AmphibiousMath::GuardRelease(true,0,60,true));
}
void test_simultaneous_claims_have_one_stable_winner() {
    Check(AmphibiousMath::ClaimPrecedes(1,9,2,1));
    Check(!AmphibiousMath::ClaimPrecedes(2,1,1,9));
    Check(AmphibiousMath::ClaimPrecedes(1,1,1,2));
    Check(!AmphibiousMath::ClaimPrecedes(1,2,1,2));
}
