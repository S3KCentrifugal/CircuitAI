#pragma once
#include "control/kernel/CommanderCombat.h"
#include <array>
#include <vector>

namespace circuit::commander {
// Construction intent only. Live tactical protection remains in Jammed().
// Prepare once per ask: O(P*J); score each terrain candidate O(P+J), P <= 9.
// No union arcs, engine callbacks or allocations during candidate scoring.
struct JammerPlan {
    struct Disc { Point center; float radius; };
    struct Probe { Point point; float weight=0; bool critical=false, missing=true; };
    std::array<Probe,9> probes{};
    std::vector<Disc> infrastructure, unavailable;
    float radius=0, minimumGain=.25f, spacing=.6f, inward=0;
    bool enabled=false, persistent=false;
    static bool Covers(const Disc& d,Point p) {
        const auto delta=p-d.center;
        return delta.x*delta.x+delta.z*delta.z<=d.radius*d.radius;
    }
    void Prepare() {
        for(auto& p:probes) {
            p.missing=true;
            if(!p.critical) for(const auto& d:unavailable) if(Covers(d,p.point)) {p.missing=false;break;}
            for(const auto& d:infrastructure) if(Covers(d,p.point)) {p.missing=false;break;}
        }
    }
    float Gain(Point site) const {
        float total=0, added=0;
        for(const auto& p:probes) {
            total+=p.weight;
            if(p.missing && Covers({site,radius},p.point)) added+=p.weight;
        }
        return total>0?added/total:0;
    }
    bool CriticalGap(Point site) const {
        for(const auto& p:probes)
            if(p.weight>0 && p.critical && p.missing && Covers({site,radius},p.point)) return true;
        return false;
    }
    bool Allows(Point site) const {
        if(!enabled) return true;
        if(radius<=0 || !persistent) return false;
        if(CriticalGap(site)) return true;
        if(Gain(site)<minimumGain) return false;
        // Useful tier upgrades may extend coverage even with a center inside
        // an old disc. Containment of the NEW disc is never useful.
        for(const auto& d:infrastructure)
            if(Length(site-d.center)+radius<=std::max(0.f,d.radius-inward)) return false;
        return true;
    }
    float Score(Point site) const {
        float proximity=0;
        for(const auto& d:infrastructure) {
            const float preferred=spacing*(radius+d.radius);
            if(preferred>0) proximity=std::max(proximity,1.f-std::min(1.f,Length(site-d.center)/preferred));
        }
        // Spacing is a preference; never veto the only safe critical-gap site.
        return Gain(site)+(CriticalGap(site)?1.f:0.f)-.25f*proximity;
    }
};

struct JammerDemandMemory {
    Point anchor{};
    int since=-1;
    bool Stable(Point at,int frame,int hold,float tolerance) {
        if(since<0 || frame<since || Length(at-anchor)>tolerance) {anchor=at;since=frame;}
        return frame-since>=hold;
    }
};
// Keep an unavailable structure reserved during a grace period. Re-observed
// availability resets the timer; callers prune IDs outside the local snapshot.
struct JammerOutage {
    int since=-1, seen=-1, definition=-1;
    bool Reserve(bool active,bool unfinished,int def,int frame,int grace) {
        if(definition!=def || active || unfinished || since<0 || frame<since) since=frame;
        definition=def;seen=frame;
        return active || unfinished || frame-since<grace;
    }
};
}
