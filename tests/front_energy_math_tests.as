void test_afus_requires_both_income_boundaries() {
    Check(!FrontEnergyMath::AdvancedAllowed(100, 3999.9f, 70, 4000));
    Check(!FrontEnergyMath::AdvancedAllowed(69.9f, 5000, 70, 4000));
    Check(FrontEnergyMath::AdvancedAllowed(70, 4000, 70, 4000));
    Check(!FrontEnergyMath::AdvancedAllowed(70, 4000, 80, 5000));
    Check(FrontEnergyMath::AdvancedAllowed(80, 5000, 80, 5000));
}
void test_normal_fusion_remains_available_until_both_gates_clear() {
    Check(FrontEnergyMath::NormalAllowed(60, 5000, true, 40, 1200, 4000, false));
    Check(FrontEnergyMath::NormalAllowed(80, 3000, true, 40, 1200, 4000, false));
    Check(!FrontEnergyMath::NormalAllowed(80, 5000, true, 40, 1200, 4000, true));
    Check(!FrontEnergyMath::NormalAllowed(60, 5000, false, 40, 1200, 4000, false));
    Check(!FrontEnergyMath::NormalAllowed(20, 5000, true, 40, 1200, 4000, false));
}
void test_afus_gate_preserves_configured_caps() {
    Check(FrontEnergyMath::AdmissionCap(false, 5) == 0);
    Check(FrontEnergyMath::AdmissionCap(true, 5) == 5);
    Check(FrontEnergyMath::AdmissionCap(true, 0) == 0);
}
