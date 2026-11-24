"""Supplied-force ranged combat: unchanged AI commands team 0; fixture owns team 1.

Each invocation allocates an immutable run identity. Economy is frozen only in
the staged scripts. --variant siege isolates the original two-list proposal;
--variant baseline takes a pinned pre-change --data/--dll pair.
"""
import argparse
import hashlib
import json
import os
import re
import subprocess
import sys
from pathlib import Path
from benchmark_store import RAW_ROOT
import storage
import playtest
from air_arena import lua

def group_fixture_policy(source,values):
    """Replace declared numeric group settings without stripping JSON comments."""
    for key,value in values.items():
        if not re.fullmatch(r'commander_group_[a-z0-9_]+',key) or type(value) not in (int,float):
            raise ValueError('Invalid commander group fixture policy')
        number=json.dumps(value,allow_nan=False)
        source,count=re.subn(r'("'+re.escape(key)+r'"\s*:\s*)-?\d+(?:\.\d+)?',
            lambda match:match[1]+number,source)
        if count!=1:raise ValueError('Missing/duplicate commander group fixture key: '+key)
    return source

def defense_fixture_policy(values):
    """Explicit script-visible rule overrides for supplied correctness arenas."""
    lines=[]
    for row in values:
        if (set(row)!={'slot','key','value'} or type(row['slot']) is not int or not -1<=row['slot']<24
            or not isinstance(row['key'],str) or not re.fullmatch(r'[a-z_]+',row['key'])
            or type(row['value']) not in (int,float)):
            raise ValueError('Invalid defense fixture policy')
        number=json.dumps(float(row['value']),allow_nan=False)
        lines.append(f'if(!aiBuilderMgr.SetDefenseRule({row["slot"]},"{row["key"]}",{number}f)) GenericHelpers::LogUtil("[DefenseFixture] ERROR rejected rule",1);')
    return '\n'.join(lines)

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def pool_symbols(staged):
    """Compatibility hook for callers; shared staging owns symbol retention."""
    from symbol_store import stage_symbols
    path = staged / 'SkirmishAI.dbg'
    if path.exists():
        stage_symbols(path, path)


