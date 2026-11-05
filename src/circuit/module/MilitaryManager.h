/*
 * MilitaryManager.h
 *
 *  Created on: Sep 5, 2014
 *      Author: rlcevg
 */

#ifndef SRC_CIRCUIT_MODULE_MILITARYMANAGER_H_
#define SRC_CIRCUIT_MODULE_MILITARYMANAGER_H_

#include "module/TaskModule.h"
#include "setup/DefenceData.h"
#include "task/fighter/FighterTask.h"
#include "task/static/DebugStrike.h"
#include "task/static/StrategicTargeting.h"
#include "unit/CircuitDef.h"
#include "unit/CoreUnit.h"
#include "util/AvailList.h"

#include <vector>
#include <cmath>
#include <string>
#include <set>
#include <unordered_map>
#include <unordered_set>
#include <array>
#include <type_traits>

namespace circuit {

class IMainJob;
class CBDefenceTask;
class CFGuardTask;
class CRangedWorld;

namespace TaskF {
	struct SFightTask {
		IFighterTask::FightType type;
		IFighterTask::FightType check;
		IFighterTask::FightType promote;
		float power;
		CCircuitUnit* vip;
	};

	static inline SFightTask Common(IFighterTask::FightType type)
	{
		SFightTask ti{};
		ti.type = type;

		ti.check = type;
		ti.promote = type;
		ti.power = 0.f;
		ti.vip = nullptr;
		return ti;
	}
	static inline SFightTask Guard(CCircuitUnit* vip)
	{
		SFightTask ti{};
		ti.type = IFighterTask::FightType::GUARD;
		ti.vip = vip;
		return ti;
	}
	static inline SFightTask Defend(IFighterTask::FightType promote, float power)
	{
		SFightTask ti{};
		ti.type = IFighterTask::FightType::DEFEND;
		ti.check = IFighterTask::FightType::_SIZE_;  // NONE
		ti.promote = promote;
		ti.power = power;
		return ti;
	}
	static inline SFightTask Defend(IFighterTask::FightType check, IFighterTask::FightType promote, float power)
	{
		SFightTask ti{};
		ti.type = IFighterTask::FightType::DEFEND;
		ti.check = check;
		ti.promote = promote;
		ti.power = power;
		return ti;
	}
} // namespace TaskF

class CMilitaryManager final: public ITaskModule {
public:
	friend class CMilitaryScript;

	using BuildVector = std::vector<std::pair<CCircuitDef*, int>>;  // cdef: frame
	using SuperInfos = std::vector<std::pair<CCircuitDef*, float>>;  // cdef: weight
	struct SSideInfo {
		std::vector<CCircuitDef*> landDefenders;
		std::vector<CCircuitDef*> waterDefenders;
		BuildVector baseDefence;

		std::vector<CCircuitDef*> wallDefs;  // land and water
		std::vector<CCircuitDef*> chokeDefs;  // land and water
		CCircuitDef* defaultPorc;

		SuperInfos superInfos;
	};

	CMilitaryManager(CCircuitAI* circuit);
	virtual ~CMilitaryManager();

	void InitHandlers();
private:
	void ReadConfig();
	void InitEconomyScores(const std::vector<CCircuitDef*>&& builders);
	void InitMilitary();

public:
	virtual int UnitCreated(CCircuitUnit* unit, CCircuitUnit* builder) override;
	virtual int UnitFinished(CCircuitUnit* unit) override;
	virtual int UnitIdle(CCircuitUnit* unit) override;
	virtual int UnitDamaged(CCircuitUnit* unit, CEnemyInfo* attacker) override;
	virtual int UnitDestroyed(CCircuitUnit* unit, CEnemyInfo* attacker) override;

	const std::set<IFighterTask*>& GetTasks(IFighterTask::FightType type) const {
		return fightTasks[static_cast<IFighterTask::FT>(type)];
	}

	IFighterTask* Enqueue(const TaskF::SFightTask& ti);
	IFighterTask* EnqueueGather(const TaskF::SFightTask& ti, const springai::AIFloat3& pos, int deadline);
	bool SetGatherPower(IUnitTask* task, float power);
	IUnitTask* EnqueueExternalControl(const std::string& ownerRule);
	IUnitTask* EnqueueEscortStrike();  // AirLiches: strikers that guard a raid (CEscortStrikeTask)
	IUnitTask* EnqueueCargoHold(int transportId);
	virtual CRetreatTask* EnqueueRetreat() override;

