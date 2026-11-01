#include "circuit/terrain/EconomySpine.h"
#include <iostream>
using namespace circuit::economy_spine;
int main() {
    int failures = 0, checks = 0;
    auto check = [&](bool value) { ++checks; if (!value) ++failures; };
    CandidateRank base{20,70,96,20,0};
    check(BetterCandidate({20,70,96,10,65536},base)); // away wins equal capacity
    check(!BetterCandidate({19,100,96,0,0},base)); // never trade an AFUS
    check(!BetterCandidate({20,69,96,0,0},base)); // preserve conversion capacity
    check(!BetterCandidate({20,70,95,0,0},base)); // preserve build-power coverage
    check(BetterCandidate({21,70,96,50,65536},base)); // constrained AIR fallback
    check(!BetterCandidate(base,base));
    check(BetterCandidate({20,70,96,20,0},{20,70,96,20,1}));
    check(ExpansionOverlap({0,0,4,4},{{0,0},{7,7},{8,0},{-1,0}})==2);
    check(ExpansionOverlap({0,0,4,4},{})==0); // no useful/buildable AIR samples
    const auto offsets=PreferenceOffsets({100,100},{{0,100}},32);
    check(offsets.front()==Point{0,0});
    check(offsets[1]==Point{32,0});
    check(PreferenceOffsets({100,100},{{200,100}},32)[1]==Point{-32,0});
    check(PreferenceOffsets({100,100},{{0,100}},0).size()==1);
    const auto order=CandidateOrder(int(offsets.size()),192);
    check(order.size()==192);
    bool shapes[6]{};
    for (size_t i=0;i<order.size();++i) {
        const auto c=order[i]; shapes[c.shape]=true;
        check(c.offset>=0 && c.offset<int(offsets.size()) && c.turn>=0 && c.turn<4);
        for(size_t j=0;j<i;++j) check(c.offset!=order[j].offset || c.turn!=order[j].turn || c.shape!=order[j].shape);
    }
    for(bool found:shapes) check(found);
    check(CandidateOrder(0,192).empty());
    check(CandidateOrder(2,1).size()==1);
    check(TouchesStart({10,10,20,20},200,200,32));
    check(TouchesStart({10,10,20,20},330,200,32));
    check(!TouchesStart({10,10,20,20},352,200,32));
    check(!TouchesStart({10,10,20,20},350,350,32));
    // Live BAR square converter footprints plus asymmetric synthetic footprints
    // catch orientation and pitch errors hidden by current faction symmetry.
    for (Footprint converter : {Footprint{4,4}, Footprint{3,4}})
        for (int wings : {1,3})
        for (int facing=0; facing<4; ++facing) for (bool mirror : {false,true})
        for (int rows : {6,12,18,24}) for (int columns : {2,4,6}) {
        const auto plan=Generate({1024,1024},facing,{3,3},{6,6},converter,columns,rows,wings,mirror,14,400);
        check(!plan.sites.empty());
        int reactors=0, converters=0, nanos=0;
        for (size_t i=0;i<plan.sites.size();++i) {
            const auto& a=plan.sites[i];
            check(IsAligned(a.slot.centre,a.slot.footprint,facing));
            const auto ra=RectFromCentre(a.slot.centre,a.slot.footprint,facing);
            check(ra.minX>=plan.bounds.minX && ra.maxX<=plan.bounds.maxX
                && ra.minZ>=plan.bounds.minZ && ra.maxZ<=plan.bounds.maxZ);
            reactors+=a.family==REACTOR; converters+=a.family==CONVERTER; nanos+=a.family==SUPPORT;
            for(size_t j=0;j<i;++j) {
                const auto& b=plan.sites[j].slot;
                const auto rb=RectFromCentre(b.centre,b.footprint,facing);
                check(ra.maxX<=rb.minX || rb.maxX<=ra.minX || ra.maxZ<=rb.minZ || rb.maxZ<=ra.minZ);
            }
        }
        check(reactors>0 && converters>0 && nanos==rows*columns);
    }
    check(Generate({0,0},0,{3,3},{6,6},{3,4},4,12,3,true,14,1).sites.empty());
    check(Generate({0,0},0,{0,3},{6,6},{3,4},4,12,3,true,14,400).sites.empty());
    check(Generate({0,0},0,{3,3},{6,6},{3,4},3,12,3,true,14,400).sites.empty());
    check(Generate({0,0},4,{3,3},{6,6},{3,4},4,12,3,true,14,400).sites.empty());
    for (int facing = 0; facing < 4; ++facing) for (int columns : {4,6}) {
        auto plan = Generate({1024,1024},facing,{3,3},{6,6},{4,4},columns,24,3,true,14,400);
        std::vector<unsigned char> allowed(plan.sites.size(), true);
        // A protected mex plot intersects multiple slots; it must leave a hole
        // without shrinking a wide, otherwise usable two-sided campus.
        const auto hole = RectFromCentre(plan.sites[40].slot.centre,{9,9},facing);
        for (size_t i = 0; i < plan.sites.size(); ++i) {
            const auto r = RectFromCentre(plan.sites[i].slot.centre,plan.sites[i].slot.footprint,facing);
            allowed[i] = r.maxX <= hole.minX || r.minX >= hole.maxX || r.maxZ <= hole.minZ || r.minZ >= hole.maxZ;
        }
        check(RetainBuildable(plan,allowed,{1024,1024},400,21));
        int reactors = 0, positive = 0, negative = 0;
        for (const auto& site : plan.sites) {
            const auto r = RectFromCentre(site.slot.centre,site.slot.footprint,facing);
            check(r.maxX <= hole.minX || r.minX >= hole.maxX || r.maxZ <= hole.minZ || r.minZ >= hole.maxZ);
            if (site.family == REACTOR) {
                ++reactors;
                const int across = (facing % 2 == 0 ? site.slot.centre.x2 : site.slot.centre.z2) - 1024;
                positive += across > 0; negative += across < 0;
            }
        }
        check(reactors == 21 && positive > 0 && negative > 0);
        allowed.assign(plan.sites.size(), true);
        for (size_t i = 0; i < plan.sites.size(); ++i) if (plan.sites[i].family == SUPPORT) allowed[i] = false;
        check(!RetainBuildable(plan,allowed,{1024,1024},400,21));
        check(plan.sites.empty()); // no orphan economy slots after support loss
    }
    std::cout<<checks<<" economy spine checks; "<<failures<<" failures\n";
    return failures!=0;
}
