# K7 standalone WebView prebuilt

Owner-provided com.google.android.webview 107.0.5304.36, code 530403610.
Original source: webview_investigation in the bring-up workspace. See
provenance.json for the immutable source hash and original signer fingerprint.

This specific APK supports API23 through API28, ARMv7. The owner confirmed
Google login after installing it as the alternate CM13 provider. A system-ROM
installation still needs cold-boot/provider/login acceptance. Do not infer
Android 6 compatibility from a version's major number or change its manifest.

K7WebView overrides the original webview module in the focused radio product.
CM13 already prefers the Google package, so no framework overlay/patch is
needed. Keep PRESIGNED identity, all four native libraries, classes.dex and
existing loader/support modules. Legacy build rules may change ZIP compression
and alignment; every entry and the API23 v1 signature must remain intact.

Do not publish this candidate as hardware-qualified until the actual system
provider is verified without an installed data update masking it. Official
GApps login and microG login are separate acceptance checks. Current sign-in
success is owner-reported for a separately installed copy, not a ROM test.