	/*
	 * Pulse-weapon target policy (Juno). A pulse weapon does no damage: its
	 * effect is a Lua gadget that deletes flagged defs inside the blast, so
	 * ranking enemy groups by metal cost aims it at armies it cannot hurt.
	 * Instead it picks the highest-priority sensor/EW target it can reach.
	 * Configured under "pulse" in behaviour.json; see doc/juno-targets.md.
	 */
	enum class PulseClass: int {JAMMER_ADVANCED = 0, JAMMER_STATIC, RADAR_ADVANCED, RADAR_STATIC, JAMMER_MOBILE, RADAR_MOBILE, _SIZE_};
	using PulseC = std::underlying_type<PulseClass>::type;
	struct SPulseInfo {
		bool isEnabled = false;  // false when the config names no usable role
		CCircuitDef::RoleM pulseRole = 0;  // defs that carry a pulse weapon
		CCircuitDef::RoleM jammerRole = 0;
		CCircuitDef::RoleM radarRole = 0;
		// rank[class] = priority, lower fires first; -1 excludes the class
		std::array<int, static_cast<PulseC>(PulseClass::_SIZE_)> rank = {-1, -1, -1, -1, -1, -1};
		std::map<int, int> targetClasses; // loaded vulnerable sensor properties, cached once
		std::set<int> unitDefs;
		int pendingFrames = 45 * FRAMES_PER_SEC;
		int coverageFrames = 90 * FRAMES_PER_SEC;
		bool scatter = true;
		float scatterStep = 384.f;
		float scatterDepth = 192.f;
		int mobileMaxAge = 0;  // frames a mobile target's last known position stays usable
		int minTargets = 1;    // do not spend a shot on fewer than this many targets
		/*
		 * Radar-hole inference. A jammer sits inside its own radardistancejam
		 * bubble (360-760 in BAR) and so hides itself from radar: it is only ever
		 * a known target when we have LOS on it, which in practice means a unit
		 * is already standing next to it. The inference runs the other way -
		 * ground we cover with radar, cannot see, believe is enemy-held, and read
		 * no contacts from, is probably jammed. The pulse AoE (1400) is wider
		 * than the widest jam radius, so hitting the hole tends to catch the
		 * jammer that made it. Known targets always outrank suspected ones.
		 */
		bool suspectJammer = true;
		float holeProbeRadius = 760.f;   // widest BAR jam radius: probe this far off a contact
		float holeRadius = 500.f;        // a probe with no contact inside this is a hole
		float holeMinEnemyInfl = 0.05f;  // only where we believe the enemy operates
		int holeProbes = 8;              // probe directions per known contact
		/*
		 * Probing shot (owner 2026-11-03). Ghost images of enemy structures
		 * inside our radar coverage, out of LOS, with no radar signature
		 * (no contact within probeClearRadius), are probably jammed. A cluster
		 * of probeMinGhosts or more is aimed at its centre, after every known
		 * radar/jammer and before the radar-hole inference. A spot probed once
		 * is not probed again for probeRepeatFrames (ally team).
		 */
		bool probe = true;
		int probeMinGhosts = 3;
		float probeRadius = 700.f;       // cluster radius: the pulse's blast radius
		float probeClearRadius = 400.f;  // a contact this close is the image's signature
		int probeRepeatFrames = 600 * FRAMES_PER_SEC;
		int probeRefreshFrames = 5 * FRAMES_PER_SEC;
	};
	const SPulseInfo& GetPulseInfo() const { return pulseInfo; }
	// Jammed-ghost clusters, best first; recomputed at most every probeRefreshFrames.
	const std::vector<strategic::ProbeCluster>& GetProbeClusters();
	// The commander group's probe Juno (owner 2026-11-03): its build site and
	// the aim its first pulse goes to. A new Juno within 400 of a live order's
	// site takes it once (TakeProbeOrder), with the aim refreshed to the
	// nearest current cluster centre within probeRadius.
	void AddProbeOrder(const springai::AIFloat3& site, const springai::AIFloat3& aim, int expires);
	bool TakeProbeOrder(const springai::AIFloat3& junoPos, springai::AIFloat3& aim);

	/*
	 * EMP-weapon target policy. A paralyzer deals no health damage: whether a
	 * shot does anything is `maxHealth < paralysisDamage * paralyzemultiplier`,
	 * so the policy computes the stun it would buy and rejects targets it
	 * cannot hold. Configured under "emp" in behaviour.json; see
	 * doc/emp-targets.md.
	 */
	struct SEmpInfo {
		bool isEnabled = false;
		CCircuitDef::RoleM empRole = 0;       // defs that carry an EMP weapon
		CCircuitDef::RoleM antiNukeRole = 0;  // the one class ranked above raw value
		int empableFlag = 0;                  // BAR EMPABLE category bit
		// modrules.paralyze.paralyzeDeclineRate: paralysis drains at
		// maxHealth / declineRate per second. 40 default, 20 with emprework.
		float declineRate = 40.f;
		float minStunSeconds = 5.f;  // do not spend a shot for less than this
		int mobileMaxAge = 0;        // frames a mobile's last known position stays usable
		int minTargets = 1;
		bool structuresFirst = true;  // only structures get an uncapped stun
		// Static shield generators rank right after the anti-nuke, above every
		// other structure: stunned, a shield drops the bubble over its porc.
		bool shieldsSecond = true;
		// Only structures at or above this cost keep their rank above mobiles;
		// cheaper ones compete with mobiles on cost. "Large statics first, then
		// the most expensive thing in range" - a 1 020-metal wall should not
		// outrank a 5 000-metal experimental just for being a building.
		float structuresFirstMinCost = 1500.f;
	};
	const SEmpInfo& GetEmpInfo() const { return empInfo; }

	/*
	 * Bomber policy. A bombing pass is alpha: it either kills or is wasted, so
	 * a group picks by value per HP, refuses targets it cannot finish, and
	 * chooses between concentrating on one target and spreading a line across
	 * a front. Configured under "bomber" in behaviour.json; see
	 * doc/bomber-targeting.md.
	 */
	struct SBomberInfo {
		bool isEnabled = false;
		// A target needing more than groupAlpha * killMargin is left for a
		// bigger group while any finishable target exists.
		float killMargin = 1.15f;
		// Concentrate the whole group on one target worth at least this much.
		float focusCost = 1500.f;
		// Spread into a line when this many candidates sit inside areaRadius.
		int areaMinTargets = 3;
		float areaRadius = 900.f;
		// Line geometry. Spacing is clamped into [minSpacing, 2 * weapon AoE]:
		// at the top of that range the bombs tile the front without overlap, at
		// the bottom a large group packs tight and concentrates damage.
		float minSpacing = 96.f;
		// How far past the front the run continues as an attack-move, so
		// survivors clean up and leave rather than circling over the AA.
		float cleanupDistance = 900.f;
		// Approach bearing: sample this many directions on a ring of this
		// radius around the aim point and run in from the quietest one.
		int approachSamples = 8;
		float approachRing = 1200.f;
		// Let bombers of different defs share one task, so a mixed wave forms
		// one line instead of several parallel groups.
		bool groupMixedDefs = true;
	};
	const SBomberInfo& GetBomberInfo() const { return bomberInfo; }

