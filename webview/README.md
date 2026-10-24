# K7 standalone WebView prebuilt

**Clean-flash boot and Google login confirmed, 2026-10-24.** ADB verified the
active package was the built-in `/system/app/K7WebView/K7WebView.apk`, version
107.0.5304.36, without a `/data` update masking the ROM provider.

This is the owner's exact `com.google.android.webview` APK, versionCode
530403610, minAPI23/maxAPI28, ARMv7. `provenance.json` records its original hash
and signer. The compatibility finding applies to this artifact, not every
release with the same major version.

`K7WebView` overrides the old `webview` module in the focused K7 products. CM13
already prefers the Google package; no provider-selection framework patch is
needed. Preserve the original signing identity, classes and all four native
libraries. Legacy build rules change ZIP compression/alignment, so audits check
all entry contents, the API23/v1 signature and native-library alignment.

The known Open GApps 20220215 Pico cleanup lists preserve this module path.
Other installers that supply WebView need checking for duplicate packages or
an older replacement. The clean-flash login result supersedes the earlier
separately installed APK test.
