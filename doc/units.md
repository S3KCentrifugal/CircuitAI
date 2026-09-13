# Beyond All Reason base UnitDefs

## Scope, source, and interpretation

This is a compact catalog of the **659 effective, non-Scavenger UnitDefs**
identified in BAR commit `1d267c20d1`: **215 Armada**, **213 Cortex**, and
**231 Legion**.  A record has the form:

```text
internal-id — Display Name — intended gameplay purpose
```

The section heading supplies faction, broad category, tier, and domain.  A
constructor, engineer, plant, lab, shipyard, or gantry is a builder/factory;
its authoritative production list is the `buildoptions` table in its source
UnitDef.  All other records are player-facing unless explicitly labelled
**helper**, **spawned**, **variant**, **decoy**, **legacy**, or **internal**.

### Authoritative BAR loading methodology

* `gamedata/unitdefs.lua:45-105` recursively loads `units/**/*.lua`, merging
  each returned `{ internalName = UnitDef }` table.  `:124-156` removes broken
  UnitDefs and build options that point at an unloaded UnitDef.
* Armada and Cortex are normally loaded.  Legion is gated by
  `experimentallegionfaction`; it is additionally enabled by ruins,
  Scavengers, zombies, extra units, player Scav units, or `forceallunits`.
  See `gamedata/unitdefs.lua:47-79` and
  `modoptions.lua:1853-1861`.
* Scavenger/Raptor definitions and generated `<name>_scav` copies are omitted.
  The latter are created only when Scavengers are enabled:
  `gamedata/unitdefs_post.lua:210-229`.
* Extra Units Pack definitions are omitted.  The option defaults to false and
  is described as units that did not make the main roster
  (`modoptions.lua:1118-1124`); its gated build-option additions are in
  `unitbasedefs/experimental_extra_units.lua:11-177`.
* English display names and the concise role text below come from
  `language/en/units.json` (`names` begins at `:15`; `descriptions` is the
  parallel table).  Each unit's raw implementation is
  `units/<section>/<internal-id>.lua`, normally beginning at lines 1-2.

**Tier convention.** `T2`, `Advanced`, and `Experimental/Gantry/T3` headings
are practical tier labels.  Consumers needing exact data must read
`customparams.techlevel`, because it can differ from a source folder.

---

## Armada — 215

### Root: commanders and support

Source: `units/arm*.lua:1-2`.

```text
armassistdrone — Assist Drone — helper; portable buildpower
armassistdrone_land — Assist Vehicle — helper; portable buildpower
armcom — Armada Commander — commander, builder, economy and combat anchor
armcomcon — armcomcon — commander construction variant; unlocalized
armcomnew — armcomnew — commander variant; unlocalized
```

`armcom` is a cloaking mobile builder with radar/sonar, resource production
and storage, normal and underwater lasers, and manual-fire Disintegrator.
Its build tree is `units/armcom.lua:61-88`; commander custom parameters are
at `:89-101`; weapon target restrictions are at `:171-307`.

### T1 land/air/mobile units

#### Aircraft — `units/ArmAircraft`
```text
armatlas — Stork — light air transport
armca — Construction Aircraft — T1 aircraft constructor
armdrone — Attack Drone — helper; drone-carrier spawned drone
armdroneold — Attack Drone — helper; legacy drone-carrier spawned drone
armfig — Falcon — fighter
armhvytrans — Osprey — heavy transport
armkam — Banshee — light gunship
armpeep — Blink — air scout
armthund — Stormbringer — bomber
```

#### Bots — `units/ArmBots`
```text
armck — Construction Bot — T1 bot constructor
armflea — Tick — fast scout bot
armham — Mace — light plasma bot
armjeth — Crossbow — amphibious anti-air bot
armpw — Pawn — fast infantry bot
armrectr — Lazarus — stealth resurrection, repair, and reclaim bot
armrock — Rocketeer — rocket bot; static-defence counter
armwar — Centurion — anti-swarm bot
```

#### Vehicles — `units/ArmVehicles`
```text
armart — Shellshocker — light artillery vehicle
armbeaver — Beaver — amphibious construction vehicle
armcv — Construction Vehicle — T1 vehicle constructor
armfav — Rover — light scout vehicle
armflash — Blitz — fast assault tank
armjanus — Janus — twin medium rocket launcher
armmlv — Groundhog — stealth minelayer/minesweeper
armpincer — Pincer — light amphibious tank
armsam — Whistler — missile truck
armstump — Stout — medium assault tank
```

#### Hovercraft — `units/ArmHovercraft`
```text
armah — Sweeper — anti-air hovercraft
armanac — Crocodile — hovertank
armch — Construction Hovercraft — T1 hover constructor
armmh — Possum — hovercraft rocket launcher
armsh — Seeker — fast attack hovercraft
```

#### Seaplanes — `units/ArmSeaplanes`
```text
armcsa — Construction Seaplane — T1 seaplane constructor
armhaca — Experimental Construction Aircraft — experimental combat engineer
armsaber — Sabre — seaplane gunship
armsb — Tsunami — seaplane bomber
armseap — Puffin — torpedo gunship
armsehak — Horizon — advanced radar/sonar plane
armsfig — Cyclone — seaplane swarmer
armsfig2 — Cyclone — heavy-AOE seaplane fighter
```

#### Ships — `units/ArmShips`
```text
armcs — Construction Ship — T1 naval constructor
armdecade — Dolphin — fast assault corvette
armpship — Ellysaw — assault frigate
armpt — Skater — stealth patrol boat; light AA and sonar
armrecl — Grim Reaper — resurrection submarine
armroy — Corsair — destroyer
armsub — Eel — submarine
armtorps — Torpedo Ship — torpedo combat ship
```

### T2 and experimental mobile units

#### Aircraft — `units/ArmAircraft/T2`
```text
armaca — Advanced Construction Aircraft — T2 aircraft constructor
armawac — Oracle — radar/sonar plane
armblade — Hornet — rapid assault gunship
armbrawl — Roughneck — gunship
armdfly — Abductor — stealthy armed heavy transport
armhawk — Highwind — stealth fighter
armlance — Cormorant — torpedo bomber
armliche — Liche — atomic bomber
armpnix — Blizzard — strategic bomber
armstil — Stiletto — EMP bomber
```

