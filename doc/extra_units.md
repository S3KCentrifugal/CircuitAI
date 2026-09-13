# BAR Extra Units Pack catalog

This document is a data-facing catalog of the **41 distinct UnitDefs made
player-buildable by BAR's `experimentalextraunits=true` option**. It is based
on BAR revision `1d267c20d1`. The categories and roles below describe BAR's
declared data only; they are not a statement of existing CircuitAI role
semantics.

## Scope, loading, and postprocessing

`experimentalextraunits` is BAR's **Extra Units Pack** and defaults to false.
BAR describes it as units which did not make the main roster but are balanced
for PvP. It is separate from `scavunitsforplayers`, the **Scavengers Units
Pack**, which BAR says is mostly silly and unbalanced for PvP.
`beyond-all-reason/Beyond-All-Reason:modoptions.lua:1117-1134`

The effective set must be derived from postprocessing rather than from folder
names:

1. `gamedata/unitdefs.lua` recursively enumerates `units/**/*.lua`. Enabling
   `experimentalextraunits` forces the **Legion** and **Scavenger** source
   trees to load (but not Raptors).
   `beyond-all-reason/Beyond-All-Reason:gamedata/unitdefs.lua:35-73`
2. `gamedata/alldefs_post.lua` calls
   `unitbasedefs/experimental_extra_units.lua` only when
   `experimentalextraunits` is true. That function appends the player build
   options cataloged below.
   `beyond-all-reason/Beyond-All-Reason:gamedata/alldefs_post.lua:462-465`
3. The manifest contains 45 builder references but 41 distinct UnitDefs:
   `armmeatball`, `armassimilator`, and `corves` each have land and underwater
   gantry producers, and `corfgate` is offered by both a Cortex and a Legion
   naval constructor.
   `beyond-all-reason/Beyond-All-Reason:unitbasedefs/experimental_extra_units.lua:54-65`
   `beyond-all-reason/Beyond-All-Reason:unitbasedefs/experimental_extra_units.lua:98-103`
   `beyond-all-reason/Beyond-All-Reason:unitbasedefs/experimental_extra_units.lua:137-146`
   `beyond-all-reason/Beyond-All-Reason:unitbasedefs/experimental_extra_units.lua:165-176`
4. A UnitDef stored under `units/Scavengers` is still an ordinary, un-suffixed
   UnitDef when exposed through this pack. BAR creates `*_scav` clones only
   for a Scavenger AI team, `ruins="enabled"`, zombies, or `forceallunits`;
   experimental extra units alone do not meet that clone-creation condition.
   `beyond-all-reason/Beyond-All-Reason:gamedata/unitdefs_post.lua:9-28`
   `beyond-all-reason/Beyond-All-Reason:gamedata/unitdefs_post.lua:210-229`
5. For generated clones, Scavenger postprocessing appends `SCAVENGER`, sets
   `customparams.isscavenger`, makes the unit uncapturable, and hides damage.
   This behavior must not be assumed for the 41 normal player UnitDefs below.
   `beyond-all-reason/Beyond-All-Reason:gamedata/scavengers/unitdef_post.lua:3-13`

### Important option boundary

The following are **not Extra Units Pack units**. They are appended only by
the independent `scavunitsforplayers=true` build-tree hook:

- `armapt3`, `armminivulc`
- `corapt3`, `corminibuzz`
- `legministarfall`

`beyond-all-reason/Beyond-All-Reason:gamedata/alldefs_post.lua:462-470`
`beyond-all-reason/Beyond-All-Reason:unitbasedefs/scavenger_units_for_players.lua:32-41`
`beyond-all-reason/Beyond-All-Reason:unitbasedefs/scavenger_units_for_players.lua:79-88`
`beyond-all-reason/Beyond-All-Reason:unitbasedefs/scavenger_units_for_players.lua:149-156`

Conversely, `armgatet3`, `corgatet3`, and `legrwall` **are** Extra Units Pack
units even though the first two, and `legrwall`, are sourced from the
Scavenger tree. `beyond-all-reason/Beyond-All-Reason:unitbasedefs/experimental_extra_units.lua:30-38`
`beyond-all-reason/Beyond-All-Reason:unitbasedefs/experimental_extra_units.lua:89-96`
`beyond-all-reason/Beyond-All-Reason:unitbasedefs/experimental_extra_units.lua:156-163`

