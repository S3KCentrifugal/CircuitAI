void test_full_metal_releases_reactor_even_with_full_energy_and_pending_conversion() {
    Check(EcoPlanner::DecideConversion(true,true,1,2,true,true,true,true,false) == EcoPlanner::METAL_FULL);
}
void test_recovery_income_exception_requires_lost_capacity_and_full_funding() {
    Check(EcoPlanner::ReplacementFunded(1,0,500,500));
    Check(!EcoPlanner::ReplacementFunded(0,0,5000,500));
    Check(!EcoPlanner::ReplacementFunded(1,0,499,500));
    Check(!EcoPlanner::ReplacementFunded(1,1,5000,500));
    Check(!EcoPlanner::ReplacementFunded(2,1,999,500));
    Check(EcoPlanner::ReplacementFunded(2,1,1000,500));
    Check(!EcoPlanner::ReplacementFunded(1,0,500,0));
}
void test_saturated_installed_capacity_releases_first_reactor_without_air_worker() {
    Check(EcoPlanner::DecideConversion(false,true,0,2,false,true,true,true,false) == EcoPlanner::CAPACITY);
}
void test_pending_converter_retains_its_supply_commitment() {
    Check(EcoPlanner::DecideConversion(false,true,1,2,false,true,true,true,false) == EcoPlanner::PENDING);
    Check(EcoPlanner::DecideConversion(false,true,2,2,true,true,true,true,false) == EcoPlanner::PENDING);
}
void test_failed_placement_releases_reactor_but_success_remains_eligible() {
    Check(EcoPlanner::DecideConversion(false,true,0,2,true,true,true,true,true) == EcoPlanner::PLACEMENT);
    Check(EcoPlanner::DecideConversion(false,true,0,2,true,true,true,true,false) == EcoPlanner::READY);
}
void test_missing_capped_unbuildable_and_income_gated_conversion_cannot_hold_reactor() {
    Check(EcoPlanner::DecideConversion(false,false,0,2,true,true,true,true,false) == EcoPlanner::UNAVAILABLE);
    Check(EcoPlanner::DecideConversion(false,true,0,2,true,false,true,true,false) == EcoPlanner::UNAVAILABLE);
    Check(EcoPlanner::DecideConversion(false,true,0,2,true,true,false,true,false) == EcoPlanner::UNBUILDABLE);
    Check(EcoPlanner::DecideConversion(false,true,0,2,true,true,true,false,false) == EcoPlanner::INCOME);
}

void test_disabled_parallelism_is_not_a_phantom_pending_task() {
    Check(EcoPlanner::DecideConversion(false,true,0,0,true,true,true,true,false) == EcoPlanner::UNAVAILABLE);
    Check(EcoPlanner::DecideConversion(false,true,1,0,true,true,true,true,false) == EcoPlanner::PENDING);
    Check(EcoPlanner::DecideConversion(false,true,1,2,true,true,true,false,false) == EcoPlanner::PENDING);
    Check(EcoPlanner::DecideConversion(false,true,1,2,true,true,true,true,false) == EcoPlanner::READY);
}
void test_compact_assist_target_reaches_each_step_at_half_income() {
    Check(TechEconomyMath::FastAssistTarget(22.49f, 2.0f, false, 10) == 0);
    Check(TechEconomyMath::FastAssistTarget(22.5f, 2.0f, false, 10) == 5);
    Check(TechEconomyMath::FastAssistTarget(44.99f, 2.0f, false, 10) == 5);
    Check(TechEconomyMath::FastAssistTarget(45.0f, 2.0f, false, 10) == 10);
}
void test_compact_assist_target_retains_rush_and_owner_caps() {
    Check(TechEconomyMath::FastAssistTarget(45.0f, 2.0f, true, 10) == 2);
    Check(TechEconomyMath::FastAssistTarget(10000.0f, 2.0f, false, 10) == 10);
    Check(TechEconomyMath::FastAssistTarget(45.0f, 2.0f, false, 7) == 7);
    Check(TechEconomyMath::FastAssistTarget(45.0f, 2.0f, true, 1) == 1);
}
void test_standard_assist_target_matches_previous_policy() {
    // Sweep through both income branches and threshold edges; the noncompact
    // maps must keep exactly the prior target, including opening rush limits.
    for (int sample = 0; sample <= 800; ++sample) {
        const float income = float(sample) * 0.25f;
        for (int rush = 0; rush < 2; ++rush) {
            int previous = income < 100.0f ? 5 * int(income / 45.0f) : 5 * int(income / 20.0f);
            if (rush != 0 && previous > 2) previous = 2;
            if (previous > 10) previous = 10;
            Check(TechEconomyMath::FastAssistTarget(income, 1.0f, rush != 0, 10) == previous);
        }
    }
}