	/*
	 * Stockpile patience. A stockpiled super weapon - nuke, EMP, Juno - only
	 * fires at a group worth at least its shot cost. That floor treats metal
	 * that is ALREADY SPENT as the price of firing, and group value is only
	 * what the AI can currently see, so a silo sat with three missiles while
	 * a discovered base "was not worth it" and died with them. The floor now
	 * decays with how long a shot has been waiting, and collapses once enough
	 * shots are stocked: a wave of a poor target beats a full tube.
	 * Configured under "stockpile" in behaviour.json.
	 */
	struct SStockInfo {
		float patienceSeconds = 240.f;  // floor decays from 1.0 to minFraction over this
		float minFraction = 0.25f;      // never below this fraction of the shot cost
		int fullFireCount = 2;          // at this many stocked, the floor is minFraction now
		// Regional stockpiled launchers (Perdition, Catalyst) aim by unit scan,
		// CSuperTask::SelectLauncherTarget, not by enemy-group centroid.
		int launcherMobileMaxAge = 900;       // frames a mobile's last known position stays usable
		int launcherMinTargets = 1;           // raise to require a clump inside the blast
		bool launcherStructuresFirst = false; // rank any structure above any mobile
	};
	const SStockInfo& GetStockInfo() const { return stockInfo; }
	struct SNuclearInfo {
		bool structuresOnly = true;
		int repeatFrames = 300 * FRAMES_PER_SEC;
		float repeatRadius = 0.f; // zero uses the loaded blast radius
		// Overnuke (owner 2026-10-28): from overnukeSilos finished silos up, all
		// of them fire at one target for a roll of overnukeMin..overnukeMax
		// launches; every overnukeScoutEvery launches AIR scouts the area.
		int overnukeSilos = 3;  // 0 = off
		int overnukeMin = 10;
		int overnukeMax = 25;
		int overnukeScoutEvery = 10;
		// Salvo (owner 2026-10-30): the reaching silos hold fire until together
		// they stock the roll (each holds overnukeStockCap), then fire as fast as
		// their reload allows; earlier after overnukeStockFrames, or when a
		// reaching silo falls below overnukeFireBelowHealth of its health.
		bool overnukeStock = true;
		int overnukeStockCap = 10;  // BAR stockpilelimit of every silo
		int overnukeStockFrames = 900 * FRAMES_PER_SEC;  // 0 = no timeout
		float overnukeFireBelowHealth = 0.5f;  // 0 = off
		// Second breakpoint (owner 2026-10-30): from overnukeTeamSilos finished
		// silos across every allied BARb, the roll is overnukeTeamMin..Max.
		int overnukeTeamSilos = 8;  // 0 = off
		int overnukeTeamMin = 15;
		int overnukeTeamMax = 30;
		// Third breakpoint (owner 2026-11-04): from overnukeTier3Silos, overnukeTier3Min..Max.
		int overnukeTier3Silos = 0;  // 0 = off
		int overnukeTier3Min = 19;
		int overnukeTier3Max = 25;
		// owner 2026-11-04: a released salvo fires every missile the reaching silos hold,
		// not only the roll; what they stock after waits for the next target.
		bool overnukeFireAll = false;
		// Antinuke cover (owner 2026-10-31, restored 2026-11-02): each known enemy
		// interceptor (any def with an interceptor weapon: Protector, Fortitude,
		// Aegis, Rampart, mobile and ship antinukes) whose coverage holds an aim
		// point multiplies the aim point's metal value by a factor (owner 2026-11-03):
		// value x max(antinukeFloor, factor ^ covering), e.g. 0.70, 0.49, 0.343.
		float antinukeFactorOrdinary = 0.70f;  // an ordinary shot
		// value each target by what the blast's falloff does to it (CSuperTask::ChainKill)
		bool blastKill = true;
		// blast distance is measured to the target's collision volume (CollisionVolumes.h); a def missing
		// from that table: centre distance - def radius x this (0.86: the best single fit, 2026-11-02)
		float volumeFactor = 0.86f;
		float antinukeFactorOvernuke = 0.85f;  // an overnuke target (the salvo is meant to saturate)
		float antinukeFloor = 0.05f;
		float coveredMargin = 64.f;  // added to each coverage radius
	};
	const SNuclearInfo& GetNuclearInfo() const { return nuclearInfo; }
	strategic::Overnuke& GetOvernuke();  // the ally team's (CAllyTeam::GetOvernuke)
	// Script reads: a new scout request is a rise in GetOvernukeScouts()
	// Only the AI whose launch raised the ally team's scout count asks AIR: one package.
	int GetOvernukeScouts() const { return overnukeScouts; }
	void NoteOvernukeScout() { ++overnukeScouts; }
	// Front nukerush (owner 2026-11-03): a rise in GetOvernukeRounds() is a new
	// overnuke target begun by one of our silos - the first is the trigger
	// (3+ silos across the allies), every later one follows a finished salvo
	// while the next stocks; the script asks AIR for a scout package each time.
	int GetOvernukeRounds() const { return overnukeRounds; }
	void NoteOvernukeRound() { ++overnukeRounds; }
	// One draw per key for the ally team (CAllyTeam::TeamRoll).
	bool AllyTeamRoll(const std::string& key, float chance);
	// The ally team's first overnuke rolls lo..hi launches (strategic::Overnuke::SetFirstRoll).
	void SetOvernukeFirstRoll(int lo, int hi);
	springai::AIFloat3 GetOvernukePos() const;
	float GetOvernukeRadius() const;
	// Nuke rush scouting (owner 2026-10-28): the latest aim point the nuclear
	// scan chose and its blast radius; x < 0 before the first one
	void SetNuclearAim(const springai::AIFloat3& pos, float radius) { nuclearAim = pos; nuclearAimRadius = radius; }
	springai::AIFloat3 GetNuclearAim() const { return nuclearAim; }
	float GetNuclearAimRadius() const { return nuclearAimRadius; }
	// Debug strikes (owner 2026-10-31, debug-widget-test): the widget's debug
	// window, through the script (barb|debug). weapon: debug::NUKE, LOL or GOAL;
	// mode: debug::Mode OFF, POS (x, z) or TEAM (team). False when malformed.
	bool SetDebugStrike(int weapon, int mode, float x, float z, int team);
	// A team strike on the team that player plays (engine GetPlayerTeam); false
	// for an unknown player, a spectator or a player of our own team.
	bool SetDebugStrikePlayer(int weapon, int player);
	// debug::GOAL (owner 2026-11-01): the army's move goal, the same commands
	debug::Strike& GetDebugStrike(int weapon) { return debugStrikes[debug::ValidWeapon(weapon) ? weapon : debug::NUKE]; }
	// The widget's status line for one weapon (debug::Describe)
	std::string GetDebugStrikeState(int weapon) const;
	// Nuke launch scouting (owner 2026-10-31): every launch of ours counts and keeps
	// where it went, so the script can tell AIR and ask scouts at the latest spot
	void NoteNuclearLaunch(const springai::AIFloat3& pos, float radius) { ++nuclearLaunches; nuclearLaunchPos = pos; nuclearLaunchRadius = radius; }
	int GetNuclearLaunches() const { return nuclearLaunches; }
	springai::AIFloat3 GetNuclearLaunchPos() const { return nuclearLaunchPos; }
	float GetNuclearLaunchRadius() const { return nuclearLaunchRadius; }

