#!/bin/sh
# Copy only the installable payload. Run with Herdr closed.
set -eu
rice_source=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
exec python3 - "$rice_source" "${1:-$HOME/.config/herdr-app}" <<'PY'
import json
import shutil
import sys
import tempfile
from pathlib import Path

source, target = map(lambda s: Path(s).absolute(), sys.argv[1:])
roots = ['layouts', 'mods', 'themes', 'keys.json', 'rice.json', 'settings.json']
files = []
for name in roots:
    path = source / name
    for item in sorted(path.rglob('*')) if path.is_dir() else [path]:
        rel = item.relative_to(source)
        if any(p.startswith('.') for p in rel.parts) or item.name in ('gpui-kit.d.ts', 'jsconfig.json'):
            continue
        if item.is_symlink():
            raise SystemExit(f'Refusing source symlink: {rel}')
        if item.is_file():
            if item.suffix not in ('.json', '.js', '.py', '.svg', '.applescript'):
                raise SystemExit(f'Unexpected payload file: {rel}')
            if item.suffix == '.json':
                json.loads(item.read_text())
            files.append(rel)

if target == source or source in target.parents or target in source.parents:
    raise SystemExit('Destination must be separate from the source checkout.')
# Do not follow Stow links and accidentally write into a dotfiles repository.
for rel in [Path('.'), *files]:
    dest = target / rel
    for ancestor in [dest, *dest.parents]:
        if ancestor.is_symlink():
            raise SystemExit(f'Refusing symlink destination: {ancestor}. Use a detached config copy first.')
    if rel != Path('.') and dest.exists() and not dest.is_file():
        raise SystemExit(f'Expected a file at {dest}')
if target.exists() and not target.is_dir():
    raise SystemExit('Destination must be a directory.')
target.parent.mkdir(parents=True, exist_ok=True)
backup = Path(tempfile.mkdtemp(prefix=target.name + '-backup-', dir=target.parent))
if target.exists():
    shutil.copytree(target, backup / 'config', symlinks=True)
else:
    (backup / 'NO_PREVIOUS_CONFIG').touch()
target.mkdir(exist_ok=True)
for rel in files:
    dest = target / rel
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source / rel, dest)
(backup / 'installed-files.txt').write_text('\n'.join(map(str, files)) + '\n')
print(f'Installed {len(files)} files into {target}')
print(f'Backup and install manifest: {backup}')
print('Open Herdr, then: herdr-app do layout.switch --name my-sleek')
PY
