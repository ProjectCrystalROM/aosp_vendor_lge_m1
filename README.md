# Project Crystal AOSP5.1.1 — LG K7/MS330 vendor inputs

Pinned vendor and application inputs for the dedicated AOSP API22 MS330 product.
Use the [AOSP manifest](https://github.com/ProjectCrystalROM/aosp_manifest) and
[product release notes](https://github.com/ProjectCrystalROM/aosp_device_lge_m1/blob/aosp-5.1.1-ms330/AOSP_RELEASE.md).
Presence in this archive does not mean every retained input is selected.

## Current selection

- Original stock LG camera/sensor/JPEG, radio, GPS, peripheral and firmware inputs.
- Stock dsi_config.xml for data initialization; APN must match the subscription.
- Pinned original-signed microG Services, Companion and GsfProxy, with separate ARM
  JNI files for API22 native loading.
- CrystalGram0.29.1.1820 ARMv7 release APK, preserving its dedicated application signer.

WebView95 and Linux3.10.108 are built from source by other manifest projects.
The legacy WebView107 module here is API23-only and is not selected by this ROM.
The current radio path does not require the retained Android6 Parcel shim modules.

## Provision ignored application inputs

```sh
python3 microg/stage.py --fetch --extract-arm-jni
python3 crystalgram/stage.py --apk /path/to/CrystalGram-0.29.1.1820-lollipop-armeabi-v7a.apk
```

CrystalGram's exact release is available from
[its GitHub releases](https://github.com/ProjectCrystalROM/CrystalGram/releases/tag/crystalgram-0.29.1.1820).
Hashes, certificate fingerprints and native entries are recorded in package metadata.
Generated APK/JNI outputs are ignored by Git. Never include private signing keys,
Telegram API source configuration or Firebase source configuration in this tree.

The ROM build wrapper verifies/stages inputs but does not silently rebuild apps or
replace release signers. See [microG](microg/README.md) and
[CrystalGram](crystalgram/README.md) for the packaging rules.

## Qualification

AOSP hardware regression passed Wi-Fi/Bluetooth/LTE, applicable persistence,
photo/video and audio input/output. Owner confirms CrystalGram login/chat/push
and active source-built WebView95. User/enforcing hardware validation passed;
final USB/artwork image acceptance remains distinct. Do not infer AOSP qualification
from inherited historical CM documentation or inactive provider directories.
Proprietary firmware/HAL attribution and original source history remain intact.
