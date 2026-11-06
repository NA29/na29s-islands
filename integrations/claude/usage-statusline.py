"""Optional minimal Claude status line and local Herdr usage snapshot writer.

Feed Claude's status-line JSON on stdin. No dependencies outside Python stdlib.
For an existing status line, invoke this with the same saved input and discard
its stdout, then render the existing line from that input.
"""
import json
import os
from pathlib import Path
import sys
import tempfile
import time


def main():
    data = json.load(sys.stdin)
    limits = data.get('rate_limits')
    if isinstance(limits, dict) and limits:
        folder = Path.home() / '.cache/agent-usage'
        folder.mkdir(parents=True, exist_ok=True)
        # Do not retain the rest of the status-line input (paths, session data).
        fd, name = tempfile.mkstemp(prefix='claude-', suffix='.tmp', dir=folder)
        with os.fdopen(fd, 'w') as out:
            json.dump({'at': int(time.time()), 'rate_limits': limits}, out)
            out.write('\n')
        os.replace(name, folder / 'claude.json')
    print((data.get('model') or {}).get('display_name') or 'Claude Code')


if __name__ == '__main__':
    try:
        main()
    except Exception:
        print('Claude Code')