def prepare(args):
    case = json.loads(storage.resolve_definition(args.case, 'cases').read_text())
    role = case.get('role', 'FRONT')
    if role not in ('FRONT', 'TECH', 'AIR', 'SEA', 'SUPPORT', 'TACTICAL'): raise ValueError('Unsupported arena role: '+role)
    directory = storage.allocate('shared', 'combat', case.get('storage_scenario',case['name']), case['map_key'], 'supplied', seed=args.seed)
    starts = directory / 'starts.as'
    starts.write_text(''.join(f'StartSpot(AIFloat3({x},0,{z}), AiRole::{role if i==0 else case.get("enemy_role",role)}, false),\n' for i,(x,z) in enumerate(case['starts'])))
    command = [sys.executable, str(HERE / 'playtest.py')]
    stage = command + ['stage','--dir',str(directory),'--dll',str(args.dll),'--data',str(args.data),
        '--map',case['map'],'--map-file',str(starts),'--role',role,'--roles','all','--ally-spots',case.get('ally_spots','1'),
        '--side',case.get('side','armada'),
        '--engine',getattr(args,'engine','recoil_2026.07.04'),'--speed',str(args.speed),'--mode',getattr(args,'mode','fast'),'--minutes',str(args.minutes),
        '--shots','','--width','1280','--height','720','--lean-render','--bonus','50',
        '--ai-option','profile='+args.profile,'--ai-option','random_seed='+str(args.seed),
        '--modoption','deathmode=neverend','--modoption','startenergy='+str(case.get('start_energy',1000000)),
        '--modoption','startmetal='+str(case.get('start_metal',1000)),
        '--modoption','startmetalstorage='+str(case.get('start_metal',1000)),
        '--modoption','startenergystorage='+str(case.get('start_energy_storage',1000000)),
        '--extra-widget',str(HERE/'widgets/ranged_arena.lua'),
        '--extra-widget',str(HERE/'widgets/workforce_perf_watch.lua')]
    if getattr(args,'opponent_dll',None):
        stage += ['--enemies','prod','--opponent-dll',str(args.opponent_dll),'--opponent-data',str(args.opponent_data or args.data)]
    # Declared per-case mod options (e.g. the Legion faction for legscout).
    for key, value in case.get('modoptions', {}).items():
        stage += ['--modoption', f'{key}={value}']
    if case.get('commander_idle_probe'):
        stage += ['--extra-widget',str(HERE/'widgets/commander_idle_watch.lua')]
    if args.headless: stage += ['--headless']
    # No --game: playtest.py resolves the lobby's last game archive, so a
    # pinned archive name does not go stale when the installed BAR updates.
    if args.game: stage += ['--game',args.game]
    if case.get('aggression_widget_test'):
        stage += ['--extra-widget',str(ROOT/'tools/widgets/gui_barb_team_link.lua'),
                  '--extra-widget',str(HERE/'widgets/aggression_watch.lua')]
    if case.get('coverage_overlay'):
        stage += ['--extra-widget',str(ROOT/'tools/widgets/gui_barb_team_link.lua')]
    if case.get('lane_front_overlay'):
        stage += ['--extra-widget',str(ROOT/'tools/widgets/gui_barb_team_link.lua'),
                  '--extra-widget',str(HERE/'widgets/lane_front_watch.lua')]
    subprocess.run(stage, check=True)
    script = directory/'script.txt'
    script.write_text(script.read_text().replace('[GAME]\n{','[GAME]\n{\n FixedRNGSeed='+str(args.seed)+';',1))
    staged = directory/'AI/Skirmish/BARbTest/test'
    pool_symbols(staged)
    # Explicit correctness-fixture policy levers; never mutate source/live data.
    if case.get('commander_idle_probe'):
        config_path=staged/'config'/args.profile/'commander.json'
        config_path.write_text(re.sub(r'("front_ladder"\s*:\s*)"[^"]*"',
            r'\1"advance,reclaim,hold"',config_path.read_text()))
    if case.get('commander_policy'):
        config_path=staged/'config'/args.profile/'commander.json'
        config_path.write_text(group_fixture_policy(config_path.read_text(),case['commander_policy']))
    setup=staged/'script/src/setup.as'
    fixture_role=('(ai.teamId==0?AiRole::'+role+':AiRole::'+case['enemy_role']+')') if case.get('enemy_role') else 'AiRole::'+role
    setup.write_text(setup.read_text().replace('Global::AISettings::Role = derivedRole;',
        'derivedRole='+fixture_role+'; Global::AISettings::Role = derivedRole;'))
    for name,manager,wait in [('builder','aiBuilderMgr','TaskB::Wait(60*SECOND)'),('factory','aiFactoryMgr','TaskS::Wait(false,60*SECOND)')]:
        path = staged/'script/src/manager'/(name+'.as')
        source = path.read_text(); start = source.index('{',source.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)'))+1
        repair='\n if (ai.teamId==1 && !u.circuitDef.IsMobile()) return aiBuilderMgr.DefaultMakeTask(u);' if name=='builder' and case.get('enemy_repair') else ''
        if name=='builder' and case.get('friendly_repair'):
            repair+='\n if (ai.teamId==0 && !u.circuitDef.IsMobile()) return aiBuilderMgr.DefaultMakeTask(u);'
        condition = 'ai.teamId==1' if name=='factory' and case.get('production') else 'ai.frame>=0'
        if name=='builder' and case.get('builders'): condition = 'ai.teamId==1'
        if name=='builder' and case.get('commander_front_work'):
            condition = 'ai.teamId!=0 || !u.circuitDef.IsRoleAny(Unit::Role::COMM.mask)'
            if case.get('coverage_probe'):
                condition = '!u.circuitDef.IsRoleAny(Unit::Role::COMM.mask)'
        if name=='builder' and case.get('production'):
            repair += '\n if (ai.teamId==0 && !u.circuitDef.IsMobile()) return aiBuilderMgr.DefaultMakeTask(u);'
        if name=='builder' and case.get('commander_repair_only'):
            repair+='\n if (ai.teamId==0 && u.circuitDef.IsRoleAny(Unit::Role::COMM.mask)) { aiBuilderMgr.SetCommanderCombatOption("front_ready",1.f); IUnitTask@ repair=aiBuilderMgr.CommanderFrontWork(u,21,null,0.f); if(repair !is null) return repair; return aiBuilderMgr.CommanderFrontWork(u,15,null,1.f); } // stationary repair isolation fixture\n'
        if name=='builder' and case.get('stationary_assist_fixture'):
            repair+='\n if (ai.teamId==0 && u.circuitDef.IsRoleAny(Unit::Role::COMM.mask)) { aiBuilderMgr.SetCommanderCombatOption("front_ready",1.f); return aiBuilderMgr.CommanderFrontWork(u,15,null,30.f); } // held-owner assist fixture\n'
            if case['stationary_assist_fixture'].get('construction'):
                repair+='\n if (ai.teamId==0 && u.circuitDef.GetName()=="armack") { IBuilderTask@ own=cast<IBuilderTask>(u.task); if(own !is null && !own.IsDead()) return own; return aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::ENERGY,Task::Priority::HIGH,ai.GetCircuitDef("armfus"),AIFloat3(4000,0,4136),0.f,true,120*SECOND)); } // real constructor supplies a nanoframe near the edge of commander reach\n'
        if name=='builder' and case.get('solar_ceiling_fixture'):
            repair+='\n if(ai.teamId==0 && ai.frame<40*SECOND) return aiBuilderMgr.CommanderFrontWork(u,15,null,1.f); // let supplied high-income stall settle before commander policy\n'
        if name=='builder' and case.get('placement_fixture')=='nano-refill':
            repair+='''
        if(ai.teamId==0 && u.circuitDef.GetName()=="armck" && ai.frame>=65*SECOND) {
            IBuilderTask@ own=cast<IBuilderTask>(u.task);
            if(own !is null && !own.IsDead()) return own;
            CCircuitDef@ nano=ai.GetCircuitDef("armnanotc");
            aiTerrainMgr.RestoreSpineSupport("fixture.spine",nano,8,30*SECOND);
            const int group=aiTerrainMgr.GetLayoutInt("fixture.spine.support",0);
            const int slot=aiTerrainMgr.NextRefilledSupportSlot(u,nano,group,8);
            AiLog("[RefillFixture] worker slot="+slot+" can_build="+u.circuitDef.CanBuild(nano)+" group="+group);
            if(slot>=0) {
                IUnitTask@ job=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::NANO,Task::Priority::HIGH,nano,
                    aiTerrainMgr.GetReservationPos(slot),0,true,120*SECOND));
                if(job !is null && AiPinReservation(job,slot)) return job;
                if(job !is null) aiBuilderMgr.AbortTask(job);
            }
        }
'''
        if name=='builder' and case.get('placement_fixture'):
            worker='armacv' if case['placement_fixture']=='factory-facing' else 'armack'
            repair+='\n if(ai.teamId==0 && u.circuitDef.GetName()=="'+worker+'" && _PlacementTask !is null && !_PlacementTask.IsDead()) return _PlacementTask; // declared placement fixture\n'
        if name=='factory' and case.get('tech_base_response_fixture'):
            repair+='\n if(ai.teamId==0 && !_BaseResponseActive && ai.frame<90*SECOND) return aiFactoryMgr.Enqueue(TaskS::Wait(false,SECOND)); // allow nearby intrusion before economy products\n'
        path.write_text(source[:start]+repair+'\n if ('+condition+') return '+manager+'.Enqueue('+wait+'); // supplied arena only\n'+source[start:])
    # KI-785: with every builder and factory frozen no first factory can
    # appear, so D-494's first-factory check (INV-267) cannot judge the arena.
    # Only that check is skipped; every other invariant stays forbidden.
    first_factory_skipped = not (case.get('builders') or case.get('commander_front_work') or case.get('production'))
    if case.get('tech_base_response_fixture'):
        path=staged/'script/src/systems/construction/front_layout.as'
        source=path.read_text(); start=source.index('{',source.index('void CheckFirstFactory()'))+1
        path.write_text(source[:start]+'\n if(ai.teamId!=0) return; // enemy builders are frozen in this supplied fixture\n'+source[start:])
    if first_factory_skipped:
        path = staged/'script/src/systems/construction/front_layout.as'
        source = path.read_text(); start = source.index('{', source.index('void CheckFirstFactory()'))+1
        path.write_text(source[:start]+'\n if (ai.frame>=0) return; // supplied arena: builders and factories frozen (KI-785)\n'+source[start:])
    path = staged/'script/src/manager/military.as'
    source = path.read_text(); start = source.index('{',source.index('IUnitTask@ AiMakeTask(CCircuitUnit@ u)'))+1
    # Normal combat cases leave friendly commands to the AI. Production-only
    # cases can explicitly hold them to retain the supplied enemy demand.
    # The enemy follows a declared path or holds, with normal weapon firing.
    destination = case.get('enemy_destination')
    point = f'AIFloat3({destination[0]},0,{destination[1]})' if destination else 'u.GetPos(ai.frame)'
    if case.get('enemy_waypoints'):
        point = ','.join(f'AIFloat3({x},0,{z})' for x,z in case['enemy_waypoints'])
    override = '''
        if (ai.teamId==1 && u.circuitDef.IsMobile()) {
            CRouteTask@ route=cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
            array<AIFloat3> points={'''+point+'''};
            route.SetTraversal(true,48,false); route.SetRoute(points); return route;
        } // enemy fixture only
'''
    if case.get('placement_fixture')=='gantry-corridor':
        override += '''
        if(ai.teamId==0 && u.circuitDef.GetName()=="armthor") {
            CRouteTask@ route=cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
            array<AIFloat3> points={AIFloat3(4000,0,4000)};
            route.SetTraversal(false,48,false); route.SetRoute(points); return route;
        } // largest-footprint gantry product physically traverses the protected connector
'''
    if case.get('hold_friendly'):
        override += '''
        if (ai.teamId==0 && u.circuitDef.IsMobile()) {
            CRouteTask@ route=cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
            array<AIFloat3> points={u.GetPos(ai.frame)};
            route.SetTraversal(true,48,false); route.SetRoute(points); return route;
        } // production-only fixture: retain army investment without clearing opponents
'''
    if case.get('native_route'):
        spec = case['native_route']
        points = ','.join(f'AIFloat3({x},0,{z})' for x,z in spec['points'])
        override += '''
        if (ai.teamId==0 && u.circuitDef.GetName()=="'''+case['unit']+'''") {
            if (FixtureRoute is null) {
                @FixtureRoute=cast<CRouteTask>(aiMilitaryMgr.Enqueue(TaskF::Route()));
                array<AIFloat3> points={'''+points+'''};
                FixtureRoute.SetLanes('''+str(spec['lanes'])+','+str(spec['spacing'])+''',1);
                FixtureRoute.SetTraversal(false,'''+str(spec['radius'])+''',false);
                FixtureRoute.SetRoute(points);
            }
            return FixtureRoute;
        } // supplied route: exercise ordinary spam's native arrival/idle path
'''
    if case.get('hold_all'):
        override=override.replace('ai.teamId==0 && u.circuitDef.IsMobile()','u.circuitDef.IsMobile()')
    if case.get('enemy_commander_home'):
        # D-294: the opposing start commander carries radar; routed with the
        # fixture it escorts the supplied T3 and confounds concealed approaches.
        override=override.replace('if (ai.teamId==1 && u.circuitDef.IsMobile())',
            'if (ai.teamId==1 && u.circuitDef.IsMobile() && !u.circuitDef.IsRoleAny(Unit::Role::COMM.mask))',1)
    # Supplied allied spotters may need to hold as well as the opposing army.
    # This affects only the fixture's military override, never normal policy.
    held_teams = case.get('hold_teams', [case.get('enemy_team', 1)])
    if not held_teams or any(type(team) is not int or team < 0 for team in held_teams):
        raise ValueError('hold_teams must contain nonnegative integer team IDs')
    hold_condition = '(' + ' || '.join('ai.teamId==' + str(team) for team in held_teams) + ')'
    override=override.replace('ai.teamId==1', hold_condition)
    patched = source[:start]+override+source[start:]
    if case.get('native_route'): patched = 'CRouteTask@ FixtureRoute;\n'+patched
    path.write_text(patched)
    if 'aggression_delta' in case:
        path=staged/'script'/args.profile/'main.as'
        source=path.read_text(); start=source.index('{',source.index('void AiUpdate()'))+1
        path.write_text(source[:start]+'\n if (ai.teamId==0) aiMilitaryMgr.SetAggressionDelta('+str(float(case['aggression_delta']))+'f); // declared fixture offset\n'+source[start:])
    if case.get('commander_observation'):
        path=staged/'script'/args.profile/'main.as'
        source=path.read_text(); start=source.index('{',source.index('void AiUpdate()'))+1
        # Frozen economic builders never ask for an opening factory, so Setup's
        # usual role resolution does not run. Declare only the fixture role.
        source=source[:start]+'\n Global::AISettings::Role='+fixture_role+'; // commander fixture role\n'+source[start:]
        if case.get('enemy_commander_home'):
            # D-294: ...and its own commander control would deploy it with the T3.
            source=source[:start]+'\n if (ai.teamId=='+str(case.get('enemy_team',1))+' && ai.frame<2*SECOND) CommanderCombat::Override("enabled",0.f); // keep enemy commander home\n'+source[start:]
        # D-293: exercise the per-AI script override on team 0 only; it must
        # win over the profile JSON that CommanderCombat::Update applies.
        # D-356: a coverage probe case observes every commander, so its
        # overrides (the unscreened push) apply to every team.
        scope='ai.frame<2*SECOND' if case.get('coverage_probe') else 'ai.teamId==0 && ai.frame<2*SECOND'
        for key,value in case.get('commander_overrides',{}).items():
            source=source[:start]+'\n if ('+scope+') CommanderCombat::Override("'+key+'",'+repr(float(value))+'f); // per-AI override fixture\n'+source[start:]
        declarations=''
        events=''
        if case.get('solar_ceiling_fixture'):
            declarations+='bool _SolarCeilingObserved=false;\n'
            events+='''
 if(ai.teamId==0 && ai.frame>=40*SECOND && !_SolarCeilingObserved
    && aiEconomyMgr.energy.income>=1000.f && aiEconomyMgr.isEnergyStalling) {
   _SolarCeilingObserved=true; AiLog("[SolarCeilingFixture] high income stall observed");
 }
'''
        if case.get('tech_base_response_fixture'):
            events+='\n if(ai.teamId==0) Global::AISettings::Side='+json.dumps(case.get('side','armada'))+';\n'
            declarations+='bool _BaseResponseReady=false,_BaseResponseActive=false,_BaseResponseClear=false,_BaseResponseResumed=false; int _BaseResponseT1=0,_BaseResponseT2=0;\n'
            events+='''
 if(ai.teamId==0) {
   if(!_BaseResponseReady) {
     _BaseResponseReady=true;
     RoleTech::Register(); @Global::profileController.RoleCfg=RoleConfigs::Get(AiRole::TECH);
     Global::Map::StartPos=AIFloat3(4000,0,2000);
     Global::RoleSettings::Tech::BaseResponseRadius=1200.f;
     Global::RoleSettings::Tech::HeavyRushEnabled=false;
     array<string> names={"armpw","corak","leggob","armfast","corpyro","legstr"};
     for(uint i=0;i<names.length();++i) { CCircuitDef@ d=ai.GetCircuitDef(names[i]); if(d !is null) d.maxThisUnit=0; }
   }
   TechBaseResponse::Tick();
   if(ai.frame>=30*SECOND && ai.frame<55*SECOND && TechBaseResponse::active)
     AiLog("[RangedArena] ERROR response to distant/air-only contact");
   if(ai.frame>=60*SECOND && TechBaseResponse::active) {
     _BaseResponseActive=true;
     const string side=Global::AISettings::Side;
     CCircuitDef@ light=ai.GetCircuitDef(side=="armada" ? "armpw" : side=="cortex" ? "corak" : "leggob");
     array<string> fast=UnitHelpers::GetFastT2Bots(side);
     CCircuitDef@ heavy=ai.GetCircuitDef(fast[0]);
     _BaseResponseT1=AiMax(_BaseResponseT1,light.count-aiBuilderMgr.GetUnfinishedCount(light));
     _BaseResponseT2=AiMax(_BaseResponseT2,heavy.count-aiBuilderMgr.GetUnfinishedCount(heavy));
   }
   if(_BaseResponseActive && !TechBaseResponse::active && !_BaseResponseClear) {
     _BaseResponseClear=true;
     const string side=Global::AISettings::Side;
     const string light=side=="armada" ? "armpw" : side=="cortex" ? "corak" : "leggob";
     array<string> fast=UnitHelpers::GetFastT2Bots(side);
     CCircuitDef@ t1=ai.GetCircuitDef(light),t2=ai.GetCircuitDef(fast[0]);
     AiLog(_BaseResponseT1>=2 && _BaseResponseT2>=1 ? "[BaseResponseFixture] PASS both tiers defended and cleared" : "[RangedArena] ERROR missing defender tier");
   }
   if(_BaseResponseClear && !_BaseResponseResumed) {
     array<string> cons=UnitHelpers::GetT1BotConstructors(Global::AISettings::Side);
     CCircuitDef@ con=ai.GetCircuitDef(cons[0]);
     array<string> advanced=UnitHelpers::GetT2BotConstructors(Global::AISettings::Side);
     CCircuitDef@ t2con=ai.GetCircuitDef(advanced[0]);
     if(con.count-aiBuilderMgr.GetUnfinishedCount(con)+t2con.count-aiBuilderMgr.GetUnfinishedCount(t2con)>0) {
       _BaseResponseResumed=true; AiLog("[BaseResponseFixture] PASS economy constructor completed after clear");
     }
   }
 }
'''
        if case.get('air_lab_policy_fixture'):
            declarations+='bool _AirLabPolicyChecked=false;\n'
            events+='''
 if(ai.teamId==0 && ai.frame>=20*SECOND && !_AirLabPolicyChecked) {
   _AirLabPolicyChecked=true;
   const AiRole savedRole=Global::AISettings::Role;
   const bool savedHeavy=Global::RoleSettings::Tech::HeavyRushEnabled;
   const string savedPlan=TechPlan::plan; const int savedPhase=TechPlan::phase;
   Global::AISettings::Role=AiRole::TECH; Global::RoleSettings::Tech::HeavyRushEnabled=false;
   array<string> plans={"eco","nuke","spamrush","lrpc","t3rush"};
   bool ok=true;
   for(uint k=0;k<plans.length();++k) {
     TechPlan::plan=plans[k]; TechPlan::phase=0;
     array<TechChain::Step@>@ steps=TechPlan::NextPhase(plans[k]=="nuke" ? "nuke" : "afus");
     int ap=-1,aap=-1,funding=-1,early=-1; string sequence="";
     for(uint i=0;i<steps.length();++i) {
       sequence+=(i>0 ? "," : "")+steps[i].key;
       if(steps[i].key=="ap") ap=int(i);
       if(steps[i].key=="aap") aap=int(i);
       if(steps[i].key=="airfunding") {funding=int(i);ok=ok && steps[i].target==80;}
       if(steps[i].key=="earlygantry") early=int(i);
     }
     if(k<2) ok=ok && ap>=0 && funding==ap+1 && aap==funding+1;
     else ok=ok && funding<0 && ap>=0 && aap>ap;
     if(k==1) ok=ok && steps[steps.length()-1].key=="income" && steps[steps.length()-1].target==200;
     if(k==4 && TechGantry::EarlyEnabled()) ok=ok && early>ap && aap>early;
     AiLog("[AirLabPolicy] "+plans[k]+" sequence="+sequence);
   }
   const string savedEndgame=Global::RoleSettings::Tech::EndgamePlan;
   Global::RoleSettings::Tech::EndgamePlan="nuke"; TechPlan::plan="nuke"; TechPlan::phase=0;
   array<TechChain::Step@>@ beforeSilo=TechPlan::NextPhase("afus");
   ok=ok && beforeSilo.length()==1 && beforeSilo[0].key=="silo";
   array<TechChain::Step@>@ afterSilo=TechPlan::NextPhase("nuke");
   ok=ok && afterSilo.length()==5 && afterSilo[0].key=="ap"
      && afterSilo[1].key=="airfunding" && afterSilo[2].key=="aap" && afterSilo[3].target==200;
   Global::RoleSettings::Tech::EndgamePlan=savedEndgame;
   CCircuitDef@ lab=ai.GetCircuitDef(TechChain::DefFor("aap"));
   ok=ok && lab !is null && aiEconomyMgr.metal.current>=lab.costM
       && Economy::GetMinMetalIncomeLast10s()<80 && TechChain::AirLabFunded(80);
   ok=ok && TechEconomyMath::AirLabFunded(80,0,lab.costM,80,false)
       && !TechEconomyMath::AirLabFunded(79,lab.costM-1,lab.costM,80,false)
       && TechEconomyMath::AirLabFunded(0,0,lab.costM,80,true);
   TechPlan::plan=savedPlan; TechPlan::phase=savedPhase;
   Global::AISettings::Role=savedRole; Global::RoleSettings::Tech::HeavyRushEnabled=savedHeavy;
   AiLog(ok ? "[AirLabPolicy] PASS plans=5 bank=pass income=pass committed=pass" : "[RangedArena] ERROR air lab policy");
 }
'''
        if case.get('placement_fixture'):
            kind=case['placement_fixture']
            if kind not in ('nano-interior','nano-refill','factory-facing','gantry-corridor'):
                raise ValueError('Unknown placement fixture')
            if kind in ('factory-facing','gantry-corridor'):
                fixture_path=staged/'script/src/systems/construction/front_layout.as'
                fixture_source=fixture_path.read_text()
                fixture_start=fixture_source.index('{',fixture_source.index('void Prepare(IUnitTask@ task)'))+1
                fixture_path.write_text(fixture_source[:fixture_start]+'\n if(ai.teamId==0) return; // supplied far-site test of native ordinary placement\n'+fixture_source[fixture_start:])
            declarations+='bool _PlacementReady=false; IUnitTask@ _PlacementTask;\n'
            events+='\n if(ai.teamId==0 && ai.frame>=20*SECOND && !_PlacementReady) { _PlacementReady=true; aiTerrainMgr.SetLayoutEnabled(true);\n'
            if kind=='nano-refill':
                declarations+='int _RefillOpening=-1; int _RefillGroup=0; bool _RefillReleased=false; bool _RefillComplete=false;\n'
                events+='''
 CCircuitDef@ nano=ai.GetCircuitDef("armnanotc"), lab=ai.GetCircuitDef("armlab");
 aiBuilderMgr.experimentalBuild = true; // TECH retains construction ownership inside reserved cells
 aiTerrainMgr.SetFactoryCorridorPolicy(false,false); // TECH's ordinary opening-lab policy
 _RefillOpening=aiTerrainMgr.ReserveBuilding(lab,AIFloat3(2016,0,3824),2,0);
 const int zone=aiTerrainMgr.ReserveZone(AIFloat3(2000,0,3504),0,512,512,false);
 _RefillGroup=aiTerrainMgr.LayBand(zone,nano,AIFloat3(1856,0,3504),3,4,6,0,false,true,false,0);
 aiTerrainMgr.SetLayoutInt("fixture.spine.zone",zone);
 aiTerrainMgr.SetLayoutInt("fixture.spine.support",_RefillGroup);
 aiTerrainMgr.SetLayoutInt("fixture.spine.x",2000); aiTerrainMgr.SetLayoutInt("fixture.spine.z",3504);
 aiTerrainMgr.SetLayoutInt("fixture.spine.facing",3); aiTerrainMgr.SetLayoutInt("fixture.spine.columns",4);
 aiTerrainMgr.SetLayoutInt("fixture.spine.rows",6); aiTerrainMgr.SetLayoutInt("fixture.spine.opening_slot",_RefillOpening);
 const int restored=aiTerrainMgr.RestoreSpineSupport("fixture.spine",nano,32,300*SECOND);
 if(_RefillOpening<0 || aiTerrainMgr.GetGroupCount(_RefillGroup,false)!=12 || restored!=0)
   AiLog("[RangedArena] ERROR active exit was not preserved slots="+aiTerrainMgr.GetGroupCount(_RefillGroup,false)+" restored="+restored);
 else AiLog("[RefillFixture] active exit preserved missing=12");
'''
            elif kind=='nano-interior':
                events+='''
 CCircuitDef@ nano=ai.GetCircuitDef("armnanotc"), utility=ai.GetCircuitDef("armtarg");
 aiTerrainMgr.SetProtectSupportRows(true);
 const int zone=aiTerrainMgr.ReserveZone(AIFloat3(2000,0,3504),0,512,512,false);
 const int group=aiTerrainMgr.LayBand(zone,nano,AIFloat3(2000,0,3600),0,12,4,0,false,true,false,0);
 for(int i=0;i<6;++i) { const int hole=aiTerrainMgr.NextSlotAny(group,AIFloat3(2000,0,3504)); if(hole>=0) aiTerrainMgr.ReleaseReservation(hole); }
 const int slot=aiTerrainMgr.PackNearGroup(zone,utility,group,0,AIFloat3(2000,0,3504),0,0,0);
 if(slot<0) AiLog("[RangedArena] ERROR utility had no perimeter placement");
 else {
   const AIFloat3 p=aiTerrainMgr.GetReservationPos(slot);
   if(p.x>1688 && p.x<2312 && p.z>3384 && p.z<3624) AiLog("[RangedArena] ERROR utility interrupted nano interior");
   else AiLog("[PlacementFixture] nano interior protected");
   @_PlacementTask=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::STORE,Task::Priority::HIGH,utility,p,0,true,180*SECOND));
   if(_PlacementTask is null || !AiPinReservation(_PlacementTask,slot)) AiLog("[RangedArena] ERROR utility pin failed");
 }
'''
            else:
                events+='''
 CoverageLanes::Load(); CoverageLanes::enabled=false; CoverageLanes::Clear();
 array<AIFloat3> lane={AIFloat3(4000,0,2000),AIFloat3(4000,0,6000)};
 aiBattle.SetFrontLane(lane,384);
'''
                if kind=='factory-facing':
                    events+='''
 aiTerrainMgr.SetFactoryFacingGoal(AIFloat3(4000,0,3024));
 aiTerrainMgr.SetFactoryFacingAdvance(1024);
 @_PlacementTask=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::FACTORY,Task::Priority::HIGH,ai.GetCircuitDef("armavp"),AIFloat3(4000,0,4000),256,true,180*SECOND));
 AiPreferFactoryFacing(_PlacementTask,0);
'''
                else:
                    events+='''
 CCircuitDef@ gantry=ai.GetCircuitDef("armshltx");
 aiTerrainMgr.SetFactoryCorridorPolicy(false,false);
 aiTerrainMgr.SetFactoryCorridorRequired(gantry.id,0.5f);
 aiTerrainMgr.SetFactoryLane(1,lane);
 const int berth=aiTerrainMgr.ReserveBuilding(gantry,AIFloat3(4000,0,3008),0,0);
 @_PlacementTask=aiBuilderMgr.Enqueue(TaskB::Common(Task::BuildType::FACTORY,Task::Priority::HIGH,gantry,AIFloat3(4000,0,3000),256,true,180*SECOND));
 if(berth<0 || _PlacementTask is null || !AiPinReservation(_PlacementTask,berth)) AiLog("[RangedArena] ERROR gantry berth failed");
'''
            events+='\n } // declared placement fixture\n'
            if kind=='nano-refill':
                events+='''
 if(ai.teamId==0 && _PlacementReady && ai.frame>=60*SECOND && !_RefillReleased) {
   _RefillReleased=true; aiTerrainMgr.ReleaseReservation(_RefillOpening);
   const int restored=aiTerrainMgr.RestoreSpineSupport("fixture.spine",ai.GetCircuitDef("armnanotc"),8,30*SECOND);
   if(restored!=8) AiLog("[RangedArena] ERROR opening removal did not wake bounded refill");
   else AiLog("[RefillFixture] opening removed restored=8");
 }
 if(ai.teamId==0 && _RefillReleased && !_RefillComplete) {
   CCircuitDef@ nano=ai.GetCircuitDef("armnanotc");
   if(nano.count-aiBuilderMgr.GetUnfinishedCount(nano)>=12) {
     _RefillComplete=true;
     if(aiTerrainMgr.GetGroupCount(_RefillGroup,false)!=24) AiLog("[RangedArena] ERROR duplicate or missing support intent");
     else AiLog("[RefillFixture] filled=12 total_slots=24");
   }
 }
'''
            if kind=='gantry-corridor':
                declarations+='bool _CorridorPeerChecked=false;\n'
                events+='''
 if(ai.teamId==1 && ai.frame>=80*SECOND && !_CorridorPeerChecked) {
   _CorridorPeerChecked=true;
   aiTerrainMgr.SetLayoutEnabled(true);
   CCircuitDef@ blocker=ai.GetCircuitDef("armestor");
   const bool road=aiTerrainMgr.CanReserveBuilding(blocker,AIFloat3(4000,0,3600),0);
   const bool outside=aiTerrainMgr.CanReserveBuilding(blocker,AIFloat3(4500,0,3600),0);
   AiLog(!road && outside ? "[PlacementFixture] ally respects gantry corridor" : "[RangedArena] ERROR allied corridor exclusion failed");
 }
'''
        if case.get('defense_overrides'):
            declarations+='bool _DefenseFixture=false;\n'
            events+='\n if(ai.teamId==0 && ai.frame>=10*SECOND && !_DefenseFixture) {\n DefensePlanner::Load();\n'+defense_fixture_policy(case['defense_overrides'])+'\n _DefenseFixture=true; GenericHelpers::LogUtil("[DefenseFixture] applied",1);\n }\n'
        if case.get('disable_lane_assignment'):
            if case.get('lane_front_probe'): raise ValueError('Conflicting supplied lane policies')
            declarations+='bool _FixtureNoLane=false;\n'
            events+='''
 if(ai.teamId==0 && ai.frame>=2*SECOND && !_FixtureNoLane) {
     CoverageLanes::Load(); CoverageLanes::enabled=false;
     CoverageLanes::Clear();
     _FixtureNoLane=true;
     AiLog("[FallbackCoverProbe] lane disabled");
 }
'''
        if case.get('coverage_probe'):
            minimum=float(case.get('coverage_min_advance',1000))
            if not 0 < minimum <= 50000: raise ValueError('Invalid coverage_min_advance')
            declarations+='const float _CoverageProbeMinimum='+repr(minimum)+'f; int _CoverageProbeNext=0;\n'
            events+='''
 if(ai.frame>=_CoverageProbeNext && ai.frame>=30*SECOND) {
     _CoverageProbeNext=ai.frame+5*SECOND;
     array<Id>@ ids=ai.GetOwnedUnitIds();
     for(uint i=0;i<ids.length();++i) {
         CCircuitUnit@ u=ai.GetTeamUnit(ids[i]);
         if(u is null || !u.circuitDef.IsRoleAny(Unit::Role::COMM.mask))continue;
         const AIFloat3 p=u.GetPos(ai.frame);
         AiLog("[CoverageProbe] team="+ai.teamId+" frame="+ai.frame+" unit="+u.id
             +" x="+p.x+" z="+p.z+" distance="+aiBattle.GetFrontLaneDistance(p)
             +" width="+aiBattle.GetFrontLaneWidth()+" length="+aiBattle.GetFrontLaneLength()
             +" moved="+sqrt(p.SqDistance2D(Global::Map::StartPos)));
         if(ai.frame>=120*SECOND && aiBattle.GetFrontLaneLength()>0.f
             && aiBattle.GetFrontLaneDistance(p)<=aiBattle.GetFrontLaneWidth()
             && p.SqDistance2D(Global::Map::StartPos)>=_CoverageProbeMinimum*_CoverageProbeMinimum)
             AiLog("[CoverageProbe] advanced_in_lane team="+ai.teamId);
     }
 }
'''
        if case.get('lane_front_probe'):
            declarations+='bool _LaneFrontSet=false; int _LaneFrontNext=0;\n'
            events+='''
 if(ai.teamId==0 && ai.frame>=2*SECOND) {
     if(!_LaneFrontSet) {
         // The supplied route owns this fixture; normal coverage must not
         // replace it later in the same update with an automatically planned lane.
         CoverageLanes::Load();
         CoverageLanes::enabled=false;
         if(CoverageLanes::frontPublished) CoverageLanes::Clear();
         // Comet's z extent is 6144; reject a broken fixture explicitly.
         array<AIFloat3> route={AIFloat3(4000,0,4000),AIFloat3(4000,0,6000)};
         if(!aiBattle.SetFrontLane(route,384)) AiLog("[RangedArena] ERROR lane route rejected");
         else AiLog("[LaneFrontProbe] route accepted");
         aiBattle.SetLaneFrontOptions(5,20,1.5f,128,100);
         _LaneFrontSet=true;
     }
     if(ai.frame>=_LaneFrontNext) {
         _LaneFrontNext=ai.frame+SECOND;
         AiLog("[LaneFrontProbe] "+aiBattle.DescribeLaneFront());
         if(abs(aiBattle.GetFrontLaneLength()-2000.f)>1.f) AiLog("[RangedArena] ERROR fixture lane replaced");
         AiLog("[LaneFrontBound] "+aiBattle.LimitLaneAdvance(0,2000));
     }
 }
'''
        for index,event in enumerate(case.get('commander_override_events',[])):
            key=event['key']
            if not re.fullmatch(r'[a-zA-Z0-9_.]+',key):raise ValueError('Invalid commander option key')
            flag='_CommanderFixtureEvent'+str(index)
            declarations+='bool '+flag+'=false;\n'
            action=('CommanderCombat::ClearOverride("'+key+'");' if event.get('clear') else
                    'CommanderCombat::Override("'+key+'",'+repr(float(event['value']))+'f);')
            events+='\n if(ai.teamId==0 && ai.frame>='+str(int(event['seconds']))+'*SECOND && !'+flag+') { '+flag+'=true; '+action+' }\n'
        if case.get('commander_lifecycle_probe'):
            declarations+='int _CommanderFixtureOperation=-1; bool _CommanderFixtureCompared=false;\n'
            events+='''
 if(ai.teamId==0 && ai.frame>=10*SECOND && _CommanderFixtureOperation<0)
     _CommanderFixtureOperation=aiBuilderMgr.GetCommanderOperation();
 if(ai.teamId==0 && ai.frame>=20*SECOND && !_CommanderFixtureCompared) {
     _CommanderFixtureCompared=true;
     AiLog(_CommanderFixtureOperation==aiBuilderMgr.GetCommanderOperation()
         ? "[RangedArena] lifecycle_operation_preserved"
         : "[RangedArena] ERROR unrelated_loss_changed_operation");
 }
'''
        source=source[:start]+events+source[start:]
        if case.get('commander_energy_test'):
            source=source[:start]+'''\n
 if (ai.teamId==0 && ai.frame==22*SECOND)
     TeamEconomy::SendEnergy(1,TeamEconomy::OwnEnergy(TeamEconomy::CURRENT)); // declared one-time bank drain
'''+source[start:]
        path.write_text(declarations+source)
    if case.get('trace_spam'):
        # Supplied buildings did not come through TECH's reserved layout.
        # Its geometry/economy Tick cannot judge this isolated production
        # fixture. Lifecycle OnUnitAdded and Spam's own invariants stay active.
        path=staged/'script/src/systems/diagnostics/invariants.as'
        source=path.read_text(); start=source.index('{',source.index('void Tick()'))+1
        path.write_text(source[:start]+'\n if (ai.frame>=0) return; // supplied-layout fixture only\n'+source[start:])
        path=staged/'script/src/systems/combat/spam.as'
        source=path.read_text(); start=source.index('{',source.index('void Update()'))+1
        probe='''
        if (ai.teamId==0 && ai.frame % (10*SECOND)==0) {
            GenericHelpers::LogUtil("[SpamProbe] workers="+aiBuilderMgr.GetWorkerCount(),1);
            array<int>@ ids=ai.GetOwnedUnitIds();
            for (uint i=0;i<ids.length();++i) {
                CCircuitUnit@ u=ai.GetTeamUnit(ids[i]);
                if (u is null || SpamUnitFor(u.circuitDef).length()==0) continue;
                GenericHelpers::LogUtil("[SpamProbe] factory="+u.id+" task="+(u.task is null ? -1 : int(u.task.GetType()))+" retiring="+Lifecycle::IsRetiring(u),1);
            }
        }
'''
        path.write_text(source[:start]+probe+source[start:])
    if args.variant=='siege':
        for path in (staged/'config').rglob('behaviour*.json'):
            data=path.read_bytes()
            for name in case.get('units',[case['unit']]):
                pattern=rb'("'+name.encode()+rb'"\s*:\s*\{)(.*?)(\n[ \t]*\},?)'
                match=re.search(pattern,data,re.S)
                if not match: continue
                block=re.sub(rb'("role"\s*:\s*)\[[^\]]*\]',rb'\1["artillery"]',match[2])
                if b'"attribute"' in block: block=re.sub(rb'("attribute"\s*:\s*)\[[^\]]*\]',rb'\1["siege"]',block)
                else: block=re.sub(rb'("role"[^\n]*\n)',rb'\1\t\t\t\t"attribute": ["siege"],\n',block)
                data=data[:match.start(2)]+block+data[match.end(2):]
            path.write_bytes(data)
    case.update(variant=args.variant,profile=args.profile,seed=args.seed,minutes=args.minutes,speed=args.speed,headless=args.headless)
    case['mode'] = getattr(args, 'mode', 'fast')
    if case['mode'] != 'visual':
        case['photos'] = []
    if case.get('fireline_observer'):
        # Read task ownership in the real host; never issue combat commands.
        profile=staged/'script'/args.profile/'main.as'
        source=profile.read_text()
        start=source.index('{',source.index('void AiUpdate()'))+1
        probe='''
        if (ai.teamId==0) {
            array<int>@ observed=ai.GetOwnedUnitIds();
            for (uint i=0;i<observed.length();++i) {
                CCircuitUnit@ unit=ai.GetTeamUnit(observed[i]);
                if (unit is null || unit.circuitDef.GetName()!="armmanni" || unit.task is null) continue;
                if (unit.task.GetType()==int(Task::Type::RETREAT)) AiLog("[INVARIANT] Starlight entered retreat");
                if (unit.GetHealthPercent()<.65f) AiLog("[FirelineTest] damaged gun holds native firing owner");
            }
        }
'''
        profile.write_text(source[:start]+probe+source[start:])
    if case.get('front_constructor_observation'):
        subprocess.run([sys.executable,str(HERE/'prepare_front_constructor_check.py'),
                        '--dir',str(directory)],check=True)
    config=directory/'LuaUI/Config';config.mkdir(parents=True,exist_ok=True)
    (config/'ranged_arena.lua').write_text('return '+lua(case)+'\n')
    (directory/'ranged-arena.json').write_text(json.dumps(case,indent=2)+'\n')
    pins={'dll_sha256':hashlib.sha256(args.dll.read_bytes()).hexdigest(),
          'diagnostics':{name:os.environ[name] for name in
              ('CIRCUIT_RANGED_TRACE','CIRCUIT_VERIFY_RANGED_QUERIES','CIRCUIT_VERIFY_RANGED_SNAPSHOT','CIRCUIT_VERIFY_RANGED_SHARED','CIRCUIT_PERF_PHASES','CIRCUIT_COMMANDER_TRACE')
              if name in os.environ},
          'files':{str(p.relative_to(staged)):storage.file_hash(p) for p in staged.rglob('*') if p.is_file() and p.suffix in ('.as','.json')},
          'observer_sha256':storage.file_hash(HERE/'widgets/ranged_arena.lua'),
          'overrides':['supplied forces','fixed seed','startup energy'] +
              ((['enemy factories and mobile builders frozen','scripted enemy path'] if case.get('production')
                else ['frozen economic builders/factories','scripted enemy path'])
               if args.profile.startswith('experimental_') else ['native legacy economy remains active'])}
    if case.get('commander_trace'):
        pins['diagnostics']['CIRCUIT_COMMANDER_TRACE']='1'
    if first_factory_skipped:
        pins['overrides'] += ['FRONT first-factory check (INV-267) skipped: no builder or factory can act (KI-785)']
    if case.get('production'):
        pins['overrides'] += ['team 0 factories and static assistants active; mobile builders '+('active' if case.get('builders') else 'frozen')]
    if case.get('commander_repair_only'):
        pins['overrides'] += ['team 0 commander offers stationary repair then stationary hold; normal combat controller remains active']
    if case.get('stationary_assist_fixture'):
        pins['overrides'] += ['team 0 commander retains stationary wait ownership; declared repair/construction target supplied']
    if case.get('solar_ceiling_fixture'):
        pins['overrides'] += ['commander held for first 40 seconds while supplied fusion/jammer economy settles; then real FRONT policy']
    if case.get('placement_fixture'):
        pins['overrides'] += ['declared placement fixture: '+case['placement_fixture']+'; supplied reservation/lane and assigned worker']
        if case['placement_fixture'] in ('factory-facing','gantry-corridor'):
            pins['overrides'] += ['team 0 FrontLayout.Prepare bypassed to exercise ordinary far-site placement']
    if case.get('commander_front_work'):
        pins['overrides'] += [('all commanders' if case.get('coverage_probe') else 'team 0 commanders')
                             +' use real FRONT builder policy; other builders frozen']
    if case.get('tech_base_response_fixture'):
        pins['overrides'] += ['TECH role handler and start assigned for supplied frozen-builder fixture; combat definition caps zero; economy production held until first land intrusion; full response and resumed role production retained']
    if case.get('trace_spam'):
        pins['overrides'] += ['TECH layout/economy invariant Tick disabled for supplied buildings; production/lifecycle and spam invariants retained', 'read-only factory task census every 10 seconds']
    if case.get('hold_friendly'):
        pins['overrides'] += ['friendly combat held for production measurement']
    if case.get('native_route'):
        pins['overrides'] += ['friendly ordinary native route and lane geometry supplied; arrival/idle mechanism test']
    (directory/'ranged-arena-pins.json').write_text(json.dumps(pins,indent=2)+'\n')
    subprocess.run([sys.executable,str(ROOT/'tools/knowledge/check_script_api.py'),'--dll',str(args.dll),'--scripts',str(staged/'script')],check=True)
    print('RANGED_ARENA='+str(directory),flush=True)
    return directory, command


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--case',required=True)
    parser.add_argument('--dll',required=True,type=Path)
    parser.add_argument('--data',type=Path,default=ROOT/'data')
    parser.add_argument('--variant',choices=['baseline','siege','ranged'],default='ranged')
    parser.add_argument('--profile',default='experimental_balanced')
    parser.add_argument('--game',default=None,help='game archive name (default: the last lobby script\'s, via playtest.py)')
    parser.add_argument('--engine',default='recoil_2026.07.04',help='Installed engine directory used for this run')
    parser.add_argument('--seed',type=int,default=2071)
    parser.add_argument('--minutes',type=int,default=4)
    parser.add_argument('--speed',type=int,default=20)
    parser.add_argument('--mode',choices=['fast','visual','performance'],default='fast')
    parser.add_argument('--headless',action='store_true')
    parser.add_argument('--stage-only',action='store_true')
    parser.add_argument('--keep-going',action='store_true',help='bounded diagnostic (KI-734): the watch runs to --minutes after a forbidden line; the verdict stays FAIL')
    # D-432: head-to-head. The enemy side plays this pinned build with its own, unpatched data
    # (its units are under its own controllers, not the fixture's route), staged as BARbBase/base.
    parser.add_argument('--opponent-dll',type=Path,default=None)
    parser.add_argument('--opponent-data',type=Path,default=None)
    args=parser.parse_args();directory,command=prepare(args)
    if args.stage_only: return 0
    launch=command+['launch','--dir',str(directory),'--engine',args.engine]
    if args.headless: launch+=['--headless']
    # Validate before spawning; cleanup must also run if the watcher cannot start.
    case=json.loads((directory/'ranged-arena.json').read_text())
    playtest.validate_checks(case.get('checks','ranged-arena'))
    watch=command+['watch','--dir',str(directory),'--role',case.get('role','FRONT'),'--checks',case.get('checks','ranged-arena'),
        '--play-decided','--minutes',str(args.minutes),'--wall-minutes','8']
    if args.keep_going: watch+=['--keep-going']
    # Supplied arenas can temporarily have no enemies between waves. Their
    # completion/grace contract (or fixed performance horizon) owns the end.
    try:
        environment=dict(os.environ)
        if case.get('commander_trace'):
            if args.mode=='performance':raise ValueError('Commander trace is diagnostic, not a performance input')
            environment['CIRCUIT_COMMANDER_TRACE']='1'
        subprocess.run(launch,check=True,env=environment)
        return subprocess.run(watch,check=False).returncode
    finally:
        subprocess.run(command+['stop','--dir',str(directory)],check=True)

if __name__=='__main__':sys.exit(main())
