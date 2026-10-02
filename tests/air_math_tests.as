void test_air_parity_still_builds_bombers() { Check(AirMath::BomberOrders(1000,1000,6,3)==3); }
void test_air_badly_losing_preserves_fighter_priority() { Check(AirMath::BomberOrders(100,500,6,3)==0); }
void test_air_clear_sky_allocation_is_bounded() { Check(AirMath::BomberOrders(1000,0,6,3)==6); }
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
void test_air_one_afus_does_not_start_mass_bombers() { Check(!AirMath::MassBombersReady(1,2) && AirMath::MassBombersReady(2,2)); }
void test_air_opening_random_bounds_are_inclusive() { Check(AirMath::OpeningWave(10,20,10)==10 && AirMath::OpeningWave(10,20,20)==20); }
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
