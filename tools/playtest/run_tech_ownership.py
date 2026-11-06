"""Supplied TECH owner regression: six/default, configurable count, and disabled."""
import argparse
import json
from pathlib import Path
import subprocess
import sys
import playtest
import storage
from run_retirement_regression import inject_entry


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dll',type=Path,required=True)
    parser.add_argument('--count',type=int,choices=(0,3,6),default=6)
    parser.add_argument('--game',default='Beyond All Reason test-31783-a096d9f')
    args=parser.parse_args()
    directory=storage.allocate('tech','strategy','ownership-'+str(args.count),'glitters','supplied')
    print('OWNERSHIP_DIRECTORY='+str(directory),flush=True)
    command=[sys.executable,str(playtest.HERE/'playtest.py')]
    subprocess.run(command+['stage','--dir',str(directory),'--dll',str(args.dll),
        '--ai-option','random_seed=2071','--role','TECH','--roles','TECH','--isolated','--side','armada','--map','All That Glitters v2.2.3',
        '--game',args.game,'--engine','recoil_2026.07.04','--headless','--mode','fast','--speed','20',
        '--extra-widget',str(playtest.HERE/'widgets/tech_air_foundry.lua')],check=True)
    data=directory/'AI/Skirmish/BARbTest/test'
    config=data/'config/experimental_balanced/economy.json'
    config.write_text(config.read_text().replace('"tech_production": {"air_foundry_count": 6}',
        '"tech_production": {"air_foundry_count": '+str(args.count)+'}'))
    source=data/'script/src'
    (source/'tech_ownership_probe.as').write_bytes((playtest.HERE/'fixtures/tech_ownership_probe.as').read_bytes())
    profile=data/'script/experimental_balanced/main.as'
    profile.write_text('#include "../src/tech_ownership_probe.as"\n'+profile.read_text())
    inject_entry(profile,'void AiLuaMessage(const string& in data)','if (TechOwnershipProbe::Handle(data)) return;')
    widget=directory/'LuaUI/Widgets/tech_air_foundry.lua'
    widget.write_text(widget.read_text().replace('local expected=6','local expected='+str(args.count)))
    checks=json.loads((playtest.HERE/'checks/tech/production/air-foundry.json').read_text())
    checks['expect']=[x for x in checks['expect'] if x['key']!='sixth foundry member']
    for item in checks['expect']:
        item['pattern']=item['pattern'].replace('=6','='+str(args.count))
    checks['forbid']=[x for x in checks['forbid'] if x['key']!='overflow']
    checks['expect'].append(dict(key='membership count',scope='any',pattern='TechOwnershipTest] actual seats='+str(args.count),by_minute=3))
    checks['forbid'].append(dict(key='overflow',scope='any',pattern=r'\[TechAirFoundry\] admitted unit=\d+ seat='+str(args.count)))
    check=directory/'checks.json';check.write_text(json.dumps(checks,indent=2))
    subprocess.run(command+['launch','--dir',str(directory),'--headless','--engine','recoil_2026.07.04'],check=True)
    result=subprocess.run(command+['watch','--dir',str(directory),'--role','TECH','--checks',str(check),
        '--minutes','3','--wall-minutes','3','--poll','2'])
    log=(directory/'infolog.txt').read_text(errors='replace')
    diagnostics=[line for line in log.splitlines() if 'TechAirFoundry' in line or 'TechOwnershipTest' in line or ': ERR' in line]
    (directory/'owner-diagnostics.json').write_text(json.dumps(diagnostics,indent=2))
    archives=sorted((directory/'runs').iterdir())
    if archives:
        (archives[-1]/'owner-diagnostics.json').write_text(json.dumps(diagnostics,indent=2))
        print('PUBLISHED='+str(storage.publish(archives[-1])),flush=True)
    subprocess.run([sys.executable,str(playtest.HERE/'prune_benchmarks.py'),'--apply','--path',str(directory)],check=True)
    return result.returncode


if __name__=='__main__': sys.exit(main())
