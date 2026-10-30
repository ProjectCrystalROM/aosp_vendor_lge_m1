# Pinned microG inputs for Project Crystal AOSP5.1.1

The API22 ROM packages GmsCore0.3.17.252432, Phonesky0.3.17.40226 and GsfProxy0.1.0.
`packages.json` pins original download URLs, hashes and signing certificate hashes.
The platform fork supplies the separately required signature-spoofing and native
compatibility changes; packaging these APKs alone does not implement them.

```sh
python3 microg/stage.py --fetch --extract-arm-jni
# Or provide the exact files from a local cache:
python3 microg/stage.py --cache /path/to/cache --extract-arm-jni
```

On API22, native libraries are installed under the app-specific lib/arm directory.
Keep the original signed APK payload intact; do not strip JNI from the signed APK
or re-sign these apps with the ROM keys. GmsCore/Companion are privileged packages;
GsfProxy is a normal system package. Generated APK/native files are not committed.

Owner confirmed actual CrystalGram push delivery through microG on the AOSP build.
That is not a claim that every microG service, account flow or self-check was
retested on every release. App data/configuration still requires normal setup.
No runtime grant/deny permission UI is introduced on Lollipop.