#### Bots — `units/ArmBots/T2`
```text
armaak — Archangel — advanced amphibious anti-air bot
armack — Advanced Construction Bot — T2 bot constructor
armamph — Platypus — amphibious bot
armaser — Smuggler — radar-jammer bot
armdecom — Commander — decoy commander
armfark — Butler — fast assist/repair bot
armfast — Sprinter — fast raider bot
armfboy — Fatboy — heavy plasma bot
armfido — Hound — mortar/skirmish bot
armhack — Butler — experimental combat engineer
armmark — Compass — radar bot
armmav — Gunslinger — experience-scaling skirmisher
armscab — Umbrella — mobile all-terrain anti-nuke
armsnipe — Sharpshooter — sniper bot
armspid — Webber — all-terrain EMP/reclaim spider
armsptk — Recluse — all-terrain rocket spider
armspy — Ghost — radar-invisible spy bot
armvader — Tumbleweed — amphibious rolling bomb
armzeus — Welder — assault bot
```

#### Vehicles — `units/ArmVehicles/T2`
```text
armacv — Advanced Construction Vehicle — T2 vehicle constructor
armbull — Bull — heavy assault tank
armconsul — Consul — combat engineer
armcroc — Turtle — heavy amphibious tank
armgremlin — Gremlin — stealth tank
armhacv — Consul — experimental combat engineer
armjam — Umbra — radar-jammer vehicle
armlatnk — Jaguar — lightning tank
armmanni — Starlight — mobile tachyon weapon
armmart — Mauser — mobile artillery
armmerl — Ambassador — stealth rocket launcher; static-defence counter
armseer — Prophet — radar vehicle
armyork — Shredder — anti-air flak vehicle
```

#### Ships — `units/ArmShips/T2`
```text
armaas — Dragonslayer — anti-air ship
armacsub — Advanced Construction Sub — T2 naval constructor
armantiship — Haven — mobile anti-nuke, generator, radar, and sonar
armbats — Dreadnought — battleship
armcarry — Haven — legacy/unreachable aircraft carrier with anti-nuke
armcrus — Paladin — cruiser
armdronecarry — Nexus — scavunitsforplayers-only drone carrier
armepoch — Epoch — flagship
armhacs — Voyager — experimental combat engineer
armlship — Maelstrom — fast raider/skirmisher
armmls — Voyager — naval engineer
armmship — Longbow — missile cruiser
armserp — Serpent — long-range battle submarine
armsjam — Bermuda — radar-jammer ship
armsubk — Barracuda — fast assault submarine
armtdrone — Depth Charge Drone — helper; spawned depth-charge drone
armtrident — Trident — scavunitsforplayers-only depth-charge drone carrier
```

#### Gantry — `units/ArmGantry`
```text
armbanth — Titan — assault mech
armlun — Lunkhead — heavy hovertank
armmar — Marauder — amphibious assault mech
armprowl — armprowl — unlocalized gantry unit
armraz — Razorback — battle mech
armthor — Thor — experimental terminator tank
armvang — Vanguard — all-terrain heavy plasma cannon
```

### Land structures

#### Defence and strategic weapons — `units/ArmBuildings/LandDefenceOffence`
```text
armamb — Rattlesnake — cloakable pop-up plasma artillery
armamd — Citadel — anti-nuke system
armanni — Pulsar — tachyon accelerator
armbeamer — Beamer — beam-laser turret
armbrtha — Basilica — long-range plasma cannon
armcir — Chainsaw — medium-range anti-air missile battery
armclaw — Dragon's Claw — pop-up lightning turret
armemp — Paralyzer — stockpiled EMP missile launcher
armferret — Ferret — pop-up anti-air missile battery
armflak — Arbalest — anti-air flak gun
armguard — Gauntlet — area-control plasma artillery
armhlt — Overwatch — area-control laser tower
armjuno — Juno — anti-radar, jammer, minefield, and scout weapon
armllt — Sentry — light laser tower
armmercury — Mercury — long-range anti-air tower
armpb — Pit Bull — pop-up Gauss cannon
armrl — Nettle — light anti-air tower
armsilo — Armageddon — nuclear ICBM launcher
armvulc — Ragnarok — rapid-fire long-range plasma cannon
```

#### Economy — `units/ArmBuildings/LandEconomy`
```text
armadvsol — Advanced Solar Collector — 80 energy
armafus — Advanced Fusion Reactor — 3000 energy; hazardous
armageo — Advanced Geothermal Powerplant — 1250 energy; hazardous
armamex — Twilight — stealthy cloakable metal extractor
armckfus — Cloakable Fusion Reactor — 750 energy
armestor — Energy Storage — 6000 energy storage
armfus — Fusion Reactor — 750 energy
armgeo — Geothermal Powerplant — 300 energy
armgmm — Prude — safe geothermal; 750 energy
armmakr — Energy Converter — 70 energy to 1 metal/sec
armmex — Metal Extractor — metalspot extraction
armmmkr — Advanced Energy Converter — 600 energy to 10.3 metal/sec
armmoho — Advanced Metal Extractor — advanced extractor/storage
armmstor — Metal Storage — 3000 metal storage
armsolar — Solar Collector — 20 energy
armwin — Wind Turbine — wind-dependent energy
```

#### Factories — `units/ArmBuildings/LandFactories`
```text
armaap — Advanced Aircraft Plant — T2 aircraft factory
armalab — Advanced Bot Lab — T2 bot factory
armap — Aircraft Plant — T1 aircraft factory
armavp — Advanced Vehicle Plant — T2 vehicle factory
armhaap — Experimental Aircraft Plant — experimental aircraft factory
armhaapuw — Advanced Aircraft Plant — underwater-placement advanced factory
armhalab — Experimental Bot Lab — experimental bot factory
armhavp — Experimental Vehicle Plant — experimental vehicle factory
armhp — Hovercraft Platform — hovercraft factory
armlab — Bot Lab — T1 bot factory
armshltx — Experimental Gantry — experimental-unit factory
armvp — Vehicle Plant — T1 vehicle factory
```

#### Utility — `units/ArmBuildings/LandUtil`
```text
armarad — Advanced Radar Tower — long-range radar
armdf — Decoy Fusion Reactor — deception; produces no energy
armdrag — Dragon's Teeth — fortification
armeyes — Beholder — perimeter camera
armfort — Fortification Wall — advanced fortification
armgate — Keeper — plasma shield
armjamt — Sneaky Pete — jammer tower
armmine1 — Light Mine — mine
armmine2 — Medium Mine — mine
armmine3 — Heavy Mine — mine
armnanotc — Construction Turret — large-radius assist/repair
armrad — Radar Tower — early warning
armsd — Tracer — intrusion countermeasure
armtarg — Pinpointer — enhanced radar targeting
armveil — Veil — long-range jammer
```

