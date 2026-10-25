# Pinned upstream microG prebuilts for K7 CM13

## Current validation — 2026-10-25

| Component | Version | Result |
| --- | --- | --- |
| Services / `com.google.android.gms` | 0.3.17.252432 | Bundled system app; owner self-check passes |
| Companion / `com.android.vending` | 0.3.17.40226 | Bundled system app; owner self-check passes |
| GsfProxy / `com.google.android.gsf` | v0.1.0 | Approved standalone upstream install; owner confirms Services Framework checkbox now checked |

Services/Companion match both the owner's working APKs and the official
GmsCore release asset hashes. GsfProxy matches its official release download
and the upstream F-Droid index hash. All original v1 signing identities and
payloads are verified. `packages.json` pins exact inputs and certificate hashes.

The current normal cm_m1 ROM packages all three pinned APKs, WebView107 and
corrected no-screen Provision. GsfProxy was initially qualified through a
separate upstream install; current system payload and signature audits verify
its inclusion. A retained /data update can still shadow its ROM copy.
Provision sets Android's two setup flags plus CM's separate setup-completed
flag for Home. Login and self-check results were confirmed during bring-up;
these do not imply a fresh account-registration test after every build.

## Stage build inputs

The APKs are generated/ignored, not committed; Services exceeds GitHub's
single-file limit. From the vendor repository root:

```sh
python3 microg/stage.py --fetch
# Or stage exact pinned files offline:
python3 microg/stage.py --cache /path/to/cache
```

Use `--mirror /path/to/build/vendor/lge/m1/microg` for a separate build checkout.
Every cached/downloaded input is hash-checked before use. No private signing
keys or implicit build-time download are required after staging.

## Packaging boundaries

Services/Companion are PRESIGNED privileged apps; GsfProxy is a PRESIGNED normal
system app. Keep all original classes and native ABIs. CM13 repacks ZIP
compression/alignment; audit identical entry contents, the API23/v1 signature
and native layout. GsfProxy's older SHA1 JAR signature is checked alongside its
pinned whole-APK SHA256; Services/Companion use SHA256 JAR digests.

No unofficial installer scripts, extra location backend, account, registration
setting or automatic runtime/spoofing-permission grant is included. CM13 does
not implement newer default-permissions/privapp-permissions XML grant handling,
so those installer files are not copied blindly. The product's direct-home
setup permits microG configuration before login.

A full bundled-install test should distinguish ROM APKs from retained `/data`
updates or addon.d restores. Existing rollback checkpoints are retained in the
bring-up workspace. References: [GmsCore release](https://github.com/microg/GmsCore/releases/tag/v0.3.17.252432),
[GsfProxy release](https://github.com/microg/GsfProxy/releases/tag/v0.1.0),
[upstream installation notes](https://github.com/microg/GmsCore/wiki/Installation).