	/*
	 * Mobile sensor escort policy. Mobile radar and jammer units carry the
	 * `support` main role, and CSupportTask walks each of them to the *nearest*
	 * squad and joins it outright, with no cap - so every sensor on the map
	 * converges on whichever squad happens to be closest (27 radar bots trailing
	 * one sharpshooter in a game on Eight Horses).
	 *
	 * One sensor per squad is all a squad can use: a second jammer adds no
	 * coverage a squad moving as one body does not already have, and a second
	 * radar bot is a duplicate of the first. So the escort is rationed - at most
	 * `max_per_squad` per squad, and the scarce sensors go to the squads worth
	 * covering first, ranked by the value of the squad's leader, which is the
	 * highest-tier unit in it. A sensor with nowhere to go holds near base
	 * rather than joining a squad that is already covered.
	 *
	 * Configured under "sensor" in behaviour.json; see doc/sensor-escort.md.
	 */
	struct SSensorInfo {
		bool isEnabled = false;
		CCircuitDef::RoleM sensorRole = 0;  // jammer | radar: the rationed defs
		int maxPerSquad = 1;   // "unless it dies": the count is of live assignees
		int topCandidates = 3;  // aim at the nearest of the N most valuable squads
		bool rebalance = true;  // release the surplus when two escorted squads merge
	};
	const SSensorInfo& GetSensorInfo() const { return sensorInfo; }

