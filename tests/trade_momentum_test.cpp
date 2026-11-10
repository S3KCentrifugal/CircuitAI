// D-512: the battle group trade ledger and momentum (control/kernel/TradeMomentum.h):
// decay by half-life, the prior that keeps one kill from being a streak, the
// commit scaling while winning and losing, and the push and fall-back gates.
#include "control/kernel/TradeMomentum.h"

#include <cassert>
#include <cmath>
#include <cstdio>

using namespace circuit;

namespace {
constexpr int FPS = 30, HALF = 120 * FPS;
constexpr float PRIOR = 300.f;
bool Near(float a, float b, float eps = 1e-3f) { return std::fabs(a - b) < eps; }
}

int main() {
    {  // A fresh ledger is neutral; one cheap kill is not a streak.
        trade::Ledger l;
        assert(trade::Momentum(l, PRIOR) == 0.f);
        trade::Kill(l, 54.f, 0, HALF);                        // one Pawn
        assert(trade::Momentum(l, PRIOR) < .2f);
    }
    {  // Winning: 6 Pawns and 2 Sentries killed (494 metal) for one Thug (140): m about +0.38.
        trade::Ledger l;
        for (int i = 0; i < 6; ++i) trade::Kill(l, 54.f, i * FPS, HALF);
        trade::Kill(l, 85.f, 10 * FPS, HALF); trade::Kill(l, 85.f, 12 * FPS, HALF);
        trade::Loss(l, 140.f, 12 * FPS, HALF);
        const float m = trade::Momentum(l, PRIOR);
        assert(m > .3f && m < .45f);
        assert(trade::Pushes(m, .3f) && !trade::FallsBack(m, .4f));
        // The advantage needed falls, the loss accepted rises (press 0.5).
        assert(trade::EntryScale(m, .5f, .5f) < 1.f && trade::LossScale(m, .5f, .5f) > 1.f);
    }
    {  // Losing: 4 Thugs lost (560) for 2 Pawns (108): m about -0.47; falls back.
        trade::Ledger l;
        for (int i = 0; i < 4; ++i) trade::Loss(l, 140.f, i * FPS, HALF);
        trade::Kill(l, 54.f, 5 * FPS, HALF); trade::Kill(l, 54.f, 6 * FPS, HALF);
        const float m = trade::Momentum(l, PRIOR);
        assert(m < -.4f && trade::FallsBack(m, .4f) && !trade::Pushes(m, .3f));
        assert(trade::EntryScale(m, .5f, .5f) > 1.f && trade::LossScale(m, .5f, .5f) < 1.f);
        // Decay: two half-lives later the ledger holds a quarter; m stays the same
        // sign but shrinks toward zero as the prior dominates.
        trade::Ledger later = l;
        trade::Decay(later, 6 * FPS + 2 * HALF, HALF);
        assert(Near(later.lost, l.lost * .25f, .5f));
        const float m2 = trade::Momentum(later, PRIOR);
        assert(m2 < 0.f && m2 > m && !trade::FallsBack(m2, .4f));   // recovered enough to stop falling back
    }
    {  // Bounds: the entry never drops below MIN_ENTRY_SCALE; switches at 0 are off.
        assert(Near(trade::EntryScale(1.f, 1.f, 0.f), trade::MIN_ENTRY_SCALE));
        assert(Near(trade::EntryScale(0.f, .5f, .5f), 1.f) && Near(trade::LossScale(0.f, .5f, .5f), 1.f));
        assert(!trade::Pushes(.9f, 0.f) && !trade::FallsBack(-.9f, 0.f));
        trade::Ledger l; trade::Kill(l, -50.f, 0, HALF);           // negative metal is ignored
        assert(l.killed == 0.f);
    }
    std::puts("trade_momentum_test: ok");
    return 0;
}