### Naval structures

#### Defence — `units/ArmBuildings/SeaDefence`
```text
armanavaldefturret — Liquifier — hybrid anti-ship tachyon/Gauss cannon
armatl — Moray — advanced torpedo launcher
armdl — Anemone — coastal torpedo launcher
armfflak — Naval Arbalest — naval anti-air flak
armfhlt — Manta — floating heavy laser tower
armfrt — Naval Nettle — floating anti-air tower
armkraken — Gorgon — floating rapid-fire plasma tower
armnavaldefturret — Cauteriser — dual anti-ship Gauss cannon
armtl — Harpoon — offshore torpedo launcher
```

#### Economy — `units/ArmBuildings/SeaEconomy`
```text
armfmkr — Naval Energy Converter — 70 energy to 1 metal/sec
armtide — Tidal Generator — map-dependent energy
armuwadves — Hardened Energy Storage — 40000 energy storage
armuwadvms — Hardened Metal Storage — 10000 metal storage
armuwageo — Advanced Geothermal — 1250 energy; hazardous
armuwes — Naval Energy Storage — 6000 energy storage
armuwfus — Naval Fusion Reactor — 1200 energy
armuwgeo — Offshore Geothermal — 300 energy
armuwmme — Naval Advanced Metal Extractor
armuwmmm — Naval Advanced Energy Converter
armuwms — Naval Metal Storage — 3000 metal storage
```

#### Factories — `units/ArmBuildings/SeaFactories`
```text
armamsub — Amphibious Complex — amphibious/underwater factory
armasy — Advanced Shipyard — T2 shipyard
armfhp — Naval Hovercraft Platform — hovercraft factory
armhasy — Experimental Shipyard — experimental shipyard
armplat — Seaplane Platform — seaplane factory
armshltxuw — Experimental Gantry — large amphibious-unit factory
armsy — Shipyard — T1 shipyard
```

#### Utility — `units/ArmBuildings/SeaUtil`
```text
armason — Advanced Sonar Station — extended sonar
armfatf — Naval Pinpointer — enhanced radar targeting
armfdrag — Shark's Teeth — naval fortification
armfmine3 — Heavy Mine — naval mine
armfrad — Naval Radar/Sonar Tower — early warning
armnanotcplat — Naval Construction Turret — assist/repair
armsonar — Sonar Station — water-unit detection
```

---

## Cortex — 213

### Root: commander and support
```text
corassistdrone — Assist Drone — helper; portable buildpower
corassistdrone_land — Assist Vehicle — helper; portable buildpower
corcom — Cortex Commander — commander, builder, economy and combat anchor
corcomcon — corcomcon — commander construction variant; unlocalized
```

### T1 and T2 mobile roster

#### Aircraft — `units/CorAircraft` and `units/CorAircraft/T2`
```text
corbw — Shuriken — light paralyzer drone
corca — Construction Aircraft — T1 aircraft constructor
cordrone — Attack Drone — helper; carrier spawned
cordroneold — Attack Drone — helper; legacy carrier spawned
corfink — Finch — scout
corhvytrans — Hephaestus — heavy transport
corshad — Whirlwind — bomber
corvalk — Hercules — light transport
corveng — Valiant — fighter

coraca — Advanced Construction Aircraft — T2 aircraft constructor
corape — Wasp — gunship
corawac — Condor — radar/sonar plane
corcrwh — Dragon — flying fortress
corhurc — Hailstorm — heavy strategic bomber
corseah — Skyhook — heavy assault transport
cortitan — Angler — torpedo bomber
corvamp — Nighthawk — stealth fighter
```

#### Bots — `units/CorBots` and `units/CorBots/T2`
```text
corak — Grunt — fast infantry bot
corck — Construction Bot — T1 bot constructor
corcrash — Trasher — amphibious anti-air bot
cornecro — Graverobber — stealth resurrection/reclaim/repair bot
corstorm — Aggravator — rocket bot; static-defence counter
corthud — Thug — light plasma bot

coraak — Manticore — heavy amphibious anti-air bot
corack — Advanced Construction Bot — T2 bot constructor
coramph — Duck — amphibious bot
corcan — Sumo — armored assault bot
cordecom — Commander — decoy commander
corfast — Twitcher — combat engineer
corhack — Twitcher — experimental combat engineer
corhrk — Arbiter — heavy rocket bot
cormando — Commando — stealth paratrooper
cormort — Sheldon — mobile mortar
corpyro — Fiend — fast assault bot
corroach — Bedbug — amphibious crawling bomb
corsktl — Skuttle — advanced amphibious crawling bomb
corspec — Deceiver — radar jammer
corspy — Spectre — radar-invisible spy
corsumo — Mammoth — heavily armored assault bot
cortermite — Termite — heavy all-terrain assault spider
corvoyr — Augur — radar bot
```

#### Vehicles — `units/CorVehicles` and `units/CorVehicles/T2`
```text
corcv — Construction Vehicle — T1 vehicle constructor
corfav — Rascal — light scout vehicle
corgarp — Garpike — light amphibious tank
corgator — Incisor — light tank
corlevlr — Pounder — anti-swarm tank
cormist — Lasher — missile truck
cormlv — Trapper — stealth minelayer/minesweeper
cormuskrat — Muskrat — amphibious construction vehicle
corraid — Brute — medium assault tank
corwolv — Wolverine — light mobile artillery

coracv — Advanced Construction Vehicle — T2 vehicle constructor
corban — Banisher — heavy missile tank
coreter — Obscurer — radar-jammer vehicle
corgol — Tzar — very heavy assault tank
corhacv — Printer — experimental combat engineer
cormabm — Saviour — mobile anti-nuke
cormart — Quaker — mobile artillery
corparrow — Poison Arrow — very heavy amphibious tank
corprinter — Printer — armored field engineer
correap — Tiger — heavy assault tank
corsala — Salamander — medium heat-ray amphibious tank
corseal — Alligator — legacy/unreachable medium amphibious tank
corsent — Fury — anti-air flak vehicle
cortrem — Tremor — heavy artillery vehicle
corvacct — corvacct — unlocalized variant
corvrad — Omen — radar vehicle
corvroc — Negotiator — stealth rocket launcher; static-defence counter
```

