# Pinned upstream microG prebuilts for K7 CM13

Includes official microG Services 0.3.17.252432 (com.google.android.gms) and
Companion 0.3.17.40226 (com.android.vending). Both have minimum API19 and support
ARMv7. Companion supplies Play Store compatibility APIs; it is not a browsable
app store. No unofficial installer, patched APK, bundled GApps, legacy C2DM
proxy, extra location backend, account or registration setting is included.

The owner's working phone APKs match these exact upstream release SHA-256
hashes, independently checked against microg/GmsCore release asset digests.
packages.json pins URLs, versions, hashes and the actual API23/v1 certificate.
Keep PRESIGNED signing, all native ABIs and classes. Legacy build rules change
ZIP compression/alignment; require identical entry contents and a valid v1
signature/certificate after packaging. Neither framework signature-spoofing
permission grants nor microG settings are silently changed by these modules.
Use microG self-check/settings after first boot to grant permissions and enable
registration/cloud messaging as desired. The product's no-screen provisioning
lets the user reach these settings before login. Battery optimization settings
remain user-configurable. CM13 does not parse newer default-permissions or
privapp-permissions XML grant mechanisms, so none are copied blindly.

APK inputs are generated/ignored, not committed (Services exceeds GitHub's
single-file limit). From this directory, run:

    python3 stage.py --fetch

Or stage the exact files from an existing trusted cache without networking:

    python3 stage.py --cache /path/to/cache

Mirror the generated APKs to the build-tree module with --mirror if using a
separate canonical repository. All cached/downloaded bytes are checked against
the pinned SHA-256 values before use; source or signer replacement is forbidden.
The usual build needs no network after staging. No private signing keys needed.

The intended first ROM test is a clean installation without the separate
microG installer ZIP, checking self-check, registration and sign-in. Runtime
APK equality is not qualification of the new ROM package's default grants or
first-boot path. Do not remove the owner's current APKs/data as a shortcut.

References:
https://github.com/microg/GmsCore/releases/tag/v0.3.17.252432
https://github.com/microg/GmsCore/wiki/Installation

2026-10-24 hardware result: owner confirms corrected Provision direct-home
boot/Recents and Services/Companion self-check pass. ADB confirms both setup
flags1 and Provision self-disable. Login on this particular candidate is not
yet reported. The optional GSF row is a separate component/test.
