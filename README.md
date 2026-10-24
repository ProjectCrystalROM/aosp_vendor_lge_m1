# LG K7 MS330 vendor inputs for CM13

**Status, 2026-10-24: selected vendor inputs build and boot in the working port.**
Use branch `bringup/cm13-m1` with the matching
[product](https://github.com/airi-kozume/cyanogenmod_device_lge_m1/tree/bringup/cm13-m1),
[common device](https://github.com/airi-kozume/android_device_lge_m1-common/tree/resurrection/cm13-static-audit)
and [kernel](https://github.com/airi-kozume/cyanogenmod_kernel_lge_m1/tree/bringup/cm13-m1)
branches. The product README tracks hardware results and remaining work.

## Input selections

| Directory | Purpose / validation |
| --- | --- |
| `proprietary/` | Retained original MS330 inputs; not every archived file is selected |
| `radio-stock/` | Focused stock radio/runtime providers and copy rules, alongside reviewed CM13-built providers |
| `camera-cm13/` | Matched H631 sensor adapter and JPEG pair; rear/front still saving confirmed |
| `video-stock/` | Complete archived K7 Venus bundle; normal firmware startup and rear AVC/AAC recording confirmed |
| `webview/` | Exact signed WebView107 APK; system-provider login confirmed after clean flash |
| `microg/` | Pinned upstream Services, Companion and Services Framework Proxy prebuilts |

Camera/sensors/rotation, wireless/audio, video and microG depend on matching
device/framework selections. Do not replace platform libraries or mix partial
firmware/JPEG sets merely because a single ELF linkage check passes. Per-set
provenance files identify the selected hashes.

## Upstream microG inputs

Services 0.3.17.252432 and Companion 0.3.17.40226 are boot-tested as bundled
system apps; their self-check entries pass. Upstream GsfProxy v0.1.0 was tested
as a separate normal-app install and completes the Services Framework checkbox.
Current source selects it for subsequent ROMs; that future system installation
is distinct from the separately tested `/data` copy.

The generated APK inputs are intentionally ignored by Git. Stage exact pinned
upstream files before building:

```sh
python3 microg/stage.py --fetch
# Or use an existing cache without networking:
python3 microg/stage.py --cache /path/to/cache
```

Hashes are checked before staging. Original signing identities, classes and
native libraries are retained. See [microG input notes](microg/README.md).

## Current limits

The port's qualified diagnostic product boots with SELinux disabled. Live
cellular service/data awaits an active compatible SIM; detection/IMEI/baseband
already work. Additional GPS, suspend/endurance and call-profile testing remains.
This repository alone is not a complete build environment or flashable ROM.
Workspace audits and checkpoint ZIPs are kept separately under `audit/` and
`checkpoints/`.
