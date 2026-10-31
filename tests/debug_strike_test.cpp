#include "task/static/DebugStrike.h"
#include <cassert>
#include <iostream>
using namespace circuit::debug;

void test_position_strike_needs_a_point_on_the_map()
{
    Strike s;
    assert(Set(s, Mode::POS, 1000.f, 2000.f, -1, 8192.f, 8192.f, 0));
    assert(s.Active() && s.mode == Mode::POS && s.x == 1000.f && s.z == 2000.f && s.team == -1);
    const int serial = s.serial;
    assert(!Set(s, Mode::POS, -1.f, 2000.f, -1, 8192.f, 8192.f, 0));
    assert(!Set(s, Mode::POS, 9000.f, 2000.f, -1, 8192.f, 8192.f, 0));
    assert(!Set(s, Mode::POS, 1000.f, std::nanf(""), -1, 8192.f, 8192.f, 0));
    assert(s.serial == serial && s.x == 1000.f);  // a refused command changes nothing
}
void test_team_strike_never_on_our_own_team()
{
    Strike s;
    assert(!Set(s, Mode::TEAM, 0.f, 0.f, 3, 8192.f, 8192.f, 3));
    assert(!Set(s, Mode::TEAM, 0.f, 0.f, -1, 8192.f, 8192.f, 3));
    assert(!s.Active());
    assert(Set(s, Mode::TEAM, 0.f, 0.f, 5, 8192.f, 8192.f, 3));
    assert(s.Active() && s.team == 5);
}
void test_every_set_bumps_the_serial_and_resets_the_count()
{
    Strike s;
    assert(Set(s, Mode::TEAM, 0.f, 0.f, 5, 8192.f, 8192.f, 3));
    s.launches = 4;
    const int serial = s.serial;
    assert(Set(s, Mode::OFF, 0.f, 0.f, -1, 8192.f, 8192.f, 3));
    assert(!s.Active() && s.serial == serial + 1 && s.launches == 0 && s.team == -1);
    assert(!Set(s, Mode::DONE, 0.f, 0.f, 5, 8192.f, 8192.f, 3));  // reached, never asked for
}
void test_team_done_only_after_a_launch()
{
    Strike s;
    assert(Set(s, Mode::TEAM, 0.f, 0.f, 5, 8192.f, 8192.f, 3));
    assert(!TeamDone(s, 0));   // nothing scouted yet: wait
    s.launches = 2;
    assert(!TeamDone(s, 7));
    assert(TeamDone(s, 0));
    assert(Set(s, Mode::POS, 10.f, 10.f, -1, 8192.f, 8192.f, 3));
    s.launches = 2;
    assert(!TeamDone(s, 0));   // a position strike runs until turned off
}
void test_describe()
{
    Strike s;
    assert(Describe(s, 0) == "off");
    Set(s, Mode::POS, 1000.4f, 2000.f, -1, 8192.f, 8192.f, 0);
    s.launches = 3;
    assert(Describe(s, 2) == "pos 1000 2000 2 3");
    Set(s, Mode::TEAM, 0.f, 0.f, 5, 8192.f, 8192.f, 0);
    assert(Describe(s, 1) == "team 5 1 0");
    s.launches = 6; s.mode = Mode::DONE;
    assert(Describe(s, 0) == "done 5 6");
}
void test_player_strike_runs_on_the_resolved_team()
{
    Strike s;
    assert(!SetPlayer(s, 4, -1, 3));   // unknown player or spectator: the engine gave no team
    assert(!SetPlayer(s, 4, 3, 3));    // a player of our own team
    assert(!SetPlayer(s, -1, 5, 3));
    assert(!s.Active());
    assert(SetPlayer(s, 4, 5, 3));
    assert(s.Active() && s.mode == Mode::TEAM && s.team == 5 && s.player == 4);
    s.launches = 2;
    assert(Describe(s, 3) == "player 4 5 3 2");
    s.mode = Mode::DONE;
    assert(Describe(s, 0) == "done 5 2 4");
    assert(Set(s, Mode::TEAM, 0.f, 0.f, 6, 8192.f, 8192.f, 3));
    assert(s.player == -1 && Describe(s, 0) == "team 6 0 0");   // a team strike forgets the player
}
int main()
{
    test_position_strike_needs_a_point_on_the_map();
    test_team_strike_never_on_our_own_team();
    test_every_set_bumps_the_serial_and_resets_the_count();
    test_team_done_only_after_a_launch();
    test_describe();
    test_player_strike_runs_on_the_resolved_team();
    std::cout << "debug_strike_test: all passed\n";
    return 0;
}