	/*
	 * D-352 commander snipe. Listed defs, and every armed mobile def at or
	 * above `min_tech` (BAR customparams.techlevel), put a scouted enemy
	 * commander within weapon range at the head of BAR's SET_TARGET list
	 * (LOS, or its radar dot when cloaked). The unit keeps its move and other
	 * orders; only its weapon target changes. Off unless the "commander_snipe"
	 * block in behaviour.json enables it.
	 */
	struct SCommSnipeInfo {
		bool isEnabled = false;
		std::unordered_set<CCircuitDef::Id> defs;
		int interval = 15;          // frames between scans
		float acquireMargin = 64.f; // lock when within weapon range + this
		float releaseMargin = 200.f; // keep it while within range + this
	};
	/*
	 * Owner 2026-11-01: legacy-path artillery (no `ranged` attribute) only ever
	 * ordered structures, so a human's commander parked in range was never shot.
	 * Listed defs also take an enemy commander inside weapon range whose speed
	 * is at most `maxSpeed` (stationary, building, walking slowly) as their first
	 * target. Off unless the "artillery_commander" block in behaviour.json
	 * enables it.
	 */
	struct SArtyCommInfo {
		bool isEnabled = false;
		std::unordered_set<CCircuitDef::Id> defs;
		float maxSqSpeed = 0.f;  // (elmos/frame)^2
		// Owner 2026-11-01: heavy units (Fatboy, Tzar, Mammoth ...) are the next
		// targets after commanders, when moving at most `heavy_speed_fraction`
		// of their own top speed. Value: that speed limit, (elmos/frame)^2.
		std::unordered_map<CCircuitDef::Id, float> heavyMaxSqSpeed;
		// Owner 2026-11-02: "ghost_units" fire on a ghost image of enemy porc
		// (armed structure out of radar and LOS, spot not seen empty) already
		// in weapon range, with nothing else to shoot, once they have not fired
		// for "ghost_idle_seconds". They never move toward a ghost.
		std::unordered_set<CCircuitDef::Id> ghostDefs;
		int ghostIdleFrames = 300;
		// Owner 2026-11-04 16:58Z: target lock. A unit of `defs` keeps the
		// identified (LOS or radar) enemy it shoots until it dies; within
		// range + lockMargin it holds and re-attacks, farther out (a structure)
		// it only steps in to range - lockStepIn, never the forward path or a
		// route resume. Only commander / heavy priority breaks it (and resumes
		// it after). lockMobiles: also lock other mobiles (default structures,
		// commanders and heavies only).
		bool lockEnabled = true;
		bool lockMobiles = false;
		float lockMargin = 150.f;
		float lockStepIn = 100.f;
		// Owner 2026-11-04 20:03Z: after the normal pick and before the idle ghost
		// volley, an unidentified radar dot (no def) in weapon range is fired on
		// until dead; never walked toward.
		bool radarDots = true;
	};
	const SArtyCommInfo& GetArtyCommInfo() const { return artyCommInfo; }
	// Owner 2026-11-04 16:57Z: per enemy id, the last frame a wreck query ran
	// and whether a wreck of it was seen at its ghost spot (ArtilleryTask).
	std::unordered_map<int, std::pair<int, bool>>& GetWreckCache() { return wreckCache; }
	/*
	 * Owner 2026-11-03: tactical launcher priority ("launcher_priority").
	 * Listed super weapons (Paralyzer armemp, Catalyst cortron, Perdition
	 * legperdition) shoot, before their ordinary pick:
	 *   rank 0 (primary): static shields and the "primary" defs (Pulsar,
	 *          Bulwark, Bastion);
	 *   rank 1: enemy commanders moving at most commander_max_speed
	 *          (a paralyzer skips this: commanders cannot be stunned);
	 *   rank 2: the "tertiary" defs (Persecutor, Rattlesnake, Eviscerator) and
	 *          tech level 3 enemies that are static or move at most
	 *          t3_max_speed.
	 * A priority target is aimed at its own position and is not held to the
	 * stockpile floor. "sync_units" (Catalyst, Perdition): with two or more of
	 * them reaching the same primary target, each holds until all have a
	 * stocked missile, then all fire at that target on the same frame
	 * (after sync_max_wait_seconds a stocked one fires alone). See
	 * CSuperTask::SyncLaunch.
	 */
	struct SLauncherPrioInfo {
		bool isEnabled = false;
		std::unordered_set<CCircuitDef::Id> defs;
		std::unordered_set<CCircuitDef::Id> primary;
		bool primaryShields = true;
		float commMaxSqSpeed = 0.f;  // (elmos/frame)^2; < 0: no commander rank
		std::unordered_set<CCircuitDef::Id> tertiary;
		std::unordered_set<CCircuitDef::Id> t3Defs;
		float t3MaxSqSpeed = 0.f;    // (elmos/frame)^2
		std::unordered_set<CCircuitDef::Id> syncDefs;
		int syncMaxWaitFrames = 0;   // 0: wait for ever
		int syncRecheckFrames = 30;
		// Owner 2026-11-03 (same impact): a mixed volley (Catalyst + Perdition)
		// is timed so every shot lands on the same frame. Per def, from headless
		// measurements: order-to-launch delay and launch-to-impact flight, both
		// in frames, by distance (piecewise linear); delayReady is the delay
		// when the def fired within readyFrames (its turret is still open).
		struct STiming {
			std::vector<std::pair<float, float>> delay, flight;
			float delayReady = -1.f;
			int readyFrames = 0;
		};
		std::unordered_map<CCircuitDef::Id, STiming> timing;
		int syncSettleFrames = 9 * 30;  // a member aimed or fired this recently is still open: its next delay is unpredictable
		int syncPendingMaxFrames = 20 * 30;  // a timed order older than this is dropped
		static float Interp(const std::vector<std::pair<float, float>>& t, float x) {
			if (t.empty()) return 0.f;
			if (t.size() == 1) return t[0].second;
			unsigned i = 1;
			while ((i + 1 < t.size()) && (x > t[i].first)) ++i;
			const auto& a = t[i - 1];
			const auto& b = t[i];
			const float span = b.first - a.first;
			return (std::abs(span) < 1e-3f) ? a.second : a.second + (b.second - a.second) * (x - a.first) / span;
		}
	};
	const SLauncherPrioInfo& GetLauncherPrioInfo() const { return launcherPrioInfo; }
	// Same-impact volleys: a shot ordered later than the volley's first, so
	// that it lands with it. UpdateSyncOrders gives the order on `frame`.
	struct SSyncOrder {
		ICoreUnit::Id unitId;
		springai::AIFloat3 pos;
		int frame;
		int volley;
		float total;    // this shot's predicted delay + flight, frames
		int created;
		float delay;    // this shot's order-to-launch delay predicted at the volley, frames
	};
	int NewSyncVolley() { return ++syncVolleySerial; }
	void AddSyncOrder(const SSyncOrder& o) { syncOrders.push_back(o); }
	// The volley's first shot left: its impact frame is now known, so the
	// orders still waiting are re-timed to it.
	void SyncAnchorLaunched(int volley, int impactFrame);
	// Learned correction of a def's predicted delay (actual - predicted, frames).
	float GetSyncDelayBias(CCircuitDef::Id id) const {
		auto it = syncDelayBias.find(id);
		return (it == syncDelayBias.end()) ? 0.f : it->second;
	}
	void NoteSyncDelay(CCircuitDef::Id id, float residual);
	/*
	 * Owner 2026-11-03: artillery snipe ("artillery_snipe"). Listed long-range
	 * rocket artillery (Thanatos, Arbiter, Boreas, Negotiator, Ambassador) that
	 * comes near a known outranging pop-up artillery structure (Persecutor,
	 * Rattlesnake, Eviscerator; seen, radar or ghost) first shoots the listed
	 * non-light porc it can reach from outside every such structure's reach
	 * (seen ones until dead, ghost images "volleys" times), then closes to
	 * snipe_range_fraction of its own range and fires "volleys" at the
	 * structure, and "volleys" more if radar or LOS shows it still alive.
	 * Then the ordinary controller has the unit back. See ArtySnipeStep.
	 * "direct_threats" (Pulsar, Bulwark, Bastion) skip the prep porc step.
	 */
	struct SArtySnipeInfo {
		bool isEnabled = false;
		std::unordered_set<CCircuitDef::Id> defs;     // the artillery that snipes
		std::unordered_set<CCircuitDef::Id> threats;  // what it snipes
		std::unordered_map<CCircuitDef::Id, int> threatRank;  // position in "threats": earlier goes first
		// Owner 2026-11-03 01:36Z: Pulsar, Bulwark, Bastion. No prep porc: attacked
		// from snipe_range_fraction (seen: until dead, at most visible_max_volleys;
		// ghost: "volleys", then "volleys" more if seen alive).
		std::unordered_set<CCircuitDef::Id> directThreats;
		std::unordered_set<CCircuitDef::Id> porc;     // prep targets
		bool avoidOtherPorc = true;   // prep spots also outside other armed porc
		float threatMargin = 100.f;   // elmos past a structure's weapon range
		float triggerDistance = 700.f;
		float porcRadius = 1600.f;    // prep porc within this of the threat
		float prepFraction = 0.99f;
		float snipeFraction = 0.99f;
		int volleys = 3;
		// Owner 2026-11-04 05:45Z: blind volleys per unit at a ghost that is not a
		// heavy (threats + direct threats get `volleys`).
		int ghostVolleysOther = 1;
		int visibleMaxVolleys = 0;    // 0: seen porc until dead (owner 01:43Z)
		int confirmFrames = 3 * 30;
		int repeatFrames = 60 * 30;
		int stageFrames = 60 * 30;    // a stage/target with no volley this long is given up
		// Test 2026-11-03 (ghost Persecutor): units went in one by one and all 8
		// died. Units that must enter a threat's reach gather hold_margin outside
		// it and go in together, once every unit on that threat is there or
		// after group_wait_seconds.
		float holdMargin = 150.f;
		int groupWaitFrames = 240 * 30;
		// Test round 2: gatherers went in alone while others were still on prep.
		// Go in when every unit on the threat has gathered, or min_group have and
		// settled for group_settle_seconds; past group_wait_seconds without
		// min_group, give the threat up (repeat_seconds).
		int minGroup = 3;
		// Test rounds 3-7: 1200-range units (Thanatos, Arbiter) standing at 99%
		// inside a 1390-1400 reach died nearly every time. Units with less range
		// than this do the prep porc only and never close in on a threat whose
		// reach is beyond their snipe spot (0: everyone closes in).
		float closeMinRange = 1290.f;
		int groupSettleFrames = 10 * 30;
		// Owner 2026-11-03 20:53Z: double heavy = the aimed heavy's weapon-range
		// half-disc (facing the group's hold point) and another heavy's share
		// more than this fraction of the smaller one; then go in only with 3+.
		float doubleHeavyOverlap = 0.5f;
		// Owner 2026-11-03 21:58Z: at the double-heavy go-in, Boreas/Negotiator/
		// Ambassador within this of the hold point or a gathered member join.
		float recruitRadius = 500.f;
	};
	// Per unit, kept here so a task change (idle, re-task) keeps the sequence.
	struct SArtySnipeState {
		int stage = 0;          // 0 off, 1 prep porc, 2 snipe, 3 confirm wait, 4 confirm fire
		int threat = -1;        // enemy unit id
		bool direct = false;    // threat is a directThreats def
		int target = -1;        // current prep target
		bool targetGhost = false;
		int volleys = 0;
		int stageFrame = -1, targetFrame = -1;
		int lastVolley = -1, reload = -1, fireSeen = -2;
		int orderKey = -1, orderUntil = -1;
		int lastCall = -1;
		int nextScan = -1;      // stage 0: threat scans at most every 0.5 s per unit
		int recruitScan = -1;   // stage 2 gathering: recruitment scans at most every 0.5 s
		int lockId = -1;        // owner 2026-11-04 16:58Z: locked target (enemy id), -1 none
		int lockOrderUntil = -1;  // next re-issue of the lock's attack / step-in order
		int lockLastHold = -1;  // last frame the lock drove the unit (resume log after a pause)
		bool lockStepping = false;
		int lockSeen = -1;      // last frame the lock was evaluated (task Execute / route update)
		int missileTarget = -1, missileOrderUntil = -1;
		int dotId = -1;         // owner 2026-11-04 20:03Z: unidentified radar dot fired on, -1 none
		int dotOrderUntil = -1; // next re-issue of the attack on it
		int dotScan = -1;       // no dot found: next scan frame
		bool recruited = false; // joined by recruitment (does not recruit in turn)
		int hvUntil = -1;       // shooting a commander / heavy unit: volleys not counted
		int nextHvScan = -1;    // priority target scans at most every 0.5 s while none
		bool go = false;        // stage 2: left the gathering spot (or no need to gather)
		int goFrame = -1;       // stage 2: when it left the gathering spot
		int ghostAim = -1;      // default targeting: ghost being given its blind volleys
		int ghostShots = 0;
		int ghostNeed = 3;      // its volleys: `volleys` for a heavy, ghost_volleys_other otherwise
		bool ghostHeavy = true;
		// Owner 2026-11-03 21:04Z synced volley: a gathered group walks in with
		// fire held and all open fire in one frame (see ArtySnipeStep stage 2).
		bool syncWait = false;  // stage 2: walking in, waiting for the group's volley
		bool atSpot = false;    // stage 2: within 99% snipe range of the threat
		bool fireHeld = false;  // fire state set to hold by the snipe (restore on exit)
		float lastHp = -1.f;    // health percent last call (being hit releases the volley)
		int hitFrame = -1;
		int dhLoggedFor = -1;   // threat whose double-heavy share was last logged
		bool atHold = false;    // stage 2: waiting at the gathering spot
		int holdSince = -1;
		bool hasSnipeSpot = false;  // stage 2: a checked snipe spot (outside other threats, safe walk)
		springai::AIFloat3 snipeSpot;
		int spotFor = -1;            // stage 2: threat the snipe / hold spots were chosen for
		bool holding = false;        // stage 2: outranged (close_in_min_range), holding outside its reach
		int drifts = 0;         // prep: times the unit slid into a threat's reach on this target
		bool drifting = false;
		// Owner 2026-11-04 20:08Z: ghost volleys per dark period. ghostDone: enemy id ->
		// the dark period (CEnemyUnit::GetDarkSince) in which it got all its volleys;
		// ghostCount: enemy id -> (dark period, volleys fired at it in that period).
		// A re-sighting (radar or LOS) starts a new period: a fresh 3 (heavy) or 1.
		std::unordered_map<int, int> ghostDone;
		std::unordered_map<int, std::pair<int, int>> ghostCount;
		springai::AIFloat3 spot;
		std::unordered_map<int, int> skipUntil;  // enemy id -> frame (done prep targets, sniped threats)
	};
	const SArtySnipeInfo& GetArtySnipeInfo() const { return artySnipeInfo; }
	SArtySnipeState& GetArtySnipeState(int unitId, int frame);
	const std::unordered_map<int, SArtySnipeState>& GetArtySnipeStates() const { return artySnipeStates; }
	// Double-heavy shares per (aimed, other) heavy pair: value, frame computed.
	// Recomputed after ~10 s; pairs of dead heavies are dropped with the states.
	std::unordered_map<uint64_t, std::pair<float, int>>& GetArtySnipeOverlaps() { return artySnipeOverlaps; }
	// A def whose escort is rationed: a mobile radar or jammer.
	bool IsSensorUnit(const CCircuitDef* cdef) const;
	// Live sensors already escorting `task`.
	int CountSensors(const IFighterTask* task) const;
	// Room for one more sensor in `task`.
	bool NeedsSensor(const IFighterTask* task) const;
	// Guard priority: the metal cost of the squad leader, which is the
	// highest-tier unit the squad has. 0 for a squad with no leader.
	float GetSquadValue(const IFighterTask* task) const;

