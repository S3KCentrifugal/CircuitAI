// D-388: unit controller framework, engine-free parts: slot store, config
// table, preset resolution, the ownership ladder and the combat snapshot grid.
#include "control/core/ConfigTable.h"
#include "control/core/PresetResolver.h"
#include "control/core/SlotStore.h"
#include "control/core/Suspension.h"
#include "control/service/CombatSnapshot.h"

#include <cassert>
#include <iostream>
#include <string>
#include <vector>

using namespace circuit;
using namespace circuit::control;

namespace {
struct Sub { float a = 1.f, b = 2.f; };
struct Config { Sub first, second; };
template <auto M> ConfigField<Config> First(const char* n, float lo, float hi) {
	return {n, [](Config& c) -> float& { return c.first.*M; }, lo, hi};
}
template <auto M> ConfigField<Config> Second(const char* n, float lo, float hi) {
	return {n, [](Config& c) -> float& { return c.second.*M; }, lo, hi};
}
const CConfigTable<Config> table({First<&Sub::a>("first_a", 0.f, 10.f), Second<&Sub::b>("second_b", -1.f, 1.f)});

Json::Value Parse(const std::string& text) {
	Json::Value v;
	Json::CharReaderBuilder builder;
	std::string errors;
	std::unique_ptr<Json::CharReader> reader(builder.newCharReader());
	const bool ok = reader->parse(text.data(), text.data() + text.size(), &v, &errors);
	assert(ok);
	return v;
}
}