#### Hovercraft, seaplanes, ships, and gantry
```text
#### Hovercraft — `units/CorHovercraft`
corah — Birdeater — anti-air hovercraft
corch — Construction Hovercraft — T1 hover constructor
corhal — Halberd — assault hovertank
cormh — Mangonel — hovercraft rocket launcher
corsh — Goon — fast attack hovercraft
corsnap — Cayman — hovertank

#### Seaplanes — `units/CorSeaplanes`
corcsa — Construction Seaplane — T1 seaplane constructor
corcut — Cutlass — seaplane gunship
corhaca — Experimental Construction Aircraft — experimental combat engineer
corhunt — Watcher — advanced radar/sonar plane
corsb — Dam Buster — seaplane bomber
corseap — Monsoon — torpedo gunship
corsfig — Bat — seaplane swarmer
corsfig2 — Bat — heavy-AOE seaplane fighter

#### T1 ships — `units/CorShips`
corcs — Construction Ship — T1 naval constructor
coresupp — Supporter — light gunboat
corpship — Riptide — assault frigate
corpt — Herring — missile corvette; light AA and sonar
correcl — Death Cavalry — resurrection submarine
corroy — Oppressor — destroyer
corsub — Orca — submarine

#### T2 ships — `units/CorShips/T2`
coracsub — Advanced Construction Sub — T2 naval constructor
corantiship — Oasis — mobile anti-nuke, generator, radar, and sonar
corarch — Arrow Storm — anti-air ship
corbats — Despot — battleship
corblackhy — Black Hydra — flagship
corcarry — Oasis — legacy/unreachable aircraft carrier with anti-nuke
corcrus — Buccaneer — cruiser
cordronecarry — Disperser — scavunitsforplayers-only drone carrier
corfship — Brimstone — anti-swarm ship
corhacs — Pathfinder — experimental combat engineer
cormls — Pathfinder — naval engineer
cormship — Messenger — cruise-missile ship
corsentinel — Sentinel — scavunitsforplayers-only depth-charge drone carrier
corshark — Predator — fast assault submarine
corsjam — Phantasm — radar jammer ship
corssub — Kraken — long-range battle submarine
cortdrone — Depth Charge Drone — helper; spawned drone

#### Gantry units — `units/CorGantry`
corcat — Catapult — heavy rocket bot
cordemon — Demon — flamethrower mech
corjugg — Behemoth — barely-mobile heavy turret
corkarg — Karganeth — all-terrain assault mech
corkorg — Juggernaut — experimental assault bot
corshiva — Shiva — amphibious siege mech
corsok — Cataphract — heavy laser hovertank
```

### Cortex land structures

#### Defence and strategic weapons — `units/CorBuildings/LandDefenceOffence`
```text
corbhmth — Cerberus — geothermal plasma battery
corbuzz — Calamity — rapid-fire long-range plasma cannon
cordoom — Bulwark — energy weapon
corerad — Eradicator — medium-range anti-air missiles
corexp — Exploiter — armed metal extractor
corflak — Birdshot — anti-air flak
corfmd — Prevailer — anti-nuke system
corhllt — Twin Guard — anti-swarm double guard
corhlt — Warden — area-control laser
corint — Basilisk — long-range plasma cannon
corjuno — Juno — anti-radar/jammer/mine/scout weapon
corllt — Guard — light laser
cormadsam — SAM — hardened anti-air missile battery
cormaw — Dragon's Maw — pop-up flamethrower
cormexp — Advanced Exploiter — armed advanced metal extractor
corpun — Agitator — area-control plasma artillery
corrl — Thistle — light anti-air
corscreamer — Screamer — long-range anti-air
corsilo — Apocalypse — nuclear ICBM launcher
cortoast — Persecutor — pop-up plasma artillery
cortron — Catalyst — tactical missile launcher
corvipe — Scorpion — pop-up sabot battery
```

#### Economy, factories, and utility
```text
#### Land economy — `units/CorBuildings/LandEconomy`
coradvsol — Advanced Solar Collector — 80 energy
corafus — Advanced Fusion Reactor — 3000 energy; hazardous
corageo — Advanced Geothermal — 1250 energy; hazardous
corestor — Energy Storage — 6000 energy storage
corfus — Fusion Reactor — 850 energy
corgeo — Geothermal — 300 energy
cormakr — Energy Converter — 70 energy to 1 metal/sec
cormex — Metal Extractor
cormmkr — Advanced Energy Converter — 600 energy to 10.3 metal/sec
cormoho — Advanced Metal Extractor
cormstor — Metal Storage — 3000 metal storage
corsolar — Solar Collector — 20 energy
corwin — Wind Turbine — wind-dependent energy

#### Land factories — `units/CorBuildings/LandFactories`
coraap — Advanced Aircraft Plant — T2 aircraft factory
coralab — Advanced Bot Lab — T2 bot factory
corap — Aircraft Plant — T1 aircraft factory
coravp — Advanced Vehicle Plant — T2 vehicle factory
corgant — Experimental Gantry — experimental-unit factory
corhaap — Experimental Aircraft Plant
corhaapuw — Advanced Aircraft Plant — underwater-placement advanced factory
corhalab — Experimental Bot Lab
corhavp — Experimental Vehicle Plant
corhp — Hovercraft Platform
corlab — Bot Lab — T1 bot factory
corvp — Vehicle Plant — T1 vehicle factory

#### Land utility — `units/CorBuildings/LandUtil`
corarad — Advanced Radar Tower
cordrag — Dragon's Teeth — fortification
coreyes — Beholder — perimeter camera
corfort — Fortification Wall
corgate — Overseer — plasma shield
corjamt — Castro — short-range jammer
cormine1 — Light Mine
cormine2 — Medium Mine
cormine3 — Heavy Mine
cormine4 — Medium Mine
cornanotc — Construction Turret
corrad — Radar Tower
corsd — Nemesis — intrusion countermeasure
corshroud — Shroud — long-range jammer
cortarg — Pinpointer — enhanced radar targeting
```