#### Changed Scavenger-pack units

These five units were involved in the configuration audit but belong only to
`scavunitsforplayers`, so their behavior entries belong in
`behaviour_scav_units.json`, not this pack's profile fragment:

| Unit | Actual purpose | Correct CircuitAI treatment |
| --- | --- | --- |
| `armapt3` — Experimental Aircraft Plant | T3 static air factory producing the Armada experimental aircraft set. It has `unitgroup=buildert3` and `airfactory=true`. | Main `static` role plus friendly `support`, with a cap and modeled buildpower. |
| `corapt3` — Experimental Aircraft Plant | T3 static air factory producing the Cortex experimental aircraft set. It has `unitgroup=buildert3` and `airfactory=true`. | Main `static` role plus friendly `support`, with a cap and modeled buildpower. |
| `armminivulc` — Mini Ragnarok | T2 static rapid plasma artillery: 1,300 range, surface-only, no stockpile/manual-fire requirement. | Main `super` role mirrors the full `armvulc` and gives deliberate `CSuperTask` targeting; secondary `static` is enemy classification. |
| `corminibuzz` — Mini Calamity | T2 static rapid plasma artillery: 1,450 range, surface-only, no stockpile/manual-fire requirement. | Main `super` role mirrors the full `corbuzz`; secondary `static` is enemy classification. |
| `legministarfall` — Mini Starfall | T2 static high-trajectory saturation artillery: 63-shot burst, 1,400 range, seven-second reload, 20,000 energy per firing cycle, surface-only, and not stockpiled. | Main `super` role is required for deliberate long-range firing through `CSuperTask`; `static` alone would not provide strategic target selection. |

Sources:
`unitbasedefs/scavenger_units_for_players.lua:32-41,79-88,149-156`;
`units/Scavengers/Buildings/Factories/armapt3.lua:1-53`;
`units/Scavengers/Buildings/Factories/corapt3.lua:1-53`;
`units/Scavengers/Buildings/DefenseOffense/armminivulc.lua:1-135`;
`units/Scavengers/Buildings/DefenseOffense/corminibuzz.lua:1-134`;
`units/Scavengers/Buildings/DefenseOffense/legministarfall.lua:1-184`.

The same conditional profile also classifies the Scavenger pack's experimental
aircraft and gantry units. Important distinctions are:

- `armthundt4` and `armlichet4` are bombers; the latter is nuclear but neither
  uses a stockpiled weapon.
- `armfepocht4`, `corcrwt4`, and `corfblackhyt4` are slow flying
  battleships/fortresses with both surface and anti-air weapons, so they need
  friendly `air`, `anti_air`, and `heavy` roles in addition to their main
  assault role.
- `cordronecarryair` is an aerial support carrier whose stockpiled weapon
  creates drones; it cannot attack aircraft itself.
- `armsptkt4` is 1,000-range rocket artillery, while `armrattet4`,
  `corthermite`, and `legpede` are heavy assault units rather than
  superweapons or raiders.
- `legsrailt4` is a slow, 1,600-range stockpiled sniper. Its `super` route is
  deliberate, while `siege` describes its firing role more accurately than
  `melee`.
- `armvadert4` is the exceptional mobile nuclear rolling bomb for which the
  special `super`/`melee` treatment remains intentional.
- `armmmkrt3`, `cormmkrt3`, and `legadveconvt3` are huge T3 energy converters;
  `armafust3`, `corafust3`, and `legafust3` are catastrophic T3 fusion
  reactors. The profile delays all six until 1,800 seconds.

### Reading the catalog

- **Tier** is BAR's explicit `customparams.techlevel` where present. BAR
  postprocessing supplies `techlevel=1` when a source definition omits it.
  Therefore a manifest comment such as “T2” is not necessarily the effective
  customparam tier. `beyond-all-reason/Beyond-All-Reason:gamedata/alldefs_post.lua:268-274`
- **Material customparams** lists the fields useful for consuming the UnitDef:
  BAR `unitgroup`, explicit/effective tier, source subfolder or mobility
  signal, plus behaviorally material parameters such as shield radius,
  extractor value, attached builder turret, or restrictions.
- Target text is BAR's declared `onlytargetcategory`/`badtargetcategory`;
  “surface”, “VTOL”, and “NOTSUB” are not translated into any CircuitAI role
  vocabulary here.