	/*
	 * Porcupine chain, by side. The defaults come from build_chain.json's
	 * "porcupine" block; these let AngelScript read that chain and replace it,
	 * so a role can order its own defences and react to mod options (Legion,
	 * the Extra Units Pack) without the ordering being frozen in JSON.
	 * Names, not defs, because that is what script works in.
	 */
	std::vector<std::string> GetPorcChain(const std::string& sideName, bool isWater) const;
	bool SetPorcChain(const std::string& sideName, bool isWater, const std::vector<std::string>& names);
	// Stocked EMP silos, an upper bound on how many shots can land together.
	int GetEmpSalvoSize() const;
private:
	virtual void DequeueTask(IUnitTask* task, bool done = false) override;

public:
	void MarkGuardUnit(CCircuitUnit* vip, CFGuardTask* task) {
		guardTasks[vip] = task;
	}

	void MakeDefence(const springai::AIFloat3& pos);
	void MakeDefence(int cluster);
	void MakeDefence(int cluster, const springai::AIFloat3& pos);
	void DefaultMakeDefence(int cluster, const springai::AIFloat3& pos);
	void MarkPorc(CCircuitUnit* unit, int defPointId);
	void UnmarkPorc(CCircuitUnit* unit);
	void AbortDefence(const CBDefenceTask* task, int defPointId);
	bool HasDefence(int cluster);
	void ProcessHubDefence(CBDefenceTask* task);
	springai::AIFloat3 GetScoutPosition(CCircuitUnit* unit);
	springai::AIFloat3 GroundObjective(CCircuitUnit* unit, const springai::AIFloat3& previous);
	void ClearScoutPosition(IUnitTask* task);
	// defend: a DefendTask leader; it follows the coverage lane only when
	// coverage.json defend_follows_lane says so (D-356), else the influence
	// and metal-cluster front positions below.
	void FillFrontPos(CCircuitUnit* unit, F3Vec& outPositions, bool defend = false);
	void FillAttackSafePos(CCircuitUnit* unit, F3Vec& outPositions);
	void FillStaticSafePos(CCircuitUnit* unit, F3Vec& outPositions);
	void FillSafePos(CCircuitUnit* unit, F3Vec& outPositions);
	CCircuitUnit* GetClosestLeader(const std::vector<IFighterTask::FightType>& types, const springai::AIFloat3& position);