### Cortex naval structures
```text
#### Naval defence — `units/CorBuildings/SeaDefence`
coranavaldefturret — Orthrus — hybrid anti-ship blaster/plasma cannon
coratl — Lamprey — advanced torpedo launcher
cordl — Jellyfish — coastal torpedo launcher
corenaa — Naval Birdshot — naval anti-air flak
corfdoom — Devastator — floating multi-weapon platform
corfhlt — Coral — floating heavy laser tower
corfrt — Slingshot — floating anti-air tower
cornavaldefturret — Cyclops — heavy anti-ship plasma blast cannon
cortl — Urchin — offshore torpedo launcher

#### Naval economy — `units/CorBuildings/SeaEconomy`
corfmkr — Naval Energy Converter
cortide — Tidal Generator
coruwadves — Hardened Energy Storage — 40000 energy storage
coruwadvms — Hardened Metal Storage — 10000 metal storage
coruwageo — Advanced Underwater Geothermal
coruwes — Naval Energy Storage — 6000 energy storage
coruwfus — Naval Fusion Reactor — 1220 energy
coruwgeo — Offshore Geothermal
coruwmme — Naval Advanced Metal Extractor
coruwmmm — Naval Advanced Energy Converter
coruwms — Naval Metal Storage — 3000 metal storage

#### Naval factories — `units/CorBuildings/SeaFactories`
coramsub — Amphibious Complex
corasy — Advanced Shipyard — T2 shipyard
corfhp — Naval Hovercraft Platform
corgantuw — Experimental Gantry — large amphibious-unit factory
corhasy — Experimental Shipyard
corplat — Seaplane Platform
corsy — Shipyard — T1 shipyard

#### Naval utility — `units/CorBuildings/SeaUtil`
corason — Advanced Sonar Station
corfatf — Naval Pinpointer
corfdrag — Shark's Teeth
corfmine3 — Heavy Mine — naval mine
corfrad — Naval Radar/Sonar Tower
cornanotcplat — Naval Construction Turret
corsonar — Sonar Station
```

---

## Legion — 231, option-gated experimental faction

Legion is not in the normal default faction set: enable
`experimentallegionfaction`.  It may also be implicitly loaded by the game
modes/options documented in the methodology above.  `leghaap` and `leghaca`
are classified here by their internal Legion identity despite residing in
Cortex-named source folders.

### Commander and air
```text
#### Root definitions — `units/Legion`
legcom — Legion Commander — commander, builder, economy and combat anchor
legassistdrone — Assist Drone — helper; portable buildpower
legassistdrone_land — Assist Vehicle — helper; portable buildpower

#### T1 aircraft — `units/Legion/Air`
legatrans — Hippotes — heavy transport
legcib — Blindfold — manual-fire Juno bomb; clears mines/scouts/radar/jammers
legdrone — Legion Drone — helper; light combat drone
legfig — Noctua — fighter/scout drone
legkam — Martyr — self-destruct area attack
leglts — Aeolus — light transport
legmos — Mosquito — light gunship with stockpiled rockets

#### T2 aircraft — `units/Legion/Air/T2 Air`
legafigdef — Ajax — defensive air-superiority fighter
legatorpbomber — Aesacus — torpedo bomber
legfort — Tyrannus — flying kinetic multi-weapon fortress
legheavydrone — Legion Heavy Drone — helper; heavy defence drone
legheavydronesmall — Legion Heavy Drone — helper; small heavy defence drone
legionnaire — Legionnaire — defensive fighter
legmineb — Harbinger — linear minelayer bomber
legnap — Wildfire — heavy area napalm bomber
legphoenix — Phoenix — heavy assault heat-ray bomber
legstronghold — Stronghold — hybrid transport gunship
legvenator — Venator — rapid-response flak interceptor fighter
legwhisper — Whisper — radar/sonar plane
leghaca — Experimental Construction Aircraft — experimental combat engineer; source is units/CorSeaplanes/leghaca.lua
```

### Bots and constructors
```text
#### T1 bots — `units/Legion/Bots`
legaabot — Toxotai — amphibious anti-air bot
legbal — Ballista — medium rocket bot
legcen — Phobos — fast assault bot
leggob — Goblin — light skirmish bot
legkark — Karkinos — medium dual-weapon infantry
leglob — Satyr — light plasma bot
legrezbot — Zagreus — stealth resurrection/repair/reclaim bot

#### T2 bots — `units/Legion/Bots/T2 Bots`
legadvaabot — Aquilon — heavy amphibious anti-air bot
legajamk — Tiresias — mobile jammer bot
legamph — Telchine — advanced amphibious assault/coast guard
legaradk — Euclid — mobile radar bot
legaspy — Eidolon — stealth invisible spy bot
legbart — Belcher — napalm/skirmish bot
legdecom — Legion Commander — decoy commander
leghrk — Thanatos — salvo rocket bot
leginc — Incinerator — barely-mobile heavy heat ray
leginfestor — Infestor — infesting all-terrain spider assault bot
legshot — Phalanx — shielded riot-defence bot
legsnapper — Snapper — amphibious screwdrive bomb
legsrail — Arquebus — all-terrain heavy railgun
legstr — Hoplite — fast raider

#### Constructors — `units/Legion/Constructors`
legaca — Advanced Construction Aircraft — T2 constructor
legaceb — Proteus — all-terrain combat engineer
legack — Advanced Construction Bot — T2 constructor
legacv — Advanced Construction Vehicle — T2 constructor
legafcv — Aceso — light construction buggy
leganavyconsub — Advanced Construction Submarine — T2 constructor
leganavyengineer — Artifex — naval engineer
legca — Legion Construction Aircraft — T1 constructor
legch — Construction Hovercraft — T1 constructor
legck — Legion Construction Bot — T1 constructor
legcv — Legion Construction Vehicle — T1 constructor
leghack — Prometheus — experimental combat engineer
leghacv — Aceso — experimental combat engineer
legnavyconship — Construction Ship — T1 naval-structure constructor
legotter — Otter — amphibious construction vehicle
legspcon — Construction Seaplane — T1 constructor
```