void test_three_home_constructors_count_queued_work_without_double_counting_frames() {
    Check(TechEconomyMath::WorkforceNeeded(2,0,3));
    Check(!TechEconomyMath::WorkforceNeeded(2,1,3));
    Check(!TechEconomyMath::WorkforceNeeded(3,0,3));
    Check(!TechEconomyMath::WorkforceNeeded(10,0,3));
    Check(!TechEconomyMath::WorkforceNeeded(0,0,0));
    Check(TechEconomyMath::WorkforceNeeded(4,0,5));
    Check(!TechEconomyMath::WorkforceNeeded(4,1,5));
}
void test_delivery_headroom_is_separate_from_home_target() {
    Check(TechEconomyMath::ConstructorUnitLimit(3,3,0)==3);
    Check(TechEconomyMath::ConstructorUnitLimit(3,3,7)==4);
    Check(TechEconomyMath::ConstructorUnitLimit(3,4,6)==5);
    Check(TechEconomyMath::ConstructorUnitLimit(3,4,0)==4);
    Check(TechEconomyMath::ConstructorUnitLimit(3,2,0)==3);
    Check(TechEconomyMath::ConstructorUnitLimit(3,10,0)==10);
    Check(TechEconomyMath::ConstructorUnitLimit(5,5,1)==6);
}
void test_nuke_opening_can_fill_own_floor_before_promised_deliveries() {
    Check(TechEconomyMath::ConstructorOpeningTarget(2,3,0)==2);
    Check(TechEconomyMath::ConstructorOpeningTarget(2,3,1)==3);
    Check(TechEconomyMath::ConstructorOpeningTarget(4,3,1)==4);
}
void test_five_assist_target_preserves_opening_and_income_gates() {
    Check(TechEconomyMath::FastAssistTarget(44.99f,1,false,5)==0);
    Check(TechEconomyMath::FastAssistTarget(45,1,false,5)==5);
    Check(TechEconomyMath::FastAssistTarget(1000,1,false,5)==5);
    Check(TechEconomyMath::FastAssistTarget(1000,1,true,5)==2);
    Check(TechEconomyMath::FastAssistTarget(22.5f,2,false,5)==5);
}
void test_one_reactor_includes_unframed_orders_and_orphaned_frames() {
    Check(TechEconomyMath::SingleProjectAvailable(0,0));
    Check(!TechEconomyMath::SingleProjectAvailable(1,0));
    Check(!TechEconomyMath::SingleProjectAvailable(0,1));
    Check(!TechEconomyMath::SingleProjectAvailable(1,1));
    Check(!TechEconomyMath::SingleProjectAvailable(-1,0));
}
void test_structure_assistance_rejects_mobile_products() {
    Check(TechEconomyMath::StructureAssistAllowed(false));
    Check(!TechEconomyMath::StructureAssistAllowed(true));
}

