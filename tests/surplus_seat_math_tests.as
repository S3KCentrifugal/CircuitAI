void test_claim_only_with_surplus_and_an_eligible_free_seat() {
    Check(SurplusSeatMath::Decide(false, false, true, true, 100, 100, 0, 600) == SurplusSeatMath::CLAIM);
    Check(SurplusSeatMath::Decide(false, true, true, true, 100, 100, 0, 600) == SurplusSeatMath::NONE);
    Check(SurplusSeatMath::Decide(false, false, false, true, 100, 100, 0, 600) == SurplusSeatMath::NONE);
    Check(SurplusSeatMath::Decide(false, false, true, false, 100, 100, 0, 600) == SurplusSeatMath::NONE);
}
void test_retry_window_blocks_a_claim() {
    Check(SurplusSeatMath::Decide(false, false, true, true, 100, 100, 450, 600) == SurplusSeatMath::NONE);
    Check(SurplusSeatMath::Decide(false, false, true, true, 450, 450, 450, 600) == SurplusSeatMath::CLAIM);
}
void test_holder_keeps_the_seat_through_the_grace() {
    Check(SurplusSeatMath::Decide(true, false, true, false, 700, 100, 0, 600) == SurplusSeatMath::HOLD);
    Check(SurplusSeatMath::Decide(true, false, true, false, 701, 100, 0, 600) == SurplusSeatMath::RELEASE_SURPLUS);
    Check(SurplusSeatMath::Decide(true, false, true, true, 5000, 5000, 0, 600) == SurplusSeatMath::HOLD);
}
void test_ineligible_holder_is_released_at_once() {
    Check(SurplusSeatMath::Decide(true, false, false, true, 100, 100, 0, 600) == SurplusSeatMath::RELEASE_INELIGIBLE);
}
void test_idle_fallback_and_its_repeat() {
    Check(!SurplusSeatMath::IdleRelease(-1, 1000, 150));
    Check(!SurplusSeatMath::IdleRelease(900, 1000, 150));
    Check(SurplusSeatMath::IdleRelease(850, 1000, 150));
    Check(!SurplusSeatMath::IdleRelease(0, 1000, 0));
    Check(SurplusSeatMath::FallbackRepeated(7, 1000, 7, 1200, 450));
    Check(!SurplusSeatMath::FallbackRepeated(7, 1000, 8, 1200, 450));
    Check(!SurplusSeatMath::FallbackRepeated(7, 1000, 7, 1450, 450));
    Check(!SurplusSeatMath::FallbackRepeated(-1, 1000, 7, 1200, 450));
}
void test_converter_waiver_only_for_the_holder_in_excess() {
    Check(SurplusSeatMath::ConverterWaived(true, true));
    Check(!SurplusSeatMath::ConverterWaived(false, true));
    Check(!SurplusSeatMath::ConverterWaived(true, false));
}
void test_surplus_predicates() {
    Check(SurplusSeatMath::MetalSurplus(1000, 1000, false));
    Check(!SurplusSeatMath::MetalSurplus(999, 1000, false));
    Check(!SurplusSeatMath::MetalSurplus(5000, 1000, true));
    Check(SurplusSeatMath::EnergyExcess(false, false, 9000, 10000, 0.9f));
    Check(!SurplusSeatMath::EnergyExcess(false, false, 8999, 10000, 0.9f));
    Check(SurplusSeatMath::EnergyExcess(false, true, 0, 10000, 0.9f));
    Check(!SurplusSeatMath::EnergyExcess(true, true, 10000, 10000, 0.9f));
}