### Defences, economy, and factories
```text
#### Defences — `units/Legion/Defenses`
legabm — Aegis — anti-nuke system
legacluster — Eviscerator — pop-up cluster-plasma artillery
legapopupdef — Chimera — pop-up multi-weapon defence
legbastion — Bastion — energy weapon defence
legbombard — Bombardier — grenade-launcher defence
legcluster — Amputator — area-control cluster artillery
legdrag — Dragon's Teeth
legdtr — Dragon's Jaw — pop-up riot cannon
legflak — Pluto — anti-air minigun
legforti — Fortification Wall
leghive — Hive — six-drone carrier
leglht — Pharos — light heat-ray tower
leglraa — Xyston — long-range anti-air rail accelerator
leglrpc — Olympus — long-range cluster-plasma cannon
leglupara — Lupara — bomb-resistant medium-AA flak
legmg — Cacophony — heavy land/air gatling tower
legperdition — Perdition — stockpiled long-range napalm
legrhapsis — Rhapsis — salvo anti-air missile battery
legrl — Bramble — light anti-air
legsilo — Supernova — nuclear ICBM launcher
legstarfall — Starfall — very-long-range 63-salvo plasma cannon

#### Economy — `units/Legion/Economy`
legadveconv — Advanced Energy Converter
legadvestore — Hardened Energy Storage — 40000 energy storage
legadvsol — Advanced Solar Collector — 100 energy
legafus — Advanced Fusion Reactor — 3300 energy; hazardous
legageo — Advanced Geothermal — 1250 energy; hazardous
legamstor — Hardened Metal Storage — 10000 metal storage
legeconv — Energy Converter
legestor — Energy Storage — 6000 energy storage
legfus — Fusion Reactor — 950 energy
leggeo — Geothermal — 300 energy
legmex — Metal Extractor
legmext15 — Overcharged Metal Extractor — high-energy extra extraction
legmoho — Advanced Metal Extractor
legmohobp — Fortifier — advanced extractor/build-drone pad
legmohobpct — legmohobpct — unlocalized auxiliary variant
legmohocon — Advanced Metal Fortifier — extractor/construction turret
legmohoconct — Advanced Metal Fortifier — auxiliary variant
legmohoconin — Advanced Metal Fortifier — internal/non-player-facing variant
legmstor — Metal Storage — 3000 metal storage
legrampart — Rampart — geothermal anti-nuke, jammer, radar, and drone platform
legsolar — Solar Collector — 20 energy
legwin — Wind Turbine

#### Factories — `units/Legion/Labs`
legaap — Legion Advanced Aircraft Plant
legadvshipyard — Advanced Shipyard — T2 Legion ships
legalab — Legion Advanced Bot Lab
legamphlab — Amphibious Complex
legap — Legion Drone Plant
legavp — Advanced Vehicle Plant
legfhp — Offshore Hovercraft Platform
leggant — Experimental Gantry
leggantuw — Experimental Gantry — large amphibious units
leghalab — Experimental Bot Lab
leghavp — Experimental Vehicle Plant
leghp — Hovercraft Platform
leghaap — Legion Experimental Aircraft Plant — experimental aircraft factory; source is units/CorBuildings/LandFactories/leghaap.lua
leglab — Legion Bot Lab
legsplab — Offshore Seaplane Platform
legsy — Shipyard
legvp — Legion Vehicle Plant
```

### Commander evolution, naval units, T3, utility, and vehicles
```text
#### Evolving commanders — `units/Legion/Legion EvoCom`
legcomlvl2 — Legion Commander Level 2 — commander evolution
legcomlvl3 — Legion Commander Level 3 — mobile rapid-assault factory
legcomlvl4 — Legion Commander Level 4 — mobile rapid-assault factory
legcomlvl5 — Legion Commander Level 5 — mobile rapid-assault factory
legcomlvl6 — Legion Commander Level 6 — mobile rapid-assault factory
legcomlvl7 — Legion Commander Level 7 — mobile rapid-assault factory
legcomlvl8 — Legion Commander Level 8 — mobile rapid-assault factory
legcomlvl9 — Legion Commander Level 9 — mobile rapid-assault factory
legcomlvl10 — Legion Commander Level 10 — mobile rapid-assault factory

#### Other and commander variants — `units/Legion/Other`
legvision — Vision — helper; temporary vision provider
legcomecon — Economy Commander — enhanced resource generation/build power/range
legcomoff — Offensive Commander — enhanced weapon and speed
legcomt2com — Combat Commander — larger, tougher, more weapons, slower
legcomt2def — Tactical Defense Commander — resource generation, EMP, shield
legcomt2off — Tactical Offense Commander — speed, unit production, jammer

#### Hovercraft — `units/Legion/Hovercraft`
legah — Alpheus — anti-air hovercraft
legcar — Cardea — shotgun hovertank
legmh — Salacia — hovercraft rocket launcher
legner — Nereus — hovertank
legsh — Glaucus — fast attack hovercraft

#### Naval defences — `units/Legion/SeaDefenses`
legctl — Euryale — coastal torpedo launcher
legfdrag — Shark's Teeth — naval fortification
legfhive — Naval Hive — six-drone carrier
legfmg — Gelasma — floating land/air gatling tower
legfrl — Polybolos — floating anti-air turret
legnavaldefturret — Phorcys — anti-ship salvo missile launcher
legtl — Stheno — offshore torpedo launcher
leganavalaaturret — Fulmen — advanced floating AA gatling turret
leganavaldefturret — Ionia — hybrid anti-ship machinegun/shotgun
leganavaltorpturret — Delphinus — advanced offshore torpedo launcher

#### Naval economy — `units/Legion/SeaEconomy`
legfeconv — Naval Energy Converter
legtide — Tidal Generator
leguwestore — Naval Energy Storage
leguwgeo — Offshore Geothermal
leguwmstore — Naval Metal Storage
leganavaladvgeo — Advanced Underwater Geothermal
leganavaleconv — Naval Advanced Energy Converter
leganavalfusion — Naval Fusion
leganavalmex — Advanced Underwater Metal Extractor

#### Seaplanes — `units/Legion/SeaPlanes`
legspbomber — Pyrphoros — seaplane bomber
legspcarrier — Hecatoncheir — airborne drone carrier
legspfighter — Astrapios — seaplane fighter
legspradarsonarplane — Okeanos — radar/sonar seaplane
legspsurfacegunship — Enyo — riot-cannon seaplane gunship
legsptorpgunship — Ladon — torpedo seaplane gunship

#### Naval utility — `units/Legion/SeaUtility`
legfrad — Naval Radar/Sonar Tower
leganavalpinpointer — Naval Pinpointer
leganavalsonarstation — Auscultor — extended sonar station

#### T1 ships — `units/Legion/Ships`
legnavyaaship — Iapetus — anti-air/radar support ship
legnavyartyship — Octeres — long-range cluster artillery ship
legnavydestro — Syracusia — heat-ray/drone-carrier destroyer
legnavyfrigate — Argonaut — torpedo frigate
legnavyrezsub — Dionysus — resurrection submarine
legnavyscout — Hippocampus — light assault corvette
legnavysub — Ketea — combat submarine

#### T2 ships — `units/Legion/Ships/T2`
leganavyaaship — Notus — advanced anti-air gatling/flak ship
leganavyantinukecarrier — Hecate — anti-nuke drone-carrier support
leganavyantiswarm — Leocampus — anti-swarm ship
leganavyartyship — Corinth — long-range cluster-plasma vessel
leganavybattleship — Scylla — cross-terrain battleship
leganavybattlesub — Architeuthis — fast assault submarine
leganavycruiser — Thalassa — gatling cruiser
leganavyflagship — Neptune — flagship
leganavyheavysub — Sphyrna — long-range battle submarine
leganavymissileship — Ultor — missile cruiser
leganavyradjamship — Dolus — radar/jammer ship

#### Experimental units — `units/Legion/T3`
leegmech — Praetorian — armored assault mech; internal id uses `leeg`
legeallterrainmech — Myrmidon — all-terrain drone-carrier mech
legeheatraymech — Sol Invictus — dual heat-ray/riot mech
legeheatraymech_old — Archaic Sol Invictus — legacy thermal-ordnance mech
legehovertank — Charybdis — heavy assault hovertank
legelrpcmech — Astraeus — long-range cluster-plasma siege mech
legerailtank — Daedalus — experimental rail-accelerator tank
legeshotgunmech — Praetorian — multi-weapon shotgun assault mech
legjav — Javelin — amphibious raider
legkeres — Keres — heavy assault/anti-swarm tank

#### Land utility — `units/Legion/Utilities`
legajam — Erebus — long-range jammer
legarad — Advanced Radar Tower
legdeflector — Soteria — plasma shield
legeyes — Argus — perimeter camera
legjam — Nyx — medium-range jammer
legjuno — Juno — anti-radar/jammer/mine/scout weapon
legmine1 — Light Mine
legmine2 — Medium Mine
legmine3 — Heavy Mine
legnanotc — Construction Turret
legnanotcplat — Naval Construction Turret
legrad — Radar Tower
legsd — Ichnaea — intrusion countermeasure
legtarg — Pinpointer — radar-targeting enhancement

#### T1 vehicles — `units/Legion/Vehicles`
legamphtank — Cetus — light amphibious tank
legbar — Barrage — napalm artillery
leggat — Decurion — armored assault tank
leghades — Alaris — fast assault tank
leghelios — Helios — skirmisher tank
legmlv — Sapper — stealth minelayer/minesweeper
legrail — Lance — long-range skirmisher/anti-air
legscout — Wheelie — light scout

#### T2 vehicles — `units/Legion/Vehicles/T2 Vehicles`
legaheattank — Prometheus — heavy assault heat-ray tank
legamcluster — Cleaver — mobile cluster artillery
legaskirmtank — Gladiator — burst-fire skirmisher
legavantinuke — Hera — mobile anti-nuke
legavjam — Cicero — radar-jammer vehicle
legavrad — Pheme — radar vehicle
legavroc — Boreas — stealth rocket launcher
legfloat — Triton — convertible tank/boat
leginf — Inferno — long-range napalm artillery
legmed — Medusa — heavy salvo rocket tank
legmrv — Quickshot — fast burst-fire raider
legvcarry — Mantis — mobile drone-carrier truck
legvflak — Charon — anti-air minigun truck
```

