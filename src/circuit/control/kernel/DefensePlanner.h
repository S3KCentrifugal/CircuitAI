#pragma once

// Engine-free functional core. Units are health damage over a policy window,
// except strategic channels (missiles and plasma damage). No task ownership,
// engine callbacks, allocation, or hidden global policy lives here.
#include <algorithm>
#include <array>
#include <cmath>
#include <limits>

namespace circuit::defense {
enum Channel { LIGHT, HEAVY, AIR, STATIC, NUCLEAR, PLASMA, COUNT };
constexpr int MAX_RULES = 24;
struct Settings {
    float enabled=0, radius=1800, memory=45, strategicMemory=600;
    float heavyMetal=1200, heavyHealth=4000, baselineHealth=1000;
    float stableSeconds=60, stableDistance=160;
    float urgentBand=4;
    float shieldInPlasmaZone=1, shieldSafeSeconds=10;
    float surplusMetal=0, surplusEnergyMargin=100, surplusFireSeconds=10, surplusLimit=32;
};
enum class Reason { READY, DISABLED, NO_BUILDER, INCOME, ENERGY, TOO_LATE, COVERED, LOW_VALUE, LIMIT };
struct Rule {
    int def = -1, band = 2, limit = 4;
    float minMetal = 0, minEnergy = 0, seconds = 90, window = 30;
    float efficiency = .65f, valueRatio = 0, priority = 1, reserve = .2f;
    float surplusPriority = 0;
    std::array<float, COUNT> weights{};
};
struct Demand {
    float health = 0, value = 0, units = 0, largest = 0;
    int armor = 0, category = -1;
    float radius = 32;
};
using Demands = std::array<Demand, COUNT>;
struct Economy { float metal = 0, energy = 0, metalIncome = 0, energyIncome = 0, metalPull = 0, energyPull = 0; };
struct Project {
    float metal = 0, energy = 0, buildTime = 0, buildPower = 0, travel = 0;
    float operatingEnergy = 0, shotEnergy = 0, warmup = 0;
};
struct Evaluation { Reason reason = Reason::DISABLED; float score = 0, ready = 0; int band = 0; bool surplus = false; };

inline float Confidence(float age, float memory) {
    return memory > 0 ? std::clamp(1.f - std::max(0.f, age) / memory, 0.f, 1.f) : (age <= 0 ? 1.f : 0.f);
}
inline float ResourceSeconds(float cost, float bank, float spare) {
    if (cost <= bank) return 0;
    return spare > 0 ? (cost - bank) / spare : std::numeric_limits<float>::infinity();
}
inline float ReadyTime(const Project& p, const Economy& e, float reserve) {
    if (p.buildPower <= 0) return std::numeric_limits<float>::infinity();
    const float work = p.buildTime / p.buildPower;
    const float ms = e.metalIncome - e.metalPull;
    const float es = e.energyIncome - e.energyPull - p.operatingEnergy;
    const float m = ResourceSeconds(p.metal, e.metal * (1 - reserve), ms);
    const float energy = ResourceSeconds(p.energy, e.energy * (1 - reserve), es);
    const float ready = p.travel + std::max({work, m, energy}) + p.warmup;
    // A stocked bank is not funding when existing commitments consume it
    // before readiness. Positive future income remains conservatively omitted
    // during travel/arming; negative flow must be affordable throughout.
    if (ms < 0 && p.metal - ms * ready > e.metal * (1 - reserve)) return std::numeric_limits<float>::infinity();
    if (es < 0 && p.energy - es * ready > e.energy * (1 - reserve)) return std::numeric_limits<float>::infinity();
    return ready;
}
inline float Residual(float demand, float active, float committed) {
    return std::max(0.f, demand - std::max(0.f, active) - std::max(0.f, committed));
}
// Finite firing windows and overkill matter for slow high-alpha weapons.
// Demand is aggregated once; this conservative mean-target model cannot claim
// full salvo efficiency against many tiny targets. Splash suitability is policy.
inline float FireCapacity(float alpha, float reload, float seconds, float meanHealth, float efficiency) {
    if (alpha <= 0 || seconds <= 0 || meanHealth <= 0) return 0;
    return std::ceil(seconds / std::max(.1f, reload)) * std::min(alpha, meanHealth) * efficiency;
}
inline float SweepScale(float fireTime,float beamTime) {
    return fireTime>0 && beamTime>0?std::max(1.f,fireTime/beamTime):1.f;
}
inline float Marginal(const Demands& demand, const std::array<float, COUNT>& active,
    const std::array<float, COUNT>& committed, const std::array<float, COUNT>& capacity,
    const Rule& rule, float cost) {
    float benefit = 0;
    for (int k = 0; k < COUNT; ++k) {
        if (rule.weights[k] <= 0 || demand[k].health <= 0) continue;
        // Value gates are per channel: spam never finances a precision heavy beam.
        if (rule.valueRatio > 0 && demand[k].value < cost * rule.valueRatio) continue;
        const float gap = Residual(demand[k].health, active[k], committed[k]);
        // Shield coverage uses the strongest overlapping shield, not an
        // additive stack. Its marginal gain must use that same composition.
        const float extra = k==PLASMA?Residual(capacity[k],active[k],committed[k]):capacity[k];
        benefit += std::min(gap, extra) / demand[k].health * rule.weights[k];
    }
    return benefit;
}
inline Evaluation Evaluate(const Rule& r, const Project& p, const Economy& e,
    float benefit, int count) {
    Evaluation v; v.band = r.band;
    if (r.def < 0 || r.priority <= 0) return v;
    if (p.buildPower <= 0) { v.reason = Reason::NO_BUILDER; return v; }
    if (count >= r.limit) { v.reason = Reason::LIMIT; return v; }
    if (e.metalIncome < r.minMetal || e.energyIncome < r.minEnergy) { v.reason = Reason::INCOME; return v; }
    if (p.shotEnergy > e.energy * (1 - r.reserve)
        || p.operatingEnergy > std::max(0.f, e.energyIncome - e.energyPull)) { v.reason = Reason::ENERGY; return v; }
    v.ready = ReadyTime(p, e, r.reserve);
    if (!std::isfinite(v.ready) || v.ready > r.seconds) { v.reason = Reason::TOO_LATE; return v; }
    if (benefit <= 0) { v.reason = Reason::COVERED; return v; }
    v.reason = Reason::READY;
    v.score = benefit * r.priority / (std::max(1.f, p.metal) * (1 + v.ready / std::max(1.f, r.seconds)));
    return v;
}
inline bool Better(const Evaluation& a, const Evaluation& b) {
    return a.reason == Reason::READY && (b.reason != Reason::READY || a.band > b.band
        || (a.band == b.band && a.score > b.score)); // ties retain catalog order
}
// Optional bank-funded capacity, independent of observed demand. Constant work,
// no allocations; caller shares its existing one-second economy/worker snapshot.
// Reserve firing energy separately so construction cannot spend the same bank.
inline Evaluation EvaluateSurplus(const Settings& s, const Rule& r, Project p,
    const Economy& e, int count) {
    Evaluation v;
    if (s.enabled <= 0 || s.surplusMetal <= 0 || e.metal <= s.surplusMetal || r.surplusPriority <= 0) return v;
    const float firingReserve = std::max(p.shotEnergy, p.operatingEnergy * s.surplusFireSeconds);
    if (e.energyIncome - e.energyPull < p.operatingEnergy + s.surplusEnergyMargin
        || e.energy * (1 - r.reserve) < firingReserve) { v.reason = Reason::ENERGY; return v; }
    Rule funded = r;
    funded.minMetal = 0; // the bank funds this project; energy income still gates it
    funded.limit = std::max(r.limit, int(s.surplusLimit));
    funded.band = 0; // all demand-driven responses take precedence
    p.energy += firingReserve;
    v = Evaluate(funded, p, e, 1, count);
    v.surplus = true;
    if (v.reason == Reason::READY)
        v.score = r.surplusPriority / (1 + v.ready / std::max(1.f, r.seconds));
    return v;
}
inline int UrgencyBand(int ordinary, int urgent, bool immediate, float benefit) {
    return immediate && benefit>0?std::max(ordinary,urgent):ordinary;
}
inline bool AllowProtectedWork(bool laneAllowed,bool enabled,bool shield,bool plasmaExposure,bool localDanger,bool recentlyDamaged) {
    return laneAllowed || (enabled && shield && plasmaExposure && !localDanger && !recentlyDamaged);
}
inline const char* Name(Reason reason) {
    switch (reason) {
        case Reason::READY: return "ready";
        case Reason::NO_BUILDER: return "needs_builder";
        case Reason::INCOME: return "income_floor";
        case Reason::ENERGY: return "energy_committed";
        case Reason::TOO_LATE: return "ready_too_late";
        case Reason::COVERED: return "covered_or_low_value";
        case Reason::LOW_VALUE: return "low_value";
        case Reason::LIMIT: return "local_limit";
        default: return "disabled";
    }
}
}
