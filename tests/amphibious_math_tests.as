void test_role_scope() { Check(AmphibiousMath::Scope(true,false,true)); Check(AmphibiousMath::Scope(false,true,true)); Check(!AmphibiousMath::Scope(false,false,true)); Check(!AmphibiousMath::Scope(true,false,false)); }
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