int main() {
	{  // KI-691: profile ignore is strategic, whereas gadget exclusion and
	   // unavailable records must never become local threats (visible or remembered).
		assert(CCombatSnapshot::Admit(false, false, false, false));
		assert(CCombatSnapshot::Admit(false, true, true, false));
		assert(!CCombatSnapshot::Admit(false, true, true, true));
		assert(!CCombatSnapshot::Admit(false, true, false, false));
		for (bool ignored : {false, true})
			for (bool profile : {false, true})
				for (bool gadget : {false, true})
					assert(!CCombatSnapshot::Admit(true, ignored, profile, gadget));
	}
	{  // KI-692: uncertainty can reach outside every edge of the original
	   // query's buckets. Broad-phase results must contain all narrow-phase hits.
		CCombatSnapshot snapshot;
		snapshot.Reset(8192.f, 8192.f);
		const commander::Point center{3072.f, 3072.f};
		const std::vector<commander::Point> offsets{{1550,0},{-1600,0},{0,1550},{0,-1600},
			{1500,1500},{-1500,-1500},{2500,0}};
		int id = 0;
		for (const auto& offset : offsets) {
			CCombatSnapshot::Entry e;
			e.id = id++; e.pos = center + offset; snapshot.Add(e);
		}
		std::vector<int> found;
		snapshot.Query(center, snapshot.QueryRadius(1500.f, 600.f, 1.f),
			[&](const auto& e) {
				if (commander::Length(e.pos-center) <= 2164.f) found.push_back(e.id);
			});
		std::sort(found.begin(), found.end());
		assert((found == std::vector<int>{0,1,2,3,4,5}));
		// A stale visible/radar snapshot can exceed the remembered movement cap.
		CCombatSnapshot::Entry fast;
		fast.id = 99; fast.pos = {6000,3072}; fast.radar = true; fast.speed = 900;
		snapshot.Add(fast);
		assert(snapshot.QueryRadius(1500,600,2) == 3364.f);
		bool seen = false;
		snapshot.Query(center,snapshot.QueryRadius(1500,600,2),[&](const auto& e) { seen |= e.id==99; });
		assert(seen);
		snapshot.Reset(8192,8192); // old fast units must not inflate later queries
		assert(snapshot.QueryRadius(1500,600,2) == 2164.f);
		fast.speed=CCombatSnapshot::BLIP_SPEED; snapshot.Add(fast);
		assert(snapshot.QueryRadius(1500,0,2) == 1684.f);
	}
	{  // Slot store: ascending id order, stable references, idempotent attach.
		CSlotStore<int> store;
		int& seven = store.Attach(7);
		seven = 70;
		store.Attach(3) = 30;
		store.Attach(11) = 110;
		assert(&store.Attach(7) == &seven && seven == 70);  // existing entry, same address
		std::vector<int> ids;
		for (auto& e : store) ids.push_back(e.id);
		assert((ids == std::vector<int>{3, 7, 11}));
		store.Attach(1) = 10;  // inserting before it does not move the 7's state
		assert(store.Find(7) == &seven);
		assert(store.Detach(3) && !store.Detach(3) && !store.Contains(3));
		assert(store.Find(7) == &seven && store.Size() == 3);
		const auto& view = store;
		assert(view.Find(11) && *view.Find(11) == 110 && view.Find(4) == nullptr);
	}
	{  // Config table: script levers clamp; JSON reports every problem by name.
		Config c;
		assert(table.Set(c, "first_a", 4.f) && c.first.a == 4.f);
		assert(table.Set(c, "second_b", 9.f) && c.second.b == 1.f);  // clamped
		assert(!table.Set(c, "nope", 1.f));
		assert(!table.Set(c, "first_a", std::nanf("")) && c.first.a == 4.f);
		std::vector<std::string> problems;
		Config d;
		table.Apply(d, Parse(R"({"type": "x", "first_a": 12, "second_b": true, "typo": 1, "first_b": "a"})"), {"type"}, problems);
		assert(d.first.a == 10.f && d.second.b == 1.f);
		assert(problems.size() == 3);  // clamped first_a, unknown typo, unknown first_b
		problems.clear();
		table.Apply(d, Parse(R"({"second_b": "high"})"), {}, problems);
		assert(problems.size() == 1 && d.second.b == 1.f);  // not a number: unchanged
	}
	{  // Presets: a child overrides its parent; cycles and missing parents fail.
		const Json::Value presets = Parse(R"({
			"base": {"type": "commander", "first_a": 1, "second_b": 0.5},
			"front": {"extends": "base", "first_a": 3},
			"loop1": {"extends": "loop2"}, "loop2": {"extends": "loop1"},
			"orphan": {"extends": "missing"}
		})");
		Json::Value out;
		std::string error;
		assert(ResolvePreset(presets, "front", out, error));
		assert(out["type"].asString() == "commander" && out["first_a"].asFloat() == 3.f && out["second_b"].asFloat() == .5f);
		assert(!out.isMember("extends"));
		assert(!ResolvePreset(presets, "loop1", out, error) && error.find("extends itself") != std::string::npos);
		assert(!ResolvePreset(presets, "orphan", out, error) && error.find("missing") != std::string::npos);
		assert(!ResolvePreset(presets, "absent", out, error));
	}
	{  // Ownership ladder: first rung wins.
		SuspensionFlags f;
		assert(Suspended(f) == Suspension::NONE);
		f.disarmed = true; f.stunned = true;
		assert(Suspended(f) == Suspension::STUNNED);
		f.player = true;
		assert(Suspended(f) == Suspension::PLAYER);
		f.noTask = true;
		assert(Suspended(f) == Suspension::NO_TASK);
		assert(std::string(Name(Suspension::EXTERNAL)) == "external");
	}
	{  // Combat snapshot grid: a query finds members in touched cells only, and
	   // a rebuild clears exactly what the last one wrote.
		CCombatSnapshot snapshot;
		snapshot.Reset(4096.f, 4096.f);
		CCombatSnapshot::Entry e;
		e.id = 1; e.pos = {100.f, 100.f}; e.elevation = 240.f; snapshot.Add(e);
		snapshot.AddStrategic(e);
		snapshot.Query(e.pos, 0.f, [&](const auto& contact) { assert(contact.elevation == 240.f); });
		assert(snapshot.StrategicContacts().front().elevation == 240.f);
		e.id = 2; e.pos = {3000.f, 3000.f}; snapshot.Add(e);
		e.id = 3; e.pos = {600.f, 120.f}; snapshot.Add(e);
		std::vector<int> found;
		snapshot.Query({120.f, 120.f}, 600.f, [&](const CCombatSnapshot::Entry& x) { found.push_back(x.id); });
		assert(found.size() == 2);  // 1 and 3, not the far one
		snapshot.Reset(4096.f, 4096.f);
		found.clear();
		snapshot.Query({120.f, 120.f}, 4000.f, [&](const CCombatSnapshot::Entry& x) { found.push_back(x.id); });
		assert(found.empty() && snapshot.Size() == 0);
		e.id = 9; e.pos = {-50.f, 99999.f}; snapshot.Add(e);  // off the map: clamped into an edge cell
		snapshot.Query({0.f, 4095.f}, 10.f, [&](const CCombatSnapshot::Entry& x) { found.push_back(x.id); });
		assert(found.size() == 1);
		assert(!snapshot.Due(0));  // nobody wants it yet
		snapshot.Want(0);
		assert(snapshot.Due(0) && !snapshot.Due(CCombatSnapshot::WANT_FRAMES + 1));
	}
	std::cout << "control_core_test: ok\n";
	return 0;
}