---

## Gameplay-defining fields and weapon restrictions

### What must be retained from UnitDefs

The loader normalizes `customparams`, `buildoptions`, `weapondefs`, and
`weapons`, so all four are meaningful fields for consumers
(`gamedata/unitdefs_post.lua:33-44`).  Do not infer these mechanics only from
the labels in the catalog:

| Mechanic | Relevant UnitDef/custom parameters and roster examples |
| --- | --- |
| Builder/production | `builder`, `workertime`, `builddistance`, `buildoptions`.  Factories and constructors above are the producer nodes; `armvp` is a representative exact list (`units/ArmBuildings/LandFactories/armvp.lua:33-56`). |
| Weapon targets | Preserve each `weapons[n].def`, `onlytargetcategory`, and `badtargetcategory`, plus referenced `weapondefs`.  Target filters are weapon-slot-specific, not merely unit-role-specific. |
| Manual fire/stockpile | `canmanualfire`, weapon `commandfire`, `stockpile`, `stockpiletime`, and custom `stockpilelimit`.  Applies especially to commanders, silos, EMP/tactical launchers, Juno, selected bombers, and drone systems. |
| Strategic interception | Weapon `interceptor`; anti-nuke units are Armada `armamd/armscab/armantiship/armcarry`, Cortex `corfmd/cormabm/corantiship/corcarry`, and Legion `legabm/legrampart/legavantinuke/leganavyantinukecarrier`. |
| Air/AA/naval | `canfly`, `cruisealtitude`, `waterweapon`, `minwaterdepth`, `floater`, movement class, and weapon target filters distinguish these domains.  AA entries above should never be generalized to all weapon slots. |
| Sensors/jamming | `radardistance`, `sonardistance`, `airsightdistance`, `radardistancejam`, jammer fields, and radar-targeting custom params. |
| Economy | `energymake`, `metalmake`, `energyupkeep`, `energystorage`, `metalstorage`, `extractsmetal`, `customparams.metal_extractor`, `standardextractor`, `energyconv_capacity`, and `energyconv_efficiency`. |
| Transport/drones | `transportcapacity`, `transportsize`, unload method, `customparams.drone`, drone spawn/stockpile mechanics, and carrier weapons. |
| Commanders/evolution | `customparams.iscommander`, decoy/evolution fields, commander manual-fire weapons, and EvoCom settings. |
| Resurrection/mines | `canresurrect`, reclaim/repair capabilities; mine/minesweeper custom parameters and Juno interactions. |

For example, Flash's rapid-fire plasma weapon is `NOTSUB` and has VTOL as a
bad target, rather than being generically “ground only”:
`units/ArmVehicles/armflash.lua:104-149`.  Commander weapons show three
different target constraints in one UnitDef:
`units/armcom.lua:293-307`.