- Except where expressly noted for the two nuclear submarines, no manual-fire
  or stockpile field was found in the UnitDefs in this catalog.

## Armada — 15 UnitDefs

The Extra Units manifest inserts these units from Armada sea constructors,
vehicle and aircraft factories, T2 land/sea constructors, T2 shipyard, and
both T3 gantries. `beyond-all-reason/Beyond-All-Reason:unitbasedefs/experimental_extra_units.lua:11-65`

| ID — display name | Builder(s) | Tier / domain / intended BAR role | Relevant weapons and restrictions | Material customparams |
|---|---|---|---|---|
| `armgplat` — Gun Platform | `armcs`, `armcsa` | Effective T1; static shallow-water defense; light plasma defense. | Cannon, 520 range, 0.5 reload; `NOTSUB`; bad `VTOL`. | `unitgroup=weapon`; `subfolder=ArmBuildings/SeaDefence`; Arm normal texture. `beyond-all-reason/Beyond-All-Reason:units/ArmBuildings/SeaDefence/armgplat.lua:1-34`, `79-113` |
| `armfrock` — Scumbag | `armcs`, `armcsa` | Effective T1; floating/shallow-water AA battery. | Pop-up rapid-fire MissileLauncher, 840 range; only `VTOL`; bad `NOTAIR LIGHTAIRSCOUT`. | `unitgroup=aa`; `subfolder=ArmBuildings/SeaDefence`; Arm normal texture. `beyond-all-reason/Beyond-All-Reason:units/ArmBuildings/SeaDefence/armfrock.lua:1-35`, `73-128` |
| `armzapper` — Zapper | `armvp` | Effective T1; fast ground scout and EMP vehicle. | EMP BeamLaser, 220 range; paralyzer for 7 seconds; only `EMPABLE`; 90-degree forward arc. | `unitgroup=weapon`; `subfolder=ArmVehicles`; `basename`, `firingceg`, `kickback`, and `lumamult` are present. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Vehicles/armzapper.lua:1-47`, `100-150` |
| `armfify` — Firefly | `armap` | Effective T1; stealth aerial repair/resurrect/reclaim builder. | No combat weapon definition; can repair, restore, and resurrect. | `unitgroup=builder`; `subfolder=ArmAircraft`; Arm normal texture. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Air/armfify.lua:1-45` |
| `armshockwave` — Shockwave | `armaca`, `armack`, `armacv` | T2; static defensive metal extractor with EMP turret. | Medium EMP Cannon, 500 range; `NOTSUB`; bad `VTOL`. | `unitgroup=metal`; `techlevel=2`; `metal_extractor=4`; `subfolder=ArmBuildings/LandDefenceOffence`. `beyond-all-reason/Beyond-All-Reason:units/ArmBuildings/LandDefenceOffence/armshockwave.lua:1-53`, `118-166` |
| `armwint2` — Advanced Wind Turbine | `armaca`, `armack`, `armacv` | T2; wind-dependent energy structure. | No weapon. | `unitgroup=energy`; `techlevel=2`; `subfolder=ArmBuildings/LandEconomy`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Buildings/Economy/armwint2.lua:1-42` |
| `armnanotct2` — Advanced Construction Turret | `armaca`, `armack`, `armacv` | **Effective T1** construction assistant: source omits `techlevel`, despite the manifest's T2 comment. | No weapon; 500 build distance; builder/NANO behavior. | `unitgroup=builder`; `movementclass=NANO`; `subfolder=ArmBuildings/LandUtil`; source has no `techlevel`. `beyond-all-reason/Beyond-All-Reason:units/ArmBuildings/LandUtil/armnanotct2.lua:1-50` |
| `armlwall` — Dragon's Fury | `armaca`, `armack`, `armacv` | T2; static pop-up wall defense with continuous lightning. | LightningCannon, 315 range; surface-only. | `unitgroup=weapon`; `techlevel=2`; `subfolder=ArmBuildings/LandDefenceOffence`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Buildings/DefenseOffense/armlwall.lua:1-48`, `113-207` |
| `armgatet3` — Asylum | `armaca`, `armack`, `armacv` | T3; static shield utility, not a conventional attacking defense. | `canattack=false`, `noautofire=true`; sole `REPULSOR` Shield, 710 range/radius, `NOTSUB`. | `unitgroup=util`; `techlevel=3`; `shield_power=24700`; `shield_radius=710`; `shield_color_mult=25`; Arm LandUtil subfolder. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Buildings/Utility/armgatet3.lua:1-47`, `102-149` |
| `armfgate` — Aurora | `armacsub` | T2; floating naval shield utility. | Non-attacking `SEA_REPULSOR` Shield; `NOTSUB`. | `unitgroup=util`; `techlevel=2`; `minwaterdepth=16`; `subfolder=ArmBuildings/SeaUtil`. `beyond-all-reason/Beyond-All-Reason:units/ArmBuildings/SeaUtil/armfgate.lua:1-50`, `104-147` |
| `armnanotc2plat` — Advanced Construction Turret | `armacsub` | **Effective T1** floating construction platform: no source `techlevel`. | No weapon; builder/NANO behavior. | `unitgroup=builder`; `floater=true`; `minwaterdepth=12`; `movementclass=NANO`; `subfolder=ArmBuildings/SeaUtil`. `beyond-all-reason/Beyond-All-Reason:units/ArmBuildings/SeaUtil/armnanotc2plat.lua:1-52` |
| `armexcalibur` — Excalibur | `armasy` | T2; coastal assault naval unit. Its display calls it a submarine, while BAR movement metadata is `BOAT3`. | Surface-only BeamLaser, 600 range; bad `UNDERWATER`. | `unitgroup=sub`; `techlevel=2`; `movementclass=BOAT3`; `subfolder=ArmShips/T2`. `beyond-all-reason/Beyond-All-Reason:units/ArmShips/T2/armexcalibur.lua:1-40`, `109-154` |
| `armseadragon` — Seadragon | `armasy` | T2; strategic nuclear submarine. | `canmanualfire=true`; targetable stockpiled nuclear ICBM, `stockpiletime=140`, limit 10; also a torpedo. Strategic weapon is `NOTSUB`; torpedo is bad against `HOVER NOTSHIP`. | `unitgroup=nuke`; `techlevel=2`; `movementclass=UBOAT4`; `minwaterdepth=20`; `subfolder=ArmShips/T2`. `beyond-all-reason/Beyond-All-Reason:units/ArmShips/T2/armseadragon.lua:1-46`, `114-256` |
| `armmeatball` — Meatball | `armshltx`, `armshltxuw` | T3; EPICBOT amphibious assault mech. | Surface LRPC plasma Cannon, 800 range, bad `GROUNDSCOUT`; VTOL-only guided MissileLauncher, 600 range. | `unitgroup=weapon`; `techlevel=3`; `movementclass=EPICBOT`; `subfolder=ArmGantry`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Bots/armmeatball.lua:1-39`, `98-215` |
| `armassimilator` — Assimilator | `armshltx`, `armshltxuw` | T3; EPICBOT amphibious battle mech. | Rapid-fire plasma LaserCannon, 800 range; `NOTSUB`; bad `VTOL GROUNDSCOUT`. | `unitgroup=weapon`; `techlevel=3`; `movementclass=EPICBOT`; `subfolder=ArmGantry`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Bots/armassimilator.lua:1-40`, `94-184` |

## Cortex — 19 UnitDefs

The manifest inserts these units through Cortex T1 sea constructors, T2 land
and sea constructors, the advanced bot/vehicle factories and shipyard, and
both T3 gantries. `beyond-all-reason/Beyond-All-Reason:unitbasedefs/experimental_extra_units.lua:75-146`

| ID — display name | Builder(s) | Tier / domain / intended BAR role | Relevant weapons and restrictions | Material customparams |
|---|---|---|---|---|
| `corgplat` — Gun Platform | `corcs`, `corcsa` | Effective T1; static shallow-water light plasma defense. | Cannon, 520 range, 0.5 reload; `NOTSUB`; bad `VTOL`. | `unitgroup=weapon`; `subfolder=CorBuildings/SeaDefence`; Cor normal texture. `beyond-all-reason/Beyond-All-Reason:units/CorBuildings/SeaDefence/corgplat.lua:1-34`, `79-113` |
| `corfrock` — Janitor | `corcs`, `corcsa` | Effective T1; floating AA missile battery. | Rapid MissileLauncher, 840 range, 0.4 reload; only `VTOL`; bad `NOTAIR LIGHTAIRSCOUT`. | `unitgroup=aa`; `subfolder=CorBuildings/SeaDefence`. `beyond-all-reason/Beyond-All-Reason:units/CorBuildings/SeaDefence/corfrock.lua:1-35`, `73-124` |
| `corwint2` — Advanced Wind Turbine | `coraca`, `corack`, `coracv` | T2; wind-dependent energy structure. | No weapon. | `unitgroup=energy`; `techlevel=2`; `subfolder=CorBuildings/LandEconomy`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Buildings/Economy/corwint2.lua:1-42` |
| `cornanotct2` — Advanced Construction Turret | `coraca`, `corack`, `coracv` | **Effective T1** construction assistant: no source `techlevel`. | No weapon; builder/NANO behavior. | `unitgroup=builder`; `movementclass=NANO`; `subfolder=CorBuildings/LandUtil`. `beyond-all-reason/Beyond-All-Reason:units/CorBuildings/LandUtil/cornanotct2.lua:1-50` |
| `cormwall` — Dragon's Rage | `coraca`, `corack`, `coracv` | T2; static pop-up multiple-rocket defense. | Surface-only CatapultRockets, 675 range, 15 reload. | `unitgroup=weapon`; `techlevel=2`; `subfolder=CorBuildings/LandDefenceOffence`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Buildings/DefenseOffense/cormwall.lua:1-47`, `110-212` |
| `corgatet3` — Sanctuary | `coraca`, `corack`, `coracv` | T3; static shield utility, not conventional attacking defense. | `canattack=false`, `noautofire=true`; sole Shield, 825 range/radius, `NOTSUB`. | `unitgroup=util`; `techlevel=3`; `shield_power=24700`; `shield_radius=825`; `shield_color_mult=25`; Cor LandUtil subfolder. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Buildings/Utility/corgatet3.lua:1-47`, `102-149` |
| `corfgate` — Atoll | `coracsub`; also `leganavyconsub` | T2; floating naval shield utility. It is a Cortex-named/source UnitDef despite its intentional Legion builder edge. | Non-attacking `SEA_REPULSOR` Shield; `NOTSUB`. | `unitgroup=util`; `techlevel=2`; `minwaterdepth=16`; `subfolder=CorBuildings/SeaUtil`. `beyond-all-reason/Beyond-All-Reason:units/CorBuildings/SeaUtil/corfgate.lua:1-50`, `104-147` |
| `cornanotc2plat` — Advanced Construction Turret | `coracsub` | **Effective T1** floating construction platform: no source `techlevel`. | No weapon; builder/NANO behavior. | `unitgroup=builder`; `floater=true`; `minwaterdepth=12`; `movementclass=NANO`; `subfolder=CorBuildings/SeaUtil`. `beyond-all-reason/Beyond-All-Reason:units/CorBuildings/SeaUtil/cornanotc2plat.lua:1-52` |
| `cordeadeye` — Deadeye | `coralab` | T2; heavy blaster bot. | Burst-3 HeavyBlaster LaserCannon, 850 range; surface-only. | `unitgroup=weapon`; `techlevel=2`; `movementclass=HBOT4`; `subfolder=CorBots/t2`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Bots/cordeadeye.lua:1-40`, `109-155` |
| `corvac` — Printer | `coravp` | T2; armored mobile field engineer. | No intrinsic weapon definition; has its own `cormex`, `corsolar`, `corrad`, and `corfort` buildoptions. | `unitgroup=buildert2`; `techlevel=2`; `attached_con_turret=corvacct`; `attached_con_turret_noselect=true`; `subfolder=CorVehicles/T2`. `beyond-all-reason/Beyond-All-Reason:units/CorVehicles/T2/corvac.lua:1-56` |
| `corphantom` — Phantom | `coravp` | T2; amphibious stealth scout/utility vehicle. | No weapon definition. | `unitgroup=util`; `techlevel=2`; `movementclass=ATANK3`; `subfolder=CorVehicles/T2`. `beyond-all-reason/Beyond-All-Reason:units/CorVehicles/T2/corphantom.lua:1-52` |
| `corsiegebreaker` — Siegebreaker | `coravp` | T2; heavy long-range vehicle weapon. | Dreadshot overcharge BeamLaser, 910 range; surface-only; bad `VTOL GROUNDSCOUT`. | `unitgroup=weapon`; `techlevel=2`; `movementclass=HTANK4`; `subfolder=CorVehicles/T2`. `beyond-all-reason/Beyond-All-Reason:units/CorVehicles/T2/corsiegebreaker.lua:1-54`, `127-224` |
| `corforge` — Forge | `coravp` | T2; mobile combat engineer. | Builder with buildoptions and a surface-only Flamethrower, 410 range. | `unitgroup=buildert2`; `techlevel=2`; `movementclass=TANK3`; `subfolder=CorVehicles/T2`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Vehicles/corforge.lua:1-55`, `114-155` |
| `cortorch` — Torch | `coravp` | Effective T1; fast flame tank. | Surface/`NOTSUB` flame weapon (declared as MissileLauncher), 280 range; bad `VTOL`. | `unitgroup=weapon`; `subfolder=CorVehicles`; source has no `techlevel`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Vehicles/cortorch.lua:1-46`, `103-166` |
| `coresuppt3` — Adjudicator | `corasy` | T3; heavy heatray assault battleship. | Two heavy heatray BeamLasers, 900 range; `NOTSUB`. | `unitgroup=weapon`; `techlevel=3`; `floater=true`; `movementclass=BOAT9`; `subfolder=CorShips`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Ships/coresuppt3.lua:1-38`, `90-143` |
| `coronager` — Onager | `corasy` | T2; coastal assault submarine. | Surface-only StarburstLauncher, 600 range, 9 reload. | `unitgroup=sub`; `techlevel=2`; `movementclass=UBOAT4`; `subfolder=CorShips/T2`. `beyond-all-reason/Beyond-All-Reason:units/CorShips/T2/coronager.lua:1-39`, `108-162` |
| `cordesolator` — Desolator | `corasy` | T2; strategic nuclear submarine. | `canmanualfire=true`; targetable stockpiled ICBM, `stockpiletime=210`, limit 10; also a torpedo. Strategic launch is `NOTSUB`. | `unitgroup=nuke`; `techlevel=2`; `movementclass=UBOAT4`; `subfolder=CorShips/T2`. `beyond-all-reason/Beyond-All-Reason:units/CorShips/T2/cordesolator.lua:1-47`, `115-257` |
| `corprince` — Black Prince | `corasy` | T2; heavy long-range bombardment ship. | Heavy plasma cannon at 3,200 range; three naval plasma cannon mounts at 2,300; two VTOL/T4AIR-only AA flak mounts. | `unitgroup=weapon`; `techlevel=2`; `floater=true`; `movementclass=BOAT9`; `subfolder=CorShips/T2`. `beyond-all-reason/Beyond-All-Reason:units/CorShips/T2/corprince.lua:1-44`, `106-253` |
| `corves` — Vesuvius | `corgant`, `corgantuw` | T3; super-heavy amphibious assault tank. | Surface plasma cannon (1,000); two `NOTSUB` Banisher missiles (800); surface flame (400); these non-AA mounts are bad against VTOL. | `unitgroup=weapon`; `techlevel=3`; `movementclass=EPICVEH`; `subfolder=CorVehicles`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Vehicles/corves.lua:1-46`, `108-262` |

