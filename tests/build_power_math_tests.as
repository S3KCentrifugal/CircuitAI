void test_full_bank_funds_negative_own_balance() {
    Check(BuildPowerMath::Funded(8000, 2000, 30, 80, 0, 230, 10, 15, 60));
    Check(!BuildPowerMath::Funded(2500, 2000, 30, 80, 0, 230, 10, 15, 60));
}
void test_energy_is_independent() {
    Check(BuildPowerMath::Funded(500, 100, 20, 5, 0, 110, 30, 2, 60));
    Check(!BuildPowerMath::Funded(1000, 200, 160, 160, 0, 2100, 30, 20, 60));
    Check(BuildPowerMath::Funded(1000, 200, 160, 60, 0, 2100, 30, 20, 60));
}
void test_unaffordable_opening_turret_does_not_veto_constructor() {
    Check(BuildPowerMath::Funded(1000, 200, 160, 60, 0, 2100, 30, 20, 60));
    Check(!BuildPowerMath::Funded(1000, 200, 160, 60, 0, 3200, 15, 20, 60));
}
void test_reserve_before_completion_not_just_end() {
    Check(!BuildPowerMath::Funded(500, 200, 100, 0, 0, 3000, 10, 0, 60));
    Check(BuildPowerMath::Funded(500, 200, 100, 0, 0, 3000, 30, 0, 60));
}
void test_committed_and_outbound_capital() {
    Check(BuildPowerMath::Funded(8000, 2000, 30, 80, 0, 230, 10, 15, 60));
    Check(!BuildPowerMath::Funded(8000, 2000, 30, 80, 4000, 230, 10, 15, 60));
    Check(!BuildPowerMath::Funded(4000, 2000, 30, 80, 0, 230, 10, 15, 60));
}
void test_long_investments_reserve_unpaid_cost() {
    Check(!BuildPowerMath::Funded(500, 100, 0, 0, 0, 600, 120, 0, 60));
    Check(BuildPowerMath::Funded(800, 100, 0, 0, 0, 600, 120, 0, 60));
}
void test_no_donations_required_with_capital() {
    Check(BuildPowerMath::Room(8000, 2000, 30, 80, 0, 60) == 50);
    Check(BuildPowerMath::Room(2500, 2000, 30, 80, 0, 60) == 0);
}
void test_funded_power_uses_both_resources() {
    Check(BuildPowerMath::Power(10, 200, 1000, 100, 4000) == 50);
    Check(BuildPowerMath::Power(10, 200, 1000, 100, 0) == 100);
    Check(BuildPowerMath::Power(10, 200, 0, 100, 4000) == 0);
}
void test_persistent_full_does_not_require_rise() {
    Check(BuildPowerMath::Pressure(1000, 1000, 1000, 15, 15, 15, .9f, 30));
    Check(!BuildPowerMath::Pressure(1000, 1000, 1000, 14, 15, 14, .9f, 30));
    Check(BuildPowerMath::Pressure(500, 1000, 450, 15, 15, 0, .9f, 30));
}
void test_queue_and_arrivals_are_capacity() {
    Check(BuildPowerMath::Shortage(600, 200, 400) == 0);
    Check(BuildPowerMath::Shortage(600, 200, 100) == 300);
    Check(BuildPowerMath::Batch(1000, 5000, 30, 2, 8) == 4);
    Check(BuildPowerMath::Batch(1000, 5000, 30, 6, 8) == 0);
}
void test_invalid_inputs_are_not_funding() {
    Check(!BuildPowerMath::Funded(1000, 100, 20, 5, 0, 100, 0, 1, 60));
    Check(!BuildPowerMath::Funded(1000, 100, 20, 5, 0, 100, 10, 1, 0));
    Check(!BuildPowerMath::Funded(-1, 100, 20, 5, 0, 100, 10, 1, 60));
    Check(BuildPowerMath::Power(100, 100, 100, 0, 0) == 0);
    Check(BuildPowerMath::Batch(1000, 0, 30, 0, 8) == 0);
}
void test_repeated_refills_survive_overflow_sharing() {
    array<float> banks = {1000, 750, 1000, 1000, 750, 1000};
    Check(BuildPowerMath::Refilling(banks, 1000, .8f, .9f));
}
void test_one_gift_is_not_recurring_refill_pressure() {
    array<float> banks = {100, 100, 1000, 900, 800, 750};
    Check(!BuildPowerMath::Refilling(banks, 1000, .8f, .9f));
}
void test_second_callback_cannot_reuse_first_cost_or_spending() {
    Check(BuildPowerMath::Funded(1000, 100, 0, 0, 0, 230, 10, 10, 60));
    Check(!BuildPowerMath::Funded(1000, 100, 0, 10, 230, 230, 10, 10, 60));
}
void test_faster_factory_must_pass_earlier_cash_breakpoint() {
    Check(BuildPowerMath::Funded(300, 100, 20, 0, 0, 500, 30, 0, 60));
    Check(!BuildPowerMath::Funded(300, 100, 20, 0, 0, 500, 5, 0, 60));
}
void test_protected_lab_bank_cannot_fund_discretionary_workforce() {
    Check(!BuildPowerMath::Funded(2900, 2900, 10, 10, 0, 100, 10, 5, 60));
    Check(BuildPowerMath::Funded(3600, 2900, 10, 10, 0, 100, 10, 5, 60));
}
void test_no_capacity_is_not_a_builder_batch() {
    Check(BuildPowerMath::Shortage(0, 0, 0) == 0);
    Check(BuildPowerMath::Shortage(300, 100, 300) == 0);
    Check(BuildPowerMath::Batch(1000, 5000, 30, 8, 8) == 0);
}
void test_assigned_energy_limited_workers_use_new_budget_first() {
    Check(BuildPowerMath::ProjectShortage(600, 100, 300000, 6, 1000, 0) == 0);
    Check(BuildPowerMath::ProjectShortage(600, 700, 300000, 6, 1000, 0) == 300);
}
void test_project_arrivals_and_queued_support_count_once() {
    Check(BuildPowerMath::ProjectShortage(600, 700, 300000, 6, 1000, 300) == 0);
    Check(BuildPowerMath::ProjectShortage(600, 700, 6000, 6, 1000, 0) == 0);
    Check(BuildPowerMath::ProjectShortage(600, 700, 300000, 0, 1000, 0) == 0);
}
