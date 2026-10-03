void test_air_parity_still_builds_bombers() { Check(AirMath::BomberOrders(1000,1000,6,3)==3); }
void test_air_badly_losing_preserves_fighter_priority() { Check(AirMath::BomberOrders(100,500,6,3)==0); }
void test_air_clear_sky_allocation_is_bounded() { Check(AirMath::BomberOrders(1000,0,6,3)==6); }
void test_air_campus_attempts_full_size_before_compacting() { Check(AirMath::CampusSize(false,5)==6); }
void test_air_compact_search_retries_large_then_medium_then_single() { Check(AirMath::CampusSize(true,3)==6 && AirMath::CampusSize(true,4)==3 && AirMath::CampusSize(true,5)==1); }
void test_air_invalid_campus_variant_preserves_full_plan() { Check(AirMath::CampusSize(true,-1)==6); }
void test_air_interleave_is_exact_per_cycle() { int n=0; for(int i=0;i<20;++i) if(AirMath::BomberTurn(i,3)) ++n; Check(n==6); }
void test_air_invalid_sequence_cannot_recruit_strike() { Check(!AirMath::BomberTurn(-1,6)); }
void test_air_unarmed_contact_does_not_stop_strike() { Check(!AirMath::Emergency(0,100,1.5f)); }
void test_air_one_expensive_bomber_can_be_emergency() { Check(AirMath::Emergency(300,100,1.5f)); }
void test_air_sufficient_defense_does_not_veto_strike() { Check(!AirMath::Emergency(300,500,1.5f)); }
void test_air_mixed_tier_defense_uses_value() { Check(AirMath::Missing(600,450,150)==1); }
void test_air_pending_fighter_value_removes_deficit() { Check(AirMath::Missing(600,600,150)==0); }
void test_air_fractional_deficit_rounds_up() { Check(AirMath::Missing(601,600,150)==1); }
void test_air_wave_is_energy_limited() { Check(AirMath::WaveTarget(10,8,4,80,0,240,1,100,1000,310,18500)==12); }
void test_air_wave_is_metal_limited() { Check(AirMath::WaveTarget(10,8,4,80,0,240,1,10,20000,310,18500)==8); }
void test_air_wave_is_factory_limited() { Check(AirMath::WaveTarget(10,8,4,80,0,240,.05f,1000,100000,310,18500)==12); }
void test_air_held_fleet_counts_toward_reachable_size() { Check(AirMath::WaveTarget(10,8,4,80,10,240,.05f,1000,100000,310,18500)==22); }
void test_air_wave_never_exceeds_cap() { Check(AirMath::WaveTarget(100,8,4,80,200,240,1,1000,100000,310,18500)==80); }
void test_air_timeout_waives_schedule_not_minimum() { Check(AirMath::LaunchDue(8,40,8,240,240,true,false)); }
void test_air_timeout_does_not_waive_escort() { Check(!AirMath::LaunchDue(8,40,8,240,240,false,false)); }
void test_air_launch_does_not_replace_active_cohort() { Check(!AirMath::LaunchDue(40,40,8,240,240,true,true)); }
void test_air_small_pool_waits() { Check(!AirMath::LaunchDue(7,40,8,1000,240,true,false)); }
void test_air_reserve_does_not_inflate_sortie_escort() { Check(AirMath::SortieSize(58,12,8,10,.5f)==12); }
void test_air_escort_shortage_uses_smaller_feasible_sortie() { Check(AirMath::SortieSize(58,28,8,5,.5f)==10); }
void test_air_escort_below_minimum_stays_home() { Check(AirMath::SortieSize(58,28,8,3,.5f)==0); }
void test_air_no_enemy_air_does_not_require_escorts() { Check(AirMath::SortieSize(58,28,8,0,0)==28); }
void test_air_extreme_deficit_saturates_before_conversion() { Check(AirMath::Missing(1.0e11f,0,0.001f)==2147483647); }
void test_air_extreme_wave_schedule_remains_capped() { Check(AirMath::WaveTarget(2147483647,8,2147483647,80,0,1.0e11f,1.0e11f,1.0e11f,1.0e11f,1,1)==80); }
void test_air_large_reserve_does_not_require_linear_search() { Check(AirMath::SortieSize(2147483647,2147483647,8,5,.5f)==10); }
void test_air_fractional_escort_capacity_rounds_down() { Check(AirMath::SortieSize(20,20,8,7,.8f)==8); }
void test_air_unlimited_campus_keeps_expanding() { Check(AirMath::BayAllowed(50,0) && AirMath::PlannedBays(50,6)==51); }
void test_air_explicit_factory_limit_is_respected() { Check(!AirMath::BayAllowed(6,6)); }
void test_air_campus_reserves_minimum_before_growth() { Check(AirMath::PlannedBays(0,6)==6 && AirMath::PlannedBays(5,6)==6); }
void test_air_income_spike_does_not_start_growth() { Check(!AirMath::GrowthPhase(false,100,50) && !AirMath::GrowthPhase(true,49.9f,50)); }
void test_air_sustained_fifty_starts_growth() { Check(AirMath::GrowthPhase(true,50,50)); }
void test_air_two_afus_completes_growth_objective() { Check(!AirMath::MassBombersReady(1,2) && AirMath::MassBombersReady(2,2)); }
void test_air_bomber_admission_requires_both_incomes() { Check(AirMath::SustainedProduction(true,50,1830,30,60,30)); }
void test_air_high_metal_cannot_mask_energy_shortfall() { Check(!AirMath::SustainedProduction(true,500,1829,30,60,30)); }
void test_air_high_energy_cannot_mask_metal_shortfall() { Check(!AirMath::SustainedProduction(true,29,50000,30,60,30)); }
void test_air_bomber_admission_waits_for_complete_window() { Check(!AirMath::SustainedProduction(false,500,50000,30,60,30)); }
void test_air_invalid_payload_ratio_fails_closed() { Check(!AirMath::SustainedProduction(true,500,50000,30,0,30)); }
void test_air_opening_random_bounds_are_inclusive() { Check(AirMath::OpeningWave(10,20,10)==10 && AirMath::OpeningWave(10,20,20)==20); }
void test_air_economy_opening_preserves_draw() { Check(AirMath::OperationSize(64,8,false,17,false,false,8)==17); }
void test_air_opening_does_not_waive_payload() { Check(AirMath::OperationSize(64,18,false,17,false,false,8)==0); }
void test_air_front_assault_uses_available_force_before_opening() { Check(AirMath::OperationSize(64,35,false,17,true,false,8)==64); }
void test_air_defence_does_not_wait_for_offensive_opening() { Check(AirMath::OperationSize(7,6,false,17,false,true,8)==6); }
void test_air_later_raid_funds_target() { Check(AirMath::OperationSize(64,28,true,17,false,false,8)==28); }
void test_air_insufficient_cohort_is_not_released() { Check(AirMath::OperationSize(5,6,true,17,false,true,8)==0); }
void test_air_bad_opening_settings_are_bounded() { Check(AirMath::OpeningWave(20,10,1)==20 && AirMath::OpeningWave(1000,2000,1000)==300); }
void test_air_shared_economy_retires_small_energy() { Check(!AirMath::EnergyEraAllows(true,false,true,false) && !AirMath::EnergyEraAllows(true,false,false,true)); }
void test_air_shared_economy_keeps_reactors_and_converters() { Check(AirMath::EnergyEraAllows(false,false,true,true)); }
void test_air_first_afus_retires_advanced_solar() { Check(AirMath::EnergyEraAllows(false,true,true,false) && !AirMath::EnergyEraAllows(false,true,true,true)); }
void test_air_campus_tiles_touch_only_at_configured_clearance() { Check(AirMath::BayPitch(216,16)==448 && AirMath::BayPitch(168,16)==352); }
void test_air_campus_negative_clearance_cannot_overlap() { Check(AirMath::BayPitch(216,-100)==432); }
void test_air_campus_growth_cannot_overflow() { Check(AirMath::PlannedBays(2147483647,6)==2147483647); }
void test_air_wipeout_increases_next_resistance() { Check(AirMath::RaidResistance(1,0,.3f,.8f,1.5f,.9f,3)==1.5f); }
void test_air_repeated_losses_have_bounded_resistance() { Check(AirMath::RaidResistance(2.5f,0,.3f,.8f,1.5f,.9f,3)==3); }
void test_air_good_survival_relaxes_learned_resistance() { Check(AirMath::RaidResistance(2,1,.3f,.8f,1.5f,.5f,3)==1); }
void test_air_success_cannot_erase_base_unknown_reserve() { Check(AirMath::RaidResistance(1,1,.3f,.8f,1.5f,.5f,3)==1); }
void test_air_neutral_survival_keeps_resistance() { Check(AirMath::RaidResistance(2,.5f,.3f,.8f,1.5f,.9f,3)==2); }
void test_air_invalid_resistance_is_safe() { Check(AirMath::RaidResistance(-1,0,.3f,.8f,1.5f,.9f,3)==1); }
void test_air_overflow_funds_serial_growth() { Check(AirMath::OverflowGrowth(true,false,false,5000,40000,100,5000,0,0,9700,69000,.65f,180)); }
void test_air_growth_leaves_production_share() { Check(!AirMath::OverflowGrowth(true,false,false,1000,40000,100,5000,0,0,9700,69000,.65f,180)); }
void test_air_growth_deducts_existing_commitments() { Check(!AirMath::OverflowGrowth(true,false,false,5000,40000,100,5000,2000,0,9700,69000,.65f,180)); }
void test_air_growth_needs_energy_funding() { Check(!AirMath::OverflowGrowth(true,false,false,20000,1000,100,100,0,0,9700,69000,.65f,180)); }
void test_air_growth_never_overrides_recovery() { Check(!AirMath::OverflowGrowth(true,true,false,20000,100000,100,5000,0,0,9700,69000,.65f,180)); }
void test_air_growth_never_starts_parallel_reactors() { Check(!AirMath::OverflowGrowth(true,false,true,20000,100000,100,5000,0,0,9700,69000,.65f,180)); }
void test_air_growth_does_not_spend_nonfloating_bank() { Check(!AirMath::OverflowGrowth(false,false,false,20000,100000,100,5000,0,0,9700,69000,.65f,180)); }
void test_air_growth_invalid_share_fails_closed() { Check(!AirMath::OverflowGrowth(true,false,false,20000,100000,100,5000,0,0,9700,69000,2,180)); }
void test_air_queued_reactor_blocks_parallel_growth() { Check(AirMath::PendingReactor(true,true,false,0)); }
void test_air_unfinished_reactor_blocks_parallel_growth() { Check(AirMath::PendingReactor(true,true,true,.8f)); }
void test_air_completed_reactor_does_not_block_growth() { Check(!AirMath::PendingReactor(true,true,true,1)); }
void test_air_small_energy_does_not_block_reactors() { Check(!AirMath::PendingReactor(false,true,false,0)); }
void test_air_reactor_repair_is_not_new_construction() { Check(!AirMath::PendingReactor(true,false,true,.8f)); }
void test_air_retained_intercept_survives_snapshot_reorder() { array<int> ids={12,5}; array<float> needs={100,100}; Check(AirMath::RetainedContact(5,ids,needs)==1); }
void test_air_disappeared_intercept_frees_group_immediately() { array<int> ids={12}; array<float> needs={100}; Check(AirMath::RetainedContact(5,ids,needs)==-1); }
void test_air_fully_funded_contact_does_not_keep_extra_group() { array<int> ids={5}; array<float> needs={-50}; Check(AirMath::RetainedContact(5,ids,needs)==-1); }
void test_air_invalid_contact_snapshot_releases_group() { array<int> ids={5}; array<float> needs; Check(AirMath::RetainedContact(5,ids,needs)==-1); }
void test_air_low_income_full_store_can_fund_transition_capacity() { Check(AirMath::TransitionStorage(false,1340,1350,2900)); }
void test_air_transition_storage_stops_at_lab_capacity() { Check(!AirMath::TransitionStorage(false,2900,2900,2900)); }
void test_air_transition_storage_does_not_spend_an_empty_bank() { Check(!AirMath::TransitionStorage(false,200,1350,2900)); }
void test_air_transition_storage_does_not_expand_after_t2() { Check(!AirMath::TransitionStorage(true,1340,1350,2900)); }
