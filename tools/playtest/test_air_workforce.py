import unittest
import json
import re
import tempfile
from pathlib import Path
from workforce_metrics import parse_sample, summarize, compare
from analyze_workforce_performance import analyze as performance
from analyze_air_natural import analyze as natural


class WorkforceMetricsTests(unittest.TestCase):
    def test_sample_counts_whole_numbers(self):
        row = parse_sample('[AirWorkforce] frame=900 t1=100 t2=60 metal=950/1000 income=30 usageM=80')
        self.assertEqual((row['t1'], row['t2']), (100, 60))

    def test_duplicate_read_does_not_double_count(self):
        row = parse_sample('[AirWorkforce] frame=900 t1=12 metal=950/1000 income=30 usageM=80')
        self.assertEqual(summarize([row, row])['samples'], 1)

    def test_old_observer_missing_usage_is_unavailable(self):
        row = parse_sample('[AirWorkforce] frame=900 t1=12 metal=950/1000 income=30')
        self.assertIsNone(summarize([row])['usageM_mean'])

    def test_full_bank_negative_own_balance_is_visible(self):
        row = parse_sample('[AirWorkforce] frame=900 metal=950/1000 income=30 usageM=80')
        self.assertEqual(summarize([row])['negative_own_balance_full_samples'], 1)

    def test_skipped_intervals_do_not_invent_resource_totals(self):
        self.assertIsNone(summarize([{'frame': 900, 'received': 5000}, {'frame': 9000, 'received': 5000}])['resource_totals'])

    def test_empty_metrics_are_unavailable(self):
        self.assertIsNone(summarize([])['full_bank_sample_fraction'])

    def test_seed_difference_rejects_comparison(self):
        base = dict(map='glacial', engine='recoil', game='bar', seed=1, side='armada', minutes=30, kind='natural')
        self.assertFalse(compare(base, dict(base, seed=2))['comparable'])

    def test_missing_metadata_rejects_comparison(self):
        self.assertFalse(compare({}, {})['comparable'])

    def test_matched_cohort_accepts_comparison(self):
        base = dict(map='glacial', engine='recoil', game='bar', seed=1, side='armada', minutes=30, kind='natural')
        self.assertTrue(compare(base, base)['comparable'])

    def test_count_checks_accept_whole_large_counts_and_reject_small_ones(self):
        checks = json.loads((Path(__file__).parent/'checks/air/economy/air_build_power.json').read_text())
        patterns = {c['key']: c['pattern'] for c in checks['expect']}
        for key, low, high in [('mobile-t1', 'construction t1=7 ', 'construction t1=100 '),
                               ('mobile-t2', 'construction t1=100 t2=5 ', 'construction t1=100 t2=60 '),
                               ('static', '[AirWatch] construction nanos=19 ', '[AirWatch] construction nanos=1000 ')]:
            self.assertIsNone(re.search(patterns[key], low))
            self.assertIsNotNone(re.search(patterns[key], high))

    def test_performance_keeps_cumulative_and_minute_percentiles_separate(self):
        result = performance('[WorkforcePerf] frame=1800 samples=1799 ai_all_p95_ms=2.0\n'
                             '[WorkforcePerfTotal] frame=18000 samples=17999 ai_all_p95_ms=3.0\n'
                             '[AirOrders] frame=1800 team=2 all_apm=3101 air_apm=2800 repeated=23')
        self.assertEqual(result['minutes'][0]['ai_all_p95_ms'], 2)
        self.assertEqual(result['totals'][0]['ai_all_p95_ms'], 3)
        self.assertEqual(result['orders'][0]['all'], 3101)
        self.assertIn('not per AIR instance', result['scope'])

    def test_absent_performance_measurements_are_not_zero_cost(self):
        self.assertEqual(performance('unrelated startup')['totals'], [])
        self.assertFalse(performance('[WorkforcePerfTotal] frame=18000 samples=18000 ai_all_max_ms=0.0')['valid_timing'])

    def test_timing_keeps_ai_elimination_for_population_comparison(self):
        result=performance('[f=0049503] local skirmish AI "BARbTest-air-0" (ID: 0) being removed from team 0')
        self.assertEqual(result['removals'],[dict(frame=49503,team=0)])

    def test_eliminated_air_does_not_score_dead_time_as_zero_spending(self):
        with tempfile.TemporaryDirectory() as tmp:
            log = Path(tmp)/'infolog.txt'
            log.write_text('[f=0000900] [AirWorkforce] frame=900 metal=900/1000 income=30 usageM=80\n'
                           '[f=0001000] local skirmish AI "BARbTest-air-0" (ID: 0) being removed from team 0\n'
                           '[f=0001800] [AirWorkforce] frame=1800 metal=500/500 income=0 usageM=0\n')
            row = natural(log, [dict(team=0,side='armada',role='AIR')])['air']['0']
        self.assertEqual(row['workforce']['usageM_mean'], 80)
        self.assertEqual(row['removed_frame'], 1000)
        self.assertEqual(row['observed_minutes'], .556)


if __name__ == '__main__':
    unittest.main()
