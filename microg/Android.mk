# Pinned upstream microG; keep original signing identities.
LOCAL_PATH := $(call my-dir)
ifneq ($(filter cm_m1 cm_m1_radio cm_m1_radio_noselinux,$(TARGET_PRODUCT)),)
ifeq ($(TARGET_DEVICE),m1)
ifeq ($(TARGET_ARCH),arm)

include $(CLEAR_VARS)
LOCAL_MODULE := GmsCore
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := .apk
LOCAL_MODULE_TAGS := optional
LOCAL_MULTILIB := 32
LOCAL_SRC_FILES := GmsCore.apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_PRIVILEGED_MODULE := true
LOCAL_DEX_PREOPT := false
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := Phonesky
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := .apk
LOCAL_MODULE_TAGS := optional
LOCAL_MULTILIB := 32
LOCAL_SRC_FILES := Phonesky.apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_PRIVILEGED_MODULE := true
LOCAL_DEX_PREOPT := false
include $(BUILD_PREBUILT)

# Upstream proxy required for the owner's complete self-check target.
include $(CLEAR_VARS)
LOCAL_MODULE := GsfProxy
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := .apk
LOCAL_MODULE_TAGS := optional
LOCAL_MULTILIB := 32
LOCAL_SRC_FILES := GsfProxy.apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_DEX_PREOPT := false
include $(BUILD_PREBUILT)
endif
endif
endif
