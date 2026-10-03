void test_threshold_is_inclusive_and_uses_storage()
{
    Check(TeamShareMath::Budget(949.0f, 1000.0f, 0.95f, 0.20f, true) == 0.0f);
    Check(TeamShareMath::Budget(950.0f, 1000.0f, 0.95f, 0.20f, true) == 200.0f);
    Check(TeamShareMath::Budget(1000.0f, 1000.0f, 0.95f, 0.20f, true) == 200.0f);
    Check(TeamShareMath::Budget(19000.0f, 20000.0f, 0.95f, 0.20f, true) == 4000.0f);
}
void test_opening_bank_is_protected()
{
    Check(TeamShareMath::Budget(1000.0f, 1000.0f, 0.95f, 0.20f, false) == 0.0f);
}
void test_missing_storage_empty_bank_and_disabled_budget()
{
    Check(TeamShareMath::Budget(1000.0f, 0.0f, 0.95f, 0.20f, true) == 0.0f);
    Check(TeamShareMath::Budget(0.0f, 1000.0f, 0.95f, 0.20f, true) == 0.0f);
    Check(TeamShareMath::Budget(1000.0f, 1000.0f, 0.95f, 0.0f, true) == 0.0f);
}
void test_custom_budget_cannot_overdraw_bank()
{
    Check(TeamShareMath::Budget(500.0f, 1000.0f, 0.5f, 0.8f, true) == 500.0f);
}
void test_minimum_and_recipient_capacity()
{
    Check(TeamShareMath::Amount(24.0f, 200.0f, 25.0f) == 0.0f);
    Check(TeamShareMath::Amount(25.0f, 200.0f, 25.0f) == 25.0f);
    Check(TeamShareMath::Amount(500.0f, 200.0f, 25.0f) == 200.0f);
    Check(TeamShareMath::Amount(500.0f, 24.0f, 25.0f) == 0.0f);
    Check(TeamShareMath::Amount(-1.0f, 200.0f, 25.0f) == 0.0f);
}
void test_budget_is_shared_between_recipients()
{
    float budget = TeamShareMath::Budget(1000.0f, 1000.0f, 0.95f, 0.20f, true);
    const float first = TeamShareMath::Amount(60.0f, budget, 25.0f);
    budget -= first;
    const float second = TeamShareMath::Amount(900.0f, budget, 25.0f);
    Check(first == 60.0f && second == 140.0f);
    Check(TeamShareMath::Amount(900.0f, budget - second, 25.0f) == 0.0f);
}
