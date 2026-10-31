void test_arrival_includes_exact_300_elmo_boundary() {
    Check(FerryMath::Arrived(0.0f, 300.0f));
    Check(FerryMath::Arrived(299.0f * 299.0f, 300.0f));
    Check(FerryMath::Arrived(300.0f * 300.0f, 300.0f));
    Check(!FerryMath::Arrived(301.0f * 301.0f, 300.0f));
}
void test_invalid_or_disabled_arrival_radius_does_not_transfer() {
    Check(!FerryMath::Arrived(-1.0f, 300.0f));
    Check(!FerryMath::Arrived(0.0f, 0.0f));
    Check(!FerryMath::Arrived(0.0f, -300.0f));
}
