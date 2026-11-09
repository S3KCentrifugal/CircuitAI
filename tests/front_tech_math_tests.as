void test_only_an_accepted_request_latches_the_delivery_plan() {
    Check(!FrontTechMath::RememberPlan(false, false, true));
    Check(!FrontTechMath::RememberPlan(false, true, false));
    Check(FrontTechMath::RememberPlan(false, true, true));
    Check(FrontTechMath::RememberPlan(true, false, false));
}
void test_front_delivery_gate_boundaries_and_income_drop() {
    Check(!FrontTechMath::FactoryAllowed(true, true, 39.99f, 40));
    Check(FrontTechMath::FactoryAllowed(true, true, 40, 40));
    Check(FrontTechMath::FactoryAllowed(true, true, 80, 40));
    Check(!FrontTechMath::FactoryAllowed(true, true, 20, 40));
    Check(FrontTechMath::FactoryAllowed(true, true, 20, 20));
    Check(FrontTechMath::FactoryAllowed(true, true, 0, 0));
}
void test_default_roles_and_unplanned_front_are_unchanged() {
    Check(FrontTechMath::FactoryAllowed(false, true, 0, 40));
    Check(FrontTechMath::FactoryAllowed(true, false, 0, 40));
}
