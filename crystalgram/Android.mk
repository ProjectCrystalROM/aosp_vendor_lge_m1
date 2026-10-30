# Preserve CrystalGram's application release signer for standalone updates.
LOCAL_PATH := $(call my-dir)
ifeq ($(TARGET_PRODUCT),aosp_m1)
include $(CLEAR_VARS)
LOCAL_MODULE := CrystalGram
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := .apk
LOCAL_MODULE_TAGS := optional
LOCAL_MULTILIB := 32
LOCAL_SRC_FILES := CrystalGram.apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_DEX_PREOPT := false
# API22 needs separate native files; do not strip or re-sign the original APK.
LOCAL_PREBUILT_JNI_LIBS := \
    jni/armeabi-v7a/libc++_shared.so \
    jni/armeabi-v7a/libcryptox.so \
    jni/armeabi-v7a/libimage_processing_util_jni.so \
    jni/armeabi-v7a/liblanguage_id_l2c_jni.so \
    jni/armeabi-v7a/libleveldbjni.so \
    jni/armeabi-v7a/libsslx.so \
    jni/armeabi-v7a/libsurface_util_jni.so \
    jni/armeabi-v7a/libtdjni.so \
    jni/armeabi-v7a/libtgcallsjni.so \
    jni/armeabi-v7a/libtgxjni.so
include $(BUILD_PREBUILT)
endif
