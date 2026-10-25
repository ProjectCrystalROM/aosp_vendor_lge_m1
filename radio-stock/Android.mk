# Matched MS33010m ARM32 radio providers. Original blob selection is preserved.
LOCAL_PATH := $(call my-dir)
ifneq ($(filter cm_m1 cm_m1_radio cm_m1_radio_noselinux,$(TARGET_PRODUCT)),)
ifeq ($(TARGET_DEVICE),m1)
ifeq ($(TARGET_ARCH),arm)

include $(CLEAR_VARS)
LOCAL_MODULE := libril
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_TAGS := optional
LOCAL_MULTILIB := 32
LOCAL_SRC_FILES := lib/libril.so
LOCAL_STRIP_MODULE := false
LOCAL_SHARED_LIBRARIES := libbinder libcutils libhardware_legacy liblog librilutils libutils
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := rild
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_TAGS := optional
LOCAL_MULTILIB := 32
LOCAL_SRC_FILES := bin/rild
LOCAL_STRIP_MODULE := false
LOCAL_SHARED_LIBRARIES := libcutils libdl liblog libril
include $(BUILD_PREBUILT)

endif
endif
endif
