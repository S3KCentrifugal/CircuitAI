// D-389: commander cloak posture kernel. Worked examples from
// rjm.bar.docs/projects/circuitai/commander-cloak-policy.md section 4.2.
#include "control/kernel/CommanderPosture.h"

#include <cassert>
#include <cmath>
#include <iostream>

using namespace circuit::commander;
using namespace circuit::commander::posture;

namespace {
// BAR unit numbers from the knowledge base unit pages (armpw/corak/corthud/corwolv).
constexpr float GRUNT_DPS = 74.f, GRUNT_RANGE = 215.f, GRUNT_HP = 280.f, GRUNT_SPEED = 80.f;
constexpr float THUG_DPS = 60.f, THUG_RANGE = 380.f, THUG_HP = 1100.f, THUG_SPEED = 45.f;
constexpr float WOLVERINE_DPS = 42.3f, WOLVERINE_RANGE = 710.f, WOLVERINE_HP = 750.f;
constexpr float COMMANDER_HP = 3700.f, LASER_RANGE = 300.f, LASER_DPS = 187.5f;

Self Commander(int shots = 2) {
	Self self;
	self.pos = {0.f, 0.f};
	self.health = COMMANDER_HP;
	self.laserRange = LASER_RANGE;
	self.laserDps = LASER_DPS;
	self.shotsBanked = shots;
	return self;
}

std::vector<ThreatEntry> Pack(int count, float distance, float dps, float range, float hp, float speed, bool artillery = false) {
	std::vector<ThreatEntry> out;
	for (int i = 0; i < count; ++i) {
		ThreatEntry t;
		t.pos = {distance, float(i) * 5.f};  // a tight pack: all at about the same distance
		t.dps = dps; t.range = range; t.health = hp; t.speed = speed; t.artillery = artillery;
		out.push_back(t);
	}
	return out;
}

Inputs Hidden(bool moving = true) {
	Inputs in;
	in.concealment = Concealment::FULL;
	in.movingFunded = true;
	in.stillFunded = true;
	in.moving = moving;
	return in;
}
}