## Legion — 7 UnitDefs

`experimentalextraunits` itself enables the Legion source tree, so these
builder edges do not additionally require `experimentallegionfaction=true`.
The exception in faction ownership is the already-cataloged Cortex `corfgate`,
which is also offered from `leganavyconsub`.
`beyond-all-reason/Beyond-All-Reason:gamedata/unitdefs.lua:56-61`
`beyond-all-reason/Beyond-All-Reason:unitbasedefs/experimental_extra_units.lua:156-176`

| ID — display name | Builder(s) | Tier / domain / intended BAR role | Relevant weapons and restrictions | Material customparams |
|---|---|---|---|---|
| `legwint2` — Advanced Wind Turbine | `legaca`, `legack`, `legacv` | T2; wind-dependent energy structure. | No weapon. | `unitgroup=energy`; `techlevel=2`; metadata subfolder is `CorBuildings/LandEconomy` despite Legion identity. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Buildings/Economy/legwint2.lua:1-42` |
| `legnanotct2` — Advanced Construction Turret | `legaca`, `legack`, `legacv` | T2; static NANO construction assistant. | No weapon; 500 build distance; builder/NANO behavior. | `unitgroup=builder`; `techlevel=2`; `movementclass=NANO`; metadata subfolder is `CorBuildings/LandUtil`. `beyond-all-reason/Beyond-All-Reason:units/Legion/Utilities/legnanotct2.lua:1-51` |
| `legrwall` — Dragon's Constitution | `legaca`, `legack`, `legacv` | T2; stationary stealthy railgun defense wall; specifically not a pop-up turret. | Compact Railgun LaserCannon, 950 range; `NOTSUB`; bad `VTOL`; weapon customparams set `overpenetrate=true`. | `unitgroup=weapon`; `techlevel=2`; `neutral_when_closed=true`; `decoyfor=armfort`; `reaimtime=4`; Legion normal texture. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Buildings/DefenseOffense/legrwall.lua:1-48`, `111-160` |
| `leggatet3` — Elysium | `legaca`, `legack`, `legacv` | T3; static shield utility, not conventional attacking defense. | `canattack=false`, `noautofire=true`; Shield-only `REPULSOR`, 710 range/radius, `NOTSUB`. | `unitgroup=util`; `techlevel=3`; `shield_power=49400`; `shield_radius=710`; `shield_color_mult=25`; `subfolder=Legion/Defenses`. `beyond-all-reason/Beyond-All-Reason:units/Legion/Defenses/leggatet3.lua:1-49`, `104-151` |
| `legnanotct2plat` — Advanced Construction Turret | `leganavyconsub` | T2; floating NANO construction platform. | No weapon; 500 build distance; builder/NANO behavior. | `unitgroup=builder`; `techlevel=2`; `isnanoturret=true`; `floater=true`; `minwaterdepth=12`; metadata subfolder is `CorBuildings/LandUtil`. `beyond-all-reason/Beyond-All-Reason:units/Legion/Utilities/legnanotct2plat.lua:1-52` |
| `legbunk` — Pilum | `leggant` | T3; mobile assault mech. | Surface-only Snub-Nose Railgun, 650 range; also a 150-range hard-plasma mining tool and a targeting system; railgun/aim mounts exclude ground scouts. | `unitgroup=weapon`; `techlevel=3`; `movementclass=HBOT4`; `subfolder=leggantry`. `beyond-all-reason/Beyond-All-Reason:units/Legion/T3/legbunk.lua:1-43`, `104-238` |
| `legapollyon` — Apollyon | `leggant` | T3; heavy rapid-fire support weapon platform. | Six anti-surface rotary mounts (750/450); two VTOL-only microflak mounts (800); two surface-only CatapultRocket mounts (1,200). No manual-fire/stockpile field. | `unitgroup=weapon`; `techlevel=3`; `paralyzemultiplier=0.5`; source omits `subfolder`, so BAR postprocessing supplies `subfolder=none`. `beyond-all-reason/Beyond-All-Reason:units/Scavengers/Vehicles/legapollyon.lua:1-45`, `104-344`; `beyond-all-reason/Beyond-All-Reason:gamedata/alldefs_post.lua:268-274` |

