# CrystalGram ROM preinstallation

This module installs the published 0.29.1.1820 ARMv7 Lollipop release as a normal
system app. PRESIGNED retains its dedicated application signer, so subsequent
standalone releases using that key can update it. It requires no platform signer
or privileged permissions.

Run `python3 vendor/lge/m1/crystalgram/stage.py --apk /path/to/release.apk` from
an AOSP checkout, or use device/lge/m1/webview/build-rom.sh, which stages the pinned
local release cache automatically. release.json records the public release URL,
APK hash, signer fingerprint and JNI entries. Staging rejects mismatched bytes;
APKs and extracted libraries are ignored by Git. Provision the exact published
APK locally before building; this script does not fetch or rebuild app sources.

API22 requires the separate app-private lib/arm native files. Keep the original
signed APK intact and use separate files rather than extracting-and-stripping
embedded libraries through @lib syntax. Do not include API/Firebase source
configuration, signing-properties files or private signing keys in the ROM.

The product uses BasicSmsReceiver for receive-only SMS notifications and dialogs,
and CrystalGram for Telegram messaging. BasicSmsReceiver has no inbox/history or
send UI and is not a full default-SMS application. An existing user-installed SMS
app may still produce its own notifications. Existing /data apps are not removed
by the product package change. Validate reception on the installed ROM separately.
