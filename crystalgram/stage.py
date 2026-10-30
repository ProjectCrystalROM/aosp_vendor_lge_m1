#!/usr/bin/env python3
"""Stage the pinned, signed CrystalGram release and its app-private ARM JNI."""
import argparse
import hashlib
import json
from pathlib import Path
import zipfile

here = Path(__file__).resolve().parent
workspace = here.parents[4]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--apk', type=Path, default=workspace/'audit/aosp511/crystalgram/github-release/CrystalGram-0.29.1.1820-lollipop-armeabi-v7a.apk')
args = parser.parse_args()
release = json.loads((here/'release.json').read_text())
source = args.apk
if not source.exists() and (here/'CrystalGram.apk').exists():
    source = here/'CrystalGram.apk'
data = source.read_bytes()
if hashlib.sha256(data).hexdigest() != release['sha256']:
    raise SystemExit('CrystalGram APK differs from the pinned verified release')
with zipfile.ZipFile(source) as apk:
    libs = sorted(n for n in apk.namelist() if n.startswith('lib/') and n.endswith('.so'))
    if apk.testzip() is not None or libs != release['jni']:
        raise SystemExit('CrystalGram APK ZIP/JNI mismatch')
    for name in libs:
        dest = here/'jni'/Path(name).relative_to('lib')
        dest.parent.mkdir(parents=True, exist_ok=True)
        content = apk.read(name)
        if not dest.exists() or dest.read_bytes() != content:
            dest.write_bytes(content)
dest = here/'CrystalGram.apk'
if not dest.exists() or dest.read_bytes() != data:
    dest.write_bytes(data)
print('CrystalGram: pinned release APK and %d ARM JNI libraries staged' % len(libs))
