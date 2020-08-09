LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)  
LOCAL_LDLIBS := -llog
LOCAL_MODULE    := lwjgl32

theirsrc := $(subst $(LOCAL_PATH)/,,\
	$(wildcard $(LOCAL_PATH)/lwjgl/core/src/generated/c/*.c) \
	$(wildcard $(LOCAL_PATH)/lwjgl/core/src/generated/c/linux/*.c) \
	$(wildcard $(LOCAL_PATH)/lwjgl/core/src/main/c/*.c))

LOCAL_SRC_FILES := $(filter-out lwjgl/core/src/generated/c/linux/org_lwjgl_system_linux_DynamicLinkLoader.c, $(theirsrc)) \
	org_lwjgl_system_linux_DynamicLinkLoader.c

LOCAL_C_INCLUDES += $(LOCAL_PATH)/lwjgl/core/src/main/c \
	$(LOCAL_PATH)/lwjgl/core/src/main/c/dyncall $(LOCAL_PATH)/lwjgl/core/src/main/c/linux

LOCAL_CFLAGS += -DLWJGL_LINUX -DJNI_VERSION_1_8=0x00010008 -include "stdio.h"

LOCAL_LDLIBS := $(LOCAL_PATH)/$(TARGET_ARCH_ABI)/libdyncall_s.a \
	$(LOCAL_PATH)/$(TARGET_ARCH_ABI)/libdyncallback_s.a $(LOCAL_PATH)/$(TARGET_ARCH_ABI)/libdynload_s.a

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_LDLIBS := -llog -lEGL
LOCAL_MODULE    := lwjgl_opengl32

LOCAL_SRC_FILES := $(subst $(LOCAL_PATH)/,,\
	$(wildcard $(LOCAL_PATH)/lwjgl/opengl/src/generated/c/*.c) \
	) \
	opengl_JniOnLoadShim.c egl_swapBuffers.c

LOCAL_C_INCLUDES += $(LOCAL_PATH)/lwjgl/core/src/main/c \
	$(LOCAL_PATH)/lwjgl/core/src/main/c/dyncall $(LOCAL_PATH)/lwjgl/core/src/main/c/linux \
	$(LOCAL_PATH)/lwjgl/opengl/src/main/c

LOCAL_CFLAGS += -DLWJGL_LINUX -DJNI_VERSION_1_8=0x00010006 -include "stdio.h"

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_LDLIBS := -llog
LOCAL_MODULE    := lwjgl_stb32

LOCAL_SRC_FILES := $(subst $(LOCAL_PATH)/,,\
	$(wildcard $(LOCAL_PATH)/lwjgl/stb/src/generated/c/*.c) \
	) \

LOCAL_C_INCLUDES += $(LOCAL_PATH)/lwjgl/core/src/main/c \
	$(LOCAL_PATH)/lwjgl/core/src/main/c/dyncall $(LOCAL_PATH)/lwjgl/core/src/main/c/linux \
	$(LOCAL_PATH)/lwjgl/stb/src/main/c

LOCAL_CFLAGS += -DLWJGL_LINUX -DJNI_VERSION_1_8=0x00010006 -include "stdio.h"

include $(BUILD_SHARED_LIBRARY)