## Concise CircuitAI configuration guidance

1. Gate this catalog on the exact mod option
   `experimentalextraunits=true`; do not enable it based solely on whether a
   UnitDef was loaded from `units/Scavengers` or `units/Legion`.
2. Keep `scavunitsforplayers` as a separate option gate. In particular, do
   not add `armapt3`, `corapt3`, `armminivulc`, `corminibuzz`, or
   `legministarfall` to an extra-pack-only configuration.
3. Use the postprocessed UnitDef fields when available. In particular,
   consume the effective `customparams.techlevel` rather than assuming that a
   `*t2*` identifier or source comment implies tier 2.
4. Preserve builder edges exactly as above, including the duplicate
   land/underwater gantry edges and the Legion-to-`corfgate` naval edge. Do
   not create separate faction copies merely because the same UnitDef has
   more than one producer.
5. Treat the two explicitly manual-fire, stockpiling nuclear submarines as
   exceptional UnitDefs; do not generalize their control requirements to
   ordinary artillery, shield, or missile units.
6. Configure `armgatet3` and `corgatet3` as `static` shield utilities with
   zero modeled combat threat. Configure `legrwall` as an ordinary `static`
   anti-surface defense, not as a `super` weapon.
7. For the exact meaning of CircuitAI `role`, `attribute`, `threat`, `power`,
   timing, and fire-control properties, see
   [`units.md`](units.md#how-behavior-properties-affect-play).