BAR postprocessing rounds weapon reload/burst values to engine frames and
prefixes cluster weapon definitions with their owning unit name.  A raw source
number/name may therefore not be the final engine value/name:
`gamedata/alldefs_post.lua:73-101`.

### Family equivalents and intentional asymmetries

| Family | Armada | Cortex | Legion | Notable difference |
| --- | --- | --- | --- | --- |
| Core commander | `armcom` | `corcom` | `legcom` | Legion has EvoCom levels and multiple specialized commander variants. |
| T1 constructors | `armca/armck/armcv/armcs/armcsa/armch` | `corca/corck/corcv/corcs/corcsa/corch` | `legca/legck/legcv/legnavyconship/legspcon/legch` | Legion adds terrain-specialist/combat-engineer choices. |
| T2 constructors | `armaca/armack/armacv/armacsub` | `coraca/corack/coracv/coracsub` | `legaca/legack/legacv/leganavyconsub` | Legion supplements these with Proteus, Aceso, and Otter. |
| Anti-nuke | Citadel, Umbrella, Haven | Prevailer, Saviour, Oasis | Aegis, Hera, Hecate, Rampart | Rampart also supplies geothermal economy, drone platform, radar, and jammer. |
| Drone carriers | Nexus, Trident | Disperser, Sentinel | Hive, Hecatoncheir, Mantis, Hecate, and more | Legion integrates drones across more domains. |
| Heavy artillery | Big Bertha/Ragnarok/Pulsar | Basilisk/Calamity/Scorpion | Olympus/Starfall/cluster systems | Legion is especially cluster/salvo oriented. |
| AA character | Missile and flak mix | Missile and flak mix | Gatling/minigun/rail emphasis | Legion's Pluto, Fulmen, Xyston, and Charon are distinctive. |
| Metal economy | Stealth extractor (`armamex`) | Armed extractor pair (`corexp/cormexp`) | Overcharged/Fortifier/drone-pad variants | Legion has the broadest extractor specialization. |

## CircuitAI integration note

**Do not map BAR `customparams.unitgroup` or `customparams.techlevel`
directly to CircuitAI JSON roles.**  BAR unit groups are UI/gameplay
classification hints (`weapon`, `aa`, `builder`, `buildert2`, `energy`,
`metal`, `util`, `sub`, `nuke`, `antinuke`, and others), while `techlevel`
is an authoring/balance field with exceptions.  CircuitAI should derive its
own role taxonomy from the union of:

1. production reachability (`buildoptions`);
2. mobility and placement fields;
3. complete weapon definitions and per-slot target restrictions;
4. economy, sensor, construction, transport, drone, and commander fields;
5. option-gated availability.

It must also keep helper/spawned/variant entities separate from ordinary
factory-buildable player choices.  In particular, drones, depth-charge
helpers, decoy commanders, EvoCom levels, and internal Legion extractor
variants are valid UnitDefs but are not equivalent to normal player-facing
production options.

### How behavior properties affect play

CircuitAI behavior JSON is operational policy, not a copy of BAR metadata:

| Property | CircuitAI effect | Practical consequence |
| --- | --- | --- |
| `role[0]` | Sets the main friendly role and task family. | An immobile `super` attacker receives strategic targeting through `CSuperTask`; a mobile `super` is routed to an ordinary attack task. `static` uses stationary-defense handling, while `support` avoids treating a utility unit as a front-line attacker. |
| Later `role` values | Add enemy-classification masks only. | `"role": ["super", "static"]` means a friendly `super` that enemies may classify as static. It does not add the friendly static role. |
| `attribute` | Adds a friendly role when the value is a role name; otherwise adds a true attribute such as `siege`, `stockpile`, or `melee`. | `"attribute": ["support"]` gives a factory an additional friendly support role. Stockpile is also detected automatically from weapons. |
| `threat` | Multiplies modeled air, surface, water, and default threat. | Setting every channel to zero prevents a utility, interceptor, or strategic weapon from distorting local combat-danger estimates. |
| `power` | Multiplies modeled combat power. | `1.0` preserves native power; larger values intentionally make the unit count more heavily in force evaluation. |
| `limit` | Lowers the engine UnitDef cap; it cannot raise it. | Use it to prevent repeated expensive factories or strategic structures. |
| `since` | Delays eligibility by the configured number of seconds. | Useful for economy and endgame structures that should not enter early build selection. |
| `build_speed` | Overrides CircuitAI's modeled build speed. | Keep it synchronized with actual buildpower when assistance and construction timing depend on it. |
| `build_mod` | Changes the income-dependent target build time used to cap assisting buildpower. | Large values discourage excessive constructor concentration on the configured builder/factory. |
| `retreat` | Sets the health-fraction retreat threshold, optionally randomized from a range. | Builders and fragile support units can withdraw earlier than assault units. |
| `fire_state` | Sets the engine fire state; `2` is fire at will. | This does not replace strategic target selection. |
| `on` | Sets activation state when construction finishes. | It controls activation, not weapon targeting or stockpile production. |

These semantics are implemented in
`src/circuit/module/FactoryManager.cpp:353-475`. Strategic units with main
role `super` are registered by
`src/circuit/module/MilitaryManager.cpp:173-196`; `CSuperTask` selects
valuable in-range groups and issues unit or ground attacks for both
stockpiled and ordinary weapons
(`src/circuit/task/static/SuperTask.cpp:73-248`).

This distinction matters for long-range artillery. For example,
`legministarfall` is not stockpiled, but its main role must still be `super`
so CircuitAI deliberately chooses distant targets. The second `static` role
only supplies enemy classification. In contrast, shield-only structures such
as `armgatet3` and `corgatet3` must be `static`, because their UnitDefs set
`canattack=false` and expose only a repulsor shield.

## Remaining ambiguity

* The precise final roster depends on Spring VFS filename normalization and
  mod options.  The loader tests lowercase substrings such as `"legion"` and
  `"scavengers"` in VFS-returned names (`gamedata/unitdefs.lua:76-104`);
  static Windows directory casing is not a substitute for engine behavior.
* `modoption_blocked` can be set without deleting a UnitDef for fusion,
  tactical-nuke, LRCP, and endgame-LRCP restriction modes
  (`gamedata/alldefs_post.lua:407-430`).  The catalog reports the base
  effective load set, not every possible restricted-match availability.
* A few valid UnitDefs lack English localization.  They remain listed by
  internal ID and should be interpreted from their source tables rather than
  silently discarded.
