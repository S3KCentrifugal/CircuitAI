#ifndef CIRCUIT_RANGED_POLICY_H
#define CIRCUIT_RANGED_POLICY_H

#include <string>
#include <unordered_set>

namespace circuit {
namespace ranged_policy_defaults {
inline constexpr float POKE_DISABLED = 0.f;
inline constexpr float POKE_PRESS_RANGE = .90f;
inline constexpr float POKE_OUT_RANGE = 1.05f;
inline constexpr float POKE_METAL_RATIO = 2.f;
inline constexpr float POKE_HEALTH = .8f;
inline constexpr float POKE_PRESS_HEALTH = .5f;
inline constexpr float POKE_PAUSE_SECONDS = 5.f;
// Owner 2026-11-02: ghost porc. Default reach for individual hulls, and the
// longest one a profile may set (LRPCs, tactical launchers and super weapons
// beyond it are not porc a hull can wait out).
inline constexpr float GHOST_PORC_RANGE = 2000.f;
inline constexpr float GHOST_PORC_MAX_RANGE = 3000.f;
}
// JSON owns policy. The RANGED attribute is the only admission switch; these
// values do not change legacy siege, squad, naval, air or specialist owners.
struct RangedPolicy {
    enum class Mode { PRECISION, SKIRMISH, BOMBARDMENT, CARRIER };
    // Empty family preserves every existing controller. Formation roles are
    // policy, not unit names: same-family homogeneous cohorts may pair.
    enum class FormationPosition { NONE, FRONT, REAR };
    std::string formationFamily;
    FormationPosition formationPosition = FormationPosition::NONE;
    float formationSeparationMinimum = 64.f, formationSeparationMaximum = 96.f;
    float withdrawalLeadSeconds = 0.f;
    Mode mode = Mode::SKIRMISH;
    float rangeFraction = .95f;
    int ghostVolleys = 0; // 0 disables idle ghost ground fire; per-unit, per dark period
    int ghostVolleysHeavy = 0; // owner 2026-11-13: volleys at a heavy ghost (artillery_snipe threats/direct_threats); 0 = ghostVolleys
    float spacing = 96.f;
    float safetyMargin = 48.f;
    float hysteresis = 48.f;
    float reactionSeconds = 1.f;
    float targetHysteresis = 1.2f;
    // Order throttles (owner 2026-10-19): least seconds between non-urgent
    // MOVE replacements, and least seconds a live priority target is kept.
    float moveMinSeconds = 0.f;   // 0: off
    float targetMinSeconds = 0.f; // 0: off
    // Owner 2026-10-24: a hard floor between any two MOVE re-issues, urgent
    // and escape moves included, and the most queued waypoints one re-path
    // may send (the rest of the route is left to the engine). 0: off.
    float moveFloorSeconds = 0.f;
    int maxWaypoints = 0;
    // A pick scoring this many times the held target's score breaks the
    // target_min_seconds hold at once. Above target_hysteresis (1.2), so only
    // a clearly better target switches during the hold.
    float targetSwitchRatio = 1.5f;
    float sensorOffset = 160.f;
    float cloakReserve = 3.f;
    float repairedTargetPenalty = .25f;
    float splashWeight = .5f;
    bool cloakOnReload = false;
    bool allowMobile = true;
    bool allowStatic = true;
    bool preferHeavy = false;
    float commanderPriority = 1.f; // multiplier after shot geometry/admission, never a second owner
    float structuresOverSlow = 0.f; // owner 2026-11-15: >0 = structures before units moving <= min(25% top speed, this) elmos/s
    bool preferScreen = true;
    bool allowRadar = true;
    bool advanceUnknownRadar = true;
    // Owner 2026-10-27: "low_trajectory". A Cannon without highTrajectory in
    // its def gets the engine default 2 (player-switchable), which CWeaponDef
    // counts as high, so Trajectory() skipped the terrain check. The AI never
    // toggles a mobile unit's trajectory, so such a gun fires low: opt-in hulls
    // get the low-arc terrain check. Off by default (the other ranged cannons
    // keep their current targeting until tested).
    bool lowTrajectory = false;
    bool holdFireline = false; // opt-in forward-fire policy: hold under pressure, never kite
    bool stageWhenBlocked = false; // opt-in: deploy outside coverage if no firing band fits
    bool coordinated = false; // local same-type firing cohorts, not legacy siege
    float cohortSize = 12.f;
    float cohortRadius = 900.f;
    float regroupSeconds = 8.f;
    float rushRatio = 1.75f;
    float catchSeconds = 6.f;
    // Zero preserves the original coordinated controller for profiles which
    // do not explicitly opt into outcome-based engagement.
    float engagementSeconds = 0.f;
    bool sustainedRush = false;
    float sustainedRushRatio = 2.f, sustainedRushRadius = 900.f;
    float sustainedRushMinFront = 8.f, sustainedRushRemaining = .25f;
    float sustainedRushCooldown = 20.f, sustainedRushRange = .80f;
    float advantageEnter = 1.4f, advantageExit = 1.1f;
    float lossFraction = .35f, staticLossFraction = 0.f;
    bool supportAllies = false; // opt-in frontline screening; never waives hard hazards
    float supportLossFraction = 0.f; // explicit HP budget when joining an allied mobile engagement
    float intentGain = 0.f; // required relative endpoint improvement; zero preserves old micro
    // D-294: per-shooter target exclusion, resolved once from JSON
    // "avoid_categories" (BAR category names, e.g. "GROUNDSCOUT"). Zero = none.
    // Excluded contacts are never targeted, approached or escaped from; they
    // remain hazards in CRangedWorld::Safe/DangerSign. O(1) AND per candidate.
    int avoidCategory = 0;
    // D-294: 0 = off. Penalise a mobile target whose drift during projectile
    // flight exceeds evasionLimit*(splash+target radius); see ranged::Evasive.
    float evasionLimit = 0.f;
    // Owner 2026-10-17: 0 = off. Coordinated firing cadence against the
    // closest mobile enemy of about our range. With a ready weapon a hull steps
    // in to pokeIn*range (pokeInDominant*range once the local metal ratio
    // reaches pokeRatio), and out to pokeOut*range while reloading. Shorter-
    // ranged enemies keep the kite; longer-ranged ones, static coverage,
    // commanders and reclaimers keep the full escape. Sustained rushes, rush
    // fallback, regrouping and the rear line are unchanged.
    float pokeIn = ranged_policy_defaults::POKE_DISABLED;
    float pokeInDominant = ranged_policy_defaults::POKE_PRESS_RANGE;
    float pokeOut = ranged_policy_defaults::POKE_OUT_RANGE;
    float pokeRatio = ranged_policy_defaults::POKE_METAL_RATIO;
    // Owner 2026-10-19 regimes (see cohort::PokeRegime): EVEN and OUTMATCHED
    // hulls step in only above pokeHealth of max HP; a PRESS hull holds the
    // deep band through its reload down to pokePressHealth; OUTMATCHED steps
    // in again only pokePauseSeconds after its last shot.
    float pokeHealth = ranged_policy_defaults::POKE_HEALTH;
    float pokePressHealth = ranged_policy_defaults::POKE_PRESS_HEALTH;
    float pokePauseSeconds = ranged_policy_defaults::POKE_PAUSE_SECONDS;
    // Owner 2026-10-19: 0 = off. Armed static defences of this tech level or
    // lower (BAR customparams.techlevel, 1 when absent) are not coverage this
    // hull avoids: it picks firing sites, paths and stays inside their reach
    // and favours them as targets. Their death blast still counts.
    // Individual (non-coordinated) controller only.
    float pressStatic = 0.f;
    // D-295: 0 = off. With no legal shot, seek the nearest LOS contact within
    // this radius that an allied screen is already fighting (CRangedWorld::Engaged).
    // Individual (non-coordinated) controller only.
    float assistRadius = 0.f;
    // Owner 2026-10-19: fire at will except at spam. Engine auto-fire is
    // allowed while no spam contact (mobile, not a commander, metal cost at
    // most spamMaxCost) is in weapon reach and a non-spam target is; otherwise
    // fire is held (our priority target still fires). Spam is never our
    // priority target.
    // Individual controller: as above (0 = no spam class). Coordinated cohort:
    // fire at will always, spamMaxCost unused (owner 2026-10-19, Thug/Mace).
    bool fireAtWill = false;
    // Owner 2026-11-21 (Swirly Rock Daedalus idle): with fireAtWill, a hull that
    // has had nothing but spam in reach (no target, no objective move, no
    // threat) for this many seconds opens fire, so engine autofire takes the
    // spam instead of standing on HOLD forever. 0 = off (spam always held).
    float spamFireIdleSeconds = 0.f;
    // Owner 2026-11-21 (Daedalus arena, radar mode): a never-identified ground
    // radar dot that is not moving may be porc that outranges us. March legs
    // (and their samples) never come within this distance of one. 0 = off.
    float unknownStaticReach = 0.f;
    // Owner 2026-11-23 (Salt Reef: Fatboys under a 200-elmo plateau): a target
    // the engine never fires at (cliff lip; our trajectory model says clear)
    // after shun_refusals stalls, or an objective with no firing site and no
    // path towards it, is left alone for shun_seconds and the next one taken.
    // 0 = off.
    float shunSeconds = 45.f;
    int shunRefusals = 2;
    // Owner 2026-11-23: spam of this hull's roster is no hazard (no escape, no blocked site/move); see CRangedWorld::SetSpamFilter.
    bool spamNoHazard = false;
    // Owner 2026-11-23 (Daedalus/Myrmidon froze inside a Bertha's reach): with porc_hazards set, only
    // structures of these defs are static hazards (live and ghost); long-range artillery, tactical
    // launchers, nukes and other statics are not. Mobile hazards are unchanged.
    bool porcHazardList = false;
    std::unordered_set<int> porcHazardDefs;
    // Owner 2026-11-23: heavy porc group assault. Hulls blocked by one of these (live or ghost) wait for
    // assault_min_group of the same kind of hull (or assault_max_wait seconds), then all treat it as no
    // hazard, close to range_fraction of their range and fire on it (attack ground if a ghost).
    std::unordered_set<int> heavyPorcDefs;
    // Owner 2026-11-23: top_targets: these come before any other target or objective (ghosts: ghost fire).
    std::unordered_set<int> topTargetDefs;
    int assaultMinGroup = 3;
    float assaultMaxWait = 45.f;
    // Owner 2026-11-24: ghost_heavy. Ghost images of these defs also take ghost_volleys_heavy
    // (Lance: 3 per Sentinel/Warden/Cacophony ghost), besides the profile-wide heavy list.
    std::unordered_set<int> ghostHeavyDefs;
    // Owner 2026-11-24 (T1 artillery): screen_poke. A live porc_hazards structure that outranges our firing
    // ring, with an allied combat unit between us and it, is no hazard while our main gun is loaded: the hull
    // steps in for a shot and, once reloading, the normal escape takes it back out. Individual controller only.
    bool screenPoke = false;
    // Owner 2026-10-28: permanent fire at will. The controller opens fire when
    // it takes the unit and never sets hold fire (no poke, cohort-hold or spam
    // gating); priority targets still steer the guns. Overrides fireAtWill.
    bool alwaysFireAtWill = false;
    // Cent (smrt-test 4a6ef45b): fire_in_range keeps the engine's automatic response
    // without changing coordinated movement; commander_focus gives a peer-spotted
    // commander strict shot priority.
    bool fireInRange = false;
    bool commanderFocus = false;
    // Owner 2026-11-03: Thugs pulled back well behind their base by the danger
    // kite. Inside home_hold_radius of our base, or on the far side of it from
    // the threat, a hull never withdraws from danger: it holds and fights.
    // 0 = off. commander_no_retreat: an enemy commander is not a reason to
    // withdraw (it still is inside its death blast).
    float homeHoldRadius = 0.f;
    bool commanderNoRetreat = false;
    // Owner 2026-11-07 (Sector 318C): Thugs/Aggravators sat inside a heavy laser
    // tower's 620 reach while their own sight is 380, so the tower was a ghost
    // or never seen and the cohort had no danger. cohort_ghost_porc: a
    // coordinated cohort treats ghost porc (ghost_porc_range) as danger and as
    // uncertain coverage that blocks commitment, like the individual
    // controller. blind_hit_seconds > 0: a hit from an attacker we cannot see
    // leaves a blind hazard at the shot's estimated origin (UnitDamaged dir x
    // the weapon's range) for that long; hulls of this AI inside its reach back
    // out and the cohort does not commit through it. 0 = off.
    bool cohortGhostPorc = false;
    float blindHitSeconds = 0.f;
    float spamMaxCost = 0.f;
    // Owner 2026-10-27: named spam ("spam_units", def ids resolved at load),
    // in addition to spamMaxCost. Same rules: mobile, never a commander.
    std::unordered_set<int> spamDefs;
    // Owner 2026-11-06 (Astraeus): an unidentified ground radar dot counts as
    // spam too: never our priority target, and fire is held while one is in
    // reach (engine autofire took dots, which were mostly fast T1 swarms).
    bool spamRadarDots = false;
    // Owner 2026-11-06 21:23Z: only a never-identified dot MOVING beyond radar
    // jiggle is spam; a still dot stays a (blind) target. Elmos per second.
    float spamDotSpeed = 15.f;
    // Owner 2026-11-18 (Astraeus): 0 = off. A mobile contact (not a commander)
    // below this tech level (BAR customparams.techlevel, 1 when absent) is no
    // hazard: the hull never backs off it, and it does not block firing sites
    // or paths, so the hull pushes forward to max range on its targets. T2/T3
    // mobiles, structures, porc (live and ghost) and blind hits keep the kite.
    // kite_ignore_fast_dots: a never-identified ground radar dot moving faster
    // than spam_dot_speed is no hazard either. Individual controller only.
    float kiteMinTech = 0.f;
    bool kiteIgnoreFastDots = false;
    // Owner 2026-11-23 (Centurion): -1 = off. An identified enemy commander's
    // hazard is its own ground weapon range + this margin, not its 350 death
    // blast + safety_margin, so a hull that outranges a commander's laser by
    // a little (Centurion 325 vs 300) can fire on it from range_fraction, backs
    // off while it closes (closing-speed escape) and re-sites onto it while it
    // retreats. Its blast no longer blocks the shot (own or friendly splash).
    // Individual controller only.
    float commanderReachMargin = -1.f;
    bool HasSpam() const { return spamMaxCost>0.f || !spamDefs.empty() || spamRadarDots; }
    // Owner 2026-11-02: "stay out of weapon range of ghost images that are
    // porc and wait for other units to give LOS". 0 = off. An armed structure
    // known only as a ghost (out of radar and LOS, spot not seen empty) with a
    // ground range up to this many elmos is coverage this hull does not path,
    // stage or fire from inside of, and escapes like observed coverage; it is
    // never a target, so the hull waits until someone's radar or LOS shows it.
    // press_static still applies (a pressed ghost counts only its death blast).
    // Individual (non-coordinated) controller only: cohorts ignore it.
    float ghostPorcRange = ranged_policy_defaults::GHOST_PORC_RANGE;
    // Owner 2026-11-04 (Barrage vs Sentry): -1 = off (safety_margin everywhere).
    // Otherwise the margin added to STATIC coverage (live porc and ghost porc)
    // in site, path, staging, danger and escape tests of the individual
    // controller. Mobile contacts keep safety_margin and the closing-speed
    // escape. With static_margin set, a hull that drifts into static reach
    // steps out just past it (16 elmos) instead of backing off 160+.
    float staticMargin = -1.f;
    // Owner 2026-11-12 (Barrage vs Beamer/Twin Guard, both 490): static porc
    // and ghost porc reach is the bare weapon range, without the structure's
    // radius (range + radius was 490 + ~40, past a 535 Barrage's 0.99 ring).
    // Individual controller only; mobiles keep range + radius + safety_margin.
    bool staticExactReach = false;
    // 0 = off. A firing-site move no longer than this, whose straight line is
    // walkable and outside static coverage, is one direct MOVE instead of a
    // grid path (grid nodes sit up to 45 elmos off the line and fail the
    // coverage test when the site is a few elmos outside porc reach).
    float directMoveRadius = 0.f;
    float assistMargin = 150.f; // ally counts as engaged within its ground range + margin + contact radius
    bool assistScreen = true;   // assist firing sites require an allied screen toward the target
};
}
#endif
