void test_lane_lengths_are_normalized_before_comparison() {
    const float shortLane = FrontlineEngineeringMath::OwnedShare(1000.0f, 2000.0f);
    const float longLane = FrontlineEngineeringMath::OwnedShare(2000.0f, 8000.0f);
    Check(shortLane == 0.5f);
    Check(longLane == 0.25f);
    Check(FrontlineEngineeringMath::BetterLane(longLane, 2, shortLane, 1));
}
void test_unknown_lane_does_not_masquerade_as_lost_territory() {
    Check(FrontlineEngineeringMath::OwnedShare(100.0f, 0.0f) < 0.0f);
    Check(FrontlineEngineeringMath::OwnedShare(-1.0f, 2000.0f) < 0.0f);
    Check(!FrontlineEngineeringMath::BetterLane(-1.0f, 1, 0.5f, 2));
    Check(FrontlineEngineeringMath::BetterLane(0.5f, 2, -1.0f, -1));
}
void test_lane_endpoints_and_equal_progress_are_deterministic() {
    Check(FrontlineEngineeringMath::OwnedShare(0.0f, 2000.0f) == 0.0f);
    Check(FrontlineEngineeringMath::OwnedShare(3000.0f, 2000.0f) == 1.0f);
    Check(FrontlineEngineeringMath::BetterLane(0.5f, 1, 0.5f, 2));
    Check(!FrontlineEngineeringMath::BetterLane(0.5f, 2, 0.5f, 1));
}
void test_reassessment_waits_until_exact_five_minute_deadline() {
    const int released = 18000;
    const int deadline = released + 300 * 30;
    Check(FrontlineEngineeringMath::ReassessmentDue(released, -1));
    Check(!FrontlineEngineeringMath::ReassessmentDue(deadline - 1, deadline));
    Check(FrontlineEngineeringMath::ReassessmentDue(deadline, deadline));
}
void test_combat_production_requires_fresh_nearby_lane_evidence() {
    Check(FrontlineEngineeringMath::CombatNearby(600,200,45*30,45*30,800));
    Check(!FrontlineEngineeringMath::CombatNearby(600,201,0,45*30,800));
    Check(!FrontlineEngineeringMath::CombatNearby(-1,0,0,45*30,800));
    Check(!FrontlineEngineeringMath::CombatNearby(0,0,45*30+1,45*30,800));
    Check(!FrontlineEngineeringMath::CombatNearby(0,0,-1,45*30,800));
}
