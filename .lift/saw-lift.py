import argparse
import json
import os
import subprocess
import toml

SAW = 'saw'
CONFIG_FILENAME = 'saw-lift-config.toml'

parser = argparse.ArgumentParser(description='Run SAW in Lyft.')
parser.add_argument('action', nargs='?')
args = parser.parse_args()

config_file = os.path.join(os.path.dirname(__file__), CONFIG_FILENAME)

match args.action:
    case 'run':
        with open(config_file, 'r') as f:
          config = toml.load(f)
        results = {'tool_notes' : [], 'warnings': []}
        for task in config['tasks']:
            completed_process = subprocess.run(
                [SAW] + task['args'] + [task['saw-script']],
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True
            )
            if completed_process.returncode:
                results['tool_notes'] += [{
                    'type': 'SAW',
                    'message': completed_process.stdout,
                    'file': task['saw-script'],
                    'line': 1,
                }]
        print(json.dumps(results))
    case 'applicable':
        print(str(os.path.isfile(config_file)).lower())
    case None:
        print(
            '{"name": "SAW", "api-version": {"type": "bulk", "version": 2}}'
        )