void test_keep_live_travelling_construction() { Check(TechEconomyMath::KeepConstruction(true,true,false,0)); }
void test_keep_live_unfinished_construction() { Check(TechEconomyMath::KeepConstruction(true,true,true,.9f)); }
void test_release_completed_construction() { Check(!TechEconomyMath::KeepConstruction(true,true,true,1)); }
void test_release_dead_construction() { Check(!TechEconomyMath::KeepConstruction(false,true,false,0)); }
void test_do_not_retain_nonconstruction() { Check(!TechEconomyMath::KeepConstruction(true,false,false,0)); }
void test_capacity_has_income_ceiling_even_with_full_banks() {
    Check(TechEconomyMath::CapacityTarget(70,8,20,1500,100000,60,300000,64000)==1400);
    Check(!TechEconomyMath::CapacityNeeded(1400,1200,200,false));
    Check(TechEconomyMath::CapacityNeeded(1400,1200,0,false));
    Check(!TechEconomyMath::CapacityNeeded(1400,200,0,true));
}
void test_project_power_and_idle_capacity_are_separate() {
    Check(TechEconomyMath::CapacityTarget(40,8,20,300,0,60,0,0)==320);
    Check(TechEconomyMath::CapacityTarget(40,8,20,300,0,60,10000,10000)==320);
    Check(TechEconomyMath::CapacityTarget(40,8,20,600,0,60,10000,10000)==600);
    Check(TechEconomyMath::CapacityTarget(0,8,20,600,0,60,10000,10000)==0);
}
void test_mex_first_allows_affordable_energy_relief_but_keeps_nuke_recipe() {
    Check(!TechEconomyMath::MexesBlockReactor(true,false,true,20,20,300,300));
    Check(!TechEconomyMath::MexesBlockReactor(true,false,true,40,20,600,300));
    Check(TechEconomyMath::MexesBlockReactor(true,true,true,40,20,600,300));
    Check(TechEconomyMath::MexesBlockReactor(true,false,false,40,20,600,300));
    Check(TechEconomyMath::MexesBlockReactor(true,false,true,19,20,600,300));
    Check(TechEconomyMath::MexesBlockReactor(true,false,true,40,20,299,300));
    Check(!TechEconomyMath::MexesBlockReactor(false,false,false,0,20,0,300));
    Check(!TechEconomyMath::MexesBlockReactor(false,true,false,0,20,0,300));
}
void test_completed_afus_satisfies_fusion_without_abandoning_work() {
    Check(TechEconomyMath::FusionSuperseded(true,false,0));
    Check(!TechEconomyMath::FusionSuperseded(false,false,0));
    Check(!TechEconomyMath::FusionSuperseded(true,true,0));
    Check(!TechEconomyMath::FusionSuperseded(true,false,1));
}
void test_floating_energy_yields_reactor_assist_to_economy_balancing() {
    Check(!TechEconomyMath::ReactorAssistFirst(true, false));
    Check(TechEconomyMath::ReactorAssistFirst(false, false));
}
void test_energy_stall_retains_reactor_assistance_even_with_a_full_bank() {
    Check(TechEconomyMath::ReactorAssistFirst(true, true));
    Check(TechEconomyMath::ReactorAssistFirst(false, true));
}

void test_wind_reclaim_waits_for_completed_afus() {
    Check(!TechEconomyMath::WindReclaimAllowed(false));
    Check(TechEconomyMath::WindReclaimAllowed(true));
}
void test_offshore_conversion_requires_real_surplus() {
    Check(!TechEconomyMath::OffshoreConversionAllowed(true,false,false,150,150,100));
    Check(!TechEconomyMath::OffshoreConversionAllowed(true,true,false,1000,100,100));
    Check(!TechEconomyMath::OffshoreConversionAllowed(true,false,true,1000,100,100));
    Check(!TechEconomyMath::OffshoreConversionAllowed(false,false,false,1000,100,100));
    Check(!TechEconomyMath::OffshoreConversionAllowed(true,false,false,299,200,100));
    Check(TechEconomyMath::OffshoreConversionAllowed(true,false,false,300,200,100));
}
void test_flak_keeps_other_t2_builders_on_economy() {
    Check(!TechEconomyMath::FlakAssistAllowed(true,2,true,false));
    Check(TechEconomyMath::FlakAssistAllowed(true,2,true,true));
    Check(TechEconomyMath::FlakAssistAllowed(true,2,false,false));
    Check(TechEconomyMath::FlakAssistAllowed(false,2,true,false));
    Check(TechEconomyMath::FlakAssistAllowed(true,1,true,false));
}
void test_growth_power_includes_income_and_backlog_drain() {
    Check(TechEconomyMath::GrowthPowerTarget(100,9500,500,90,8)==1600.f);
    Check(TechEconomyMath::GrowthPowerTarget(150,9500,500,90,8)==2000.f);
    Check(TechEconomyMath::GrowthPowerTarget(100,0,500,90,8)==800.f);
}

void test_growth_reactor_breaks_full_bank_deadlock_only_when_funded() {
    Check(TechEconomyMath::FundedGrowthReactor(12000,500,9700,18000,20000,6000,250000,90,false));
    Check(!TechEconomyMath::FundedGrowthReactor(10000,500,9700,18000,20000,6000,250000,90,false));
    Check(!TechEconomyMath::FundedGrowthReactor(12000,500,9700,5000,20000,6000,250000,90,false));
    Check(!TechEconomyMath::FundedGrowthReactor(12000,500,9700,18000,20000,1000,250000,90,false));
    Check(!TechEconomyMath::FundedGrowthReactor(12000,500,9700,18000,20000,6000,250000,90,true));
    Check(!TechEconomyMath::FundedGrowthReactor(12000,500,9700,18000,0,6000,250000,90,false));
    Check(!TechEconomyMath::FundedGrowthReactor(12000,500,9700,18000,20000,6000,250000,0,false));
}
