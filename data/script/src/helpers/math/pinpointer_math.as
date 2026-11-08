// D-493: Pinpointer policy, pure. One TECH AI per allied team builds them: the
// lowest team id among this AI (when it is TECH) and its TECH allies. Every AI
// computes the same answer from the roster, so no message is needed, and when
// that AI dies or changes role the next one takes over on its next check.
// Tests: tests/pinpointer_math_tests.as.
namespace PinpointerMath {
    // The elected builder's team id, -1 when no TECH AI is on the team.
    int Elected(int ownTeam, bool ownIsTech, const array<int> &in techAllies)
    {
        int best = ownIsTech ? ownTeam : -1;
        for (uint i = 0; i < techAllies.length(); ++i)
            if (techAllies[i] >= 0 && (best < 0 || techAllies[i] < best)) best = techAllies[i];
        return best;
    }

    // Build while the team has artillery and no Pinpointer, until `target` of ours.
    // wanted: the previous state (the latch).
    bool Wanted(bool wanted, int teamPinpointers, int teamArtillery, int own, int target)
    {
        if (teamArtillery <= 0) return false;
        if (!wanted && teamPinpointers == 0 && own < target) return true;
        if (wanted && own >= target) return false;
        return wanted;
    }
}
