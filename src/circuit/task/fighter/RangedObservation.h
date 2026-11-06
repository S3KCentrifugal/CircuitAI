#ifndef CIRCUIT_RANGED_OBSERVATION_H
#define CIRCUIT_RANGED_OBSERVATION_H

#include "terrain/RangedGeometry.h"
#include "AIFloat3.h"
#include <deque>
#include <unordered_map>
#include <vector>

namespace circuit {
class CAllyTeam;
class CCircuitAI;
class CCircuitDef;

// D-462: the part of the ranged combat picture that is identical for every AI
// of one ally team within a simulation frame, built once and shared by them.
//
// Contacts come from the ally team's shared enemy records and are rebuilt when
// the frame, the ally team's enemy revision or the authority epoch changes, so
// an AI that runs before the authority's enemy update in a frame still sees
// the pre-update records, as it did with a private snapshot. Friends come from
// the engine's allied units: positions and types do not change while the AIs
// of a frame run, so a cell is read on first use in the frame (engine area
// query around the cell) and every reader sees what a full read at Refresh
// would have put there. Engaged needs every allied screen and calls
// LoadAllFriends, one full read per side per frame at most.
//
// Ownership: one per CAllyTeam, created lazily, held by each CRangedWorld.
// Main (callback) thread only. Readers keep contact and friend indices only
// within their own AI turn; every ranged world read follows that AI's Refresh
// in the same turn (INV-247). Authority change or release calls Invalidate:
// friend prototypes hold the authority's CCircuitDef pointers.
//
// Costs per side and frame: contacts O(E) once per enemy revision instead of
// once per AI; friends O(engine area query + units near the queried cells)
// per loaded cell, or O(N + F) for a full read (N world units walked by the
// engine, F allies), against O(A*(N+F)) for A AIs before. Retained memory:
// per-unit observation cache O(MAX_UNITS) per side.
class CRangedObservation final {
public:
	struct Contact {
		int id = -1;
		int armor = 0;
		CCircuitDef* def = nullptr;
		springai::AIFloat3 pos, velocity;
		float health = 1.f, radius = 16.f, cost = 1.f, groundRange = 0.f;
		float explosionRadius = 0.f, hazardRadius = 0.f;
		float tech = 1.f; // BAR customparams.techlevel, 1 when absent
		bool los = false, armed = false, mobile = false;
		// Owner 2026-11-02: an armed structure known only as a ghost image
		// (out of radar and LOS, its spot not seen empty). Ghosts live in
		// their own list/index (Ghosts, GhostHazards): a hazard for shooters
		// that opt in (RangedPolicy::ghostPorcRange), never a target.
		bool ghost = false;
		// Owner 2026-11-06: an unidentified radar dot well above the ground
		// (an aircraft). Only meaningful when def is null.
		bool airDot = false;
		// Owner 2026-11-06: for an unidentified dot, what this side last saw
		// it as in LOS (within SEEN_DEF_FRAMES), else null. Used only by the
		// spam rule; targeting still treats the dot as unidentified.
		CCircuitDef* seenDef = nullptr;
	};
	struct Friend {
		int id; springai::AIFloat3 pos; float radius;
		bool screen; float radar, jammer, los;
		CCircuitDef* def=nullptr;
		float combatHealth=-1.f; // lazy, valid for this frame's observation only
		float range=0.f;    // D-295: LAND weapon range of a screen definition
		bool assist=false;  // D-295: definition itself assists (excluded as engager)
	};
	struct Metadata { float radar=0.f, jammer=0.f, los=0.f; int armor=0; float explosionRadius=0.f; float tech=1.f; };
	struct ContactBounds {
		float largestRange=0.f, largestStaticRange=0.f, largestCohortHazard=0.f;
		bool nonnegativeHazardCosts=true, finiteStaticHazards=true;
	};
	// SpatialIndex-compatible friend queries; cells load on first touch.
	class Allies {
	public:
		explicit Allies(CRangedObservation* owner): owner(owner) {}
		template<class F> void Query(ranged::Point p,float radius,F&& visit) const {
			owner->friendCells.Query(p,radius,[this](int x,int z) { owner->LoadCell(x,z); },visit);
		}
		template<class F> bool Any(ranged::Point p,float radius,F&& predicate) const {
			return owner->friendCells.Any(p,radius,[this](int x,int z) { owner->LoadCell(x,z); },predicate);
		}
	private:
		CRangedObservation* owner;
	};

	CRangedObservation(CAllyTeam* allyTeam, CCircuitAI* reader);
	CRangedObservation(const CRangedObservation&) = delete;
	CRangedObservation& operator=(const CRangedObservation&) = delete;

	// Contacts, objectives, enemy indexes and bounds for the reader's frame.
	void AcquireContacts(CCircuitAI* reader);
	// Makes reader the AI whose callbacks load friend cells, and starts a new
	// friend generation when the frame or authority epoch changed.
	void BindFriends(CCircuitAI* reader);
	// Completes the friend picture with one full read (Engaged, or a busy
	// frame). adoptX/adoptZ: the cell whose load started it, if any.
	void LoadAllFriends(int adoptX=-1,int adoptZ=-1);
	// Called by CAllyTeam on authority change and on each AI release.
	void Invalidate();

