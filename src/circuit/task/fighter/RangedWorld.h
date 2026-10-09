#ifndef CIRCUIT_RANGED_WORLD_H
#define CIRCUIT_RANGED_WORLD_H

#include "terrain/RangedGeometry.h"
#include "AIFloat3.h"
#include <map>
#include <memory>
#include <unordered_map>
#include <vector>

namespace springai { class WeaponMount; }
namespace circuit {
class CCircuitAI;
class CCircuitDef;
class CCircuitUnit;
class CWeaponDef;

// Per-AI, callback-thread service. No wrappers or mutable indexes escape to a
// worker. Each observed frame builds at most one O(E+F log F+U+B) snapshot;
// B is retained spatial buckets. Sorted friendly IDs preserve legacy ties; shooters
// query local cells. Unit IDs, not borrowed unit pointers, survive callbacks.
class CRangedWorld {
public:
    struct Weapon {
        std::unique_ptr<springai::WeaponMount> mount;
        CWeaponDef* def = nullptr; // owned by CircuitAI
        std::vector<float> damage;
        int category = 0, index = 0;
        float range = 0.f, arc = -1.f, reload = 1.f, burst = 0.f;
        float heightMod = 1.f, cylinder = 0.f, speed = 0.f, gravity = 0.f;
        float splash = 0.f, alphaScale = 1.f;
        bool ballistic = false, high = false, forward = false, fake = false, guided = false;
        Weapon(); ~Weapon();
        Weapon(Weapon&&) noexcept; Weapon& operator=(Weapon&&) noexcept;
    };
    struct Capabilities {
        std::vector<Weapon> weapons;
        float turnRate = 1.f, acceleration = 0.f, speed = 0.f, blastRadius = 0.f;
        float radius = 16.f, cloakCost = 0.f, cloakMoving = 0.f;
        bool cloak = false;
    };
    struct Contact {
        int id = -1;
        int armor = 0;
        CCircuitDef* def = nullptr;
        springai::AIFloat3 pos, velocity;
        float health = 1.f, radius = 16.f, cost = 1.f, groundRange = 0.f;
        float explosionRadius = 0.f, hazardRadius = 0.f;
        bool los = false, armed = false, mobile = false;
    };
    struct Friend {
        int id; springai::AIFloat3 pos; float radius;
        bool screen; float radar, jammer, los;
    };
    struct Slot { springai::AIFloat3 pos; float spacing, value; };

    explicit CRangedWorld(CCircuitAI* circuit): circuit(circuit) {}
    ~CRangedWorld();
    const Capabilities& CapabilitiesFor(CCircuitDef* def);
    void Refresh();
    void Join(CCircuitUnit* unit);
    void Leave(int id);
    void SetSlot(int id, const springai::AIFloat3& pos, float spacing, float value);
    bool FreeSlot(int id, const springai::AIFloat3& pos, float spacing) const;
    void Nearby(const springai::AIFloat3& pos, float radius, std::vector<int>& result) const;
    const std::vector<Contact>& Contacts() const { return contacts; }
    const std::vector<int>& Objectives() const { return objectives; }
    bool Safe(const springai::AIFloat3& from, const springai::AIFloat3& to, float margin, bool escaping=false) const;
    float Danger(const springai::AIFloat3& pos, float margin) const;
    bool FriendlySplash(int id, const springai::AIFloat3& target, float radius) const;
    bool FriendlyLine(const Weapon& weapon, int id, const springai::AIFloat3& from, const springai::AIFloat3& target) const;
    bool HasScreen(int id, const springai::AIFloat3& from, const springai::AIFloat3& target) const;
    float Range(const Weapon& weapon, const springai::AIFloat3& from, const springai::AIFloat3& to) const;
    bool Trajectory(const Weapon& weapon, const springai::AIFloat3& from, const springai::AIFloat3& to) const;
    void ReserveShot(int owner, int target, float damage, int until);
    float Reserved(int target, int owner) const;
    void ReleaseShot(int owner);
    float Progress(int target, float penalty) const;
    float ClusterValue(const springai::AIFloat3& target, float radius) const;
    bool Escort(CCircuitUnit* sensor, springai::AIFloat3& position);
    bool HasMembers() const { return !slots.empty(); }
    void ReleaseEscort(int id) { escorts.erase(id); }

private:
    CCircuitAI* circuit;
    int frame = -1;
    float largestRange = 0.f, largestSpacing = 0.f, largestFriendRadius = 0.f;
    struct Metadata { float radar=0.f, jammer=0.f, los=0.f; int armor=0; float explosionRadius=0.f; };
    std::unordered_map<int,Metadata> metadata;
    const Metadata& MetadataFor(CCircuitDef* def);
    std::unordered_map<int,Capabilities> capabilities;
    std::vector<Contact> contacts;
    std::vector<Friend> friends;
    std::vector<int> friendlyIds;
    std::vector<int> objectives;
    ranged::SpatialIndex enemies, allies, formations;
    std::unordered_map<std::uint64_t,float> clusterValues;
    std::map<int,Slot> slots;
    struct Shot { int target, until; float damage; };
    std::unordered_map<int,Shot> shots;
    std::unordered_map<int,float> reserved;
    struct History { float health=0.f; int stalled=0, frame=0, seen=0, engaged=-1; };
    std::unordered_map<int,History> history;
    struct EscortLease { int anchor=-1; bool jammer=false; };
    std::map<int,EscortLease> escorts;
};
}
#endif