int main() {
	const Settings s;
	{  // KI-693: one cached weapon fact, two presets, either evaluation order,
	   // then a script threshold change. Classification never sticks in the cache.
		WeaponMatchup cached;
		cached.artilleryRange = 710.f;
		for (const auto& thresholds : {std::vector<float>{600,800}, std::vector<float>{800,600}}) {
			for (float threshold : thresholds) {
				auto threats=Pack(2,650.f,WOLVERINE_DPS,WOLVERINE_RANGE,WOLVERINE_HP,50.f,
					cached.IsArtillery(threshold));
				const auto sum=Summarize(threats,Commander(),s);
				assert((sum.artilleryDps > 0.f) == (threshold <= 710.f));
				assert((Choose(sum,Commander(),s,Hidden()).posture == Posture::WITHDRAW) == (threshold <= 710.f));
			}
		}
		float threshold=800.f;
		assert(!cached.IsArtillery(threshold));
		threshold=600.f;
		assert(cached.IsArtillery(threshold));
		assert(cached.IsArtillery(710.f));
		assert(!WeaponMatchup{}.IsArtillery(0.f)); // no qualifying weapon
	}
	{  // No threat: work, never cloak.
		const auto sum = Summarize({}, Commander(), s);
		const auto c = Choose(sum, Commander(), s, Hidden());
		assert(c.posture == Posture::WORK && !c.cloak);
		assert(std::isinf(sum.timeToDie));
	}
	{  // 6 Grunts in range: 444 dps, 8.3 s to die; two D-gun lines and the laser clear them first.
		const auto sum = Summarize(Pack(6, 200.f, GRUNT_DPS, GRUNT_RANGE, GRUNT_HP, GRUNT_SPEED), Commander(), s);
		assert(sum.reaching == 6 && sum.outrangedDps == 0.f);
		assert(std::abs(sum.timeToDie - COMMANDER_HP / (6 * GRUNT_DPS)) < 0.01f);
		const auto c = Choose(sum, Commander(), s, Hidden());
		assert(c.posture == Posture::BRAWL && !c.cloak);  // be seen: they walk into the D-gun
	}
	{  // 15 Grunts: 1,110 dps, 3.3 s to die: withdraw, cloaked only when it hides.
		const auto sum = Summarize(Pack(15, 200.f, GRUNT_DPS, GRUNT_RANGE, GRUNT_HP, GRUNT_SPEED), Commander(), s);
		const auto hidden = Choose(sum, Commander(), s, Hidden());
		assert(hidden.posture == Posture::WITHDRAW && hidden.cloak);
		Inputs onRadar = Hidden(); onRadar.concealment = Concealment::PARTIAL;
		const auto seen = Choose(sum, Commander(), s, onRadar);
		assert(seen.posture == Posture::WITHDRAW && !seen.cloak);
	}
	{  // 4 Thugs outrange the laser (380 > 300 + 50): withdraw, but 15 s to die
	   // is not worth a 1,000 E/s moving cloak.
		const auto sum = Summarize(Pack(4, 350.f, THUG_DPS, THUG_RANGE, THUG_HP, THUG_SPEED), Commander(), s);
		assert(sum.outrangedDps == 4 * THUG_DPS);
		const auto c = Choose(sum, Commander(), s, Hidden());
		assert(c.posture == Posture::WITHDRAW && !c.cloak);
	}
	{  // One outranging rocket bot approaching a still commander: no ambush cloak.
		const auto sum = Summarize(Pack(1, 700.f, 60.f, 475.f, 720.f, 60.f), Commander(0), s);
		assert(sum.approaching == 1);
		const auto c = Choose(sum, Commander(0), s, Hidden(false));
		assert(!c.cloak);
	}
	{  // 2 Wolverines shelling from 650: artillery withdrawal.
		const auto sum = Summarize(Pack(2, 650.f, WOLVERINE_DPS, WOLVERINE_RANGE, WOLVERINE_HP, 50.f, true), Commander(), s);
		assert(sum.artilleryDps > s.artilleryDps);
		const auto c = Choose(sum, Commander(), s, Hidden());
		assert(c.posture == Posture::WITHDRAW);
	}
	{  // Remembered Thugs in fog: 900 away, may have moved 600; they still count.
		auto thugs = Pack(3, 900.f, THUG_DPS, THUG_RANGE, THUG_HP, THUG_SPEED);
		for (auto& t : thugs) t.uncertainty = 600.f;
		const auto sum = Summarize(thugs, Commander(), s);
		assert(sum.reaching == 3);
		thugs = Pack(3, 900.f, THUG_DPS, THUG_RANGE, THUG_HP, THUG_SPEED);
		assert(Summarize(thugs, Commander(), s).reaching == 0);
	}
	{  // Grunts approaching, no D-gun banked, commander still and hidden: ambush.
		const auto threats = Pack(3, 500.f, GRUNT_DPS, GRUNT_RANGE, GRUNT_HP, 100.f);
		const auto sum = Summarize(threats, Commander(0), s);
		assert(sum.reaching == 0 && sum.approaching == 3);
		auto c = Choose(sum, Commander(0), s, Hidden(false));
		assert(c.posture == Posture::AMBUSH && c.cloak);
		c = Choose(sum, Commander(0), s, Hidden(true));  // a travelling commander does not ambush
		assert(c.posture == Posture::WORK && !c.cloak);
		Inputs over = Hidden(false); over.budgetOk = false;  // the minute's cloak budget is spent
		assert(!Choose(sum, Commander(0), s, over).cloak);
	}
	{  // Escape: dying fast, any concealment, moving cloak funded.
		const auto sum = Summarize(Pack(30, 200.f, GRUNT_DPS, GRUNT_RANGE, GRUNT_HP, GRUNT_SPEED), Commander(), s);
		assert(sum.timeToDie < s.escapeSeconds);
		Inputs partial = Hidden(); partial.concealment = Concealment::PARTIAL;
		const auto c = Choose(sum, Commander(), s, partial);
		assert(c.posture == Posture::ESCAPE && c.cloak);
		partial.movingFunded = false;
		assert(!Choose(sum, Commander(), s, partial).cloak);
	}
	{  // A short-range T3 is never a brawl, and a D-gun is not credited with removing it.
		auto t3 = Pack(1, 200.f, 336.f, 250.f, 30000.f, 30.f);
		t3[0].heavy = true;
		const auto sum = Summarize(t3, Commander(), s);
		assert(sum.heavy && sum.clearSeconds == 0.f && sum.outrangedDps == 0.f);
		const auto c = Choose(sum, Commander(), s, Hidden());
		assert(c.posture != Posture::BRAWL && !c.cloak);  // the T3 plans own the cloak
	}
	{  // Too far and too slow to matter: ignored.
		const auto sum = Summarize(Pack(5, 3000.f, THUG_DPS, THUG_RANGE, THUG_HP, THUG_SPEED), Commander(), s);
		assert(sum.incomingDps == 0.f);
	}
    {
        assert(!IncomeCloakEnabled(true,2000,1999));
        assert(IncomeCloakEnabled(true,2000,2000));
        assert(!IncomeCloakEnabled(false,2000,10000));
        assert(!IncomeCloakEnabled(true,0,10000));
        float peak=0;
        for(float income:{1999.f,2000.f,500.f}) peak=std::max(peak,income);
        assert(IncomeCloakEnabled(true,2000,peak));
        Inputs in=Hidden(false);in.preferCloak=true;in.budgetOk=false;
        Summary quiet;
        assert(Choose(quiet,Commander(),s,in).cloak); // no enemy required, spend budget bypassed
        in.stillFunded=false;assert(!Choose(quiet,Commander(),s,in).cloak);
        in.moving=true;assert(Choose(quiet,Commander(),s,in).cloak);
        in.movingFunded=false;assert(!Choose(quiet,Commander(),s,in).cloak);
        in=Hidden();in.preferCloak=true;in.budgetOk=false;
        auto brawl=Summarize(Pack(2,200,GRUNT_DPS,GRUNT_RANGE,GRUNT_HP,GRUNT_SPEED),Commander(),s);
        assert(Choose(brawl,Commander(),s,in).posture==Posture::BRAWL);
        assert(!Choose(brawl,Commander(),s,in).cloak);
        auto thugs=Summarize(Pack(4,350,THUG_DPS,THUG_RANGE,THUG_HP,THUG_SPEED),Commander(),s);
        assert(Choose(thugs,Commander(),s,in).cloak);
        in.concealment=Concealment::NONE;assert(!Choose(thugs,Commander(),s,in).cloak);
        thugs.heavy=true;in.concealment=Concealment::FULL;
        assert(!Choose(thugs,Commander(),s,in).cloak); // T3 plan remains sole owner
    }
	std::cout << "commander_posture_test: ok\n";
	return 0;
}
