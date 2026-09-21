#include "circuit/terrain/BaseLayoutGeometry.h"

#include <cstdlib>
#include <iostream>
#include <string>
#include <tuple>
#include <vector>

namespace {

using namespace circuit::base_layout;

int failures = 0;

void Check(bool condition, const std::string& message)
{
	if (!condition) {
		std::cerr << "FAIL: " << message << '\n';
		++failures;
	}
}

void CheckNoOverlap(const std::vector<Slot>& slots, const std::string& name)
{
	for (std::size_t i = 0; i < slots.size(); ++i) {
		for (std::size_t j = i + 1; j < slots.size(); ++j) {
			Check(!Intersects(
					RectFromCentre(slots[i].centre, slots[i].footprint, slots[i].facing),
					RectFromCentre(slots[j].centre, slots[j].footprint, slots[j].facing)),
					name + " slots overlap");
		}
	}
}

int ForwardProjection(const Point& origin, const Point& point, int facing)
{
	const Point fw = Forward(facing);
	return (point.x2 - origin.x2) * fw.x2 / 2 + (point.z2 - origin.z2) * fw.z2 / 2;
}

int SideProjection(const Point& origin, const Point& point, int facing)
{
	const Point side = Side(facing);
	return (point.x2 - origin.x2) * side.x2 / 2 + (point.z2 - origin.z2) * side.z2 / 2;
}

void TestFootprintSnapping()
{
	for (int facing = 0; facing < 4; ++facing) {
		const Footprint odd{3, 5};
		const Footprint even{6, 4};
		const Point oddCentre{21, 31};
		const Point evenCentre{20, 32};
		Check(IsAligned(oddCentre, odd, facing), "odd footprint aligns for facing " + std::to_string(facing));
		Check(IsAligned(evenCentre, even, facing), "even footprint aligns for facing " + std::to_string(facing));
		const Rect oddRect = RectFromCentre(oddCentre, odd, facing);
		const Rect evenRect = RectFromCentre(evenCentre, even, facing);
		Check(oddRect.Width() == ((facing & 1) == 0 ? 3 : 5), "odd width rotates exactly");
		Check(oddRect.Depth() == ((facing & 1) == 0 ? 5 : 3), "odd depth rotates exactly");
		Check(evenRect.Width() == ((facing & 1) == 0 ? 6 : 4), "even width rotates exactly");
		Check(evenRect.Depth() == ((facing & 1) == 0 ? 4 : 6), "even depth rotates exactly");
	}
}

void TestFactoryClusters()
{
	const Footprint nano{3, 3};
	for (int facing = 0; facing < 4; ++facing) {
		for (const auto [factory, tier, expected] : {
				std::tuple{Footprint{6, 6}, FactoryTier::T1, 2},
				std::tuple{Footprint{9, 9}, FactoryTier::T2, 6}}) {
			const Point centre{100 + Across(factory, facing) % 2, 120 + Along(factory, facing) % 2};
			const FactoryCluster cluster = MakeFactoryCluster(centre, facing, factory, nano, tier);
			Check(cluster.valid, "factory cluster valid");
			Check(static_cast<int>(cluster.nanos.size()) == expected, "factory nano count");
			CheckNoOverlap(cluster.nanos, "factory");
			const Rect factoryRect = RectFromCentre(cluster.factory.centre, factory, facing);
			Check(TouchesEdge(factoryRect, cluster.nanoBounds), "nano block touches factory rear");
			for (const Slot& slot : cluster.nanos) {
				Check(ForwardProjection(centre, slot.centre, facing) < 0, "nanos are behind factory");
			}
			for (std::size_t i = 1; i < cluster.nanos.size(); ++i) {
				Check(ForwardProjection(centre, cluster.nanos[i - 1].centre, facing)
						<= ForwardProjection(centre, cluster.nanos[i].centre, facing),
						"factory nano rows are ordered far-to-near");
			}
			Check(cluster.exit.Width() == (((facing & 1) == 0) ? Across(factory, facing) + 4 : 20),
					"exit world width");
			Check(cluster.exit.Depth() == (((facing & 1) == 0) ? 20 : Across(factory, facing) + 4),
					"exit world depth");
			Check(TouchesEdge(factoryRect, cluster.exit), "exit rectangle touches factory front");
			Check(!Intersects(factoryRect, cluster.exit), "exit rectangle does not overlap factory");
		}
	}
}

void TestFactoryPairSymmetry()
{
	const Footprint nano{3, 3};
	for (int facing = 0; facing < 4; ++facing) {
		const Point rear{80, 80};
		const FactoryPair pair = MakeFactoryPair(
				rear, facing, Footprint{6, 6}, FactoryTier::T1,
				Footprint{9, 9}, FactoryTier::T2, nano, 2);
		Check(pair.valid, "factory pair valid");
		const int firstSide = SideProjection(pair.rearEdgeCentre, pair.first.factory.centre, facing);
		const int secondSide = SideProjection(pair.rearEdgeCentre, pair.second.factory.centre, facing);
		Check(firstSide < 0 && secondSide > 0, "factory pair straddles centre");
		Check(pair.sideMin2 == -pair.sideMax2, "factory pair bounds are symmetric");
		Check(!Intersects(
				RectFromCentre(pair.first.factory.centre, pair.first.factory.footprint, facing),
				RectFromCentre(pair.second.factory.centre, pair.second.factory.footprint, facing)),
				"factory pair does not overlap");
	}
}

void TestBoundsAndIntersection()
{
	const Rect a{0, 0, 4, 4};
	const Rect b{4, 0, 8, 4};
	const Rect c{3, 3, 6, 6};
	Check(!Intersects(a, b), "touching rectangles do not overlap");
	Check(TouchesEdge(a, b), "touching edge detected");
	Check(Intersects(a, c), "intersection detected");
	Check(Contains(Rect{0, 0, 10, 10}, c), "containment detected");
	Check(InBounds(Rect{0, 0, 10, 10}, 10, 10), "upper edge is in bounds");
	Check(!InBounds(Rect{-1, 0, 2, 2}, 10, 10), "negative edge is out of bounds");
	Check(!InBounds(Rect{0, 0, 11, 2}, 10, 10), "oversized rectangle is out of bounds");
}

} // namespace

int main()
{
	TestFootprintSnapping();
	TestFactoryClusters();
	TestFactoryPairSymmetry();
	TestBoundsAndIntersection();
	if (failures != 0) {
		std::cerr << failures << " base-layout geometry check(s) failed\n";
		return EXIT_FAILURE;
	}
	std::cout << "base-layout geometry tests passed\n";
	return EXIT_SUCCESS;
}