	IFighterTask* GetGuardTask(CCircuitUnit* unit) const;

	const std::set<CCircuitUnit*>& GetRoleUnits(CCircuitDef::RoleT type) const {
		return roleInfos[type].units;
	}
	float GetRoleCost(CCircuitDef::RoleT type) const { return roleInfos[type].cost; }
	void AddResponse(CCircuitUnit* unit);
	void DelResponse(CCircuitUnit* unit);
	float GetArmyCost() const { return armyCost; }
    void SetAggressionDelta(float value);
    float GetAggressionDelta() const { return aggressionDelta; }
    void SetAutomaticAggression(float value);
    float GetAutomaticAggression() const { return automaticAggression; }
    float GetAggression() const { return automaticAggression + aggressionDelta; }
	float RoleProbability(const CCircuitDef* cdef) const;
	bool IsNeedBigGun(const CCircuitDef* cdef) const;
	springai::AIFloat3 GetBigGunPos(CCircuitDef* bigDef) const;
	void DiceBigGun();
	float ClampMobileCostRatio() const;
	void UpdateDefenceTasks();
	void UpdateSensorGuards();
	void UpdateCommanderSnipe();
	// Debug goal: takes the military non-spam units in reach into one
	// CDebugGoalTask while it is on, ends the task when it is off
	void UpdateDebugGoal();
	bool IsDebugGoalCandidate(CCircuitUnit* unit) const;
	/*
	 * Where this AI is currently fighting: the leader position of the strongest
	 * ATTACK squad, or the enemy centroid when we have no attack squad, or an
	 * invalid position when neither exists. Script has no other way to see the
	 * front - it can reach neither the fighter tasks nor CEnemyManager's groups -
	 * and the spam routes need it to run their lanes through the fight rather
	 * than straight at the enemy start. See doc/spam-routes.md.
	 */
	springai::AIFloat3 GetCombatFocusPos() const;
	float GetMinAttackers() const { return minAttackers; }
	float GetAttackWaitSeconds() const { return attackWaitSeconds; }
	float GetAttackScale() const { return attackScale; }
	void UpdateDefence();
	void MakeBaseDefence(const springai::AIFloat3& pos);

	void AddSensorDefs(const std::set<CCircuitDef*>& buildDefs);  // add available sensor defs
	void RemoveSensorDefs(const std::set<CCircuitDef*>& buildDefs);

	const SSideInfo& GetSideInfo() const;
	const std::vector<SSideInfo>& GetSideInfos() const { return sideInfos; }

	CCircuitDef* GetBigGunDef() const { return bigGunDef; }
	CCircuitDef* GetDefaultPorc() const { return GetSideInfo().defaultPorc; }
	CCircuitDef* GetLowSonar(const CCircuitUnit* builder = nullptr) const;

	void SetBaseDefRange(float range) { defence->SetBaseRange(range); }
	float GetBaseDefRange() const { return defence->GetBaseRange(); }
	float GetCommDefRadBegin() const { return defence->GetCommRadBegin(); }
	float GetCommDefRad(float baseDist) const { return defence->GetCommRad(baseDist); }
	unsigned int GetGuardTaskNum() const { return defence->GetGuardTaskNum(); }
	unsigned int GetGuardsNum() const { return defence->GetGuardsNum(); }
	int GetGuardFrame() const { return defence->GetGuardFrame(); }

	void AddPointOfInterest(CEnemyInfo* enemy) { PointOfInterest(enemy, +3, -1); }
	void DelPointOfInterest(CEnemyInfo* enemy) { PointOfInterest(enemy, -3, +1); }

	// TODO: Create CMilitaryManager::CTargetManager and move all FindTarget variations there.
	//       CMilitaryManager must be responsible for target selection.
	CEnemyInfo* FindBCombatTarget(CCircuitUnit* unit, const springai::AIFloat3& pos,
								  float powerMod, bool isTest);

	float GetRangeUnitCountCompensatorScale();
	IUnitTask* TryMakeRangedTask(CCircuitUnit* unit);
	std::shared_ptr<CRangedWorld> GetRangedWorld();
	bool HasRangedUnits() const;

private:
	std::shared_ptr<CRangedWorld> rangedWorld;
    float aggressionDelta=0.f, automaticAggression=0.f;
    IUnitTask* MakeTask(CCircuitUnit* unit) override;
    void UpdateExternalControl();
    std::string externalOwnerRule;
    std::unordered_set<int> externalOwnerDefinitions;
    std::set<int> externalOwnerCandidates;
    std::vector<int> externalOwnerSnapshot;
	virtual IUnitTask* DefaultMakeTask(CCircuitUnit* unit) override;

	void Watchdog();

	void AddArmyCost(CCircuitUnit* unit);
	void DelArmyCost(CCircuitUnit* unit);
	void PointOfInterest(CEnemyInfo* enemy, int start, int step);
	CDefenceData::SDefPoint* FindClosestDefPoint(const springai::AIFloat3& pos);
	CDefenceData::SDefPoint* FindClosestDefPoint(int cluster, const springai::AIFloat3& pos,
			std::function<bool (const CDefenceData::SDefPoint&)> predicate = nullptr);

	Handlers2 createdHandler;
	Handlers1 finishedHandler;
	Handlers1 idleHandler;
	EHandlers damagedHandler;
	EHandlers destroyedHandler;

	std::vector<std::set<IFighterTask*>> fightTasks;

	CDefenceData* defence;
	unsigned int defenceIdx;
	std::map<CCircuitUnit*, int> porcToPoint;  // unit: defPointId

	struct SScoutPoint {
		int spotNum;  // last used spot number in cluster
		int scouted;  // times this point was scouted
		int score;
		int enemyNum;
		IUnitTask* task;
	};
	std::vector<SScoutPoint> scoutPoints;  // list of clusters, index = custerId
	std::map<IUnitTask*, int> scoutTasks;  // task: clusterId
	bool isEnemyFound;

