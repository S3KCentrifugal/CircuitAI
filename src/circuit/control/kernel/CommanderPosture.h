#pragma once
// D-389: the commander's cloak posture. Pure, engine-free arithmetic over a
// threat picture the controller builds from the per-side combat snapshot.
// Design and worked examples: rjm.bar.docs/projects/circuitai/commander-cloak-policy.md
// section 4; tests: tests/commander_posture_test.cpp.
// Cost: Summarize is O(T) for T threat entries (bounded by the snapshot's
// local query); Choose is O(1). No allocation, no engine call, no state.

#include "control/kernel/CommanderCombat.h"

#include <algorithm>
#include <cmath>
#include <limits>
#include <vector>

namespace circuit::commander::posture {

// Logged as integers: append new values only.
enum class Posture : int { WORK = 0, BRAWL = 1, AMBUSH = 2, WITHDRAW = 3, ESCAPE = 4 };
// How much a cloak hides the commander right now. FULL: off enemy radar and
// seismic, or inside a friendly jammer. PARTIAL: on enemy radar, but a friendly
// combat screen is near; Recoil's automatic targeting ranks a radar-only
// contact 10x lower than a visible one (CGameHelper target priority).
// NONE: alone on enemy radar, or within decloak distance of an enemy.
enum class Concealment : int { NONE = 0, PARTIAL = 1, FULL = 2 };

inline const char* Name(Posture p) {
	switch (p) {
		case Posture::WORK:     return "work";
		case Posture::BRAWL:    return "brawl";
		case Posture::AMBUSH:   return "ambush";
		case Posture::WITHDRAW: return "withdraw";
		case Posture::ESCAPE:   return "escape";
	}
	return "?";
}

// One enemy that can damage the commander's armour class.
// Cached weapon facts only: artillery thresholds belong to the current
// preset, so changing a preset never needs to invalidate this metadata.
struct WeaponMatchup {
	float dps = 0.f, range = 0.f, speed = 0.f, health = 0.f;
	float artilleryRange = -1.f; // longest admitted ballistic/high unguided weapon
	bool IsArtillery(float threshold) const { return artilleryRange >= threshold; }
};

struct ThreatEntry {
	Point pos;               // last known position
	float uncertainty = 0.f; // radius it may have moved since (remembered or radar)
	float dps = 0.f;         // effective damage per second against the commander
	float range = 0.f;       // longest weapon range that can hit the commander
	float speed = 0.f;       // elmos per second
	float health = 0.f;      // for the clear-time estimate; 0 when unknown
	bool artillery = false;  // ballistic or high-trajectory long-range weapon
	bool heavy = false;      // a T3: one D-gun pass does not remove it, and it is never a brawl
};

struct Self {
	Point pos;
	float health = 1.f;
	float laserRange = 300.f; // main weapon range
	float laserDps = 1.f;     // main weapon damage per second
	int shotsBanked = 0;      // D-guns the bank can pay for now
};

struct Settings {
	float horizon = 4.f;          // seconds ahead an approaching threat counts
	float outrangeMargin = 50.f;  // elmos beyond the laser that count as outranging
	float outrangeDps = 120.f;    // outranging dps that forces a withdrawal
	float artilleryDps = 60.f;    // artillery dps that forces a withdrawal
	float retreatSeconds = 6.f;   // time to die below which the commander withdraws
	float escapeSeconds = 3.f;    // time to die below which a cloaked escape is taken
	float brawlMargin = 1.5f;     // clear time x margin must be below time to die
	float dgunKills = 2.f;        // short-range units one D-gun line is expected to remove
	// Cloak only against real danger: a cloak costs 100 E/s still and
	// 1,000 E/s moving, so a lone outranging rocket bot is not worth one.
	float ambushSeconds = 20.f;        // ambush only when approaching enemies would kill it this fast
	float withdrawCloakSeconds = 10.f; // a withdrawal cloaks only below this time to die
};

struct Summary {
	float incomingDps = 0.f;  // in range now or within the horizon
	float outrangedDps = 0.f; // of that, from weapons outranging the laser
	float artilleryDps = 0.f; // of that, from artillery
	float clearSeconds = 0.f; // laser and D-gun time to remove the short-range threats
	bool heavy = false;       // a T3 is among the threats
	float timeToDie = std::numeric_limits<float>::infinity();
	int reaching = 0;         // threats in range now
	int approaching = 0;      // threats reaching range within the horizon
};

inline Summary Summarize(const std::vector<ThreatEntry>& threats, const Self& self, const Settings& s) {
	Summary out;
	float shortHealth = 0.f;
	int shortCount = 0;
	for (const auto& t : threats) {
		if (t.dps <= 0.f) continue;
		const float distance = Length(t.pos - self.pos);
		// Closest place the threat may be, minus its reach.
		const float gap = std::max(0.f, distance - t.uncertainty - t.range);
		const bool now = gap <= 0.f;
		const bool soon = !now && gap <= std::max(0.f, t.speed) * s.horizon;
		if (!now && !soon) continue;
		now ? ++out.reaching : ++out.approaching;
		out.incomingDps += t.dps;
		if (t.range > self.laserRange + s.outrangeMargin) {
			out.outrangedDps += t.dps;
		} else if (!t.heavy) {
			shortHealth += std::max(0.f, t.health);
			++shortCount;
		}
		if (t.artillery) out.artilleryDps += t.dps;
		if (t.heavy) out.heavy = true;
	}
	if (out.incomingDps > 0.f) out.timeToDie = std::max(0.f, self.health) / out.incomingDps;
	// D-gun lines remove whole units; credit the banked shots with the average
	// short-range health, then the laser clears the rest.
	if (shortCount > 0) {
		const float average = shortHealth / float(shortCount);
		const float removed = std::min(float(shortCount), std::max(0, self.shotsBanked) * std::max(0.f, s.dgunKills));
		out.clearSeconds = std::max(0.f, shortHealth - removed * average) / std::max(1.f, self.laserDps);
	}
	return out;
}

struct Inputs {
	Concealment concealment = Concealment::NONE;
	bool movingFunded = false; // bank pays a moving cloak for the escape
	bool stillFunded = false;  // bank pays a stationary cloak
	bool budgetOk = true;      // cloak spend over the last minute is under budget
	bool moving = false;       // the commander is travelling (not holding still)
	bool preferCloak = false;  // script-enabled economy unlock; bypasses spend budget
};

inline bool IncomeCloakEnabled(bool front, float threshold, float peakIncome) {
    return front && threshold > 0.f && peakIncome >= threshold;
}
inline bool PreferredCloakFunded(const Inputs& in) {
    return in.preferCloak && (in.moving ? in.movingFunded : in.stillFunded);
}

struct Choice {
	Posture posture = Posture::WORK;
	bool cloak = false;
	const char* reason = "no threat";
};

// The posture table of commander-cloak-policy.md section 4.2, first match wins.
// Cloak is requested only where it hides the commander and the bank pays for it.
inline Choice Choose(const Summary& sum, const Self& self, const Settings& s, const Inputs& in) {
	if (sum.incomingDps <= 0.f) return {Posture::WORK, PreferredCloakFunded(in), in.preferCloak ? "front economy cloak" : "no threat"};
	// A T3 is owned by the D-294 T3 plans (approach, hold, low-health shot),
	// which manage their own cloak and energy. The posture never spends the
	// bank those plans need.
	if (sum.heavy) return {Posture::WITHDRAW, false, "T3: plan owns the cloak"};
	if (sum.timeToDie < s.escapeSeconds && in.concealment != Concealment::NONE && in.movingFunded)
		return {Posture::ESCAPE, true, "dying, cloak breaks targeting"};
	const bool outranged = sum.outrangedDps >= s.outrangeDps;
	const bool shelled = sum.artilleryDps >= s.artilleryDps;
	if (outranged || shelled || sum.timeToDie < s.retreatSeconds) {
		const bool hide = in.concealment == Concealment::FULL && in.movingFunded && (in.budgetOk || in.preferCloak)
			&& (sum.timeToDie < s.withdrawCloakSeconds || in.preferCloak);
		return {Posture::WITHDRAW, hide, shelled ? "artillery" : outranged ? "outranged" : "losing"};
	}
	const bool shortOnly = sum.outrangedDps <= 0.f;
	if (shortOnly && !sum.heavy && self.shotsBanked > 0 && sum.clearSeconds * s.brawlMargin < sum.timeToDie)
		return {Posture::BRAWL, false, "favourable brawl, be seen"};
	if (sum.reaching == 0 && sum.approaching > 0 && !in.moving && sum.timeToDie < s.ambushSeconds
		&& in.concealment == Concealment::FULL && in.stillFunded && (in.budgetOk || in.preferCloak))
		return {Posture::AMBUSH, true, "ambush, still cloak"};
	return {Posture::WORK, PreferredCloakFunded(in) && in.concealment != Concealment::NONE, "threat manageable"};
}

} // namespace circuit::commander::posture
