void test_energy_limits_rich_field_spending() { Check(MetalMath::Sustainable(500, 1030, 30, 50) == 20); }
void test_metal_limits_balanced_spending() { Check(MetalMath::Sustainable(10, 1030, 30, 50) == 10); }
void test_opening_has_time_and_count_limits() { Check(MetalMath::OpeningDone(2, 2, 30, 100) && MetalMath::OpeningDone(0, 2, 100, 100)); }
void test_field_is_not_a_reason_to_delay_factory() { Check(!MetalMath::OpeningDone(1, 2, 30, 100)); }
void test_float_stops_mexes() { Check(!MetalMath::NeedMex(100, 100, 25, 900, 1000, 200)); }
void test_energy_surplus_allows_mex_growth() { Check(MetalMath::NeedMex(10, 1000, 25, 100, 1000, 12)); }
void test_new_lab_needs_energy_as_well_as_metal() { Check(!MetalMath::CanInvest(100, 50, 10000, 100, 3000, 15000, 90)); }
void test_funded_investment_passes() { Check(MetalMath::CanInvest(100, 1000, 10000, 100, 3000, 15000, 90)); }
void test_afus_does_not_justify_removing_needed_wind() { Check(!MetalMath::RetirePower(3500, 500, 3200, 3100, .1f)); }
void test_replaced_wind_can_be_retired() { Check(MetalMath::RetirePower(4500, 500, 3000, 3100, .1f)); }
void test_full_small_bank_can_fund_future_lab() { Check(MetalMath::NeedInvestmentStorage(1100, 1150, 2900)); }
void test_storage_stops_when_next_investment_fits() { Check(!MetalMath::NeedInvestmentStorage(4000, 4000, 2900)); }
