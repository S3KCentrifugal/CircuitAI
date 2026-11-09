#pragma once
#include <map>
#include <bit>
#include <set>
#include <vector>
#include <algorithm>
#include <utility>
#include <cmath>
#include <limits>

namespace circuit::defense {
struct Claim { int def = -1, frameId = -1, until = 0; float x = 0, z = 0, radius = 0, metal = 0, energy = 0; };
// Simulation-thread owned. Ordered x broad phase avoids scanning distant claims;
// exact circles and owner/token visitation order remain authoritative. Mutations
// O(log P), query O(log P + X + K log K), capped at O(P) via ordered fallback.
// Expiry costs O(Q log P) for Q removed claims, once per lifetime.
// Expiry is global even for a local query. Tests: defense_planner_test.cpp.
class Claims {
    using Key=std::pair<int,int>;
public:
    Claims()=default;
    Claims(const Claims&)=delete;
    Claims& operator=(const Claims&)=delete;
    void Upsert(int owner,int& token,const Claim& claim) {
        if(token<=0) {
            if(nextToken==std::numeric_limits<int>::max()) return;
            token=++nextToken;
        }
        Put(owner,token,claim);
    }
    void Put(int owner,int token,const Claim& claim) {
        const auto old=entries.find({owner,token});
        if(old!=entries.end()) {
            const auto& c=old->second;
            if(c.def==claim.def && c.frameId==claim.frameId && c.until==claim.until
                && c.x==claim.x && c.z==claim.z && c.radius==claim.radius
                && c.metal==claim.metal && c.energy==claim.energy) return;
        }
        Erase(owner,token);
        const Key key{owner,token};const auto stored=entries.emplace(key,claim).first;
        byX.emplace(std::make_pair(claim.x,key),&stored->second);expiry.emplace(claim.until,key);radii.insert(claim.radius);
    }
    void Erase(int owner,int token) {
        const Key key{owner,token};const auto it=entries.find(key);
        if(it==entries.end()) return;
        byX.erase({it->second.x,key});expiry.erase({it->second.until,key});
        radii.erase(radii.find(it->second.radius));entries.erase(it);
    }
    void RemoveOwner(int owner) {
        auto it=entries.lower_bound({owner,std::numeric_limits<int>::min()});
        while(it!=entries.end() && it->first.first==owner) {
            const auto key=(it++)->first;Erase(key.first,key.second);
        }
    }
    template<class F> void Nearby(float x,float z,float radius,int frame,F visit) {
        while(!expiry.empty() && expiry.begin()->first<frame) {
            const auto key=expiry.begin()->second;Erase(key.first,key.second);
        }
        if(entries.empty()) return;
        // Double bounds and an outward margin prevent float subtraction/hypot
        // rounding at the original inclusive boundary from losing a candidate.
        const double reach=std::nextafter(radius+*radii.rbegin(),std::numeric_limits<float>::infinity());
        const float lo=std::nextafter(float(double(x)-reach),-std::numeric_limits<float>::infinity());
        const float hi=std::nextafter(float(double(x)+reach),std::numeric_limits<float>::infinity());
        if(lo<=byX.begin()->first.first && hi>=byX.rbegin()->first.first) {
            // Wide-range protection queries keep the old O(P) ordered scan.
            VisitAll(x,z,radius,visit);return;
        }
        candidates.clear();
        const auto sortLimit=entries.size()/std::max(1u,unsigned(std::bit_width(entries.size())));
        for(auto it=byX.lower_bound({lo,{std::numeric_limits<int>::min(),std::numeric_limits<int>::min()}});
            it!=byX.end() && it->first.first<=hi;++it) {
            const auto& c=*it->second;
            if(std::hypot(x-c.x,z-c.z)<=radius+c.radius) {
                candidates.emplace_back(it->first.second,it->second);
                if(candidates.size()>sortLimit) {VisitAll(x,z,radius,visit);return;}
            }
        }
        std::sort(candidates.begin(),candidates.end(),[](const auto& a,const auto& b){return a.first<b.first;});
        // Callers only inspect claims; mutation or recursive queries in visit
        // are unsupported, as with the previous direct map traversal.
        for(const auto& candidate:candidates) visit(candidate.first.first,*candidate.second);
    }
private:
    template<class F> void VisitAll(float x,float z,float radius,F& visit) const {
        for(const auto& entry:entries) {
            const auto& c=entry.second;
            if(std::hypot(x-c.x,z-c.z)<=radius+c.radius) visit(entry.first.first,c);
        }
    }
    int nextToken=0;
    std::map<Key,Claim> entries;
    std::map<std::pair<float,Key>,const Claim*> byX;
    std::set<std::pair<int,Key>> expiry;
    std::multiset<float> radii;
    std::vector<std::pair<Key,const Claim*>> candidates; // retained allocation; no borrowed AI objects
};
}