	struct SRoleInfo {
		float cost;
		float maxPerc;
		float factor;
		std::set<CCircuitUnit*> units;
		struct SVsInfo {
			CCircuitDef::RoleT role;
			float ratio;
			float importance;
		};
		std::vector<SVsInfo> vs;
	};
	std::vector<SRoleInfo> roleInfos;
	// Script hooks
	const SRoleInfo* GetRoleInfo(CCircuitDef::RoleT type) const { return &roleInfos[type]; }

	std::set<CCircuitUnit*> stockpilers;
	std::set<CCircuitUnit*> army;
	float armyCost;

	std::map<CCircuitUnit*, CFGuardTask*> guardTasks;

	struct SRaidQuota {
		float min;
		float avg;
	} raid;
	unsigned int maxScouts = 0;
	float minAttackers = 0.f;
	/*
	 * Attack-wave policy, script-set through quota.attackWait / quota.attackScale.
	 * attackScale > 0 switches a DEFEND squad's promotion bar from the map-wide
	 * second-strongest enemy group to the strongest group the squad can
	 * actually REACH, scaled - a naval squad no longer waits to outweigh a land
	 * army it will never meet. attackWaitSeconds > 0 promotes a squad that has
	 * waited that long at or above minAttackers. Both 0 = legacy behaviour.
	 */
	float attackWaitSeconds = 0.f;
	float attackScale = 0.f;
	struct SThreatQuota {
		float min;
		float len;
	} attackMod, defenceMod;

	struct SThreatRangeScaling {
		int enemyCountPerEnemyTeamToStartScaling = 0;
		int enemyCountPerEnemyTeamToEndScaling = 1;
		float endScaleValue = 1.f;
		float scale = 1.f;  // cache per frame
		int frame = -1;
	} threatRangeScaling;

	SPulseInfo pulseInfo;
	std::vector<strategic::ProbeCluster> probeClusters;
	int probeNextFrame = 0;
	struct SProbeOrder { springai::AIFloat3 site, aim; int expires; };
	std::vector<SProbeOrder> probeOrders;
	SEmpInfo empInfo;
	SBomberInfo bomberInfo;
	SStockInfo stockInfo;
	SNuclearInfo nuclearInfo;
	int overnukeScouts = 0;
	int overnukeRounds = 0;
	springai::AIFloat3 nuclearAim = springai::AIFloat3(-1.f, 0.f, -1.f);
	float nuclearAimRadius = 0.f;
	std::array<debug::Strike, debug::_WEAPONS_> debugStrikes;
	IUnitTask* debugGoalTask = nullptr;  // owned reference (AssignOwnedReference)
	int nuclearLaunches = 0;
	springai::AIFloat3 nuclearLaunchPos = springai::AIFloat3(-1.f, 0.f, -1.f);
	float nuclearLaunchRadius = 0.f;
	SSensorInfo sensorInfo;
	SCommSnipeInfo commSnipeInfo;
	std::unordered_map<int, std::pair<int, bool>> wreckCache;
	SArtyCommInfo artyCommInfo;
	SLauncherPrioInfo launcherPrioInfo;
	std::vector<SSyncOrder> syncOrders;
	int syncVolleySerial = 0;
	std::unordered_map<CCircuitDef::Id, float> syncDelayBias;
	void UpdateSyncOrders();
	SArtySnipeInfo artySnipeInfo;
	std::unordered_map<int, SArtySnipeState> artySnipeStates;
	std::unordered_map<uint64_t, std::pair<float, int>> artySnipeOverlaps;
	int artySnipePrune = 0;

	unsigned int preventCount = 0;
	float amountFactor = 0.f;
	// Script overrides read by DefaultMakeDefence (aiMilitaryMgr.porcMode / porcBudgetMod,
	// set per call by Military::Porc in data/script/src/manager/porc_policy.as):
	// mode 0 keeps the native front-line heuristic, 1 forces the preventive count,
	// 2 forces the full porcupine order; budgetMod scales the per-point income budget.
	int porcMode = 0;
	float porcBudgetMod = 1.f;
	// aiMilitaryMgr.porcAllyAA: when set, the porc pass also visits clusters
	// inside an ALLY's zone and builds only anti-air there. An AIR role's whole
	// value to its team is air denial, and its teammates' clusters are where
	// the enemy air actually goes. Ground defence in an ally's zone stays off:
	// that is the ally's own porc.
	int porcAllyAA = 0;
	CCircuitDef* bigGunDef;

	std::vector<SSideInfo> sideInfos;

	struct SSensorExt {
		float radius;
	};
	CAvailList<SSensorExt> radarDefs, sonarDefs;

	std::shared_ptr<IMainJob> defend;
	std::vector<std::pair<springai::AIFloat3, BuildVector>> buildDefence;  // pos: defences

	/*
	 * Drone AA (owner 2026-11-04): when enemy drones (customparams.drone = 1,
	 * e.g. a Legion Hive's) hit one of our structures, the nearest builders,
	 * commanders included, build up to `count` light AA towers next to it,
	 * outside known enemy gun porc reach (seen or ghost; mex safety list) and
	 * preferably outside the drone carrier's own reach. Event driven: work
	 * happens only on a drone hit, at most once per `interval` per AI.
	 * Config: behaviour root "drone_aa" {enabled, count, units, interval,
	 * pull_radius, cover_margin, carrier_margin, timeout}.
	 */
public:
	bool IsDroneAATask(const IUnitTask* task) const { return (task != nullptr) && (droneAATasks.count(task) > 0); }
	void DroneAATaskGone(const IUnitTask* task) { droneAATasks.erase(task); }
private:
	void ReadDroneAAConfig();
	void DroneAAStrike(CCircuitUnit* unit, CEnemyInfo* attacker);
	bool IsCarrierDef(CCircuitDef* cdef, float* reach);
	struct SDroneAA {
		bool enabled = true;
		int count = 2;
		std::vector<std::string> units;  // light AA per side, first buildable wins
		int interval = 2 * FRAMES_PER_SEC;
		float pullRadius = 1600.f;
		float coverMargin = 150.f;  // a tower stands within its AA range minus this of the hit structure
		float carrierMargin = 96.f;
		int timeout = 90 * FRAMES_PER_SEC;
	} droneAA;
	int droneAANext = 0;
	int droneAALogFrame = -1000;
	std::unordered_set<const IUnitTask*> droneAATasks;
	std::unordered_map<int, float> carrierReach;  // def id -> drone reach, < 0 when not a carrier
};

} // namespace circuit

#endif // SRC_CIRCUIT_MODULE_MILITARYMANAGER_H_