	const std::vector<Contact>& Contacts() const { return contacts; }
	const std::vector<int>& Objectives() const { return objectives; }
	const ranged::SpatialIndex& Enemies() const { return enemies; }
	const ranged::SpatialIndex& StaticHazards() const { return staticHazards; }
	const ranged::CellStore<float>& ClusterValues() const { return clusterValues; }
	const ContactBounds& Bounds() const { return bounds; }
	// Owner 2026-11-02 ghost porc, rebuilt with the contacts.
	const std::vector<Contact>& Ghosts() const { return ghosts; }
	const ranged::SpatialIndex& GhostHazards() const { return ghostHazards; }
	float LargestGhostHazard() const { return largestGhostHazard; }
	unsigned ContactGeneration() const { return contactGeneration; }
	std::deque<Friend>& Friends() { return friends; }
	const Allies& AlliesIndex() const { return allies; }
	// Radius that bounds every friend: exact (largest loaded radius) once the
	// side is complete, else the largest non-flying definition radius. It
	// only sizes broad phases of exact predicates: same results either way.
	float FriendRadius();
	float FriendRadiusBound();
	// Largest screen range of all friends; valid after LoadAllFriends.
	float ScreenRange() const { return screenRange; }
	const Metadata& MetadataFor(CCircuitDef* def);

	// INV-247/248 oracle (CIRCUIT_VERIFY_RANGED_SHARED): builds the private
	// legacy contact view and full friend read and compares. Never in timing.
	static const bool verify;
	void VerifyContacts(CCircuitAI* reader);

private:
	void BuildContacts(CCircuitAI* reader, std::vector<Contact>& out, std::vector<int>& outObjectives,
	                   ranged::SpatialIndex& outEnemies, ranged::SpatialIndex& outStatic,
	                   ranged::CellStore<float>& outClusters, ContactBounds& outBounds);
	// Owner 2026-11-02: the ghost porc pass, O(E) once per contact rebuild.
	void BuildGhosts(CCircuitAI* reader);
	void LoadCell(int x,int z);
	// Reads (once per frame per unit) whether an allied unit is a ground
	// friend and, if so, its corrected position. Returns null when it is not.
	const Friend* Observe(int id);
	const Friend* ObserveDirect(int id);
	const Friend* PrototypeFor(int definitionId);
	int AppendFriend(const Friend& friendly);
	void ResetFriends(int frame);
	void CaptureLegacyFriends();
	void CompareLegacyFriends();

	CAllyTeam* allyTeam;
	CCircuitAI* reader = nullptr;
	unsigned epoch = 1;

	// Contacts: shared, rebuilt per (frame, enemy revision, epoch).
	int contactFrame = -1;
	unsigned contactRevision = 0, contactEpoch = 0, contactGeneration = 0;
	std::vector<Contact> contacts;
	std::vector<int> objectives;
	ranged::SpatialIndex enemies, staticHazards;
	ranged::CellStore<float> clusterValues;
	ContactBounds bounds;
	std::unordered_map<int,Metadata> metadata;
	std::vector<Contact> ghosts;
	ranged::SpatialIndex ghostHazards;
	float largestGhostHazard = 0.f;
	// Owner 2026-11-06: last LOS identity per enemy id (def, frame), for
	// Contact::seenDef; entries older than SEEN_DEF_FRAMES are pruned once
	// per SEEN_DEF_FRAMES, so the map holds only the enemies seen lately.
	struct SeenDef { CCircuitDef* def=nullptr; int frame=-1; };
	std::unordered_map<int,SeenDef> seenDefs;
	int seenDefsPruned = 0;

	// Friends: shared per (frame, epoch), cells filled lazily.
	int friendFrame = -1;
	unsigned friendEpoch = 0;
	std::deque<Friend> friends; // stable references while cells append
	ranged::LazySpatialIndex friendCells;
	Allies allies{this};
	float screenRange = 0.f, loadedRadius = 0.f;
	bool cellsLoaded = false;              // a cell load ran in this generation
	bool preferFull = false;               // the previous frame's cells cost more than a full read
	double cellCost = -1.0, fullCost = -1.0; // running mean wall seconds per cell load / full read
	double cellSpend = 0.0;                // this frame's cell-load seconds
	bool FullReadCheaper(int cells) const;
	float radiusBound = -1.f;
	unsigned radiusEpoch = 0;
	std::vector<Friend> prototypes;          // per definition id, stamped per frame
	std::vector<int> prototypeFrames;
	struct Seen { int frame=-1; int index=-1; springai::AIFloat3 pos; bool ground=false; };
	std::vector<Seen> seen;                  // per unit id, stamped per frame
	std::vector<int> ids, local;
	Friend observed{};                       // Observe result, copied by the caller
	ranged::OrderedIds order;

	// Oracle state (verify only).
	int legacyFrame = -1;
	std::vector<Friend> legacyFriends;
	ranged::SpatialIndex legacyCells;
	float legacyScreenRange = 0.f, legacyRadius = 0.f;
	std::vector<Contact> verifyContacts;
	std::vector<int> verifyObjectives;
	ranged::SpatialIndex verifyEnemies, verifyStatic;
	ranged::CellStore<float> verifyClusters;
};
}
#endif
