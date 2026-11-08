void test_lowest_tech_team_is_elected() {
    array<int> none;
    array<int> allies = {7, 3};
    Check(PinpointerMath::Elected(5, true, none) == 5);
    Check(PinpointerMath::Elected(5, true, allies) == 3);
    Check(PinpointerMath::Elected(2, true, allies) == 2);
    Check(PinpointerMath::Elected(2, false, allies) == 3);
    Check(PinpointerMath::Elected(2, false, none) == -1);
}
void test_build_only_with_artillery_and_no_pinpointer() {
    Check(!PinpointerMath::Wanted(false, 0, 0, 0, 3));
    Check(PinpointerMath::Wanted(false, 0, 1, 0, 3));
    Check(!PinpointerMath::Wanted(false, 1, 1, 0, 3));
}
void test_latch_holds_until_three_of_ours() {
    Check(PinpointerMath::Wanted(true, 1, 1, 2, 3));
    Check(!PinpointerMath::Wanted(true, 1, 1, 3, 3));
    Check(!PinpointerMath::Wanted(true, 0, 0, 1, 3));
}
