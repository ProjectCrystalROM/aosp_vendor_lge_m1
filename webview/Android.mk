ifeq ($(PLATFORM_SDK_VERSION),23)
# Exact owner-tested ARM32 Android 6-compatible Google WebView.
LOCAL_PATH := $(call my-dir)
ifneq ($(filter cm_m1 cm_m1_radio cm_m1_radio_noselinux,$(TARGET_PRODUCT)),)
ifeq ($(TARGET_DEVICE),m1)
ifeq ($(TARGET_ARCH),arm)
include $(CLEAR_VARS)
LOCAL_MODULE := K7WebView
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := .apk
LOCAL_MODULE_TAGS := optional
LOCAL_MULTILIB := 32
LOCAL_SRC_FILES := WebView.apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_DEX_PREOPT := false
LOCAL_OVERRIDES_PACKAGES := webview
LOCAL_REQUIRED_MODULES := libwebviewchromium_loader libwebviewchromium_plat_support
include $(BUILD_PREBUILT)
endif
endif
endif

endif
