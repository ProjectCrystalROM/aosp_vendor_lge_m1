#!/usr/bin/env python3
"""Stage immutable upstream APKs from cache, or explicitly fetch missing inputs."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import tempfile
from zipfile import ZipFile
from urllib.request import urlopen

MODULE = Path(__file__).resolve().parent
parser = argparse.ArgumentParser()
parser.add_argument('--cache', type=Path)
parser.add_argument('--fetch', action='store_true')
parser.add_argument('--extract-arm-jni', action='store_true', help='Stage separate ARM libraries for Lollipop system apps without modifying signed APKs')
parser.add_argument('--mirror', type=Path)
args = parser.parse_args()

def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

for item in json.loads((MODULE / 'packages.json').read_text()):
    target = MODULE / (item['module'] + '.apk')
    if not target.exists():
        source = args.cache / item['cache_file'] if args.cache else None
        if source is not None and source.exists():
            assert sha(source) == item['sha256'], source
            shutil.copyfile(source, target)
        else:
            if not args.fetch:
                raise SystemExit('Missing ' + target.name + ': supply --cache or --fetch')
            assert item['url'].startswith('https://microg.org/fdroid/repo/')
            with tempfile.TemporaryDirectory(prefix='microg-input-') as temporary:
                download = Path(temporary) / item['cache_file']
                with urlopen(item['url'], timeout=60) as stream, download.open('wb') as output:
                    shutil.copyfileobj(stream, output)
                assert sha(download) == item['sha256'], download
                shutil.copyfile(download, target)
    assert sha(target) == item['sha256'], target
    if args.mirror:
        args.mirror.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(target, args.mirror / target.name)
    if args.extract_arm_jni:
        with ZipFile(target) as apk:
            for name in apk.namelist():
                if not name.startswith('lib/armeabi-v7a/') or not name.endswith('.so'):
                    continue
                assert name.count('/') == 2, name
                relative = Path(item['module'] + '-jni/armeabi-v7a') / Path(name).name
                output = MODULE / relative
                output.parent.mkdir(parents=True, exist_ok=True)
                payload = apk.read(name)
                output.write_bytes(payload)
                if args.mirror:
                    mirrored = args.mirror / relative
                    mirrored.parent.mkdir(parents=True, exist_ok=True)
                    mirrored.write_bytes(payload)
    print(item['module'], item['version'], item['sha256'])
